Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEF14424FB3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 11:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240477AbhJGJIV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 05:08:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:60132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240471AbhJGJIO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 05:08:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 32AEE610A0;
        Thu,  7 Oct 2021 09:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633597581;
        bh=6tNvzRHLV8l4CA0/hjuw2PI5nvhrwOnua9V6TngagYc=;
        h=From:To:Cc:Subject:Date:From;
        b=KNul1VIfUwm9tjWcCiwNhEp+itDg4SNVjUGVkJ3GW8ZXC+R1iT6LVKQa/KAZU3YQQ
         4rPCEoEaPQ/m6kIDyVDWunE2sEsM+U1VDGNLXSot6tbmgDgcUqV6DszwN8aZqSEUtm
         JoXyycvyE7uam2un4GdQRo9uO/lfY0+fXpDpWFFtGjeodniycYQSxJYtWbXJhQVrbW
         pr7v15782l7/iB9Z8S+kJUHDl7VINqS78jIfxUDepIlu9lRaSQMAjyITKaTszO4tVY
         bqXK08aOe6FHW/M1XASTSeGnP3P4jPckC9xktFodMrfqx/TIqKvt/fKWgpsuOFJcLd
         nzVH7e3wKNt0A==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1mYPM3-0004zq-Bs; Thu, 07 Oct 2021 11:06:20 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Razvan Heghedus <heghedus.razvan@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH] Revert "usb: misc: ehset: Workaround for "special" hubs"
Date:   Thu,  7 Oct 2021 11:06:01 +0200
Message-Id: <20211007090601.19156-1-johan@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit ce3e90d5a0cdbcb2ddebbf9e4363e59fa779ad3a.

The commit in question added list of quirky hubs, but the match
implementation clearly hasn't been tested at all.

First, hub_udev->dev.parent does not represent a USB interface so using
to_usb_interface() makes no sense and we'd be passing a random pointer
to usb_match_id().

Second, if hub_udev is a root hub it doesn't even even represent a USB
device.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/misc/ehset.c | 81 ++++++++--------------------------------
 1 file changed, 16 insertions(+), 65 deletions(-)

diff --git a/drivers/usb/misc/ehset.c b/drivers/usb/misc/ehset.c
index b848bbdee802..f87890f9cd26 100644
--- a/drivers/usb/misc/ehset.c
+++ b/drivers/usb/misc/ehset.c
@@ -18,47 +18,6 @@
 #define TEST_SINGLE_STEP_GET_DEV_DESC		0x0107
 #define TEST_SINGLE_STEP_SET_FEATURE		0x0108
 
