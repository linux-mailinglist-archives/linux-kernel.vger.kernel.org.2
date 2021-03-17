Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4505C33F5F5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 17:46:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232823AbhCQQpw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 12:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232664AbhCQQpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 12:45:23 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE631C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 09:45:22 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id c10so3662351ejx.9
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 09:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VEHA0wDh2t06lBti+/CKy5TQQJ8gS0FLl9pl6QcZYKI=;
        b=mgQTBMdiVpGU1c8bhyl7HeAbSBfBcnKwGFIsbaMnLGEArbGwaUrNW154yqFq+3oYg3
         gyjvzFIXeA63PU1mc0FBsLbHa5eYEPF0MPISC6TnIn/YRiuU2+2juO2e5tuxMFgKEBUm
         +R4KskFhh3ACtEQFBVEwqhZAtkG4nZ27cAsvk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VEHA0wDh2t06lBti+/CKy5TQQJ8gS0FLl9pl6QcZYKI=;
        b=gzGNbL6VNknU7xEp61WhcXBmMAwV8XcmXOBSHF6XP9UiLm8EwzC3vNOscfwQoDNqIk
         n5Uu7jr/7Yw/gotOi+LFP1qJ9xgXTvzJFPk+IwiXCmEB4iSZNMrDWz1Hb7uv6p5UatFD
         Nuj23ulhlc1kHrHrnUUWq/UQcMQi3w77CMWUMa+9CubBCzw9Z47HeoJbrIkzWdkDyJKE
         E8ALjr2fWYhsQsbQp/fNVVHtm0sR1TNEXxON0d/NkMhzORGegzfQQ8d0gY3c45+Y/xVr
         duLFKBH6SfX7fG/VqQ5SLMyKPt4pmsVzLdPRoPnAMeNBO2g7JjefAP0ia+vzqWtITV5y
         rV2Q==
X-Gm-Message-State: AOAM531OKRif1BjJJdfdMaLGB21AVh3wYswa+b1MMjESjVPw7wcwXaVz
        +/LiGCQnpk0K3zlJQEVHgzydzQ==
X-Google-Smtp-Source: ABdhPJwZT7QpP4sRlmOC/UBr9A2IKOvA97oOViqUgtTkafGPXJ+CcxqELLqJu0z5986oMv+qLN3NAg==
X-Received: by 2002:a17:906:95d1:: with SMTP id n17mr35308578ejy.394.1615999521499;
        Wed, 17 Mar 2021 09:45:21 -0700 (PDT)
Received: from alco.lan ([80.71.134.83])
        by smtp.gmail.com with ESMTPSA id hy25sm12088128ejc.119.2021.03.17.09.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 09:45:21 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        tfiga@chromium.org
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v6 12/17] media: uvcvideo: Set unique vdev name based in type
Date:   Wed, 17 Mar 2021 17:45:06 +0100
Message-Id: <20210317164511.39967-13-ribalda@chromium.org>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
In-Reply-To: <20210317164511.39967-1-ribalda@chromium.org>
References: <20210317164511.39967-1-ribalda@chromium.org>
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
2.31.0.rc2.261.g7f71774620-goog

