Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2B4E3ACAF2
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 14:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234412AbhFRMcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 08:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234103AbhFRMbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 08:31:47 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E278C061224
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 05:29:34 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id z12so8447579edc.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 05:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lOh6gFQr+zjz82LzX2/OB42mS3BaL90VV98LqFeTeuQ=;
        b=Q6Xm+yBiq6Y/vkzxBQhJeNRY2tqA5oqBlXm5Huk/EvOXgSCj8dNZKjx0VD3nxaaA9J
         TNPUAoUwSx/AhiCSpkM5uZxhLi42oJFvQkI1YaM4WZ6AQ+HnlI+4TMiM8kJO5SddLqHK
         /cokBYRP42Ibfm84/YYl2fWHQ2Q7jyqj+PbNk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lOh6gFQr+zjz82LzX2/OB42mS3BaL90VV98LqFeTeuQ=;
        b=Ie8HitLNutB8O8pRWCEgP91ii5Khmhxz7HDTQ66HwOYMxlC7n84mBn9iYDa5mWgbRw
         QVDe56GVOEv1bDBg6thla/zXBCKvLzkDe7BK1heQ0XzdE5olVJCdaY0JCoThR3ks55s1
         HSYh6mtPsKfc2ip0GrJYjQcSYqKNqG/ZPPC2R1Up6CEe9bx8frO3UVZz3QRv9OzO0sQL
         vO2ZKXRDhCV22BezW0Ef3KA0dzsSxRZYNZu3tEOXGGDSGEboSI29SMtVBhw2wlu9esgV
         VpqWSAU3/+VKOMk28Q8np6qjYWIdtbYqHHcmveoC+6JpDOttdAZG1yYjnt18MwBSnLr8
         yL7g==
X-Gm-Message-State: AOAM530eWF6NDBZRpLrXf5POV23FV7sasFGsDOOL7gjUOtIsfqVI0QfY
        hhH/rexqnrziXXIHoQwaq4wPVQ==
X-Google-Smtp-Source: ABdhPJznI00sn1T0oWPtmMeGy3P4HmXKKmAdW+6TXxV6LdU8Rd9xJYl9u8Y/VklSvnTnAtvse/J6mw==
X-Received: by 2002:a05:6402:40d2:: with SMTP id z18mr4721724edb.366.1624019373083;
        Fri, 18 Jun 2021 05:29:33 -0700 (PDT)
Received: from alco.lan (80.71.134.83.ipv4.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id o26sm4336403edt.62.2021.06.18.05.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 05:29:32 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        tfiga@chromium.org
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v10 11/21] media: uvcvideo: Set unique vdev name based in type
Date:   Fri, 18 Jun 2021 14:29:13 +0200
Message-Id: <20210618122923.385938-12-ribalda@chromium.org>
X-Mailer: git-send-email 2.32.0.288.g62a8d224e6-goog
In-Reply-To: <20210618122923.385938-1-ribalda@chromium.org>
References: <20210618122923.385938-1-ribalda@chromium.org>
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
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
---
 drivers/media/usb/uvc/uvc_driver.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index 14b60792ffab..037bf80d1100 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -2194,6 +2194,7 @@ int uvc_register_video_device(struct uvc_device *dev,
 			      const struct v4l2_file_operations *fops,
 			      const struct v4l2_ioctl_ops *ioctl_ops)
 {
+	const char *name;
 	int ret;
 
 	/* Initialize the video buffers queue. */
@@ -2222,16 +2223,20 @@ int uvc_register_video_device(struct uvc_device *dev,
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
2.32.0.288.g62a8d224e6-goog

