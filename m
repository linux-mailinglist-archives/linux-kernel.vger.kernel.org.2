Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7276F34B232
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 23:34:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbhCZWeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 18:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbhCZWdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 18:33:55 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC918C0613AA;
        Fri, 26 Mar 2021 15:33:55 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id x126so5773327pfc.13;
        Fri, 26 Mar 2021 15:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7KLLuIVGI6Rr7hFWmC0jb94MNYsjTl6vCpgMsd7M+Wo=;
        b=mMoIE0d2FQR4+Xbwh0yyY0743Fo3D6McR5zTN4ptfzmp6iTRCEQPsDW4GUa+U8Xu+A
         Q4TDX8u885s3ZMnMEqkBvfWweAKOOajZtyeSm86y29XN9C2LmwYYrQeFI+SJJRjbupoC
         Q9CpSHlKKctMP2GG0820eGMwTrbksewI/dfk4Hf/KNxaKDII25ro4+gtR2EdRWreDGsd
         SvIQKK83dvS2nLDeNf2taYWPj+qS4xGepTB4x1sKyMc5TfF+QPBrTxRmuOf4qfTrJOxd
         hp/6ioJj0Xip43p9NA95LKeE2na4rx778J09x48xdgR6V2DEFmXkY18ynMWx3li7vDc0
         jIJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7KLLuIVGI6Rr7hFWmC0jb94MNYsjTl6vCpgMsd7M+Wo=;
        b=PswTKOoQR8TAsq/xegD5KbcoFVPJQ1L5cWGjoo/kAjL+K4+LGdoejTJzgKdz6vGUDc
         mGkprmUYgGD+Z81PHpil0IS1xzGMgGZfjT45yJ3D2uAYJBfDe60rZAp0JyiArXTnkt9F
         yieGWkneFapxKX5NVcaIy3Q5askhAK1XFQcr+y0vWnZlT6ck2VjQmcPRUxuZG02fhF1C
         RZi+7X2InAfl9jCKCMq7JIeuKzas2TYzAnSyN/eCkTial97WFnunxlOlAUWgZevrYdTg
         HbygaNOPVjxjvKfXJelE1dshsRb03u81S+F8ayr6v8BMiaXb4wXrJYRtTTrhj62j3y0g
         DFkw==
X-Gm-Message-State: AOAM5309UmlX6XtLDUcemkJNGS4KSHbzYCH7VBMJs+NxMcetfD95L0jV
        eR7PVthYRRrd7DOj8C05tLk=
X-Google-Smtp-Source: ABdhPJwEOWEXuEyGKQ/RJ1e8eeyJnWumv7O2hXRyXpU4SyELVck/Oav4gMFlFOw17WC0ONpBbaq+zQ==
X-Received: by 2002:a63:356:: with SMTP id 83mr14280478pgd.344.1616798035244;
        Fri, 26 Mar 2021 15:33:55 -0700 (PDT)
Received: from localhost.localdomain ([49.207.194.205])
        by smtp.gmail.com with ESMTPSA id c193sm10136262pfc.180.2021.03.26.15.33.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 15:33:54 -0700 (PDT)
From:   Anant Thazhemadam <anant.thazhemadam@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Chen <peter.chen@nxp.com>,
        Minas Harutyunyan <hminas@synopsys.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Anant Thazhemadam <anant.thazhemadam@gmail.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH v4 1/3] usb: misc: ehset: update to use the usb_control_msg_{send|recv}() API
Date:   Sat, 27 Mar 2021 04:02:49 +0530
Message-Id: <20210326223251.753952-2-anant.thazhemadam@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210326223251.753952-1-anant.thazhemadam@gmail.com>
References: <20210326223251.753952-1-anant.thazhemadam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The newer usb_control_msg_{send|recv}() API ensures that a short read
is treated as an error, data can be used off the stack, and raw usb
pipes need not be created in the calling functions.
For this reason, instances of usb_control_msg() have been replaced with
usb_control_msg_{recv|send}() appropriately.

Now, we also test for a short device descriptor (which USB core
should already have fetched if you get to probe this driver), but which
wasn't verified again here before.

Signed-off-by: Anant Thazhemadam <anant.thazhemadam@gmail.com>
Reviewed-by: Peter Chen <peter.chen@nxp.com>
Reviewed-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/misc/ehset.c | 76 +++++++++++++++++-----------------------
 1 file changed, 32 insertions(+), 44 deletions(-)

