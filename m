Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC964171DB
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 14:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343700AbhIXMaB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 08:30:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343615AbhIXM3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 08:29:21 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1DD4C061767
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 05:27:48 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id u27so34855117edi.9
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 05:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IucAc/qAxnfh7vVamv7kHUvrKnYQaxRt5IMV6QC88mw=;
        b=B2kX3FL+aGyOauUiu/vIIbwzQE9ZXy84fQXOTWBZP7oL32MO20DUhaCG/RbBzmHpMz
         e71kO7lh4yRzhcD0IufPSrJdUAz+qrbdoJv3bJJh77MJmoLow/FxxhS+uIbDOU1CySDH
         qm0wjZE03sgSyVVJKBPhd4Zqt0n0lR6oO6mRjZ3/7pexatErWSPVx0uLIWbFpTPpdUri
         gvydRqil7WzKlI+Bcdj8ti2HfZScw46gJGlRb89mstAk26BKkcd6jSmwGy38mzHjjChl
         itqzZIQQX9AR4zzcjq4M77vI8lewmZ4Ln1kPgUSC2DNIHRi7y8qvJT7e3PEsc3iyfXGE
         py9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IucAc/qAxnfh7vVamv7kHUvrKnYQaxRt5IMV6QC88mw=;
        b=TMq1gyJ3Ze6mYuIcrWSgVUTmFQ+6bXdEflQ2mQlzx9p3udHET2DYldA9Qf95iAbXpj
         kSkD9SUr4h69eVM8RiC1Y30dKu7ghxcw8uvNJtFjxqTnVUeaskiymghZQA03cD2u0+Q1
         Yk2XTianrfGQiNs7EEqmQ+qXHw5STsI3BpuWJDa2tJvaYZDHpFP7YKC11g3qxjCNBMOU
         xexVAyxjcTs7pVULGjTvUHp3Pp/gUByv6x3gCG3c5Wb3dfa9ASeLIvQUD16ndgocgJK+
         8TkLs8S1kCG4Nmh20ukobxNJ3owK+4Wf2EcwAF5vnDki++QHzONbV9oLHTjSfRKzGok0
         pucQ==
X-Gm-Message-State: AOAM531j4Zm1D8AO/GUX3ToD7egDr/4cz4pX49S+FH11SRuXjBZHC9wM
        KKOJFrdPWUxweN9v0XF1WmA=
X-Google-Smtp-Source: ABdhPJxyYRJzrJl8qPDYmMnAzYHDbDvywzH2jwohNcbUoFBqFG4m74xQtA9yZw4GUuOqIZCQB5N9kw==
X-Received: by 2002:aa7:c459:: with SMTP id n25mr4596171edr.29.1632486467191;
        Fri, 24 Sep 2021 05:27:47 -0700 (PDT)
Received: from localhost.localdomain.it (host-212-171-30-160.retail.telecomitalia.it. [212.171.30.160])
        by smtp.gmail.com with ESMTPSA id v13sm4882522ejh.62.2021.09.24.05.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 05:27:46 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        David Laight <david.Laight@aculab.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Michael Straube <straube.linux@gmail.com>,
        Martin Kaiser <martin@kaiser.cx>
Cc:     "Fabio M . De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v10 15/16] staging: r8188eu: remove shared buffer for USB requests
Date:   Fri, 24 Sep 2021 14:27:04 +0200
Message-Id: <20210924122705.3781-16-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210924122705.3781-1-fmdefrancesco@gmail.com>
References: <20210924122705.3781-1-fmdefrancesco@gmail.com>
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

