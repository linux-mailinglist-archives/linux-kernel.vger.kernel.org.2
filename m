Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B3E6337266
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 13:21:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233205AbhCKMVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 07:21:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233130AbhCKMUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 07:20:48 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08866C061760
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 04:20:48 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id e19so45854952ejt.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 04:20:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CaRhVK/8csj+vIrO16ApXt+4+Lm7p1eKMEWudzp2f7U=;
        b=gmjGSpExTAWAssj+18RP7Dlx4fkoDIUccDxXC04TbeBV0PT+XzNObVR3Q4Oe/gFjL1
         b+m/r2+mTqwiTUxiI2rO61orwxdgpzrlTTjZ3V1j36I+mh9TA1zyqwA9v+IWQaSI25Xy
         FTXNwfE5qDdmUWnNgCapfmcqnmFFEhHizT9Cc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CaRhVK/8csj+vIrO16ApXt+4+Lm7p1eKMEWudzp2f7U=;
        b=ZsrCO1X7GF7oEopcbHp2Mphw+my622j4jyMqshXR6TkemdJmORoh1tis8rhaTEyH+R
         vewtuifKCUXfEggmjBF2ijaw8ht/DsuHxyZbel0CdKBXBG0viYXnTt4WLGA3XsQTokEf
         tKFo7tBEeUcB1i9T2WwQdb4taYvBEO3/Y0uPni68sEYOYRH+eBiq0hfPWcGlhCo7bO/i
         YpBiVK4uedDtT4+OB1g/KHrezaP5aUXK2uOEW5TlSfA+LSdDSZmI2kyqqiukR9FUBFN0
         z/tJpw+bdN6dlQftTgR5j6yMnZX//5FxuGc6LlSkyAFMtf1JnQrLS6CLpLifDCiRJHpN
         sWFg==
X-Gm-Message-State: AOAM532T13Kb5i3vfS/XkDk8ITqN8H8gIQ1Z2AwW25GDF+1EEwfCXsu6
        jINKVQKkpQRORQiZJpA7tjjbfg==
X-Google-Smtp-Source: ABdhPJz9csyyS/O02ggpZUqK882qN17Rjf54BW2VsvpJXVt4YaeHbCvtOfqPHRIQesuhtAKo8HIZYQ==
X-Received: by 2002:a17:906:3b47:: with SMTP id h7mr2769759ejf.377.1615465246673;
        Thu, 11 Mar 2021 04:20:46 -0800 (PST)
Received: from alco.lan ([80.71.134.83])
        by smtp.gmail.com with ESMTPSA id u13sm1264126ejy.31.2021.03.11.04.20.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 04:20:46 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tomasz Figa <tfiga@chromium.org>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, senozhatsky@chromium.org
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH 06/10] media: uvcvideo: Implement UVC_CTRL_CLASS_UNIT
Date:   Thu, 11 Mar 2021 13:20:36 +0100
Message-Id: <20210311122040.1264410-8-ribalda@chromium.org>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
In-Reply-To: <20210311122040.1264410-1-ribalda@chromium.org>
References: <20210311122040.1264410-1-ribalda@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create a virtual entity that holds all the class control.

Fixes v4l2-compliance:
Control ioctls (Input 0):
                fail: v4l2-test-controls.cpp(216): missing control class for class 00980000
                fail: v4l2-test-controls.cpp(253): missing control class for class 009a0000
        test VIDIOC_QUERY_EXT_CTRL/QUERYMENU: FAIL

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_ctrl.c   |  3 ++
 drivers/media/usb/uvc/uvc_driver.c | 52 +++++++++++++++++++++++++++---
 drivers/media/usb/uvc/uvc_entity.c |  1 +
 drivers/media/usb/uvc/uvcvideo.h   | 10 ++++++
 4 files changed, 61 insertions(+), 5 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index fd4d5ad098b9..273eccc136b8 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -2354,6 +2354,9 @@ int uvc_ctrl_init_device(struct uvc_device *dev)
 		} else if (UVC_ENTITY_TYPE(entity) == UVC_EXT_GPIO_UNIT) {
 			bmControls = entity->gpio.bmControls;
 			bControlSize = entity->gpio.bControlSize;
+		} else if (UVC_ENTITY_TYPE(entity) == UVC_CTRL_CLASS_UNIT) {
+			bmControls = entity->ctrl_class.bmControls;
+			bControlSize = entity->ctrl_class.bControlSize;
 		}
 
 		/* Remove bogus/blacklisted controls */
diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index 30ef2a3110f7..996e8bd06ac5 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -1025,6 +1025,7 @@ static int uvc_parse_streaming(struct uvc_device *dev,
 }
 
 static const u8 uvc_camera_guid[16] = UVC_GUID_UVC_CAMERA;
+static const u8 uvc_ctrl_class_guid[16] = UVC_GUID_CTRL_CLASS;
 static const u8 uvc_gpio_guid[16] = UVC_GUID_EXT_GPIO_CONTROLLER;
 static const u8 uvc_media_transport_input_guid[16] =
 	UVC_GUID_UVC_MEDIA_TRANSPORT_INPUT;
