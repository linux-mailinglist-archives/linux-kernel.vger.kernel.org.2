Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC1794139FA
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 20:20:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233521AbhIUSV1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 14:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232866AbhIUSUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 14:20:43 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0875FC061756
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 11:19:14 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id eg28so54936585edb.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 11:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IucAc/qAxnfh7vVamv7kHUvrKnYQaxRt5IMV6QC88mw=;
        b=nFpKxsRNhzCUXO+Xp3fD4HrPTqgds0r1/Gy751kthDqisR1yPYpbu9T68OYaAyV0/w
         Q3baSEE1Ga5ksbEf7Xt8VfeNwwFnPKn1Ha+j+jeVyIBJzLBrbBzmH0l1xyME89Pf6TI7
         GAeacFbZV39ngAitFzW1aWG6yo+rRF6tWlLofA0kWrcdpPzbrfiA+Z5tZ4dC5ieHRf+1
         z6oEYPpRNjktsUOa8TN6/Wleq1b1SbuH0FRyCTxFLdAdsyfb6S/3YrR21NOkoFlbYjDG
         DUFgxgiCo+qYQXsQzPZEjNCYBFGeYigV19Spb8Xvtcjj9ePOF3DhHALlzW2ICyOCXDA5
         lk9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IucAc/qAxnfh7vVamv7kHUvrKnYQaxRt5IMV6QC88mw=;
        b=O00PgcYnissTtKAqkn56LqCFfrzFQ0uSNwzyWx80Kz/O0FUfgnNK04byylO5gjQaoL
         G3i0TXHW4AucCWq/hQvl5mBQHE9B7lAvv0kO1vFf7IPwS198FIz42QGVV5uDLYJ0pdyL
         0xjo7i86njEngcEbsTZo/s5Zte88Qsmd+y3rksMgJccysBD9BnxkUmdCFMSOEoXWZxmP
         HEKFzvmE2C58Tc9Chn5xibIxcGXMgGGudAh4wVwdxpGD6hdq/OO9aOC8SHLazzEjGMwv
         nh/gYaEX3ct+ripSCB6hWQhwHHhz4yuvtiLN8MlGO7ulxsmxOIzBz62kPWHtYn/hra1+
         QoSw==
X-Gm-Message-State: AOAM530ouDZ+e4+bGXCPlhR1lQUa1xqIKJ+6Ew6O2PLUzszGRjpM1BpU
        mIlDvJiD4wj9XT9dkk7zkbM=
X-Google-Smtp-Source: ABdhPJwPYbWgyVxGAjcEyaSLihZl+jpCCy6TunWmEs1jUHbYKGNv6UfrCgmFGOq3QOEy+dtm8JD8aw==
X-Received: by 2002:aa7:d2ce:: with SMTP id k14mr37343236edr.396.1632248352601;
        Tue, 21 Sep 2021 11:19:12 -0700 (PDT)
Received: from localhost.localdomain.it (host-212-171-30-160.retail.telecomitalia.it. [212.171.30.160])
        by smtp.gmail.com with ESMTPSA id cn8sm1833162edb.77.2021.09.21.11.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 11:19:12 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        David Laight <david.Laight@aculab.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Martin Kaiser <martin@kaiser.cx>
Cc:     "Fabio M . De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v9 15/16] staging: r8188eu: remove shared buffer for USB requests
Date:   Tue, 21 Sep 2021 20:18:33 +0200
Message-Id: <20210921181834.29677-16-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210921181834.29677-1-fmdefrancesco@gmail.com>
References: <20210921181834.29677-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pavel Skripkin <paskripkin@gmail.com>

Remove the shared buffer for USB requests because it is not necessary
and use a local on stack variable since the new Core USB API does not
have the constraints of usb_control_msg().

Co-developed-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
---
 drivers/staging/r8188eu/hal/usb_ops_linux.c | 15 ++++++---------
 drivers/staging/r8188eu/include/drv_types.h |  3 ---
 drivers/staging/r8188eu/os_dep/usb_intf.c   | 14 +-------------
 3 files changed, 7 insertions(+), 25 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
index 88db7488b3a2..3ede93cd68d6 100644
--- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
+++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
@@ -14,7 +14,7 @@ static int usb_read(struct intf_hdl *intf, u16 value, void *data, u8 size)
 	struct dvobj_priv *dvobjpriv = adapter_to_dvobj(adapt);
 	struct usb_device *udev = dvobjpriv->pusbdev;
 	int status;
