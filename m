Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62E253F6066
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 16:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237772AbhHXOaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 10:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237310AbhHXOaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 10:30:12 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F39ACC061757
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 07:29:27 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id u14so19942110ejf.13
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 07:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+IjsyQxtMvVoSlmXlJccBcJQMxnxgU9X+CivOPIrpF8=;
        b=Ql7aJQkf8awF8bORcFW1ITvAmQcGJUZZ8L1I2cHJmIdLfnc6DpvXb+SZj5ZZ78oswn
         oHn997gLeZwvWAaJj8rIv6TdYo66VUB4w5dYDPAZZvXMiNjdAKMN/hGgJljHtygms5FP
         a11QEQOo+XA1P38oNaOTAv/8gJg+mc2pnDCbcJSRj2UuJTSJzLkctOXaKh7sd4p2GOc4
         6Z37ynjwC4MQqI/xwe1c1TjQ0t4pJrEEkM9LA7Z/DDkbnR/4Ah/Ut27QpJRgudndnFQb
         wPa9DoE0TkBPDChxEq/TgSPs36hTAZjdfQVBZ/T0EwEC/1uclazofwYmcWAoK8ronotv
         7B9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+IjsyQxtMvVoSlmXlJccBcJQMxnxgU9X+CivOPIrpF8=;
        b=iS3euhfWwHyWiXnD9+/bwriR5NB3EMLk3n8uiqx9M0TuFwiPSvkdifFz/VuOZoFnri
         6WV8CtX3Gy/S6K7bqoWIGQ1ibUGzdTsEhImfqcGdgEzIBE5BOPl1DE1KqtKzxCca9Dx4
         IImvni6AWnPDAWv802mS2CRxsv4b/LW2CXq6H6CfLKZhKqXSxqnrEF24EUkKaVfW68FS
         RF4nFa6xIooZI5JfG7BwR6GsBoR+rEQpCDwwaWOGjON/a2jNWSSd3YjncUQAv5YiVJZ5
         KaBCl7on+mHvH5LaTUlRik+n/u1MHk5htY5BGs3YjUifBGf24HJt3K5ViRZ0X2b30Z/E
         RLoQ==
X-Gm-Message-State: AOAM530ZtFb9VfAuh5PcDWkuICHfvkb3ITRchmYgpU0IqeEkxW1IpSFu
        4qESSyruS9dl42+VwhGXcR0=
X-Google-Smtp-Source: ABdhPJxj/1LSnJVHJWb606Al+xogyUfGlavwFD/ODnl/sbOJK0UoRGhla2BOlCEEeUUaddmaAn0sJA==
X-Received: by 2002:a17:906:1416:: with SMTP id p22mr40385228ejc.364.1629815366568;
        Tue, 24 Aug 2021 07:29:26 -0700 (PDT)
Received: from localhost.localdomain (host-79-22-100-164.retail.telecomitalia.it. [79.22.100.164])
        by smtp.gmail.com with ESMTPSA id r2sm11873480edv.78.2021.08.24.07.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 07:29:26 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Pavel Skripkin <paskripkin@gmail.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH 2/2] staging: r8188eu: Make some clean-ups in usbctrl_vendorreq()
Date:   Tue, 24 Aug 2021 16:28:23 +0200
Message-Id: <20210824142823.16845-3-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210824142823.16845-1-fmdefrancesco@gmail.com>
References: <20210824142823.16845-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After replacing usb_control_msg() with the new usb_control_msg_recv() and
usb_control_msg_send() API of USB Core, remove camelcase from the pIo_buf
variable that is passed as argument to the new API and remove the initial
'p' (that probably stands for "pointer") from the same pIo_buf and from
the pintfhdl and pdata arguments of usbctrl_vendorreq().

Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 drivers/staging/r8188eu/hal/usb_ops_linux.c | 22 ++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
index 13e925d21e00..a038aaa5a624 100644
--- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
+++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
@@ -10,13 +10,13 @@
 #include "../include/recv_osdep.h"
 #include "../include/rtl8188e_hal.h"
 
-static int usbctrl_vendorreq(struct intf_hdl *pintfhdl, u16 value, void *pdata, u16 len, u8 requesttype)
+static int usbctrl_vendorreq(struct intf_hdl *intfhdl, u16 value, void *data, u16 len, u8 requesttype)
 {
-	struct adapter	*adapt = pintfhdl->padapter;
+	struct adapter	*adapt = intfhdl->padapter;
 	struct dvobj_priv  *dvobjpriv = adapter_to_dvobj(adapt);
 	struct usb_device *udev = dvobjpriv->pusbdev;
 	int status = 0;
-	u8 *pIo_buf;
+	u8 *io_buf;
 	int vendorreq_times = 0;
 
 	if ((adapt->bSurpriseRemoved) || (adapt->pwrctrlpriv.pnp_bstop_trx)) {
@@ -33,10 +33,10 @@ static int usbctrl_vendorreq(struct intf_hdl *pintfhdl, u16 value, void *pdata,
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
@@ -45,14 +45,14 @@ static int usbctrl_vendorreq(struct intf_hdl *pintfhdl, u16 value, void *pdata,
 		if (requesttype == 0x01) {
 			status = usb_control_msg_recv(udev, 0, REALTEK_USB_VENQT_CMD_REQ,
 						      REALTEK_USB_VENQT_READ, value,
-						      REALTEK_USB_VENQT_CMD_IDX, pIo_buf,
+						      REALTEK_USB_VENQT_CMD_IDX, io_buf,
 						      len, RTW_USB_CONTROL_MSG_TIMEOUT,
 						      GFP_KERNEL);
 		} else {
-			memcpy(pIo_buf, pdata, len);
+			memcpy(io_buf, data, len);
 			status = usb_control_msg_send(udev, 0, REALTEK_USB_VENQT_CMD_REQ,
 						      REALTEK_USB_VENQT_WRITE, value,
-						      REALTEK_USB_VENQT_CMD_IDX, pIo_buf,
+						      REALTEK_USB_VENQT_CMD_IDX, io_buf,
 						      len, RTW_USB_CONTROL_MSG_TIMEOUT,
 						      GFP_KERNEL);
 		}
@@ -60,11 +60,11 @@ static int usbctrl_vendorreq(struct intf_hdl *pintfhdl, u16 value, void *pdata,
 		if (!status) {   /*  Success this control transfer. */
 			rtw_reset_continual_urb_error(dvobjpriv);
 			if (requesttype == 0x01)
-				memcpy(pdata, pIo_buf,  len);
+				memcpy(data, io_buf,  len);
 		} else { /*  error cases */
 			DBG_88E("reg 0x%x, usb %s %u fail, status:%d value=0x%x, vendorreq_times:%d\n",
 				value, (requesttype == 0x01) ? "read" : "write",
-				len, status, *(u32 *)pdata, vendorreq_times);
+				len, status, *(u32 *)data, vendorreq_times);
 
 			if (status == (-ESHUTDOWN) || status == -ENODEV) {
 				adapt->bSurpriseRemoved = true;
-- 
2.32.0

