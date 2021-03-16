Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B3A033DC0A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 19:04:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239648AbhCPSDc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 14:03:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239592AbhCPSAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 14:00:31 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA3DAC0613E7
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 11:00:18 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id mm21so73615480ejb.12
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 11:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VEHA0wDh2t06lBti+/CKy5TQQJ8gS0FLl9pl6QcZYKI=;
        b=GSCUdaKKddn0P+JUnfqgXAmGvZnbOBtsQGdNms0pyNeLiuPWUKslqIlvheKIMmoDjv
         GFtfr1R7h9339Q9RKI03TiFHnVAL6GxzQ+YBOewBSC5KCzHMywU92h5dX3LDUJDfcW4J
         uH5IcXjDaXgLZUgL8VpPIn5Q2v+9zWYGpckGw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VEHA0wDh2t06lBti+/CKy5TQQJ8gS0FLl9pl6QcZYKI=;
        b=WwCRwqdvrG8WNvExgCIDph3QBqDpGFRJnw3oJnIj7wMbK8GA08whA4AIc9njSZM2LQ
         kqtzRf+5af7+SnVdB46iUfagyOUilXk5hSmFAWI026BNm2s60fPnJn59eZe2H4wrDvum
         CbLDxId+HXhGTk4Y3nvDqkA3XW8ZWq2ym+UT/O3DNmtkMTk5XIWUjqrpAXxfFwOuyEYE
         Xx/t1W18EIRUkIbRmB3ZksJgs7BPETongofe5nqmlL3cCqTH9haKRvYfliXPaqnHcSxi
         L4ha42UY1ycZrWKTIpoG6xSoxRgeSxFUJoVwyNgtEcXUambesjrnmtrlfUdj6bdnvfBS
         OyhA==
X-Gm-Message-State: AOAM530ewzKNpPURwfpR0qJLkbfdtuMvBG493kiYDkk/L4G71YcDwlMs
        UvTFOXSDHQEu3G+3g3Ze27C7Dg==
X-Google-Smtp-Source: ABdhPJwuYvdcRXLFbAxCVfmlwMyWicHY+t8gLx1gsMVoS/OPAlaTb3WIMdYo3wy5Z8/LVi/cPyLj3A==
X-Received: by 2002:a17:906:abcd:: with SMTP id kq13mr31862932ejb.477.1615917612312;
        Tue, 16 Mar 2021 11:00:12 -0700 (PDT)
Received: from alco.lan ([80.71.134.83])
        by smtp.gmail.com with ESMTPSA id c19sm10953182edu.20.2021.03.16.11.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 11:00:12 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        tfiga@chromium.org
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v5 08/13] media: uvcvideo: Set unique vdev name based in type
Date:   Tue, 16 Mar 2021 18:59:58 +0100
Message-Id: <20210316180004.1605727-9-ribalda@chromium.org>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
In-Reply-To: <20210316180004.1605727-1-ribalda@chromium.org>
References: <20210316180004.1605727-1-ribalda@chromium.org>
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