diff --git a/drivers/usb/misc/ehset.c b/drivers/usb/misc/ehset.c
index 2752e1f4f4d0..f87890f9cd26 100644
--- a/drivers/usb/misc/ehset.c
+++ b/drivers/usb/misc/ehset.c
@@ -24,68 +24,57 @@ static int ehset_probe(struct usb_interface *intf,
 	int ret = -EINVAL;
 	struct usb_device *dev = interface_to_usbdev(intf);
 	struct usb_device *hub_udev = dev->parent;
-	struct usb_device_descriptor *buf;
+	struct usb_device_descriptor buf;
 	u8 portnum = dev->portnum;
 	u16 test_pid = le16_to_cpu(dev->descriptor.idProduct);
 
 	switch (test_pid) {
 	case TEST_SE0_NAK_PID:
-		ret = usb_control_msg(hub_udev, usb_sndctrlpipe(hub_udev, 0),
-					USB_REQ_SET_FEATURE, USB_RT_PORT,
-					USB_PORT_FEAT_TEST,
-					(USB_TEST_SE0_NAK << 8) | portnum,
-					NULL, 0, 1000);
+		ret = usb_control_msg_send(hub_udev, 0, USB_REQ_SET_FEATURE,
+					   USB_RT_PORT, USB_PORT_FEAT_TEST,
+					   (USB_TEST_SE0_NAK << 8) | portnum,
+					   NULL, 0, 1000, GFP_KERNEL);
 		break;
 	case TEST_J_PID:
-		ret = usb_control_msg(hub_udev, usb_sndctrlpipe(hub_udev, 0),
-					USB_REQ_SET_FEATURE, USB_RT_PORT,
-					USB_PORT_FEAT_TEST,
-					(USB_TEST_J << 8) | portnum,
-					NULL, 0, 1000);
+		ret = usb_control_msg_send(hub_udev, 0, USB_REQ_SET_FEATURE,
+					   USB_RT_PORT, USB_PORT_FEAT_TEST,
+					   (USB_TEST_J << 8) | portnum, NULL, 0,
+					   1000, GFP_KERNEL);
 		break;
 	case TEST_K_PID:
-		ret = usb_control_msg(hub_udev, usb_sndctrlpipe(hub_udev, 0),
-					USB_REQ_SET_FEATURE, USB_RT_PORT,
-					USB_PORT_FEAT_TEST,
-					(USB_TEST_K << 8) | portnum,
-					NULL, 0, 1000);
+		ret = usb_control_msg_send(hub_udev, 0, USB_REQ_SET_FEATURE,
+					   USB_RT_PORT, USB_PORT_FEAT_TEST,
+					   (USB_TEST_K << 8) | portnum, NULL, 0,
+					   1000, GFP_KERNEL);
 		break;
 	case TEST_PACKET_PID:
-		ret = usb_control_msg(hub_udev, usb_sndctrlpipe(hub_udev, 0),
-					USB_REQ_SET_FEATURE, USB_RT_PORT,
-					USB_PORT_FEAT_TEST,
-					(USB_TEST_PACKET << 8) | portnum,
-					NULL, 0, 1000);
+		ret = usb_control_msg_send(hub_udev, 0, USB_REQ_SET_FEATURE,
+					   USB_RT_PORT, USB_PORT_FEAT_TEST,
+					   (USB_TEST_PACKET << 8) | portnum,
+					   NULL, 0, 1000, GFP_KERNEL);
 		break;
 	case TEST_HS_HOST_PORT_SUSPEND_RESUME:
 		/* Test: wait for 15secs -> suspend -> 15secs delay -> resume */
 		msleep(15 * 1000);
-		ret = usb_control_msg(hub_udev, usb_sndctrlpipe(hub_udev, 0),
-					USB_REQ_SET_FEATURE, USB_RT_PORT,
-					USB_PORT_FEAT_SUSPEND, portnum,
-					NULL, 0, 1000);
+		ret = usb_control_msg_send(hub_udev, 0, USB_REQ_SET_FEATURE,
+					   USB_RT_PORT, USB_PORT_FEAT_SUSPEND,
+					   portnum, NULL, 0, 1000, GFP_KERNEL);
 		if (ret < 0)
 			break;
 
 		msleep(15 * 1000);
-		ret = usb_control_msg(hub_udev, usb_sndctrlpipe(hub_udev, 0),
-					USB_REQ_CLEAR_FEATURE, USB_RT_PORT,
-					USB_PORT_FEAT_SUSPEND, portnum,
-					NULL, 0, 1000);
+		ret = usb_control_msg_send(hub_udev, 0, USB_REQ_CLEAR_FEATURE,
+					   USB_RT_PORT, USB_PORT_FEAT_SUSPEND,
+					   portnum, NULL, 0, 1000, GFP_KERNEL);
 		break;
 	case TEST_SINGLE_STEP_GET_DEV_DESC:
 		/* Test: wait for 15secs -> GetDescriptor request */
 		msleep(15 * 1000);
-		buf = kmalloc(USB_DT_DEVICE_SIZE, GFP_KERNEL);
-		if (!buf)
-			return -ENOMEM;
 
-		ret = usb_control_msg(dev, usb_rcvctrlpipe(dev, 0),
-					USB_REQ_GET_DESCRIPTOR, USB_DIR_IN,
-					USB_DT_DEVICE << 8, 0,
-					buf, USB_DT_DEVICE_SIZE,
-					USB_CTRL_GET_TIMEOUT);
-		kfree(buf);
+		ret = usb_control_msg_recv(dev, 0, USB_REQ_GET_DESCRIPTOR,
+					   USB_DIR_IN, USB_DT_DEVICE << 8, 0,
+					   &buf, USB_DT_DEVICE_SIZE,
+					   USB_CTRL_GET_TIMEOUT, GFP_KERNEL);
 		break;
 	case TEST_SINGLE_STEP_SET_FEATURE:
 		/*
@@ -100,11 +89,10 @@ static int ehset_probe(struct usb_interface *intf,
 			break;
 		}
 
-		ret = usb_control_msg(hub_udev, usb_sndctrlpipe(hub_udev, 0),
-					USB_REQ_SET_FEATURE, USB_RT_PORT,
-					USB_PORT_FEAT_TEST,
-					(6 << 8) | portnum,
-					NULL, 0, 60 * 1000);
+		ret = usb_control_msg_send(hub_udev, 0, USB_REQ_SET_FEATURE,
+					   USB_RT_PORT, USB_PORT_FEAT_TEST,
+					   (6 << 8) | portnum, NULL, 0,
+					   60 * 1000, GFP_KERNEL);
 
 		break;
 	default:
@@ -112,7 +100,7 @@ static int ehset_probe(struct usb_interface *intf,
 			__func__, test_pid);
 	}
 
-	return (ret < 0) ? ret : 0;
+	return ret;
 }
 
 static void ehset_disconnect(struct usb_interface *intf)
-- 
2.25.1

