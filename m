Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B44983ACAEF
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 14:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234385AbhFRMcJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 08:32:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234326AbhFRMbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 08:31:46 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D43B0C06124A
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 05:29:33 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id c7so7473358edn.6
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 05:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VY+MwtTzjVqKCPnuwcTEoHPw94xFL8xuvnf0e6wvu50=;
        b=lBocezO2BT8O8bEg7CpGfoRO9e0Y2ghW2/CcOMigIOVVRmMDDOCq1FaS7YufMoL6z2
         r+TCL1cj+B/PGgJUckP62QOv02+K9ylForK1dBE4VfVnW2AsJzlG57w2pqUD8qEMEnQf
         YeMRWN+wYPZEKyJ/GpB9EazE/gM9AELbYhMGM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VY+MwtTzjVqKCPnuwcTEoHPw94xFL8xuvnf0e6wvu50=;
        b=b37W6z4xIEKAoRVlpEOjopfrAi6kJpcupi3lqmYMx+PFdAGBnJegN1FSkgfwJfEycL
         6G3A8m6GGBuBEGCN2LIf/R0Eoe3pZxL/IZv/x6dj2VAKat6IB86UWf/hkIGqUtSZQmBH
         mHMc/93c2bxc/OWi7UyHuxYcSrDWG5T4QMZOQnM6ST7BIqDTZYaTqzUphuriY26uR4Jc
         5+R/mUiT0baJF8WBzaol0ISG3Pq79Xb2SHjquF+njKKDIebXoP8VoFv49q+KqleCEp3X
         7ySSdvPvcI0e636XXyGksMJ/xHtsqEkXf0d5tvHryCfe8462K1U51CrH2JZ8f+S/OHRq
         v5hA==
X-Gm-Message-State: AOAM531pviYCnIjRoR56P5h1gvvikUTwFBHZBH6wXwSEQgIDnw7mAoxg
        7nb+9YDFXG2E84RZTJ851u15cQ==
X-Google-Smtp-Source: ABdhPJz7c28cJb1pvAHztCDTs9UtUKkk+ht96mYbjKBEnMuNXSA4zLSH69uqwtYYRKVscnWgm9ovEQ==
X-Received: by 2002:a05:6402:144d:: with SMTP id d13mr4477012edx.288.1624019372532;
        Fri, 18 Jun 2021 05:29:32 -0700 (PDT)
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
Subject: [PATCH v10 10/21] media: uvcvideo: Use dev->name for querycap()
Date:   Fri, 18 Jun 2021 14:29:12 +0200
Message-Id: <20210618122923.385938-11-ribalda@chromium.org>
X-Mailer: git-send-email 2.32.0.288.g62a8d224e6-goog
In-Reply-To: <20210618122923.385938-1-ribalda@chromium.org>
References: <20210618122923.385938-1-ribalda@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the device name for the card name instead of vdev->name. That way
all the devices have a different name instead of the common vdev->name.

Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_metadata.c | 2 +-
 drivers/media/usb/uvc/uvc_v4l2.c     | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_metadata.c b/drivers/media/usb/uvc/uvc_metadata.c
index b6279ad7ac84..82de7781f5b6 100644
--- a/drivers/media/usb/uvc/uvc_metadata.c
+++ b/drivers/media/usb/uvc/uvc_metadata.c
@@ -30,7 +30,7 @@ static int uvc_meta_v4l2_querycap(struct file *file, void *fh,
 	struct uvc_video_chain *chain = stream->chain;
 
 	strscpy(cap->driver, "uvcvideo", sizeof(cap->driver));
-	strscpy(cap->card, vfh->vdev->name, sizeof(cap->card));
+	strscpy(cap->card, stream->dev->name, sizeof(cap->card));
 	usb_make_path(stream->dev->udev, cap->bus_info, sizeof(cap->bus_info));
 	cap->capabilities = V4L2_CAP_DEVICE_CAPS | V4L2_CAP_STREAMING
 			  | chain->caps;
diff --git a/drivers/media/usb/uvc/uvc_v4l2.c b/drivers/media/usb/uvc/uvc_v4l2.c
index 1eeeb00280e4..9cdd30eff495 100644
--- a/drivers/media/usb/uvc/uvc_v4l2.c
+++ b/drivers/media/usb/uvc/uvc_v4l2.c
@@ -617,13 +617,12 @@ static int uvc_v4l2_release(struct file *file)
 static int uvc_ioctl_querycap(struct file *file, void *fh,
 			      struct v4l2_capability *cap)
 {
-	struct video_device *vdev = video_devdata(file);
 	struct uvc_fh *handle = file->private_data;
 	struct uvc_video_chain *chain = handle->chain;
 	struct uvc_streaming *stream = handle->stream;
 
 	strscpy(cap->driver, "uvcvideo", sizeof(cap->driver));
-	strscpy(cap->card, vdev->name, sizeof(cap->card));
+	strscpy(cap->card, handle->stream->dev->name, sizeof(cap->card));
 	usb_make_path(stream->dev->udev, cap->bus_info, sizeof(cap->bus_info));
 	cap->capabilities = V4L2_CAP_DEVICE_CAPS | V4L2_CAP_STREAMING
 			  | chain->caps;
-- 
2.32.0.288.g62a8d224e6-goog

