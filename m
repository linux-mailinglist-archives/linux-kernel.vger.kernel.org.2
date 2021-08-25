Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5F603F6DEB
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 05:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238126AbhHYDyO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 23:54:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233162AbhHYDyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 23:54:06 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA49BC061764
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 20:53:20 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id x11so48800445ejv.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 20:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1w2cAGYWar4f5mxRu25K9hplCnJCtJjqAx1GoCfw1zc=;
        b=Or+K8vP4GiRm55Spkls60aiHZT7ReRr78K6klrNFNyiYLUPmwmce46E/Y7vbRAQpfX
         cjAeo0G7x3xouUOxsKqhUf8jtEyavXXUPkKeCCrDufynXci21yAPQywN5T6WGY5jnQ8L
         G9fQMJdXvczEf6L82c0mGQEQJzfO1G7Q6ctrC6WS/7DzvzhOUIxtqcdg/t185Q91/CFd
         C91pClEvVzuJ+RoVZBSusDJMm5w3lXNCC2MuF+ipAv3rVLk7HMVL7yBrA837kyT7OoHw
         KaFdpTVceED2fmuRC5uNJCczgd8Qj/YOh0dSTVLfhWLX6a2Z5d+LRlLxoCAnNKU7DF75
         VVbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1w2cAGYWar4f5mxRu25K9hplCnJCtJjqAx1GoCfw1zc=;
        b=GeiRVsaQjcaMUuBwao+v8fK0TuRiy+4FSRkMBMn1lbRlFtk0qKkHEn7MGVn5vMdgFm
         ZbIYC9B6bnAV8TSx+62KQWdoPzzE1ySEexFh4UwUR5QVpGBYX1yVgWI8IP9Rtr4f2VXL
         sPig8U6Uh7+DHak1Y/zF1lLm4k02OnGpLQT1oEcjUgDKnB7t2PbwBgBeQrjsyy/Svnwu
         iYv82TBcm/c9OqGjekZqZUkUnixkXa9/ewNatFI5aAO11TnGDQ7KnXNyrUzL6mH7SIYh
         HP7UobA3YXHs55orRSpFl51A00mgDJeBeTdsGZTVMKsyopoufbQupxh8CzSFxpvJ8Hz3
         Mp1w==
X-Gm-Message-State: AOAM53123VJnx/RINkOY+h+bcV6cQSbjastP4BXby07Nqsrvv39GAI93
        wT2e+xFZb29TQZ44fQ7MVR4=
X-Google-Smtp-Source: ABdhPJyfy3zTeeBonpeCnKFd0/Fx4wxkVUNZY6ZDEFrKM2L4HOtSH2EswPkBhvAIZ/B78TytWFkL5w==
X-Received: by 2002:a17:906:180a:: with SMTP id v10mr43620342eje.112.1629863599505;
        Tue, 24 Aug 2021 20:53:19 -0700 (PDT)
Received: from localhost.localdomain (host-79-22-100-164.retail.telecomitalia.it. [79.22.100.164])
        by smtp.gmail.com with ESMTPSA id b15sm4326751ejq.83.2021.08.24.20.53.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 20:53:19 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Pavel Skripkin <paskripkin@gmail.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v3 1/2] staging: r8188eu: Use usb_control_msg_recv/send() in usbctrl_vendorreq()
Date:   Wed, 25 Aug 2021 05:53:10 +0200
Message-Id: <20210825035311.8910-2-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210825035311.8910-1-fmdefrancesco@gmail.com>
References: <20210825035311.8910-1-fmdefrancesco@gmail.com>
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

v2->v3: Restore the test for success of usb_control_message_recv/send
that was inadvertently removed. Issue reported by Pavel Skripkin.

v1->v2: According to suggestions by Christophe JAILLET 
<christophe.jaillet@wanadoo.fr>, remove 'pipe' and pass an explicit 0
to the new API. According to suggestions by Pavel Skripkin 
<paskripkin@gmail.com>, remove an extra if-else that is no more needed, 
since status can be 0 and < 0 and there is no 3rd state, like it was before.
Many thanks to them and also to Phillip Potter <phil@philpotter.co.uk>
who kindly offered his time for the purpose of testing v1.

 drivers/staging/r8188eu/hal/usb_ops_linux.c | 45 ++++++++-------------
 1 file changed, 17 insertions(+), 28 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
index a93d5cfe4635..21581ca5f214 100644
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
+		if ((value >= FW_8188E_START_ADDRESS && value <= FW_8188E_END_ADDRESS) || !status)
 			break;
 	}
 release_mutex:
-- 
2.32.0

