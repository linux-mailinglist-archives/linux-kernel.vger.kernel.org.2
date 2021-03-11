Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79AC633802E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 23:21:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbhCKWUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 17:20:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbhCKWT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 17:19:58 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33759C061762
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 14:19:58 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id i61so5161582edd.7
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 14:19:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+NxfxF6MYENNTplKQDaPyj0JYf8Q7xTxx8mkc60+VVM=;
        b=cmdfBk3FY4BcK/I9H/TXYw39tVMK6GUJmeYusCfuzLEAIZBgvMN2nm2giUdYLARcpz
         6BoK91xe9K8oHVhKafi4IA1dh60mYijPyesjZpbr9uyYXz+QIleZbNAIEQR7y6b8bApF
         Um/RcUl+v9cAwKSkl58T/G+f+WNalIHSjglzM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+NxfxF6MYENNTplKQDaPyj0JYf8Q7xTxx8mkc60+VVM=;
        b=crsI9O5f/rRhMiSWTUQOK/ppDK4Jkmd+YPPg+daztE5yapfOP//a5EqKwMAGDT5LGO
         7kddQV6FKgayQIZXBCO1Xh1Bz1O89unwze6BX5VipO28KISiTEpVYCq14lkOMzLgnQIF
         kIm3juaMilnoxef6ZY1jGrQVXXBCvIi3JyELapAlYepuM5erjvtxI0yTgITZgJRb/T28
         +oodwnmM0Xhmij4Y0UYAgz3kjB8Cfq5EzFHfzLwlP6bOj2oG4NuA+wHBtRI1WW1rPQms
         NIXHWuMW4DLif865X2o4tda1Uh1OTyzG2RXqRKXFOmDTLPXojLfQwheubA8tnQYe/COh
         c9Sw==
X-Gm-Message-State: AOAM530sX/+yr7Z+sf6uWR9Eckpu5zAcUweDAHeOCzsjBtDaaz1RbKk6
        GG7wASDtEnG5YihPzhRkvwbp1UYTkdv3BsUsVNk=
X-Google-Smtp-Source: ABdhPJwu0WgyN0QkKtKMmQ987e1pAm6FPH/Olhhw0hOalUlWFzOppoe4TggQSyiOZKk6wmDPxNf+7g==
X-Received: by 2002:aa7:dc15:: with SMTP id b21mr10881024edu.350.1615501196937;
        Thu, 11 Mar 2021 14:19:56 -0800 (PST)
Received: from alco.lan ([80.71.134.83])
        by smtp.gmail.com with ESMTPSA id b18sm1942174ejb.77.2021.03.11.14.19.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 14:19:56 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tomasz Figa <tfiga@chromium.org>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, senozhatsky@chromium.org,
        Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v2 5/6] media: uvcvideo: Add support for V4L2_CTRL_TYPE_CTRL_CLASS
Date:   Thu, 11 Mar 2021 23:19:45 +0100
Message-Id: <20210311221946.1319924-6-ribalda@chromium.org>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
In-Reply-To: <20210311221946.1319924-1-ribalda@chromium.org>
References: <20210311221946.1319924-1-ribalda@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create all the class controls for the device defined controls.

Fixes v4l2-compliance:
Control ioctls (Input 0):
		fail: v4l2-test-controls.cpp(216): missing control class for class 00980000
		fail: v4l2-test-controls.cpp(216): missing control tclass for class 009a0000
	test VIDIOC_QUERY_EXT_CTRL/QUERYMENU: FAIL

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_ctrl.c | 90 ++++++++++++++++++++++++++++++++
 drivers/media/usb/uvc/uvcvideo.h |  7 +++
 2 files changed, 97 insertions(+)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index b3dde98499f4..4e0ed2595ae9 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -357,6 +357,17 @@ static const struct uvc_control_info uvc_ctrls[] = {
 	},
 };
 
