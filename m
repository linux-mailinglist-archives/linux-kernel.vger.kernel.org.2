Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 550003D7DBB
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 20:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231640AbhG0Scj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 14:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbhG0Sce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 14:32:34 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A412C061765;
        Tue, 27 Jul 2021 11:32:31 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id h14so23329387lfv.7;
        Tue, 27 Jul 2021 11:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ni9d4GzSQFfwhqPx8Gkoyybb1Q0rtG7dEF0EzTUPjlE=;
        b=WS3UH+S8XHbWuEciXqSYFXERDceNzNb4BhpvYPNDpZjYK+nYzjEdzcX5XDGMMr/Pij
         P6ZMWYkmtjDGB9qWmrzMsFzgsi2lZd7Q4I7bODwGguVWHfGvixzzPBkc1by4MmF6rkKf
         fJ5gDZ2zQphd8HBTtaW3r5+7iwmB72Hv42GKjBd/+0Vv5F6W6eTu5RfjxlKU09Ds/BHX
         fePZXrPa/2WexGH5E4slybR6MtiRtFVSdfVLVSSXDitYaefCnafEZhlN0S1hFx58hs6R
         /Y62oeLMUiLKr74D7l/u7Q/bUcabPRtjrASEaUom3uZCM6MLq0X9LulzzHmjOhPJ8ZD6
         VcTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ni9d4GzSQFfwhqPx8Gkoyybb1Q0rtG7dEF0EzTUPjlE=;
        b=D1hZp/q1iIXdHqwvZAfJTKWV9SXJHPObp4dEYW8185pTwFfTOBjRdlDY8S+Pyyv/s3
         qincRlB5esBATNt6VLp3EQ7g4osLGfON1iKVa88whjaFrYW8/w1Eg5SHTcvIcmDwbvsS
         x6SWTfs+CBNKlfAyBbRnRhm4Mu1nKxJamkjNUwUHR+lkMc4Ok6DdzuIF0Hw1Bbs69G/z
         AFqIT78kLKhMKSeDKc31u1nrjF37H59S4DCGCMN+P6RekPz8ld98BZLCyFzUFWAPYodo
         ODgA3fBnsi/OJ3YPvHvra60pKE6wtRnxGLDD1+MFJOyaMZ/FYWwyc/Hk0RjpdPV8PX0G
         A3Gg==
X-Gm-Message-State: AOAM532JY7/EBiq/ARU0+bfwPsVgQWV27NHyOshv+K1f26Cm39qa+EJj
        vcoJ8JDxPgUP/QfgVfBJsMc=
X-Google-Smtp-Source: ABdhPJzxVaAJxzF9UODfocIvLHq2yFd0PXH0GJpMAJAQXOYgoLZ1aK03iSjprcXO18Ig2n6J0T1tJw==
X-Received: by 2002:a05:6512:32aa:: with SMTP id q10mr16971418lfe.368.1627410749912;
        Tue, 27 Jul 2021 11:32:29 -0700 (PDT)
Received: from localhost.localdomain (broadband-95-84-198-152.ip.moscow.rt.ru. [95.84.198.152])
        by smtp.gmail.com with ESMTPSA id b41sm326637ljr.67.2021.07.27.11.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 11:32:29 -0700 (PDT)
From:   Maxim Devaev <mdevaev@gmail.com>
To:     balbi@kernel.org
Cc:     gregkh@linuxfoundation.org, sandeen@redhat.com, mdevaev@gmail.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] usb: gadget: f_hid: added GET_IDLE and SET_IDLE handlers
Date:   Tue, 27 Jul 2021 21:31:41 +0300
Message-Id: <20210727183140.42330-1-mdevaev@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The USB HID standard declares mandatory support for GET_IDLE and SET_IDLE
requests for Boot Keyboard. Most hosts can handle their absence, but others
like some old/strange UEFIs and BIOSes consider this a critical error
and refuse to work with f_hid.

This primitive implementation of saving and returning idle is sufficient
to meet the requirements of the standard and these devices.

Signed-off-by: Maxim Devaev <mdevaev@gmail.com>
---
 drivers/usb/gadget/function/f_hid.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/usb/gadget/function/f_hid.c b/drivers/usb/gadget/function/f_hid.c
index 02683ac07..1010f0a3e 100644
--- a/drivers/usb/gadget/function/f_hid.c
+++ b/drivers/usb/gadget/function/f_hid.c
@@ -41,6 +41,7 @@ struct f_hidg {
 	unsigned char			bInterfaceSubClass;
 	unsigned char			bInterfaceProtocol;
 	unsigned char			protocol;
+	unsigned char			idle;
 	unsigned short			report_desc_length;
 	char				*report_desc;
 	unsigned short			report_length;
@@ -523,6 +524,14 @@ static int hidg_setup(struct usb_function *f,
 		goto respond;
 		break;
 
+	case ((USB_DIR_IN | USB_TYPE_CLASS | USB_RECIP_INTERFACE) << 8
+		  | HID_REQ_GET_IDLE):
+		VDBG(cdev, "get_idle\n");
+		length = min_t(unsigned int, length, 1);
+		((u8 *) req->buf)[0] = hidg->idle;
+		goto respond;
+		break;
+
 	case ((USB_DIR_OUT | USB_TYPE_CLASS | USB_RECIP_INTERFACE) << 8
 		  | HID_REQ_SET_REPORT):
 		VDBG(cdev, "set_report | wLength=%d\n", ctrl->wLength);
@@ -546,6 +555,14 @@ static int hidg_setup(struct usb_function *f,
 		goto stall;
 		break;
 
+	case ((USB_DIR_OUT | USB_TYPE_CLASS | USB_RECIP_INTERFACE) << 8
+		  | HID_REQ_SET_IDLE):
+		VDBG(cdev, "set_idle\n");
+		length = 0;
+		hidg->idle = value >> 8;
+		goto respond;
+		break;
+
 	case ((USB_DIR_IN | USB_TYPE_STANDARD | USB_RECIP_INTERFACE) << 8
 		  | USB_REQ_GET_DESCRIPTOR):
 		switch (value >> 8) {
@@ -773,6 +790,7 @@ static int hidg_bind(struct usb_configuration *c, struct usb_function *f)
 	hidg_interface_desc.bInterfaceSubClass = hidg->bInterfaceSubClass;
 	hidg_interface_desc.bInterfaceProtocol = hidg->bInterfaceProtocol;
 	hidg->protocol = HID_REPORT_PROTOCOL;
+	hidg->idle = 1;
 	hidg_ss_in_ep_desc.wMaxPacketSize = cpu_to_le16(hidg->report_length);
 	hidg_ss_in_comp_desc.wBytesPerInterval =
 				cpu_to_le16(hidg->report_length);
-- 
2.32.0

