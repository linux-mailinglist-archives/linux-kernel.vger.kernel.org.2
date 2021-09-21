Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48D644139ED
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 20:19:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232845AbhIUSUl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 14:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232752AbhIUSUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 14:20:25 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9327C061575
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 11:18:56 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id v5so75763831edc.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 11:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jdEHukJFI5KLXKseovA8chBIFpkWExbdPtIweTTcHKQ=;
        b=aqS5TeLn+fzYLEhUDqy9fpqsrppKU4+icFEz4JNW+cdksX5mgioeQy1aSgwvz94Xvw
         OPht+HiWQNHiFDMBHVJdJisxR2kFnhG9S2yUg27eeu7L1omuIjd6TpAVJzQU5EJ9Wv5F
         FqxdC+tCbZluc4QIo/8YDvFyknfPrjgju15hpiy1E1qwCzS5rgFHx3DavbDFqm4WhyIB
         +aX9Qs+Z6o/Mk1dvxVB35OC0haZBGxh2Cj2Z28FEKOSRnm3w/gYFMUhpEK83kwKnUJa/
         44dredyBJI0Su9aylcZnWbcb1gNsa4JV3WphzLETeB4Rd8kheaHk10rUUIRA5ickapDG
         678g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jdEHukJFI5KLXKseovA8chBIFpkWExbdPtIweTTcHKQ=;
        b=IjnK+sAo+ARWG4qn8u4lngmqzPrtI5HXn1OHwtrq15jxrYOdzXsJq05VgoR4+vUYyn
         /amy5ileBpfRFWJLfsGWVBlIXotIAM09qB2CAqhu1n4QCgVq0MOFiv/pB8LwjJ51Z9gA
         7AGEervP+j0mlhgK95BiFzFVs6qxziH50GZHxxzgRZeNVYulsMK38q20uhBOzgfWthQJ
         cjav2yfOuhaR21kVJAFi41cQiBQrz8qvhYz5USdHb9PRKTkk2Mq7uGACvyEz6tzXyt+v
         WDX907jQd/UnJP/QHh3Rl4pgDD83CPUu1nUtYnuaaR2idUbkJdJaf3d7UEMaMChUEAJp
         fKjA==
X-Gm-Message-State: AOAM532dpoPnWHjHad8Xedappr2XGPY56yqd23+KEIsnc+ZSXllh/Ydg
        JX1B3++FzrA/fhrROHHe0TI=
X-Google-Smtp-Source: ABdhPJx20UKy2azUUf3V7i0IFS4p1AUN/T7815y11Bif75xQYtdfK1CdCs0f4i/XDQ7SA1IBm4Gc3w==
X-Received: by 2002:aa7:c2d3:: with SMTP id m19mr37209847edp.57.1632248335405;
        Tue, 21 Sep 2021 11:18:55 -0700 (PDT)
Received: from localhost.localdomain.it (host-212-171-30-160.retail.telecomitalia.it. [212.171.30.160])
        by smtp.gmail.com with ESMTPSA id cn8sm1833162edb.77.2021.09.21.11.18.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 11:18:55 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        David Laight <david.Laight@aculab.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Martin Kaiser <martin@kaiser.cx>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v9 01/16] staging: r8188eu: clean up symbols in usbctrl_vendorreq()
Date:   Tue, 21 Sep 2021 20:18:19 +0200
Message-Id: <20210921181834.29677-2-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210921181834.29677-1-fmdefrancesco@gmail.com>
References: <20210921181834.29677-1-fmdefrancesco@gmail.com>
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

