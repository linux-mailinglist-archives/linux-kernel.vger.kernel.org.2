Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D17A34B791
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Mar 2021 15:26:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbhC0OZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Mar 2021 10:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbhC0OYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Mar 2021 10:24:50 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAC43C0613B1
        for <linux-kernel@vger.kernel.org>; Sat, 27 Mar 2021 07:24:49 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id f22-20020a7bc8d60000b029010c024a1407so6324222wml.2
        for <linux-kernel@vger.kernel.org>; Sat, 27 Mar 2021 07:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qPyy7/lZ8Cg/+Dzl8fbK+ayIcd2lL4l3eej3var3e0U=;
        b=h207w138afGw+fknV7MJ45zlGKaBJ3ImdE1IizLksOinUn11h2UQ6H+RAyoP+y27ze
         xt1Xc7PNf1zLR/0VYDdK4JWCvEWb8KH6lMM9bI95+O9z9CbwFZYJVfyHDoQygbAJF4vC
         YUig3igKTREgDyj79ptlVMap8p0maZHmv+C2OgeUzOvdOWkWm9QqkjA96o6JYACEDtsi
         yQ/pHrnz9x+OKcREK15h+t7Ng0yoTqu7VvP0v89bO2cUFerCul5Hsp9mKxn6aGAwQwTe
         ZPZYghEcZEA2CJ+SR85+4MmLbVVJunlDNe6ybpkVtBBeHc4suuSAnUqqQ7PrJD882ihw
         gNLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qPyy7/lZ8Cg/+Dzl8fbK+ayIcd2lL4l3eej3var3e0U=;
        b=jew25KPmXJD0EBob8WZjvXsfmdu67rkimaSwql05g7Iiu2Q3UrMJAKyxohnlLH0GbM
         6d93MrrbdmjaEWWt1A/CyqJG5zYFsVElrhoa7HAa8sb/YFi2VEnEKa7VQWJbUdQ0UQqb
         JbsIXFsBNYtCSk7UFe2LdWovcSNNPfFKLINFihd6Hl2kiQPV6OxdMGmM06oFRKXRr+Kg
         ItAiPDfhEh07M2CRKcP/8x3hMP8u5afo5jzJetZ0ikT0wydH+iovbM/m+/GxyJTbAQda
         mvawgGCQPLLAemPrqq+geRW2uk2G0uIqlXhSA9MKtlfZTz9nKyJr4F+IkNG3HN3YAH3J
         7M3A==
X-Gm-Message-State: AOAM530mfes90e02TLGGRmurOJzGbSYDYVT49g/r0DZBaj2udpedfy76
        TkAiP6aMK+Y1VlUd1F2InSI=
X-Google-Smtp-Source: ABdhPJw4g+4xgLvEl60eZ9ZLbdDQXDd6Bgi/yJh7hvDtNDuyMZlzFjbKmAOVU5yrz5SkgL0F7XXYgw==
X-Received: by 2002:a1c:7415:: with SMTP id p21mr17778160wmc.187.1616855083686;
        Sat, 27 Mar 2021 07:24:43 -0700 (PDT)
Received: from agape ([151.46.211.242])
        by smtp.gmail.com with ESMTPSA id g9sm18742235wrp.14.2021.03.27.07.24.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Mar 2021 07:24:43 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, david.laight@aculab.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH v2 02/20] staging: rtl8723bs: put parentheses on macro with complex values in include/hal_com.h
Date:   Sat, 27 Mar 2021 15:24:01 +0100
Message-Id: <3d187b860c3a104b00e97543390b2bbe3f2caa24.1616854134.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1616854134.git.fabioaiuto83@gmail.com>
References: <cover.1616854134.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix the following checkpatch warning:

ERROR: Macros with complex values should be enclosed in parentheses
187: FILE: drivers/staging/rtl8723bs/include/hal_com.h:187:
+#define PageNum_128(_Len)
                (u32)(((_Len)>>7) + ((_Len)&0x7F ? 1:0))

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/include/hal_com.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/include/hal_com.h b/drivers/staging/rtl8723bs/include/hal_com.h
index dc023dd17534..55f9caee6610 100644
--- a/drivers/staging/rtl8723bs/include/hal_com.h
+++ b/drivers/staging/rtl8723bs/include/hal_com.h
@@ -180,7 +180,7 @@ enum rt_media_status {
 #define TX_SELE_NQ			BIT(2)		/*  Normal Queue */
 #define TX_SELE_EQ			BIT(3)		/*  Extern Queue */
 
-#define PageNum_128(_Len)		(u32)(((_Len)>>7) + ((_Len)&0x7F ? 1:0))
+#define PageNum_128(_Len)		((u32)(((_Len)>>7) + ((_Len)&0x7F ? 1:0)))
 
 u8 rtw_hal_data_init(struct adapter *padapter);
 void rtw_hal_data_deinit(struct adapter *padapter);
-- 
2.20.1

