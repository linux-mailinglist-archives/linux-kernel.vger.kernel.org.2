Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D15A340F2A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 21:30:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233207AbhCRUaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 16:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233103AbhCRU3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 16:29:37 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 059AFC06175F
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 13:29:37 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id ce10so6020260ejb.6
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 13:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VEHA0wDh2t06lBti+/CKy5TQQJ8gS0FLl9pl6QcZYKI=;
        b=FxrXiBUssxlUwHkM1ojnp77RrcpX0k720yrbNJ/G4W7mYnxn4xqxgdHrK03DizTT3t
         MRR5iSaoqal0SdR7j/g3LU9aBmng6Es3zQC1ttrjynHXzhQ2pm9y7+PrsIib0u178TCE
         GTtk+Q6SsfR/S5yr92v4EEO8QLP8IdLEoKz1g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VEHA0wDh2t06lBti+/CKy5TQQJ8gS0FLl9pl6QcZYKI=;
        b=N+DRlDrTNa624AjiUxBEyksSFZLab/cC0/Q8pokhYCI1DEZdrom2U36qtqqp80Ecr7
         pdp7jSzjbdPs5yRagTWl0qNIWsbEaB5hgl201lqwXOxI39rpzevmCAYkImlYxt07jYIT
         OWxXp2A89ph42Uv8Bh1CMd8HqW3ZXqg9zVjB4tehiaApD81xVbplZalhLwQdRRHdAb2K
         00EGWCA06lzn/TxsuR2ldfO5pq0eDiJepsYZX+uYKFioOM5BqaJB3jFgmZEAn8gPF9E2
         qLf63iPOFnbjECnEEJN2NWkutf6vpOjjGY58d44EMV1wz9zubsbKChDctM8zH91Te1YH
         L+8Q==
X-Gm-Message-State: AOAM532yf5++J1SxXqyD8RZ2buqXOffzlPba+WjJRYCWb3QupOLHyPBq
        uZVcUpjY4KLoBD9xJ2af8J4wUw==
X-Google-Smtp-Source: ABdhPJwUsxb3W2/mPhn1NFAJjLETq6g7Dihth49d6TepEBPbmS07bEX2ykD8K43JD/LCq+ja2Vj/qg==
X-Received: by 2002:a17:907:aa2:: with SMTP id bz2mr397448ejc.239.1616099375761;
        Thu, 18 Mar 2021 13:29:35 -0700 (PDT)
Received: from alco.lan ([80.71.134.83])
        by smtp.gmail.com with ESMTPSA id a22sm2533767ejr.89.2021.03.18.13.29.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 13:29:35 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        tfiga@chromium.org
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v7 09/17] media: uvcvideo: Set unique vdev name based in type
Date:   Thu, 18 Mar 2021 21:29:20 +0100
Message-Id: <20210318202928.166955-10-ribalda@chromium.org>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
In-Reply-To: <20210318202928.166955-1-ribalda@chromium.org>
References: <20210318202928.166955-1-ribalda@chromium.org>
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

