Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E15034A522
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 11:00:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbhCZJ71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 05:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbhCZJ6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 05:58:53 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CF75C0613AA
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 02:58:53 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id w18so5690635edc.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 02:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NAt2Z25D9SYYUpw3Y+wmG0p1xTHdfyVY2RGY6L+Y0hI=;
        b=LrHEzGD9Ux0D8mtGSKfVkBZRLNoH2qNBpGR7qYHGhKS5Zme7q5MPI6ZZWz82JjhhAh
         gZQO9Xy2aAZzim5GW32rq0dkMWGU2yQaZrZMwv1wY6wGYsR7YHI1fymo68fRAwlmqKkM
         1i3+XVDpkOTk6i2u3QBWFnVIH7B136LEHLoAQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NAt2Z25D9SYYUpw3Y+wmG0p1xTHdfyVY2RGY6L+Y0hI=;
        b=XbBRqWu0+1OYkUWGJTEuXmBK3rFQT06QiEpSKi6JEIYLaA0xbuOG++B0UgNP7o9Cop
         87n2giU4jJNUIVE92sIAo9KiMf2/wcOK/ZyXuYYldFqTSeKdUO1L2Pp+VyevPAQxTdAw
         FoHjSatR4X6wDO4aqQZMnft05pPCKMlxtuzdKcKLErbwMhRdxtORlOI4L6xt1lYGmb3Y
         ztHsX3WZ9f23OOgoTcBr1v2mm19Sl6iWmpiqddA9X4PWdN4r3W9RtxUSDTtNv2TuElDE
         kU32M4JoEzcXQwo04QVMz2IzV8JB4K9l8QzEHusEYCu5XXYE2xvki+CQMxJ211JszYfr
         tT2Q==
X-Gm-Message-State: AOAM531HADlAfwnegRBmaxmaeXHd4slkR6lNgU02Dc2oNboHIEhaB6MI
        24fJoxtr6Yj7wI9j1dUHPQGfYQ==
X-Google-Smtp-Source: ABdhPJyeic7XYW8exgiEgegNfx0tIOIllkPhddEzh/cMFXSwk9DliC5yF5YdlkgGjxwf5ngG4nmi2A==
X-Received: by 2002:aa7:c74a:: with SMTP id c10mr13749686eds.332.1616752731925;
        Fri, 26 Mar 2021 02:58:51 -0700 (PDT)
Received: from alco.lan ([80.71.134.83])
        by smtp.gmail.com with ESMTPSA id h13sm4036658edz.71.2021.03.26.02.58.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 02:58:51 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        tfiga@chromium.org
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v9 11/22] media: uvcvideo: Set unique vdev name based in type
Date:   Fri, 26 Mar 2021 10:58:29 +0100
Message-Id: <20210326095840.364424-12-ribalda@chromium.org>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
In-Reply-To: <20210326095840.364424-1-ribalda@chromium.org>
References: <20210326095840.364424-1-ribalda@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All the entities must have a unique name. We can have a descriptive and
unique name by appending the function and the entity->id.

This is even resilent to multi chain devices.

Fixes v4l2-compliance:
Media Controller ioctls:
                fail: v4l2-test-media.cpp(205): v2_entity_names_set.find(key) != v2_entity_names_set.end()
        test MEDIA_IOC_G_TOPOLOGY: FAIL
                fail: v4l2-test-media.cpp(394): num_data_links != num_links
	test MEDIA_IOC_ENUM_ENTITIES/LINKS: FAIL

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
Reviewed-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
---
 drivers/media/usb/uvc/uvc_driver.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index 35873cf2773d..76ab6acecbc9 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -2163,6 +2163,7 @@ int uvc_register_video_device(struct uvc_device *dev,
 			      const struct v4l2_ioctl_ops *ioctl_ops)
 {
 	int ret;
+	const char *name;
 
 	/* Initialize the video buffers queue. */
 	ret = uvc_queue_init(queue, type, !uvc_no_drop_param);
@@ -2190,16 +2191,20 @@ int uvc_register_video_device(struct uvc_device *dev,
 	case V4L2_BUF_TYPE_VIDEO_CAPTURE:
 	default:
 		vdev->device_caps = V4L2_CAP_VIDEO_CAPTURE | V4L2_CAP_STREAMING;
+		name = "Video Capture";
 		break;
 	case V4L2_BUF_TYPE_VIDEO_OUTPUT:
 		vdev->device_caps = V4L2_CAP_VIDEO_OUTPUT | V4L2_CAP_STREAMING;
+		name = "Video Output";
 		break;
 	case V4L2_BUF_TYPE_META_CAPTURE:
 		vdev->device_caps = V4L2_CAP_META_CAPTURE | V4L2_CAP_STREAMING;
+		name = "Metadata";
 		break;
 	}
 
-	strscpy(vdev->name, dev->name, sizeof(vdev->name));
+	snprintf(vdev->name, sizeof(vdev->name), "%s %u", name,
+		 stream->header.bTerminalLink);
 
 	/*
 	 * Set the driver data before calling video_register_device, otherwise
-- 
2.31.0.291.g576ba9dcdaf-goog

