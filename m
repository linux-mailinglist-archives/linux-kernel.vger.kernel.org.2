Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 623B63422FD
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 18:10:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbhCSRJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 13:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbhCSRJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 13:09:19 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA50DC06175F
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 10:09:18 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id w3so10879227ejc.4
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 10:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VEHA0wDh2t06lBti+/CKy5TQQJ8gS0FLl9pl6QcZYKI=;
        b=klWXVuR8O1Vy0VInrrZJzfEK7Dyb/ZVFAXvREjrGP2AzreuOcJH6CP8Nkx+kzTOpwF
         dyoBUbm7rsFHianFatx1CBzC/PQEaYQ/X1z27rjWiEalg7uito9Ll/W8j4DiqnC94z84
         +vCjWfO9GTpNFBJ3KGxf2St4zT7hsyuU3NE3k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VEHA0wDh2t06lBti+/CKy5TQQJ8gS0FLl9pl6QcZYKI=;
        b=EQT9KyRuCd31BTvlRQ6eJlNCEU04f6Djj0LrllifgExT8ZJ0sVP+kTXxpufx4juK8F
         IPLU1gu48eXIYvfvpl/Ght5MO17ImhwPWbhhIgf/KHbwyJdnHyB8E9F4bHiWfCc5iDFz
         dAMdL5UWwzp9VnlOnxm44Az1hcgrSP9gW5LwTM3m+x7bxr6O+h24qrwV0MFdCHTlSwJn
         xZqQwYKMgNCVYB9vnuBAZI0WxV3UsJAjJs9Eyk8YuKdpmbSF1LF2RoNn83K6yW6BqyMd
         eGKmm0WXIKy2AsQ+v8zaKRb57hvEsQUc3nPa2uW374aJalZYbXj5GyYw8lMazbCbY9Ck
         hBpA==
X-Gm-Message-State: AOAM533DdV0uacVe5YTVoGLsx6HO14JJFfZYMe8O2CbilF8bRNcL2X/7
        iLIxq1IG1b+thgWKm7vPBOWZ5w==
X-Google-Smtp-Source: ABdhPJw1ILzYRAUxjyqz7ZokXkN2d+Mx2gK9UjQXDOWBwtzQfv6aAN9JVK9oE3gOv5I4PepmwvPt/Q==
X-Received: by 2002:a17:906:f953:: with SMTP id ld19mr5400744ejb.164.1616173757580;
        Fri, 19 Mar 2021 10:09:17 -0700 (PDT)
Received: from alco.lan ([80.71.134.83])
        by smtp.gmail.com with ESMTPSA id be27sm4506050edb.47.2021.03.19.10.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 10:09:16 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        tfiga@chromium.org
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v8 11/19] media: uvcvideo: Set unique vdev name based in type
Date:   Fri, 19 Mar 2021 18:08:58 +0100
Message-Id: <20210319170906.278238-12-ribalda@chromium.org>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
In-Reply-To: <20210319170906.278238-1-ribalda@chromium.org>
References: <20210319170906.278238-1-ribalda@chromium.org>
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

