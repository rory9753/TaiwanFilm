package com.web.login.controller;

import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.sql.Blob;
import java.text.ParseException;


import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.sql.rowset.serial.SerialBlob;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.CacheControl;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;

import com.web.login.Model.MembersBean;
import com.web.login.Service.MembersService;





@Controller
@SessionAttributes({ "members", "Login" })
public class RegisterController {
	String noImage = "/images/NoImage.png";
	String noImageFemale = "/images/NoImage_Female.jpg";
	String noImageMale = "/images/NoImage_Male.png";

	@Autowired
	MembersService service;
	@Autowired
	ServletContext context;

	@GetMapping("members/add")
	public String getAddNewMemberForm(Model model) {
		MembersBean member = new MembersBean();
		model.addAttribute("MembersBean", member);
		return "_01_register/registerNewMember";
	}

	@PostMapping("/_01_register/registerNewMember")
	public String processAddNewMemberForm(@ModelAttribute("MembersBean") MembersBean member, Model model) {
		try {
			service.saveMembers(member);
		} catch (org.hibernate.exception.ConstraintViolationException e) {
			System.out.println("org.hibernate.exception.ConstraintViolationException");
			return "_01_register/registerNewMember";
		} catch (Exception ex) {
			System.out.println(ex.getClass().getName() + ", ex.getMessage()=" + ex.getMessage());
			return "_01_register/registerNewMember";
		}

		return "redirect:/ToIndex";

	}
	
	@GetMapping("/ToIndex")
	public String returnToIndex() {	
		return "index";
	}
	
	@RequestMapping("/register")
	public String register() {
		return "_01_register/register";
	}

	@RequestMapping("/members")
	public String memberpage(Model model) {
		return "index";
	}

	@PostMapping("/Checklogin")
	public String memberCheckLogin(@ModelAttribute("MembersBean") MembersBean member, Model model,
			HttpSession session) {
		System.out.println("Login頁面");
		MembersBean bean = service.login(member.getEmail(), member.getPassword());
		if (bean != null) {
			session.setAttribute("Login", bean);
		}
		member = service.getMemberByBean(member);
		model.addAttribute("members", member);
		// return "_01_register/LoginSuccessful";
		return "index";
	}

	@RequestMapping(value = "/UpdateMember")
	public String UpdateMember(Model model, @ModelAttribute("MembersBean") MembersBean member, HttpSession session) {
		member = service.getMemberByBean(member);
		model.addAttribute("members", member);
		return "_01_register/registerUpdateMember";
	}

	@RequestMapping(value = "/_01_register/DoUpdateMember", method = RequestMethod.POST)
	public String DoUpdateMember(
//	@ModelAttribute("MembersBean") 
//	MembersBean member,
	@RequestParam("memImage")
	MultipartFile picture,
	HttpServletRequest request,
	Model model, 
	HttpSession session) throws ParseException {
		MembersBean member1 =(MembersBean) session.getAttribute("members");
		MembersBean member = new MembersBean(
				//request.gstParameter("memberName")
				request.getParameter("memberName"),request.getParameter("email"),
				request.getParameter("gender"),request.getParameter("birthDay"));		
//		MultipartFile picture = (MultipartFile) (request.getParameter("memImage"));
		member.setMemberId(member1.getMemberId());
//		System.out.println("member.getmemImage() :照片"+member.getmemImage());
		String originalFilename = picture.getOriginalFilename();
		if (originalFilename.length() > 0 && originalFilename.lastIndexOf(".") > -1) {
			member.setFileName(originalFilename);}
			try {
				byte[] b = picture.getBytes();
				Blob blob = new SerialBlob(b);
				member.setMemberImage(blob);
				System.out.println(member.getMemberImage());
			} catch (Exception e) {
				e.printStackTrace();
				throw new RuntimeException("檔案上傳發生異常: " + e.getMessage());}
			
//			member = service.getMemberByBean(member);
			model.addAttribute("members", member);

		if(service.updateMembers(member)) {
			System.out.println("會員資料修改成功");
			return "redirect:/ToIndex";
		} else {
			System.out.println("會員資料修改失敗");
			return "redirect:/ToIndex";
		}
	}
	
	
	@SuppressWarnings("unused")
	@GetMapping("/crm/picture/{id}")
	public ResponseEntity<byte[]> getPicture(@PathVariable("id") Integer id) {
		System.out.println("!!!!!");		
		byte[] body = null;
		ResponseEntity<byte[]> re = null;
		MediaType mediaType = null;
		HttpHeaders headers = new HttpHeaders();
		headers.setCacheControl(CacheControl.noCache().getHeaderValue());

		MembersBean member = service.getMemberById(id);
		System.out.println(" 照片"+member.getMemberImage());
		if (member == null) {
			return new ResponseEntity<byte[]>(HttpStatus.NOT_FOUND);
		}
		String filename = member.getFileName();
		if (filename != null) {
			if (filename.toLowerCase().endsWith("jfif")) {
				mediaType = MediaType.valueOf(context.getMimeType("dummy.jpeg"));
			} else {
				mediaType = MediaType.valueOf(context.getMimeType(filename));
				headers.setContentType(mediaType);
			}
		}
		Blob blob = member.getMemberImage();
		System.out.println(member.getMemberImage());
		if (blob != null) {
			body = blobToByteArray(blob);
		} else {
			String path = null;
			if (member.getGender() == null || member.getGender().length() == 0) {
				path = noImageMale;
			} else if (member.getGender().equals("M")) {
				path = noImageMale;
			} else {
				path = noImageFemale;
				;
			}
			body = fileToByteArray(path);
		}
		re = new ResponseEntity<byte[]>(body, headers, HttpStatus.OK);

		return re;
	}
	public byte[] blobToByteArray(Blob blob) {
		byte[] result = null;
		try (InputStream is = blob.getBinaryStream(); ByteArrayOutputStream baos = new ByteArrayOutputStream();) {
			byte[] b = new byte[819200];
			int len = 0;
			while ((len = is.read(b)) != -1) {
				baos.write(b, 0, len);
			}
			result = baos.toByteArray();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;

	}
	private byte[] fileToByteArray(String path) {
		byte[] result = null;
		try (InputStream is = context.getResourceAsStream(path);
				ByteArrayOutputStream baos = new ByteArrayOutputStream();) {
			byte[] b = new byte[819200];
			int len = 0;
			while ((len = is.read(b)) != -1) {
				baos.write(b, 0, len);
			}
			result = baos.toByteArray();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
}
