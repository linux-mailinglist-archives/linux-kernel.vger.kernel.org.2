Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A8DC3F536B
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 00:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233130AbhHWWjA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 18:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233096AbhHWWiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 18:38:46 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3133DC061575
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 15:38:03 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id b7so28606122edu.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 15:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4ld900jyL6QKZg3xhi/oE/LIzTQAbQ0oX5h9lti0dsI=;
        b=TiECi5QwfHCq/q+SzixhKKkZclBoaBgkBTnfTj/Xbk15mT//5+Lbjusa0NztyQFiNV
         yMnYgu6Plg0igJLKOHzfsfodrKngz/yXVbNd+XNgUG/0onr4SxnDhGOMk1iabYEtRncJ
         adOjA+J8+9iojR4RxFCYv+Ihfh2ey2zfL4hIq0VqOI/uHw5yr29qX670KOU3b8kXu6fE
         v9aSJ/n/ySHNm47dDCjRkjXMNy3ypUT3zoc7iw/944l8oXL4UiGmqEoZlHkU6ZYblGEM
         w+Smt1GYMRk8TTkWTXqVL30CrwfvOItdaA9v4GiMw0vr3FzX5CBUpu2ZBMk0d//w+ezq
         fTiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4ld900jyL6QKZg3xhi/oE/LIzTQAbQ0oX5h9lti0dsI=;
        b=UvFXW4oWoH3el5aeZPw35hg61ce4osBux6Qcn9ALyMrguMXe3hwHsZQiqyHEQd9g/f
         GC/hSr7FJ9H7RcwxmY2RM0JI0fFbezYcmGVB0dU7gKNyxOYUHoXDtcZGayOtGAAE98Rz
         /EhitICUMeawHH4iLDT9HuKPHhjdDvxgClGee+ZlHwk+pKNnCfVBcOiyRLOB+7VWcuXL
         4u77Gh6H65mhrelPwLVdL/mV4oZS5PFJ70Ky/V+P9iAgm60t7rZgXxByJEyKw44Fqtm0
         hprqislCLukrIm5T0yx688PmMIQjwtolf/r4SAVd8CfWwV0uYNx8jBCyq93ywLsUJXnn
         2PxA==
X-Gm-Message-State: AOAM533dwg5woPR1K1A2n2rI2sqDt3bLyKwtzAKVTjxhnA86uEfNguAl
        LwR+kifIV+6/rGG4FaOLNx0=
X-Google-Smtp-Source: ABdhPJxoHJMfycnYlS6cxpTShraLaMMw3jXzi4EpxQ3bz9S7HtghF4ngD7SQYMJMGKB10fjk08/tLA==
X-Received: by 2002:a05:6402:328:: with SMTP id q8mr40486571edw.84.1629758281737;
        Mon, 23 Aug 2021 15:38:01 -0700 (PDT)
Received: from localhost.localdomain (host-79-22-100-164.retail.telecomitalia.it. [79.22.100.164])
        by smtp.gmail.com with ESMTPSA id p23sm10375326edw.94.2021.08.23.15.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 15:38:01 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Pavel Skripkin <paskripkin@gmail.com>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH 1/2] staging: r8188eu: Use usb_control_msg_recv/send() in usbctrl_vendorreq()
Date:   Tue, 24 Aug 2021 00:37:50 +0200
Message-Id: <20210823223751.25104-2-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210823223751.25104-1-fmdefrancesco@gmail.com>
References: <20210823223751.25104-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace usb_control_msg() with the new usb_control_msg_recv() and
usb_control_msg_send() API of USB Core in usbctrl_vendorreq().

Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---

Thanks to Pavel Skripkin <paskripkin@gmail.com> for his review of the
RFC patch.
 
drivers/staging/r8188eu/hal/usb_ops_linux.c | 25 ++++++++++-----------
1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
index a93d5cfe4635..6f51660b967a 100644
--- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
+++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
@@ -15,9 +15,8 @@ static int usbctrl_vendorreq(struct intf_hdl *pintfhdl, u16 value, void *pdata,
 	struct adapter	*adapt = pintfhdl->padapter;
 	struct dvobj_priv  *dvobjpriv = adapter_to_dvobj(adapt);
 	struct usb_device *udev = dvobjpriv->pusbdev;
-	unsigned int pipe;
+	u8 pipe;
 	int status = 0;
-	u8 reqtype;
 	u8 *pIo_buf;
 	int vendorreq_times = 0;
 
@@ -44,22 +43,22 @@ static int usbctrl_vendorreq(struct intf_hdl *pintfhdl, u16 value, void *pdata,
 	}
 
 	while (++vendorreq_times <= MAX_USBCTRL_VENDORREQ_TIMES) {
-		memset(pIo_buf, 0, len);
-
 		if (requesttype == 0x01) {
-			pipe = usb_rcvctrlpipe(udev, 0);/* read_in */
-			reqtype =  REALTEK_USB_VENQT_READ;
+			status = usb_control_msg_recv(udev, pipe, REALTEK_USB_VENQT_CMD_REQ,
+						      REALTEK_USB_VENQT_READ, value,
+						      REALTEK_USB_VENQT_CMD_IDX,
+						      pIo_buf, len, RTW_USB_CONTROL_MSG_TIMEOUT,
+						      GFP_KERNEL);
 		} else {
-			pipe = usb_sndctrlpipe(udev, 0);/* write_out */
-			reqtype =  REALTEK_USB_VENQT_WRITE;
 			memcpy(pIo_buf, pdata, len);
+			status = usb_control_msg_send(udev, pipe, REALTEK_USB_VENQT_CMD_REQ,
+						      REALTEK_USB_VENQT_WRITE, value,
+						      REALTEK_USB_VENQT_CMD_IDX,
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

