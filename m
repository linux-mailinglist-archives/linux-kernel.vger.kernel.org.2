Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FD2B305B27
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 13:23:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236313AbhA0MWA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 07:22:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237336AbhA0MOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 07:14:40 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4E32C061573;
        Wed, 27 Jan 2021 04:13:59 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id md11so1154087pjb.0;
        Wed, 27 Jan 2021 04:13:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YLLhgi+NiVGDqhBaYQHDfMrKV4DMWFVLqCYi85ZNzho=;
        b=K/LKbJ18NNtDlWPKhhN9q8pyPtPZcXJNc0IclJOz2d4MmqjquK68m1DYuIAIObBQjx
         S8bV5zkpxajM1TXSWIILfAA+BMOBLmnQT7MMuTTU0vIk4tckHYSivJ3jGocs/rWjw5CC
         L01TVUA+PGr2MMvekkAHBI+HuGlmsBaGXnSKkT3l6AXIkTLw8U+7U9Ijqr3OpqGfneno
         AVpfI4EwEg1Dzq2l8YrvEmwzJco05mk89YZKwABIpHVexBioetJBQGuqkBJOyzMFkWo9
         26a8VcKrkx0aaD2H21dK75yGbfbf+0cYq3oMNWNuBlneq71AeR4pimCYtCJqYDRQWIVb
         394w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YLLhgi+NiVGDqhBaYQHDfMrKV4DMWFVLqCYi85ZNzho=;
        b=Gvl9dC3MsblE4tvKst+tZG+gw/L14t1+caAMgHj2Zqp2zH18cu2yV78ZYaZN01H03s
         AF1IXN3afurCrMuphoBuF2Pfn9inictVZH8UR3/ZNvhSwjZjS9HZDIv6XdP9rF5AxjbP
         cMsZ1wpcwOyxkkI/H9TChbMYe2xK4d/denwaU1VZs2GWUjjkbadCI+QAKR6nV7uzw9B/
         O8XG8IP0UwGeQ9Yl0q/XuAhd+W/0zLGfcKyw9T9sm+UOuJZz8k3vxXJhAGqkZpjd4Vn/
         1nxuO5QUIgWdUFwNpRcTKQ3OJLzkblRB6MmkWXE+YTlAjfwnP6J+bUrt9RrXPtUbNwhn
         Guxw==
X-Gm-Message-State: AOAM53084di7D2n8x+pMglWcOqIBGohwR1X/scUe6SWQ4XKQN/p64eMs
        MYOWu6YZZGCYNef51V4XbYo=
X-Google-Smtp-Source: ABdhPJwGlxqoH0mpc3HshizQEQaAmfuPRd9Ap8ytEXfRDlWeUY6tHV3ZCb0e9VW5oWGOTadzRqU9sA==
X-Received: by 2002:a17:903:1c2:b029:de:ad0a:2dbf with SMTP id e2-20020a17090301c2b02900dead0a2dbfmr11190998plh.44.1611749639192;
        Wed, 27 Jan 2021 04:13:59 -0800 (PST)
Received: from localhost.localdomain ([49.207.195.86])
        by smtp.gmail.com with ESMTPSA id 67sm2365488pfv.20.2021.01.27.04.13.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jan 2021 04:13:58 -0800 (PST)
From:   Anant Thazhemadam <anant.thazhemadam@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Anant Thazhemadam <anant.thazhemadam@gmail.com>,
        Bixuan Cui <cuibixuan@huawei.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Zqiang <qiang.zhang@windriver.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RESEND PATCH v3 12/12] usb: misc: usbtest: update to use the usb_control_msg_{send|recv}() API
Date:   Wed, 27 Jan 2021 17:42:47 +0530
Message-Id: <20210127121247.9938-1-anant.thazhemadam@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210126183403.911653-1-anant.thazhemadam@gmail.com>
References: <20210126183403.911653-1-anant.thazhemadam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The newer usb_control_msg_{send|recv}() API are an improvement on the
existing usb_control_msg() as it ensures that a short read/write is treated
as an error, data can be used off the stack, and raw usb pipes need not be
created in the calling functions.
For this reason, instances of usb_control_msg() have been replaced with
usb_control_msg_{recv|send}() and the return value checking conditions have
also been modified appropriately.

Signed-off-by: Anant Thazhemadam <anant.thazhemadam@gmail.com>
---
Resending this patch since the subject line for the initial submission 
(sent as a part of the patch series) wasn't set correctly.

 drivers/usb/misc/usbtest.c | 69 ++++++++++++++++----------------------
 1 file changed, 29 insertions(+), 40 deletions(-)

diff --git a/drivers/usb/misc/usbtest.c b/drivers/usb/misc/usbtest.c
index 150090ee4ec1..4337eff2a749 100644
--- a/drivers/usb/misc/usbtest.c
+++ b/drivers/usb/misc/usbtest.c
@@ -672,19 +672,15 @@ static int get_altsetting(struct usbtest_dev *dev)
 	struct usb_device	*udev = interface_to_usbdev(iface);
 	int			retval;
 
