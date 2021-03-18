Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04964340F2F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 21:30:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233217AbhCRUaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 16:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233095AbhCRU3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 16:29:36 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63DC3C061760
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 13:29:36 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id bf3so8306749edb.6
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 13:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1w+yB/Vqk+uy2WQ0zMmIaM63jYG8/iXQEcm7mXu6CN0=;
        b=knCtczGqIp4yGRnucKtZVemea6vyGs+o/wVyeXHrwGywUzdxQuCZ6hCcCKSiPbmDjh
         5GGzbcoMUFAHgiUO068mp04lRW5Fg3vNxSKc4wOKByVooHa/Bsynz9y2opsdT72OPAnQ
         h+P9yxbv27aT2jxulRUqvFe5eY09Wtk2Tvc5M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1w+yB/Vqk+uy2WQ0zMmIaM63jYG8/iXQEcm7mXu6CN0=;
        b=BhWAO9+Nv3/C9EyKGbYleZU4xlB8FKVcnCDvB5I42j9chGyK5Exd8T5SamJy+VMFhf
         utgn9AuXfTg+9+18r2tZNnsZ2QwZ59dhO0j/EG76C0XmZKIHwtZt6dXa+6dAIifM8Ji+
         tE2iuYrOeD98jxp1DHOLhbX1H4Sb95C9oko7Ep/nLckkXQmNxzHIdHDJSKPJdf3C6ziY
         WJrvI0Roq8eXLVV2yGvRaLyg84aXF3UjLWrUijCgGLg8OkksLDoTRQIA/eOiuxFYKcDG
         4OlkKDbjBOMsARrXxUtaiMY5hBSmFbINorO0gLa7uTgC/i1ywp3mBnRGg/Jm/7rAXhVv
         wKfA==
X-Gm-Message-State: AOAM531wlhd7JE5oRmgDQQFyiv7t3ZUdmouilnZc8/NeNUA0+j9bXA3e
        5YbeEGb1QdGXvJT7OLnlgl0ARw==
X-Google-Smtp-Source: ABdhPJyMukq7CuLYHqsAnHerZP+Fm2/R1NeEAq0Kjlv7HSo0HALJcs72PlO4szMvRai0itY56YPGXg==
X-Received: by 2002:a05:6402:512:: with SMTP id m18mr5740025edv.372.1616099375130;
        Thu, 18 Mar 2021 13:29:35 -0700 (PDT)
Received: from alco.lan ([80.71.134.83])
        by smtp.gmail.com with ESMTPSA id a22sm2533767ejr.89.2021.03.18.13.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 13:29:34 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        tfiga@chromium.org
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v7 08/17] media: uvcvideo: Use dev->name for querycap()
Date:   Thu, 18 Mar 2021 21:29:19 +0100
Message-Id: <20210318202928.166955-9-ribalda@chromium.org>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
In-Reply-To: <20210318202928.166955-1-ribalda@chromium.org>
References: <20210318202928.166955-1-ribalda@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the device name for the card name instead of vdev->name.

Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
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
index 397217171bbb..dd10cb9361fa 100644
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
2.31.0.rc2.261.g7f71774620-goog

