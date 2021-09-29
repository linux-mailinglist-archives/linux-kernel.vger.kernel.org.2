Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7585A41BFBF
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 09:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244568AbhI2HTG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 03:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244525AbhI2HTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 03:19:04 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDCE7C06161C;
        Wed, 29 Sep 2021 00:17:23 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id x8so878453plv.8;
        Wed, 29 Sep 2021 00:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LEQFPQiTn4Bx9qdKWxs/A4UShFsbFjXxm6TVxU4yPMY=;
        b=GwJm4JswLA46fbEkpEOMHk+VNR1RKffxoJCk8dyCcn9ARU4ERBYpskdjhHrcFlN+cQ
         Llpsp4Vz7i2NP165l5ChcN1mto1/fUIjyyclSVJZVkRgwsWjfYsVCdiUvjXQk3qvuGMK
         xHk6gmglwdaBUH+Wr31juWGKpFNEk758ichrOEhUIUE1CJcNcXDtgCrfo5vkcAqUk/m3
         PfQInSCqaDtzZQM14+Yf/kP92A5OTH6M/co4eYuCBOabhAXBV2l6jKeryOIhvkSm/dRo
         7WZAZ74c/JWQeBR57iQ31g7P6WRwipUUU9uj+qM+D1AmBH4gSCW5oOW7nkSVZWqKSCeq
         i05g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LEQFPQiTn4Bx9qdKWxs/A4UShFsbFjXxm6TVxU4yPMY=;
        b=oaeZGokodaRI0zASallawE3zPIemSplVtPTU95HH3Hjdjc51ptdPN7KTWM7G3jp71F
         NMqwwR/vNOm6dVjwtVgVpiFUqq+rEJn4mXjyctBKXMOCODOUSXix9VjBS6k59/6tAe1e
         ykGG7EtgBoiZUNFXaTKYvPH2E9sT685X8bUkpUOU1q5T8kGr4WEuzdkvJRhNx44X4Xqo
         ea7uRDZFsuHUcr9bzxaKxeaQ4IHuxMyuwZxb6Sa0lzlwf8kWNJyKjEzO/NEo/6KZXMtb
         N3XQZnxiq0d6/50uG7vvRKoE5gvvBx6gNJ69ZcJZ6u7sBCWVH7tIxjWnxDE/NfsDtt1W
         /kRg==
X-Gm-Message-State: AOAM533NS5lPkMnRxmaig7KFM6uepJBYyhly1z+n2gtPhJH2OXguZ3xr
        rZk7IF65EFLLiC0/8b/5yHI=
X-Google-Smtp-Source: ABdhPJx4wvpJ2rAeGKxW6eOyAjyN6Ef7Mn+ibeuCsSuUY0LBDHAhewdjoOGViSuvfj0vfjhscZVzOQ==
X-Received: by 2002:a17:902:710f:b0:13c:aad1:8343 with SMTP id a15-20020a170902710f00b0013caad18343mr9162053pll.16.1632899843280;
        Wed, 29 Sep 2021 00:17:23 -0700 (PDT)
Received: from ruantu-linux-1.. ([211.72.215.15])
        by smtp.gmail.com with ESMTPSA id z124sm1355263pfb.108.2021.09.29.00.17.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 00:17:22 -0700 (PDT)
From:   Yu-Tung Chang <mtwget@gmail.com>
To:     johan@kernel.org
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yu-Tung Chang <mtwget@gmail.com>
Subject: [PATCH] USB: serial: option: add Quectel EC200S-CN module support
Date:   Wed, 29 Sep 2021 15:17:13 +0800
Message-Id: <20210929071713.319751-1-mtwget@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add usb product id of the Quectel EC200S-CN module.

usb-devices output for 0x6002:
T:  Bus=01 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  3 Spd=480 MxCh= 0
D:  Ver= 2.00 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=2c7c ProdID=6002 Rev=03.18
S:  Manufacturer=Android
S:  Product=Android
S:  SerialNumber=0000
C:  #Ifs= 5 Cfg#= 1 Atr=e0 MxPwr=500mA
I:  If#=0x0 Alt= 0 #EPs= 1 Cls=02(commc) Sub=06 Prot=00 Driver=cdc_ether
I:  If#=0x1 Alt= 1 #EPs= 2 Cls=0a(data ) Sub=00 Prot=00 Driver=cdc_ether
I:  If#=0x2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=(none)
I:  If#=0x3 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=(none)
I:  If#=0x4 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=(none)

Signed-off-by: Yu-Tung Chang <mtwget@gmail.com>
---
 drivers/usb/serial/option.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index 6cfb5d33609f..428d101f6193 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -252,6 +252,7 @@ static void option_instat_callback(struct urb *urb);
 #define QUECTEL_PRODUCT_EM12			0x0512
 #define QUECTEL_PRODUCT_RM500Q			0x0800
 #define QUECTEL_PRODUCT_EC200T			0x6026
+#define QUECTEL_PRODUCT_EC200S_CN		0x6002
 
 #define CMOTECH_VENDOR_ID			0x16d8
 #define CMOTECH_PRODUCT_6001			0x6001
-- 
2.33.0