@@ -1057,6 +1058,9 @@ static struct uvc_entity *uvc_alloc_entity(u16 type, u16 id,
 	 * is initialized by the caller.
 	 */
 	switch (type) {
+	case UVC_CTRL_CLASS_UNIT:
+		memcpy(entity->guid, uvc_ctrl_class_guid, 16);
+		break;
 	case UVC_EXT_GPIO_UNIT:
 		memcpy(entity->guid, uvc_gpio_guid, 16);
 		break;
@@ -1474,6 +1478,39 @@ static int uvc_parse_control(struct uvc_device *dev)
 	return 0;
 }
 
+/* -----------------------------------------------------------------------------
+ * Control Class
+ */
+
+static int uvc_ctrl_class_get_info(struct uvc_device *dev,
+				   struct uvc_entity *entity,
+				   u8 cs, u8 *caps)
+{
+	*caps = 0;
+	return 0;
+}
+
+static int uvc_ctrl_class_parse(struct uvc_device *dev)
+{
+	struct uvc_entity *unit;
+
+	unit = uvc_alloc_entity(UVC_CTRL_CLASS_UNIT,
+				UVC_CTRL_CLASS_UNIT_ID, 0, 1);
+	if (!unit)
+		return -ENOMEM;
+
+	unit->ctrl_class.bControlSize = 1;
+	unit->ctrl_class.bmControls = (u8 *)unit + sizeof(*unit);
+	unit->ctrl_class.bmControls[0] = (1 << (UVC_CC_LAST_CLASS + 1)) - 1;
+	unit->get_info = uvc_ctrl_class_get_info;
+	strncpy(unit->name, "Control Class", sizeof(unit->name) - 1);
+
+	list_add_tail(&unit->list, &dev->entities);
+	dev->ctrl_class_unit = unit;
+
+	return 0;
+}
+
 /* -----------------------------------------------------------------------------
  * Privacy GPIO
  */
@@ -2054,12 +2091,11 @@ static int uvc_scan_device(struct uvc_device *dev)
 		return -1;
 	}
 
-	/* Add GPIO entity to the first chain. */
-	if (dev->gpio_unit) {
-		chain = list_first_entry(&dev->chains,
-					 struct uvc_video_chain, list);
+	/* Add virtual entities to the first chain. */
+	chain = list_first_entry(&dev->chains, struct uvc_video_chain, list);
+	list_add_tail(&dev->ctrl_class_unit->chain, &chain->entities);
+	if (dev->gpio_unit)
 		list_add_tail(&dev->gpio_unit->chain, &chain->entities);
-	}
 
 	return 0;
 }
@@ -2399,6 +2435,12 @@ static int uvc_probe(struct usb_interface *intf,
 		goto error;
 	}
 
+	/* Parse the control class. */
+	if (uvc_ctrl_class_parse(dev) < 0) {
+		uvc_dbg(dev, PROBE, "Unable to parse UVC CTRL CLASS\n");
+		goto error;
+	}
+
 	dev_info(&dev->udev->dev, "Found UVC %u.%02x device %s (%04x:%04x)\n",
 		 dev->uvc_version >> 8, dev->uvc_version & 0xff,
 		 udev->product ? udev->product : "<unnamed>",
diff --git a/drivers/media/usb/uvc/uvc_entity.c b/drivers/media/usb/uvc/uvc_entity.c
index 7c4d2f93d351..5285030a738c 100644
--- a/drivers/media/usb/uvc/uvc_entity.c
+++ b/drivers/media/usb/uvc/uvc_entity.c
@@ -106,6 +106,7 @@ static int uvc_mc_init_entity(struct uvc_video_chain *chain,
 		case UVC_OTT_MEDIA_TRANSPORT_OUTPUT:
 		case UVC_EXTERNAL_VENDOR_SPECIFIC:
 		case UVC_EXT_GPIO_UNIT:
+		case UVC_CTRL_CLASS_UNIT:
 		default:
 			function = MEDIA_ENT_F_V4L2_SUBDEV_UNKNOWN;
 			break;
diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
index 5792232ed312..1d59ac10c2eb 100644
--- a/drivers/media/usb/uvc/uvcvideo.h
+++ b/drivers/media/usb/uvc/uvcvideo.h
@@ -41,6 +41,9 @@
 #define UVC_EXT_GPIO_UNIT		0x7ffe
 #define UVC_EXT_GPIO_UNIT_ID		0x100
 
+#define UVC_CTRL_CLASS_UNIT		0x7ffd
+#define UVC_CTRL_CLASS_UNIT_ID		0x101
+
 /* ------------------------------------------------------------------------
  * GUIDs
  */
@@ -183,6 +186,7 @@
  */
 #define UVC_CC_CAMERA_CLASS	0
 #define UVC_CC_USER_CLASS	1
+#define UVC_CC_LAST_CLASS	UVC_CC_USER_CLASS
 
 /* ------------------------------------------------------------------------
  * Driver specific constants.
@@ -375,6 +379,11 @@ struct uvc_entity {
 			struct gpio_desc *gpio_privacy;
 			int irq;
 		} gpio;
+
+		struct {
+			u8  bControlSize;
+			u8  *bmControls;
+		} ctrl_class;
 	};
 
 	u8 bNrInPins;
@@ -715,6 +724,7 @@ struct uvc_device {
 	} async_ctrl;
 
 	struct uvc_entity *gpio_unit;
+	struct uvc_entity *ctrl_class_unit;
 };
 
 enum uvc_handle_state {
-- 
2.31.0.rc2.261.g7f71774620-goog