+static const struct uvc_control_class uvc_control_class[] = {
+	{
+		.id		= V4L2_CID_CAMERA_CLASS,
+		.name		= "Camera Controls",
+	},
+	{
+		.id		= V4L2_CID_USER_CLASS,
+		.name		= "User Controls",
+	},
+};
+
 static const struct uvc_menu_info power_line_frequency_controls[] = {
 	{ 0, "Disabled" },
 	{ 1, "50 Hz" },
@@ -1024,6 +1035,49 @@ static int __uvc_ctrl_get(struct uvc_video_chain *chain,
 	return 0;
 }
 
+static int __uvc_query_v4l2_class(struct uvc_device *dev, u32 req_id,
+				  u32 found_id)
+{
+	bool find_next = req_id & V4L2_CTRL_FLAG_NEXT_CTRL;
+	int i;
+
+	req_id &= V4L2_CTRL_ID_MASK;
+
+	for (i = 0; i < ARRAY_SIZE(uvc_control_class); i++) {
+		if (!(dev->ctrl_class_bitmap & BIT(i)))
+			continue;
+		if (!find_next) {
+			if (uvc_control_class[i].id == req_id)
+				return i;
+			continue;
+		}
+		if ((uvc_control_class[i].id > req_id) &&
+		    (uvc_control_class[i].id < found_id))
+			return i;
+	}
+
+	return -ENODEV;
+}
+
+static int uvc_query_v4l2_class(struct uvc_device *dev, u32 req_id,
+				u32 found_id, struct v4l2_queryctrl *v4l2_ctrl)
+{
+	int idx;
+
+	idx = __uvc_query_v4l2_class(dev, req_id, found_id);
+	if (idx < 0)
+		return -ENODEV;
+
+	memset(v4l2_ctrl, 0, sizeof(*v4l2_ctrl));
+	v4l2_ctrl->id = uvc_control_class[idx].id;
+	strscpy(v4l2_ctrl->name, uvc_control_class[idx].name,
+		sizeof(v4l2_ctrl->name));
+	v4l2_ctrl->type = V4L2_CTRL_TYPE_CTRL_CLASS;
+	v4l2_ctrl->flags = V4L2_CTRL_FLAG_WRITE_ONLY |
+					V4L2_CTRL_FLAG_READ_ONLY;
+	return 0;
+}
+
 static int __uvc_query_v4l2_ctrl(struct uvc_video_chain *chain,
 	struct uvc_control *ctrl,
 	struct uvc_control_mapping *mapping,
@@ -1123,6 +1177,14 @@ int uvc_query_v4l2_ctrl(struct uvc_video_chain *chain,
 	struct uvc_control_mapping *mapping;
 	int ret;
 
+	/* Check if the ctrl is a know class */
+	if (!(v4l2_ctrl->id & V4L2_CTRL_FLAG_NEXT_CTRL)) {
+		ret = uvc_query_v4l2_class(chain->dev, v4l2_ctrl->id,
+					   v4l2_ctrl->id, v4l2_ctrl);
+		if (!ret)
+			return 0;
+	}
+
 	ret = mutex_lock_interruptible(&chain->ctrl_mutex);
 	if (ret < 0)
 		return -ERESTARTSYS;
@@ -1133,6 +1195,13 @@ int uvc_query_v4l2_ctrl(struct uvc_video_chain *chain,
 		goto done;
 	}
 
+	if (v4l2_ctrl->id & V4L2_CTRL_FLAG_NEXT_CTRL) {
+		ret = uvc_query_v4l2_class(chain->dev, v4l2_ctrl->id,
+					   mapping->id, v4l2_ctrl);
+		if (!ret)
+			goto done;
+	}
+
 	ret = __uvc_query_v4l2_ctrl(chain, ctrl, mapping, v4l2_ctrl);
 done:
 	mutex_unlock(&chain->ctrl_mutex);
@@ -1422,6 +1491,9 @@ static int uvc_ctrl_add_event(struct v4l2_subscribed_event *sev, unsigned elems)
 	struct uvc_control *ctrl;
 	int ret;
 
+	if (__uvc_query_v4l2_class(handle->chain->dev, sev->id, 0) >= 0)
+		return 0;
+
 	ret = mutex_lock_interruptible(&handle->chain->ctrl_mutex);
 	if (ret < 0)
 		return -ERESTARTSYS;
@@ -1458,6 +1530,9 @@ static void uvc_ctrl_del_event(struct v4l2_subscribed_event *sev)
 {
 	struct uvc_fh *handle = container_of(sev->fh, struct uvc_fh, vfh);
 
+	if (__uvc_query_v4l2_class(handle->chain->dev, sev->id, 0) >= 0)
+		return;
+
 	mutex_lock(&handle->chain->ctrl_mutex);
 	list_del(&sev->node);
 	mutex_unlock(&handle->chain->ctrl_mutex);
@@ -1577,6 +1652,9 @@ int uvc_ctrl_get(struct uvc_video_chain *chain,
 	struct uvc_control *ctrl;
 	struct uvc_control_mapping *mapping;
 
+	if (__uvc_query_v4l2_class(chain->dev, xctrl->id, 0) >= 0)
+		return -EACCES;
+
 	ctrl = uvc_find_control(chain, xctrl->id, &mapping);
 	if (ctrl == NULL)
 		return -EINVAL;
@@ -1596,6 +1674,9 @@ int uvc_ctrl_set(struct uvc_fh *handle,
 	s32 max;
 	int ret;
 
+	if (__uvc_query_v4l2_class(chain->dev, xctrl->id, 0) >= 0)
+		return -EACCES;
+
 	ctrl = uvc_find_control(chain, xctrl->id, &mapping);
 	if (ctrl == NULL)
 		return -EINVAL;
@@ -2062,6 +2143,7 @@ static int __uvc_ctrl_add_mapping(struct uvc_device *dev,
 {
 	struct uvc_control_mapping *map;
 	unsigned int size;
+	int i;
 
 	/* Most mappings come from static kernel data and need to be duplicated.
 	 * Mappings that come from userspace will be unnecessarily duplicated,
@@ -2085,6 +2167,14 @@ static int __uvc_ctrl_add_mapping(struct uvc_device *dev,
 	if (map->set == NULL)
 		map->set = uvc_set_le_value;
 
+	for (i = 0; i < ARRAY_SIZE(uvc_control_class); i++) {
+		if (V4L2_CTRL_ID2WHICH(uvc_control_class[i].id) ==
+						V4L2_CTRL_ID2WHICH(map->id)) {
+			dev->ctrl_class_bitmap |= BIT(i);
+			break;
+		}
+	}
+
 	list_add_tail(&map->list, &ctrl->info.mappings);
 	uvc_dbg(dev, CONTROL, "Adding mapping '%s' to control %pUl/%u\n",
 		map->name, ctrl->info.entity, ctrl->info.selector);
diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
index 97df5ecd66c9..63b5d697a438 100644
--- a/drivers/media/usb/uvc/uvcvideo.h
+++ b/drivers/media/usb/uvc/uvcvideo.h
@@ -262,6 +262,11 @@ struct uvc_control_mapping {
 		    u8 *data);
 };
 
+struct uvc_control_class {
+	u32 id;
+	char name[32];
+};
+
 struct uvc_control {
 	struct uvc_entity *entity;
 	struct uvc_control_info info;
@@ -707,6 +712,8 @@ struct uvc_device {
 	} async_ctrl;
 
 	struct uvc_entity *gpio_unit;
+
+	u8 ctrl_class_bitmap;
 };
 
 enum uvc_handle_state {
-- 
2.31.0.rc2.261.g7f71774620-goog

