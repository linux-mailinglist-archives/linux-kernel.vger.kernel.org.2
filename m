Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6279C41D14E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 04:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347626AbhI3CNC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 22:13:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233941AbhI3CNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 22:13:01 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABBC2C06161C;
        Wed, 29 Sep 2021 19:11:19 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id r7so3069894pjo.3;
        Wed, 29 Sep 2021 19:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Vx2XlZ4FegGZ4VBMiJz6zHP9tSJ66bvq6JyHo/xaLRU=;
        b=RAnlGPDeNFcKcGDmEN+pDC5DDMNviROi76zg0TVSVHUUVGPZ9LFwt+KYvpsk9+ZcYp
         v7y1xgy8cBsya5aKI2561+92pJhhZYwn5vobSRD9cTqALiIETJ0eKdzg0ZgPDBCltRTD
         /SXQM9fartt1GRZtRMVOUGvOsiK/gd+zOj1YeYckoKv1i5XxYB6dIqZVh3EgSOJnVhwF
         76eq7gI22EHZka0VzL7DeLK/9/raG0t1Hq6bGOcUbnOlq7wZkUz5/3L4w4+qgQJm3XbQ
         76G+KwI59d0gtIPABwWWtuH4pvoAOJcHS8CwUzmOI8ZyUXwfYofafCc54NMX3s/5NgAi
         SpJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Vx2XlZ4FegGZ4VBMiJz6zHP9tSJ66bvq6JyHo/xaLRU=;
        b=sC6GBqavN7L8K0A4tFFXgd40v/fYL+Pz/5cNRX6fZGTx5ZYcWmmI9pp/6ecgLWkSzE
         8uRa04mCN6SRAs6uOZvfpJ60dKqVUn0QCRqxR4gSa1Y+lM4rBs4/S34NKAtfcJ+2PmFJ
         PRA9FOTobR4a+h98pgC6FH5UgjK5p1QeQeXJ+kLm5LH0SStIWXhb/6EKDtjqAHnab7Gt
         LMKZzF+1pbyhTYO112/WlUWR6ozmEdYctZr45Zs9N7puD/u/3TaomSgH6qiyY+YCG4af
         KYtaU/bKGt6PEMyVJ9MbNbI/RjaRc6xRJSjwbz/sLMZHL5E44sUVBZZ9E4dCf1D28KTZ
         D6EQ==
X-Gm-Message-State: AOAM531TD03eUN0VJ5EQPTiwXjHe/5j73vMoDnUoTzfx0nNxy1Zbj99n
        mk4yltCGTM+5JIkMGMBx0DomMwUr6N8=
X-Google-Smtp-Source: ABdhPJyUKGR61yoBB19QMgH8+u4bRxZBfexMHdHynMJC2tzguc1Rx74OI7yierbnRsTnmH97v3T3Lg==
X-Received: by 2002:a17:90a:7892:: with SMTP id x18mr3318084pjk.95.1632967879204;
        Wed, 29 Sep 2021 19:11:19 -0700 (PDT)
Received: from ruantu-linux-1.. ([211.72.215.15])
        by smtp.gmail.com with ESMTPSA id y24sm928448pfo.69.2021.09.29.19.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 19:11:18 -0700 (PDT)
From:   Yu-Tung Chang <mtwget@gmail.com>
To:     johan@kernel.org
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yu-Tung Chang <mtwget@gmail.com>
Subject: [PATCH v1] USB: serial: option: add Quectel EC200S-CN module support
Date:   Thu, 30 Sep 2021 10:11:12 +0800
Message-Id: <20210930021112.330396-1-mtwget@gmail.com>
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
 drivers/usb/serial/option.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index 6cfb5d33609f..f65a2e7699bf 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -251,6 +251,7 @@ static void option_instat_callback(struct urb *urb);
 #define QUECTEL_PRODUCT_EP06			0x0306
 #define QUECTEL_PRODUCT_EM12			0x0512
 #define QUECTEL_PRODUCT_RM500Q			0x0800
+#define QUECTEL_PRODUCT_EC200S_CN		0x6002
 #define QUECTEL_PRODUCT_EC200T			0x6026
 
 #define CMOTECH_VENDOR_ID			0x16d8
@@ -1128,6 +1129,7 @@ static const struct usb_device_id option_ids[] = {
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_RM500Q, 0xff, 0, 0) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_RM500Q, 0xff, 0xff, 0x10),
 	  .driver_info = ZLP },
+	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EC200S_CN, 0xff, 0, 0) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EC200T, 0xff, 0, 0) },
 
 	{ USB_DEVICE(CMOTECH_VENDOR_ID, CMOTECH_PRODUCT_6001) },
-- 
2.33.0

