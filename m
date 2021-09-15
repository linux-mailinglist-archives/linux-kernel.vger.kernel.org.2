Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98E4940C507
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 14:17:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237485AbhIOMS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 08:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232399AbhIOMS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 08:18:28 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8450C061574;
        Wed, 15 Sep 2021 05:17:09 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id t8so3580452wrq.4;
        Wed, 15 Sep 2021 05:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kcS2XyyHq4ePpqFxgqBZYVU+YiIVDnpExo/3UThHlpY=;
        b=feGAmNrkw6Q3FUFkc1YDFe6vPTegqPB5Ux8vOjTw69oc3voQyjgPEIVUL16kwAVNh7
         UKEBbYRy5oC/aKNUJbuoVgs9aV7+llCcbWZ4rCaTt0xlvabNWmvtmnkJP9oaDVJsOjxY
         rc3EfK/zU1FmEhKvz4AkSsdW07KjH2JRSzf4CQeeL/LkylXOHBCXbv5Sk921MBXPcIY+
         HaD1NQlvUnfvxfjQE8dgmDXgg+i/Jp7FUClBQ0qylJ2Fra5RgIHZKxbvnyaxOP52M+Jj
         sJI0UZjVC0ELCC9aPPrxjdrI3yFI8W5u8B60bvPtjLMDoM+/mPW3IaT9xgYrJTy1O2v+
         4gEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kcS2XyyHq4ePpqFxgqBZYVU+YiIVDnpExo/3UThHlpY=;
        b=2lcTMRSuVwTjS/6jUSSoTj/ERGU0I1BbZey9mVZUZ6AdWSBWRj0I7XwMtvV3yt9xrr
         Dzzyy4MEJ0y65vy/wO6Fj7MGlKtYMEQHgT1UMG2NJEFzN6RwcLi9U4JnvWwbEgLJbqG6
         kjlwgawW2HDYUcHnwpq2OEJWrN6p9OkGvX97Y+bkaWHjwkp6FYzw6QqV7pTUslMlIt6+
         QziVqhsxRYkRiUXEZnowQ39r6rRFPaxeq73NabLizKGVPxojp3rDDNmBkbTxsDUHMB/0
         6fvr9HoMNQ2XRAcwTrmfVhCGOn0sUQZYl3Q7KhCSeVfQsLGNIdSOC78KzipR8rlyF7Cs
         B+sg==
X-Gm-Message-State: AOAM530b/UiJzHoXGF8AqL1QV6Bwf81oVv2tsnStQkqkISog4asFCRvU
        gkVqCIUJD6ku1/F/08RoUxk=
X-Google-Smtp-Source: ABdhPJwXpvh6d2fHuiAIZ3Z+6VahDK/oZfdxpZp+tJJ4tHRqXbceS/l7pqyxeEemy07MJE6XoLS3KQ==
X-Received: by 2002:adf:e684:: with SMTP id r4mr4763112wrm.229.1631708228396;
        Wed, 15 Sep 2021 05:17:08 -0700 (PDT)
Received: from CLU-56K1TB3.ad.garmin.com ([176.223.64.4])
        by smtp.gmail.com with ESMTPSA id m1sm4028225wmq.10.2021.09.15.05.17.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 05:17:08 -0700 (PDT)
From:   Razvan Heghedus <heghedus.razvan@gmail.com>
Cc:     heghedus.razvan@gmail.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>,
        Peter Chen <peter.chen@nxp.com>,
        Anant Thazhemadam <anant.thazhemadam@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] usb: misc: ehset: Workaround for "special" hubs
Date:   Wed, 15 Sep 2021 15:16:13 +0300
Message-Id: <20210915121615.3790-1-heghedus.razvan@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The USB2.0 spec chapter 11.24.2.13 says that the USB port which is going
under test needs to be put in suspend state before sending the test
command. Many hubs, don't enforce this precondition and they work fine
without this step. But there are some "special" hubs, which requires to
disable the port power before sending the test command.

Because the USB spec mention that the port should be suspended, also
do this step before sending the test command. This could rise the
problem with other hubs which are not compliant with the spec and the
test command will not work if the port is suspend. If such hubs are
found, a similar workaround like the disable part could be implemented
to skip the suspend port command.

Signed-off-by: Razvan Heghedus <heghedus.razvan@gmail.com>
---
 Changes in v2:
  - style change regarding multi-line comments and a new black line
    after local variable definitions
  - No more corporate email annotation
This time without that corporate email annotation.
Also has a couple of style changes regardind multi-line comments and a
black line after local variable definitions.
 drivers/usb/misc/ehset.c | 81 ++++++++++++++++++++++++++++++++--------
 1 file changed, 65 insertions(+), 16 deletions(-)

diff --git a/drivers/usb/misc/ehset.c b/drivers/usb/misc/ehset.c
index f87890f9cd26..b848bbdee802 100644
--- a/drivers/usb/misc/ehset.c
+++ b/drivers/usb/misc/ehset.c
@@ -18,6 +18,47 @@
 #define TEST_SINGLE_STEP_GET_DEV_DESC		0x0107
 #define TEST_SINGLE_STEP_SET_FEATURE		0x0108
 
