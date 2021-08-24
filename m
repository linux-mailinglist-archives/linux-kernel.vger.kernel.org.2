Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BEC63F6064
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 16:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237733AbhHXO36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 10:29:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237310AbhHXO34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 10:29:56 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81506C061757
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 07:29:12 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a25so18091431ejv.6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 07:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vN+dgvF4hmE+Iar5EJri+h+yPSWNSBEiO5gOFOWoxjs=;
        b=bIrIkvIKwsKP3xOSJLtz7l5QujFVtvzFxh/hS0r3KIAyAM7JcklDixFz31aHDbwS67
         TFwm1665MVGD7Tx8FGxvn+LSX1v+9VG+M3Rrn+gDtOJGIZpO3cUMsKr2WEePF6IOuLF4
         J3kdNnphlo4MWUqVKpOLq9I5aXMLqlEHeeAs6Or8srfgdi2/1aYesXCilVy18nGd3BSx
         UddcKjctVRfJHYvtisLI5/E0DcVkL6I3lmQkRAy8x2BWehyhNTh2oCnN8WHin24Dp0QL
         mRsjIsutWrXS2ESTBI0PBJbXIO85oAfAE64pSHS2ndRs4he0NqFADj1G4LxjuDOijWwS
         DBog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vN+dgvF4hmE+Iar5EJri+h+yPSWNSBEiO5gOFOWoxjs=;
        b=ISr6XBVDui0gIk3H8GnYtNzg45k1gFM5OMhfMdC7Z9JAfH9sghO/CUO6DXYTxP0ueN
         +YgkeNPXqewcJUeRNrKG/qIpZvhM1jzwaxkQq+BXdxFxYDFF+uo9PVwOcZ0puWVJja5E
         BynsoEC+sP6iZatBDGubRx8d2OZWOsp2v6ld98Z6rt4RfWoFGVUc1SjGyt5t6ScF+94k
         21idBj/co1CYxEOzHgmHmwNcrmAkueLnGZDKkc1pIG/brlOZGfMNjVwO95UrpKMapGF0
         L+qvvKVStbgxAXl7OWGgYTSZEzAKPLwIYQH4X0CQJ0D6/aPdY0XddOF6aloC2AqlcJGF
         SJUQ==
X-Gm-Message-State: AOAM531I+EgOpUJVpDpD1lHbr6fXk0SjNNtBhW4Sma11/BABbsSWaEpM
        tIdcYO6buoZBIQKaQ+l3mfs=
X-Google-Smtp-Source: ABdhPJwkaoTSkOSaBKa5mevsMoz0FAbZr6qETNmc2za3wdzuC0/h2bmLWR45UColvDz1tFYhWB/EZQ==
X-Received: by 2002:a17:906:520b:: with SMTP id g11mr4664892ejm.502.1629815351027;
        Tue, 24 Aug 2021 07:29:11 -0700 (PDT)
Received: from localhost.localdomain (host-79-22-100-164.retail.telecomitalia.it. [79.22.100.164])
        by smtp.gmail.com with ESMTPSA id r2sm11873480edv.78.2021.08.24.07.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 07:29:10 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Pavel Skripkin <paskripkin@gmail.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v2 1/2] staging: r8188eu: Use usb_control_msg_recv/send() in usbctrl_vendorreq()
Date:   Tue, 24 Aug 2021 16:28:22 +0200
Message-Id: <20210824142823.16845-2-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210824142823.16845-1-fmdefrancesco@gmail.com>
References: <20210824142823.16845-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace usb_control_msg() with the new usb_control_msg_recv() and
usb_control_msg_send() API of USB Core in usbctrl_vendorreq().
Remove no more needed variables. Move out of an if-else block
some code that it is no more dependent on status < 0. Remove
redundant code depending on status > 0 or status == len.

Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---

v1->v2: According to suggestions by Christophe JAILLET 
<christophe.jaillet@wanadoo.fr>, remove 'pipe' and pass an explicit 0
to the new API. According to suggestions by Pavel Skripkin 
<paskripkin@gmail.com>, remove an extra if-else that is no more needed, 
since status can be 0 and < 0 and there is no 3rd state, like it was before.
Many thanks to both them and to Phillip Potter <phil@philpotter.co.uk>
who kindly offered his time for the purpose of testing v1.
 

 drivers/staging/r8188eu/hal/usb_ops_linux.c | 45 ++++++++-------------
 1 file changed, 17 insertions(+), 28 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
