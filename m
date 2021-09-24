Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B37C34171C7
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 14:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245727AbhIXM3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 08:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245437AbhIXM3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 08:29:02 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA3C8C061574
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 05:27:28 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id u27so34851831edi.9
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 05:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jdEHukJFI5KLXKseovA8chBIFpkWExbdPtIweTTcHKQ=;
        b=ULs1YJiv33WySPCHQ3PhUxwaBmGj4OrzmnV5Vck4pOybn+iO6d/ar5GS1+IZs2lkmS
         j+MDfa6epXFwOetF5r57uL92hV6g9gpkx+mvMX9bBxGN5lvjeTWBbcvl6A0kqc0wwK5e
         WPpwEGwNRGNdh82+xr3R4WpiHB/uoRz9HANj4NuxIuDbXSGTY89goXGGQZSejdbHxkQm
         UnaWx3Tsca6nLx2EWGschA7KoIHFeMxLqzt1agF6gf2QxsRiOO21DshK8zTt1RR3eEEL
         GhFZe0jJgwbcYCovxv7v3AIQPQf6hn15tVpj2OHW7C4G9riauyYFWxMz5ehXW5OwmN4u
         G8jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jdEHukJFI5KLXKseovA8chBIFpkWExbdPtIweTTcHKQ=;
        b=xh+/4RExV/t7mMGR3E9YJLDcM4zzuEdmyggOiylDvDNVr334+KbHzQuy+cdG/8/WaU
         ZtH/y1bHN6UgQNRFKXMeBeJn7vovmKg4bxCZlVqfeHJ3xNT9VidZZ5iPEl2sZpMScPGT
         esr2Rpwsl3HRlNqOEWW0pIibqqJZ2QOwUSVr0oibpNm2+zVcQDN0n9iAb3AOvn7tlnlR
         cUcPMxBTnwf2yQuQNJrqIqwW5ldhBfBdRAeG48+w6SNJNeGBXaO7e7u0nxoz9il/Z6ES
         eMBrqG+VbDxEZXPSSVHK0aBz6CTcaJeTVm4Al6ckf2Sqfr/o/WwlBMFydbfAaWpcwZNv
         z1zg==
X-Gm-Message-State: AOAM530q9wUgVbC7AM0dpyda9Lfx/yQQWVL5HHAVGXjeVit1kj0I0NC5
        r1Y1jwN+JjQmojZM6V6SLuc=
X-Google-Smtp-Source: ABdhPJzvVLw9WxxkagswZ54HrpkkgftJs8TOWMcpr6ws5/JT0RzEpDzgUSPgub+ZuQdJ20dG/CPcDg==
X-Received: by 2002:a17:906:584b:: with SMTP id h11mr11287202ejs.209.1632486447558;
        Fri, 24 Sep 2021 05:27:27 -0700 (PDT)
Received: from localhost.localdomain.it (host-212-171-30-160.retail.telecomitalia.it. [212.171.30.160])
        by smtp.gmail.com with ESMTPSA id v13sm4882522ejh.62.2021.09.24.05.27.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 05:27:27 -0700 (PDT)
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
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v10 01/16] staging: r8188eu: clean up symbols in usbctrl_vendorreq()
Date:   Fri, 24 Sep 2021 14:26:50 +0200
Message-Id: <20210924122705.3781-2-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210924122705.3781-1-fmdefrancesco@gmail.com>
References: <20210924122705.3781-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up symbol names in usbctrl_vendorreq():

	pdata => data;
	pio_priv => io_priv;
	pintfhdl => intf.

Co-developed-by: Pavel Skripkin <paskripkin@gmail.com>
Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 drivers/staging/r8188eu/hal/usb_ops_linux.c | 28 ++++++++++-----------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
index 6de99079e117..3e7bc510197e 100644
--- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
+++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
@@ -8,14 +8,14 @@
 #include "../include/recv_osdep.h"
 #include "../include/rtl8188e_hal.h"
 