+/*
+ * A list of USB hubs which requires to disable the power
+ * to the port before starting the testing procedures.
+ */
+static const struct usb_device_id ehset_hub_list[] = {
+	{USB_DEVICE(0x0424, 0x4502)},
+	{USB_DEVICE(0x0424, 0x4913)},
+	{USB_DEVICE(0x0451, 0x8027)},
+	{}
+};
+
+static int ehset_prepare_port_for_testing(struct usb_device *hub_udev, u16 portnum)
+{
+	int ret = 0;
+
+	/*
+	 * The USB2.0 spec chapter 11.24.2.13 says that the USB port which is
+	 * going under test needs to be put in suspend before sending the
+	 * test command. Most hubs don't enforce this precondition, but there
+	 * are some hubs which needs to disable the power to the port before
+	 * starting the test.
+	 */
+	if (usb_match_id(to_usb_interface(hub_udev->dev.parent), ehset_hub_list)) {
+		ret = usb_control_msg_send(hub_udev, 0, USB_REQ_CLEAR_FEATURE,
+					   USB_RT_PORT, USB_PORT_FEAT_ENABLE,
+					   portnum, NULL, 0, 1000, GFP_KERNEL);
+		/* Wait for the port to be disabled. It's an arbitrary value
+		 * which worked every time.
+		 */
+		msleep(100);
+	} else {
+		/* For the hubs which are compliant with the spec,
+		 * put the port in SUSPEND.
+		 */
+		ret = usb_control_msg_send(hub_udev, 0, USB_REQ_SET_FEATURE,
+					   USB_RT_PORT, USB_PORT_FEAT_SUSPEND,
+					   portnum, NULL, 0, 1000, GFP_KERNEL);
+	}
+	return ret;
+}
+
 static int ehset_probe(struct usb_interface *intf,
 		       const struct usb_device_id *id)
 {
@@ -30,28 +71,36 @@ static int ehset_probe(struct usb_interface *intf,
 
 	switch (test_pid) {
 	case TEST_SE0_NAK_PID:
-		ret = usb_control_msg_send(hub_udev, 0, USB_REQ_SET_FEATURE,
-					   USB_RT_PORT, USB_PORT_FEAT_TEST,
-					   (USB_TEST_SE0_NAK << 8) | portnum,
-					   NULL, 0, 1000, GFP_KERNEL);
+		ret = ehset_prepare_port_for_testing(hub_udev, portnum);
+		if (!ret)
+			ret = usb_control_msg_send(hub_udev, 0, USB_REQ_SET_FEATURE,
+						   USB_RT_PORT, USB_PORT_FEAT_TEST,
+						   (USB_TEST_SE0_NAK << 8) | portnum,
+						   NULL, 0, 1000, GFP_KERNEL);
 		break;
 	case TEST_J_PID:
-		ret = usb_control_msg_send(hub_udev, 0, USB_REQ_SET_FEATURE,
-					   USB_RT_PORT, USB_PORT_FEAT_TEST,
-					   (USB_TEST_J << 8) | portnum, NULL, 0,
-					   1000, GFP_KERNEL);
+		ret = ehset_prepare_port_for_testing(hub_udev, portnum);
+		if (!ret)
+			ret = usb_control_msg_send(hub_udev, 0, USB_REQ_SET_FEATURE,
+						   USB_RT_PORT, USB_PORT_FEAT_TEST,
+						   (USB_TEST_J << 8) | portnum, NULL, 0,
+						   1000, GFP_KERNEL);
 		break;
 	case TEST_K_PID:
-		ret = usb_control_msg_send(hub_udev, 0, USB_REQ_SET_FEATURE,
-					   USB_RT_PORT, USB_PORT_FEAT_TEST,
-					   (USB_TEST_K << 8) | portnum, NULL, 0,
-					   1000, GFP_KERNEL);
+		ret = ehset_prepare_port_for_testing(hub_udev, portnum);
+		if (!ret)
+			ret = usb_control_msg_send(hub_udev, 0, USB_REQ_SET_FEATURE,
+						   USB_RT_PORT, USB_PORT_FEAT_TEST,
+						   (USB_TEST_K << 8) | portnum, NULL, 0,
+						   1000, GFP_KERNEL);
 		break;
 	case TEST_PACKET_PID:
-		ret = usb_control_msg_send(hub_udev, 0, USB_REQ_SET_FEATURE,
-					   USB_RT_PORT, USB_PORT_FEAT_TEST,
-					   (USB_TEST_PACKET << 8) | portnum,
-					   NULL, 0, 1000, GFP_KERNEL);
+		ret = ehset_prepare_port_for_testing(hub_udev, portnum);
+		if (!ret)
+			ret = usb_control_msg_send(hub_udev, 0, USB_REQ_SET_FEATURE,
+						   USB_RT_PORT, USB_PORT_FEAT_TEST,
+						   (USB_TEST_PACKET << 8) | portnum,
+						   NULL, 0, 1000, GFP_KERNEL);
 		break;
 	case TEST_HS_HOST_PORT_SUSPEND_RESUME:
 		/* Test: wait for 15secs -> suspend -> 15secs delay -> resume */
-- 
2.33.0