index a93d5cfe4635..13e925d21e00 100644
--- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
+++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
@@ -15,9 +15,7 @@ static int usbctrl_vendorreq(struct intf_hdl *pintfhdl, u16 value, void *pdata,
 	struct adapter	*adapt = pintfhdl->padapter;
 	struct dvobj_priv  *dvobjpriv = adapter_to_dvobj(adapt);
 	struct usb_device *udev = dvobjpriv->pusbdev;
-	unsigned int pipe;
 	int status = 0;
-	u8 reqtype;
 	u8 *pIo_buf;
 	int vendorreq_times = 0;
 
@@ -44,22 +42,22 @@ static int usbctrl_vendorreq(struct intf_hdl *pintfhdl, u16 value, void *pdata,
 	}
 
 	while (++vendorreq_times <= MAX_USBCTRL_VENDORREQ_TIMES) {
-		memset(pIo_buf, 0, len);
-
 		if (requesttype == 0x01) {
-			pipe = usb_rcvctrlpipe(udev, 0);/* read_in */
-			reqtype =  REALTEK_USB_VENQT_READ;
+			status = usb_control_msg_recv(udev, 0, REALTEK_USB_VENQT_CMD_REQ,
+						      REALTEK_USB_VENQT_READ, value,
+						      REALTEK_USB_VENQT_CMD_IDX, pIo_buf,
+						      len, RTW_USB_CONTROL_MSG_TIMEOUT,
+						      GFP_KERNEL);
 		} else {
-			pipe = usb_sndctrlpipe(udev, 0);/* write_out */
-			reqtype =  REALTEK_USB_VENQT_WRITE;
 			memcpy(pIo_buf, pdata, len);
+			status = usb_control_msg_send(udev, 0, REALTEK_USB_VENQT_CMD_REQ,
+						      REALTEK_USB_VENQT_WRITE, value,
+						      REALTEK_USB_VENQT_CMD_IDX, pIo_buf,
+						      len, RTW_USB_CONTROL_MSG_TIMEOUT,
+						      GFP_KERNEL);
 		}
 
-		status = usb_control_msg(udev, pipe, REALTEK_USB_VENQT_CMD_REQ,
-					 reqtype, value, REALTEK_USB_VENQT_CMD_IDX,
-					 pIo_buf, len, RTW_USB_CONTROL_MSG_TIMEOUT);
-
-		if (status == len) {   /*  Success this control transfer. */
+		if (!status) {   /*  Success this control transfer. */
 			rtw_reset_continual_urb_error(dvobjpriv);
 			if (requesttype == 0x01)
 				memcpy(pdata, pIo_buf,  len);
@@ -68,20 +66,11 @@ static int usbctrl_vendorreq(struct intf_hdl *pintfhdl, u16 value, void *pdata,
 				value, (requesttype == 0x01) ? "read" : "write",
 				len, status, *(u32 *)pdata, vendorreq_times);
 
-			if (status < 0) {
-				if (status == (-ESHUTDOWN) || status == -ENODEV) {
-					adapt->bSurpriseRemoved = true;
-				} else {
-					struct hal_data_8188e	*haldata = GET_HAL_DATA(adapt);
-					haldata->srestpriv.Wifi_Error_Status = USB_VEN_REQ_CMD_FAIL;
-				}
-			} else { /*  status != len && status >= 0 */
-				if (status > 0) {
-					if (requesttype == 0x01) {
-						/*  For Control read transfer, we have to copy the read data from pIo_buf to pdata. */
-						memcpy(pdata, pIo_buf,  len);
-					}
-				}
+			if (status == (-ESHUTDOWN) || status == -ENODEV) {
+				adapt->bSurpriseRemoved = true;
+			} else {
+				struct hal_data_8188e	*haldata = GET_HAL_DATA(adapt);
+				haldata->srestpriv.Wifi_Error_Status = USB_VEN_REQ_CMD_FAIL;
 			}
 
 			if (rtw_inc_and_chk_continual_urb_error(dvobjpriv)) {
@@ -92,7 +81,7 @@ static int usbctrl_vendorreq(struct intf_hdl *pintfhdl, u16 value, void *pdata,
 		}
 
 		/*  firmware download is checksumed, don't retry */
-		if ((value >= FW_8188E_START_ADDRESS && value <= FW_8188E_END_ADDRESS) || status == len)
+		if (value >= FW_8188E_START_ADDRESS && value <= FW_8188E_END_ADDRESS)
 			break;
 	}
 release_mutex:
-- 
2.32.0