-/*
- * A list of USB hubs which requires to disable the power
- * to the port before starting the testing procedures.
- */
-static const struct usb_device_id ehset_hub_list[] = {
-	{USB_DEVICE(0x0424, 0x4502)},
-	{USB_DEVICE(0x0424, 0x4913)},
-	{USB_DEVICE(0x0451, 0x8027)},
-	{}
-};
-
-static int ehset_prepare_port_for_testing(struct usb_device *hub_udev, u16 portnum)
-{
-	int ret = 0;
-
-	/*
-	 * The USB2.0 spec chapter 11.24.2.13 says that the USB port which is
-	 * going under test needs to be put in suspend before sending the
-	 * test command. Most hubs don't enforce this precondition, but there
-	 * are some hubs which needs to disable the power to the port before
-	 * starting the test.
-	 */
-	if (usb_match_id(to_usb_interface(hub_udev->dev.parent), ehset_hub_list)) {
-		ret = usb_control_msg_send(hub_udev, 0, USB_REQ_CLEAR_FEATURE,
-					   USB_RT_PORT, USB_PORT_FEAT_ENABLE,
-					   portnum, NULL, 0, 1000, GFP_KERNEL);
-		/* Wait for the port to be disabled. It's an arbitrary value
-		 * which worked every time.
-		 */
-		msleep(100);
-	} else {
-		/* For the hubs which are compliant with the spec,
-		 * put the port in SUSPEND.
-		 */
-		ret = usb_control_msg_send(hub_udev, 0, USB_REQ_SET_FEATURE,
-					   USB_RT_PORT, USB_PORT_FEAT_SUSPEND,
-					   portnum, NULL, 0, 1000, GFP_KERNEL);
-	}
-	return ret;
-}
-
 static int ehset_probe(struct usb_interface *intf,
 		       const struct usb_device_id *id)
 {
@@ -71,36 +30,28 @@ static int ehset_probe(struct usb_interface *intf,
 
 	switch (test_pid) {
 	case TEST_SE0_NAK_PID:
-		ret = ehset_prepare_port_for_testing(hub_udev, portnum);
-		if (!ret)
-			ret = usb_control_msg_send(hub_udev, 0, USB_REQ_SET_FEATURE,
-						   USB_RT_PORT, USB_PORT_FEAT_TEST,
-						   (USB_TEST_SE0_NAK << 8) | portnum,
-						   NULL, 0, 1000, GFP_KERNEL);
+		ret = usb_control_msg_send(hub_udev, 0, USB_REQ_SET_FEATURE,
+					   USB_RT_PORT, USB_PORT_FEAT_TEST,
+					   (USB_TEST_SE0_NAK << 8) | portnum,
+					   NULL, 0, 1000, GFP_KERNEL);
 		break;
 	case TEST_J_PID:
-		ret = ehset_prepare_port_for_testing(hub_udev, portnum);
-		if (!ret)
-			ret = usb_control_msg_send(hub_udev, 0, USB_REQ_SET_FEATURE,
-						   USB_RT_PORT, USB_PORT_FEAT_TEST,
-						   (USB_TEST_J << 8) | portnum, NULL, 0,
-						   1000, GFP_KERNEL);
+		ret = usb_control_msg_send(hub_udev, 0, USB_REQ_SET_FEATURE,
+					   USB_RT_PORT, USB_PORT_FEAT_TEST,
+					   (USB_TEST_J << 8) | portnum, NULL, 0,
+					   1000, GFP_KERNEL);
 		break;
 	case TEST_K_PID:
-		ret = ehset_prepare_port_for_testing(hub_udev, portnum);
-		if (!ret)
-			ret = usb_control_msg_send(hub_udev, 0, USB_REQ_SET_FEATURE,
-						   USB_RT_PORT, USB_PORT_FEAT_TEST,
-						   (USB_TEST_K << 8) | portnum, NULL, 0,
-						   1000, GFP_KERNEL);
+		ret = usb_control_msg_send(hub_udev, 0, USB_REQ_SET_FEATURE,
+					   USB_RT_PORT, USB_PORT_FEAT_TEST,
+					   (USB_TEST_K << 8) | portnum, NULL, 0,
+					   1000, GFP_KERNEL);
 		break;
 	case TEST_PACKET_PID:
-		ret = ehset_prepare_port_for_testing(hub_udev, portnum);
-		if (!ret)
-			ret = usb_control_msg_send(hub_udev, 0, USB_REQ_SET_FEATURE,
-						   USB_RT_PORT, USB_PORT_FEAT_TEST,
-						   (USB_TEST_PACKET << 8) | portnum,
-						   NULL, 0, 1000, GFP_KERNEL);
+		ret = usb_control_msg_send(hub_udev, 0, USB_REQ_SET_FEATURE,
+					   USB_RT_PORT, USB_PORT_FEAT_TEST,
+					   (USB_TEST_PACKET << 8) | portnum,
+					   NULL, 0, 1000, GFP_KERNEL);
 		break;
 	case TEST_HS_HOST_PORT_SUSPEND_RESUME:
 		/* Test: wait for 15secs -> suspend -> 15secs delay -> resume */
-- 
2.32.0

