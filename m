Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB973064B2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 21:02:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232442AbhA0UC3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 15:02:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232508AbhA0UAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 15:00:09 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76864C061574;
        Wed, 27 Jan 2021 11:59:28 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id rv9so4343665ejb.13;
        Wed, 27 Jan 2021 11:59:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FcjjaJ3LJyxy+uNzIzTchssZp72itK8F22M5j8rqleY=;
        b=rAh4JF5v8cmWUB9UB7r076rKQ1gHJZaMCAIfg7L3LTGdalysoqApkvFvFhZ6Sbwz72
         bZi+4KetTp1E/6O3vmudgGIUHvA4FIwOAXz/l/Dz9Dvjiqq7/bQgdJF3simpSeXKV3EX
         EF1HRnulmioETAkOHV0h5kSu7O+bVaBhJWdIFbHNT/XMJH3tZRbG0tosmYtWZDjY7LNc
         F1wqx+6sfRTigrT7UR3a8Ca/PwqaoM5VSMRWeTUK93AglTcIWd2lJWp6keoguhd6OLyK
         XG83KmTvEdxt3yZK4yVMr7yX2/CV5CnMY/Px+NjdjLXZLCtQo+bgeQcxl/MGUq/QcWHd
         Np5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FcjjaJ3LJyxy+uNzIzTchssZp72itK8F22M5j8rqleY=;
        b=hyldb7n92PYr8YYDVDxaVHGLt+UPiXznpCi78WyR+J9NXEnFY9j4SvMheur9KhgpaL
         Af1VWmfrvr/nNaR+zHLFOK/iO68fU3uOTuL97uNAStFytd9cAu2AFf1L1jKet49bh6lm
         yVzzSTRD539u1Xz6a5AQ7TqlP3lhHEWd9QNtPgp4cFjBa8XfJ3Tgp+daCpT3/unVOVgo
         jj6UHA/xKIKw/bgUJiD9wSYgwHGyb+n6pm3XGKeru9l3QzeryaEOntjCLCcmBnUTl0mF
         pGlvZxTRUTdFu6jZw+IrYgbq49ABmzeLhFFxgusE3itwbXlYYP6DpWqWtnKLe2tx9JoC
         fo+A==
X-Gm-Message-State: AOAM530BmbWGFTCOXC2LDzlZ4cd/GW5SIutZ4LEuuv56Pg4P+VN5gecU
        1H4UhIJWd8OvCFhHIG45bbI=
X-Google-Smtp-Source: ABdhPJxsZ5qCNGOkVZNfIEF0LokBpL3PZycaH0nidSbMOoonJmAPdse1uYv1Rrepehnjmf5kQ5E3Ww==
X-Received: by 2002:a17:906:38c3:: with SMTP id r3mr8125792ejd.193.1611777567251;
        Wed, 27 Jan 2021 11:59:27 -0800 (PST)
Received: from cinterion-pc.localdomain (dynamic-077-013-132-254.77.13.pool.telefonica.de. [77.13.132.254])
        by smtp.googlemail.com with ESMTPSA id v25sm1910363edx.49.2021.01.27.11.59.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jan 2021 11:59:26 -0800 (PST)
From:   Christoph Schemmel <christoph.schemmel@gmail.com>
To:     johan@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        hans-christoph.schemmel@thalesgroup.com,
        Christoph Schemmel <christoph.schemmel@gmail.com>
Subject: [PATCH] USB: serial: option: Adding support for Cinterion MV31
Date:   Wed, 27 Jan 2021 20:58:46 +0100
Message-Id: <20210127195846.3663-1-christoph.schemmel@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding support for Cinterion device MV31 for enumeration with
PID 0x00B3 and 0x00B7.

usb-devices output for 0x00B3
T:  Bus=04 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  6 Spd=5000 MxCh= 0
D:  Ver= 3.20 Cls=ef(misc ) Sub=02 Prot=01 MxPS= 9 #Cfgs=  1
P:  Vendor=1e2d ProdID=00b3 Rev=04.14
S:  Manufacturer=Cinterion
S:  Product=Cinterion PID 0x00B3 USB Mobile Broadband
S:  SerialNumber=b3246eed
C:  #Ifs= 6 Cfg#= 1 Atr=a0 MxPwr=896mA
I:  If#=0x0 Alt= 0 #EPs= 1 Cls=02(commc) Sub=0e Prot=00 Driver=cdc_mbim
I:  If#=0x1 Alt= 1 #EPs= 2 Cls=0a(data ) Sub=00 Prot=02 Driver=cdc_mbim
I:  If#=0x2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
I:  If#=0x3 Alt= 0 #EPs= 1 Cls=ff(vend.) Sub=ff Prot=ff Driver=cdc_wdm
I:  If#=0x4 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
I:  If#=0x5 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=30 Driver=option

usb-devices output for 0x00B7
T:  Bus=04 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  5 Spd=5000 MxCh= 0
D:  Ver= 3.20 Cls=ef(misc ) Sub=02 Prot=01 MxPS= 9 #Cfgs=  1
P:  Vendor=1e2d ProdID=00b7 Rev=04.14
S:  Manufacturer=Cinterion
S:  Product=Cinterion PID 0x00B3 USB Mobile Broadband
S:  SerialNumber=b3246eed
C:  #Ifs= 4 Cfg#= 1 Atr=a0 MxPwr=896mA
I:  If#=0x0 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=ff Driver=qmi_wwan
I:  If#=0x1 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
I:  If#=0x2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
I:  If#=0x3 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=30 Driver=option

Signed-off-by: Christoph Schemmel <christoph.schemmel@gmail.com>
---
 drivers/usb/serial/option.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index 3fe959104311..e6a9b3379070 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -425,6 +425,8 @@ static void option_instat_callback(struct urb *urb);
 #define CINTERION_PRODUCT_AHXX_2RMNET		0x0084
 #define CINTERION_PRODUCT_AHXX_AUDIO		0x0085
 #define CINTERION_PRODUCT_CLS8			0x00b0
+#define CINTERION_PRODUCT_MV31_MBIM		0x00b3
+#define CINTERION_PRODUCT_MV31_RMNET		0x00b7
 
 /* Olivetti products */
 #define OLIVETTI_VENDOR_ID			0x0b3c
@@ -1914,6 +1916,10 @@ static const struct usb_device_id option_ids[] = {
 	{ USB_DEVICE(SIEMENS_VENDOR_ID, CINTERION_PRODUCT_HC25_MDMNET) },
 	{ USB_DEVICE(SIEMENS_VENDOR_ID, CINTERION_PRODUCT_HC28_MDM) }, /* HC28 enumerates with Siemens or Cinterion VID depending on FW revision */
 	{ USB_DEVICE(SIEMENS_VENDOR_ID, CINTERION_PRODUCT_HC28_MDMNET) },
+	{ USB_DEVICE_INTERFACE_CLASS(CINTERION_VENDOR_ID, CINTERION_PRODUCT_MV31_MBIM, 0xff),
+	  .driver_info = RSVD(3)},
+	{ USB_DEVICE_INTERFACE_CLASS(CINTERION_VENDOR_ID, CINTERION_PRODUCT_MV31_RMNET, 0xff),
+	  .driver_info = RSVD(0)},
 	{ USB_DEVICE(OLIVETTI_VENDOR_ID, OLIVETTI_PRODUCT_OLICARD100),
 	  .driver_info = RSVD(4) },
 	{ USB_DEVICE(OLIVETTI_VENDOR_ID, OLIVETTI_PRODUCT_OLICARD120),
-- 
2.25.1

