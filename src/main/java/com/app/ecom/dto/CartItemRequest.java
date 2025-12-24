package com.app.ecom.dto;

import lombok.Data;
import java.math.BigDecimal;

@Data
public class CartItemRequest {
    private Long productId;
    private Integer quantity;
}
