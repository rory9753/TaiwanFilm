package com.web.shoppingCart.dao;

import java.sql.Connection;

import com.web.shoppingCart.model.OrderItemBean;

public interface OrderItemDao {
	
	// 由 OrderItemBean取得商品價格(eBook#Price)。
		
	double findItemAmount(OrderItemBean oib);

//	int updateProductStock(OrderItemBean ob);
	
	void setConnection(Connection conn);
}