-	u8 *io_buf; /* Pointer to I/O buffer */
+	u8 io_buf[4];
 
 	mutex_lock(&dvobjpriv->usb_vendor_req_mutex);
 
@@ -23,9 +23,6 @@ static int usb_read(struct intf_hdl *intf, u16 value, void *data, u8 size)
 		goto mutex_unlock;
 	}
 
-	/*  Acquire IO memory for vendorreq */
-	io_buf = dvobjpriv->usb_vendor_req_buf;
-
 	status = usb_control_msg_recv(udev, 0, REALTEK_USB_VENQT_CMD_REQ,
 				      REALTEK_USB_VENQT_READ, value,
 				      REALTEK_USB_VENQT_CMD_IDX, io_buf,
@@ -70,14 +67,14 @@ static int usb_write(struct intf_hdl *intf, u16 value, void *data, u8 size)
 	struct dvobj_priv *dvobjpriv = adapter_to_dvobj(adapt);
 	struct usb_device *udev = dvobjpriv->pusbdev;
 	int status;
-	u8 *io_buf; /* Pointer to I/O buffer */
+	u8 io_buf[VENDOR_CMD_MAX_DATA_LEN];
 
 	mutex_lock(&dvobjpriv->usb_vendor_req_mutex);
 
-	if (adapt->bSurpriseRemoved || adapt->pwrctrlpriv.pnp_bstop_trx)
-		return -EPERM;
-
-	io_buf = dvobjpriv->usb_vendor_req_buf;
+	if (adapt->bSurpriseRemoved || adapt->pwrctrlpriv.pnp_bstop_trx) {
+		status = -EPERM;
+		goto mutex_unlock;
+	}
 
 	memcpy(io_buf, data, size);
 	status = usb_control_msg_send(udev, 0, REALTEK_USB_VENQT_CMD_REQ,
diff --git a/drivers/staging/r8188eu/include/drv_types.h b/drivers/staging/r8188eu/include/drv_types.h
index c96a33c8c621..6d63429d06c6 100644
--- a/drivers/staging/r8188eu/include/drv_types.h
+++ b/drivers/staging/r8188eu/include/drv_types.h
@@ -168,9 +168,6 @@ struct dvobj_priv {
 	struct semaphore usb_suspend_sema;
 	struct mutex  usb_vendor_req_mutex;
 
-	u8 *usb_alloc_vendor_req_buf;
-	u8 *usb_vendor_req_buf;
-
 	struct usb_interface *pusbintf;
 	struct usb_device *pusbdev;
 
diff --git a/drivers/staging/r8188eu/os_dep/usb_intf.c b/drivers/staging/r8188eu/os_dep/usb_intf.c
index 11a584cbe9d8..5ab42d55207f 100644
--- a/drivers/staging/r8188eu/os_dep/usb_intf.c
+++ b/drivers/staging/r8188eu/os_dep/usb_intf.c
@@ -75,24 +75,12 @@ static struct rtw_usb_drv *usb_drv = &rtl8188e_usb_drv;
 
 static u8 rtw_init_intf_priv(struct dvobj_priv *dvobj)
 {
-	u8 rst = _SUCCESS;
-
 	mutex_init(&dvobj->usb_vendor_req_mutex);
-
-	dvobj->usb_alloc_vendor_req_buf = kzalloc(MAX_USB_IO_CTL_SIZE, GFP_KERNEL);
-	if (!dvobj->usb_alloc_vendor_req_buf) {
-		DBG_88E("alloc usb_vendor_req_buf failed... /n");
-		rst = _FAIL;
-		goto exit;
-	}
-	dvobj->usb_vendor_req_buf = (u8 *)N_BYTE_ALIGMENT((size_t)(dvobj->usb_alloc_vendor_req_buf), ALIGNMENT_UNIT);
-exit:
-	return rst;
+	return _SUCCESS;
 }
 
 static void rtw_deinit_intf_priv(struct dvobj_priv *dvobj)
 {
-	kfree(dvobj->usb_alloc_vendor_req_buf);
 	mutex_destroy(&dvobj->usb_vendor_req_mutex);
 }
 
-- 
2.33.0