-static int usbctrl_vendorreq(struct intf_hdl *pintfhdl, u16 value, void *pdata, u16 len, u8 requesttype)
+static int usbctrl_vendorreq(struct intf_hdl *intf, u16 value, void *data, u16 len, u8 requesttype)
 {
-	struct adapter	*adapt = pintfhdl->padapter;
-	struct dvobj_priv  *dvobjpriv = adapter_to_dvobj(adapt);
+	struct adapter *adapt = intf->padapter;
+	struct dvobj_priv *dvobjpriv = adapter_to_dvobj(adapt);
 	struct usb_device *udev = dvobjpriv->pusbdev;
 	unsigned int pipe;
 	int status = 0;
-	u8 *pIo_buf;
+	u8 *io_buf;
 	int vendorreq_times = 0;
 
 	if ((adapt->bSurpriseRemoved) || (adapt->pwrctrlpriv.pnp_bstop_trx)) {
@@ -32,10 +32,10 @@ static int usbctrl_vendorreq(struct intf_hdl *pintfhdl, u16 value, void *pdata,
 	mutex_lock(&dvobjpriv->usb_vendor_req_mutex);
 
 	/*  Acquire IO memory for vendorreq */
-	pIo_buf = dvobjpriv->usb_vendor_req_buf;
+	io_buf = dvobjpriv->usb_vendor_req_buf;
 
-	if (!pIo_buf) {
-		DBG_88E("[%s] pIo_buf == NULL\n", __func__);
+	if (!io_buf) {
+		DBG_88E("[%s] io_buf == NULL\n", __func__);
 		status = -ENOMEM;
 		goto release_mutex;
 	}
@@ -47,22 +47,22 @@ static int usbctrl_vendorreq(struct intf_hdl *pintfhdl, u16 value, void *pdata,
 
 	while (++vendorreq_times <= MAX_USBCTRL_VENDORREQ_TIMES) {
 		if (requesttype == REALTEK_USB_VENQT_READ)
-			memset(pIo_buf, 0, len);
+			memset(io_buf, 0, len);
 		else
-			memcpy(pIo_buf, pdata, len);
+			memcpy(io_buf, data, len);
 
 		status = usb_control_msg(udev, pipe, REALTEK_USB_VENQT_CMD_REQ,
 					 requesttype, value, REALTEK_USB_VENQT_CMD_IDX,
-					 pIo_buf, len, RTW_USB_CONTROL_MSG_TIMEOUT);
+					 io_buf, len, RTW_USB_CONTROL_MSG_TIMEOUT);
 
 		if (status == len) {   /*  Success this control transfer. */
 			rtw_reset_continual_urb_error(dvobjpriv);
 			if (requesttype == REALTEK_USB_VENQT_READ)
-				memcpy(pdata, pIo_buf,  len);
+				memcpy(data, io_buf,  len);
 		} else { /*  error cases */
 			DBG_88E("reg 0x%x, usb %s %u fail, status:%d value=0x%x, vendorreq_times:%d\n",
 				value, (requesttype == REALTEK_USB_VENQT_READ) ? "read" : "write",
-				len, status, *(u32 *)pdata, vendorreq_times);
+				len, status, *(u32 *)data, vendorreq_times);
 
 			if (status < 0) {
 				if (status == -ESHUTDOWN || status == -ENODEV) {
@@ -74,8 +74,8 @@ static int usbctrl_vendorreq(struct intf_hdl *pintfhdl, u16 value, void *pdata,
 			} else { /*  status != len && status >= 0 */
 				if (status > 0) {
 					if (requesttype == REALTEK_USB_VENQT_READ) {
-						/*  For Control read transfer, we have to copy the read data from pIo_buf to pdata. */
-						memcpy(pdata, pIo_buf,  len);
+						/*  For Control read transfer, we have to copy the read data from io_buf to data. */
+						memcpy(data, io_buf,  len);
 					}
 				}
 			}
-- 
2.33.0

