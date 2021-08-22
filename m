Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA303F423E
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 01:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231841AbhHVXDX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Aug 2021 19:03:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbhHVXDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Aug 2021 19:03:22 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09C02C061575
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 16:02:41 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id u3so33025005ejz.1
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 16:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qcmFYHyHdQbe2MpjDtDCFg4l/AD/ofCMkrpwmvBTkbM=;
        b=c6V8uuGLQIAjUx85tmkbOdNlFWOtz4/nWFX5se86F0QNoOx7l4o9Y6caFbp00/t3FG
         Z8EI6eTTfBQfVYbfsdUHrrSCIOjOcBAt1FpVWDTgi5ziiOuF2DT1VRbS5RLaat4AO8Tb
         TwF7k0QOKuIgfmSj1f+m3Yk2KkpAQ9deMjQ73RpZbz5+yC/KXIEoe+aVmYglNouc4AFQ
         Z7zTWpXA76737ZZa8TSEo1nWbSBUD28Om+g5W+qBxuWzMyrDZwgF2zrsV3kF8M0IF+/O
         muGsGyMe5BlVTbZdnpIiwOENvGv0w5qnu4WeIGfM/BUmyzkpGoUON43yqASq5fN2eaAV
         PRlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qcmFYHyHdQbe2MpjDtDCFg4l/AD/ofCMkrpwmvBTkbM=;
        b=IqlY564xHTtcVT8WhFiq4rHxTdFIhf/ra3msOv4Cxi/0UTF4Kxvy/jER/fOh8VhlLv
         KL/rrED0o3GeesPS67+fqZImoiIOXNAGdjf5WYgkKuYliYdCPE/sFaZI5RJ69NK4afrx
         st35TeufFEDks67aC3nS8KJMhzNnbwkszhRYWYViEVIWM+lTk/1sbgEqGz0nW5+NZ59Q
         VmCW/6s2D+xrNz9SrnaaH1QGK1oj5eI9HdW7BBWeCvApt1iGoVDF2hgzp5RAvwSQM+O2
         YSMUqNDUUHhy4XnbdDdJYG3T3Bc3yFfW1Txc8lh9Qt1FrW/B3s90JQmETf3pQQytCbBp
         a6EQ==
X-Gm-Message-State: AOAM531UhGTqRPfAH8yZBls42t+wiDrUTx1M4jUWpSUrsq2q8dCsYE4z
        t0UErMEhSP1xfWpqWEuNESQ=
X-Google-Smtp-Source: ABdhPJywK2uGfORh1Yk871iA1iLoDKfUDx1npShz2yLQVw0CEwV1+SVatwLa/LpiJcUSEtx6ImThxQ==
X-Received: by 2002:a17:907:9546:: with SMTP id ex6mr11023382ejc.325.1629673359644;
        Sun, 22 Aug 2021 16:02:39 -0700 (PDT)
Received: from localhost.localdomain (host-79-22-100-164.retail.telecomitalia.it. [79.22.100.164])
        by smtp.gmail.com with ESMTPSA id z15sm1684461edr.80.2021.08.22.16.02.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Aug 2021 16:02:39 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev (open list:STAGING SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list),
        Pavel Skripkin <paskripkin@gmail.com>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH RFC] staging: r8188eu: Use usb_control_msg_recv/send() in usbctrl_vendorreq()
Date:   Mon, 23 Aug 2021 01:02:35 +0200
Message-Id: <20210822230235.10953-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace usb_control_msg() with the new usb_control_msg_recv() and
usb_control_msg_send() API of USB Core.

This patch is an RFC for different reasons:

1) I'm not sure if it is needed: while Greg Kroah-Hartman suggested to 
use the new API in a message to a thread that was about a series of patches
submitted by Pavel Skripkin (who decided to not use it), I cannot explain 
if and why the driver would benefit from this patch.
2) I have doubts about the sematic of the API I use here, so I'd like to
know whether or not I'm using them properly.
3) At the moment I cannot test the driver because I don't have my device
with me.
4) This patch could probably lead to a slight change in some lines of
Pavel's series (for sure in usb_read*()).

I'd like to hear from the Maintainers and other interested people if this
patch is worth to be considered and, in this case, if there are suggestions
for the purpose to improve it. 

Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 drivers/staging/r8188eu/hal/usb_ops_linux.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
index 6a0a24acf292..9e290c1cc449 100644
--- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
+++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
@@ -15,7 +15,7 @@ static int usbctrl_vendorreq(struct intf_hdl *pintfhdl, u16 value, void *pdata,
 	struct adapter	*adapt = pintfhdl->padapter;
 	struct dvobj_priv  *dvobjpriv = adapter_to_dvobj(adapt);
 	struct usb_device *udev = dvobjpriv->pusbdev;
-	unsigned int pipe;
+	u8 pipe;
 	int status = 0;
 	u8 reqtype;
 	u8 *pIo_buf;
@@ -47,19 +47,20 @@ static int usbctrl_vendorreq(struct intf_hdl *pintfhdl, u16 value, void *pdata,
 		memset(pIo_buf, 0, len);
 
 		if (requesttype == 0x01) {
-			pipe = usb_rcvctrlpipe(udev, 0);/* read_in */
 			reqtype =  REALTEK_USB_VENQT_READ;
+			status = usb_control_msg_recv(udev, pipe, REALTEK_USB_VENQT_CMD_REQ,
+						      reqtype, value, REALTEK_USB_VENQT_CMD_IDX,
+						      pIo_buf, len, RTW_USB_CONTROL_MSG_TIMEOUT,
+						      GFP_KERNEL);
 		} else {
-			pipe = usb_sndctrlpipe(udev, 0);/* write_out */
 			reqtype =  REALTEK_USB_VENQT_WRITE;
-			memcpy(pIo_buf, pdata, len);
+			status = usb_control_msg_send(udev, pipe, REALTEK_USB_VENQT_CMD_REQ,
+						      reqtype, value, REALTEK_USB_VENQT_CMD_IDX,
+						      pIo_buf, len, RTW_USB_CONTROL_MSG_TIMEOUT,
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
-- 
2.32.0