-	retval = usb_control_msg(udev, usb_rcvctrlpipe(udev, 0),
-			USB_REQ_GET_INTERFACE, USB_DIR_IN|USB_RECIP_INTERFACE,
-			0, iface->altsetting[0].desc.bInterfaceNumber,
-			dev->buf, 1, USB_CTRL_GET_TIMEOUT);
-	switch (retval) {
-	case 1:
-		return dev->buf[0];
-	case 0:
-		retval = -ERANGE;
-		fallthrough;
-	default:
+	retval = usb_control_msg_recv(udev, 0, USB_REQ_GET_INTERFACE,
+				      USB_DIR_IN|USB_RECIP_INTERFACE,
+				      0, iface->altsetting[0].desc.bInterfaceNumber,
+				      dev->buf, 1, USB_CTRL_GET_TIMEOUT, GFP_KERNEL);
+
+	if (retval < 0)
 		return retval;
-	}
+
+	return dev->buf[0];
 }
 
 static int set_altsetting(struct usbtest_dev *dev, int alternate)
@@ -872,14 +868,15 @@ static int ch9_postconfig(struct usbtest_dev *dev)
 		 * ... although some cheap devices (like one TI Hub I've got)
 		 * won't return config descriptors except before set_config.
 		 */
-		retval = usb_control_msg(udev, usb_rcvctrlpipe(udev, 0),
-				USB_REQ_GET_CONFIGURATION,
-				USB_DIR_IN | USB_RECIP_DEVICE,
-				0, 0, dev->buf, 1, USB_CTRL_GET_TIMEOUT);
-		if (retval != 1 || dev->buf[0] != expected) {
+		retval = usb_control_msg_recv(udev, 0, USB_REQ_GET_CONFIGURATION,
+					      USB_DIR_IN | USB_RECIP_DEVICE,  0,
+					      0, dev->buf, 1, USB_CTRL_GET_TIMEOUT,
+					      GFP_KERNEL);
+
+		if (retval != 0 || dev->buf[0] != expected) {
 			dev_err(&iface->dev, "get config --> %d %d (1 %d)\n",
 				retval, dev->buf[0], expected);
-			return (retval < 0) ? retval : -EDOM;
+			return retval;
 		}
 	}
 
@@ -1683,10 +1680,10 @@ static int test_halt(struct usbtest_dev *tdev, int ep, struct urb *urb)
 		return retval;
 
 	/* set halt (protocol test only), verify it worked */
-	retval = usb_control_msg(urb->dev, usb_sndctrlpipe(urb->dev, 0),
-			USB_REQ_SET_FEATURE, USB_RECIP_ENDPOINT,
-			USB_ENDPOINT_HALT, ep,
-			NULL, 0, USB_CTRL_SET_TIMEOUT);
+	retval = usb_control_msg_send(urb->dev, 0, USB_REQ_SET_FEATURE,
+				      USB_RECIP_ENDPOINT, USB_ENDPOINT_HALT,
+				      ep, NULL, 0, USB_CTRL_SET_TIMEOUT,
+				      GFP_KERNEL);
 	if (retval < 0) {
 		ERROR(tdev, "ep %02x couldn't set halt, %d\n", ep, retval);
 		return retval;
@@ -1845,30 +1842,22 @@ static int ctrl_out(struct usbtest_dev *dev,
 		/* write patterned data */
 		for (j = 0; j < len; j++)
 			buf[j] = (u8)(i + j);
-		retval = usb_control_msg(udev, usb_sndctrlpipe(udev, 0),
-				0x5b, USB_DIR_OUT|USB_TYPE_VENDOR,
-				0, 0, buf, len, USB_CTRL_SET_TIMEOUT);
-		if (retval != len) {
+		retval = usb_control_msg_send(udev, 0, 0x5b,
+					      USB_DIR_OUT | USB_TYPE_VENDOR, 0,
+					      0, buf, len, USB_CTRL_SET_TIMEOUT,
+					      GFP_KERNEL);
+		if (retval < 0) {
 			what = "write";
-			if (retval >= 0) {
-				ERROR(dev, "ctrl_out, wlen %d (expected %d)\n",
-						retval, len);
-				retval = -EBADMSG;
-			}
 			break;
 		}
 
 		/* read it back -- assuming nothing intervened!!  */
-		retval = usb_control_msg(udev, usb_rcvctrlpipe(udev, 0),
-				0x5c, USB_DIR_IN|USB_TYPE_VENDOR,
-				0, 0, buf, len, USB_CTRL_GET_TIMEOUT);
-		if (retval != len) {
+		retval = usb_control_msg_recv(udev, 0,
+					      0x5c, USB_DIR_IN|USB_TYPE_VENDOR,
+					      0, 0, buf, len, USB_CTRL_GET_TIMEOUT,
+					      GFP_KERNEL);
+		if (retval < 0) {
 			what = "read";
-			if (retval >= 0) {
-				ERROR(dev, "ctrl_out, rlen %d (expected %d)\n",
-						retval, len);
-				retval = -EBADMSG;
-			}
 			break;
 		}
 
-- 
2.25.1

