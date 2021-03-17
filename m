Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A580C33F5F4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 17:46:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232815AbhCQQpv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 12:45:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232666AbhCQQpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 12:45:23 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37DDAC061762
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 09:45:23 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id h13so3087022eds.5
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 09:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LCfiO2M8eBv1nSfw6SX3LELyYme5LYmWED/jUeSNqLo=;
        b=XiofJ4gOsO7WAp+jv8oHLjsQ8od5HRXQfPGgLrEunER+Bt1XtcgiH1nM+oUWKvYWS9
         049HI5zEij5AS8++RWPc160JBbLeHoamnw0YJx43WQkUr0v6x8guSq4dItZvNGP7EIXe
         XySuQwiBx+9e6CqnMsib+HQHE17noLBFTUIQM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LCfiO2M8eBv1nSfw6SX3LELyYme5LYmWED/jUeSNqLo=;
        b=FesAkNB0jSJaqxheeiANMRVIaBQJWNMkP0ghDoH1sqy1DFY+66DtO9SQ6i5/RajuKy
         OZJoqcTJDAqiY9KzP6GKDTc8zhbqrw4c7Nrkgik9ua+7wRpUC18fmfi0FMnTJCU3qv/n
         agCOIcVT8PHJwJR60em9/UOwzmxeU/JrlCbM5t9ssr4k8dwJTvY5eZIXuZnCEMw9Bap8
         VgNIMMhNI/K7Rnx4zPWlJO0aKeZ78jSCucT1eEs5BHiK7dAE1o5XFmQXqUuYdPcll0S+
         dnZr72MfUoXGdxoVVX2KWweuHBcySm2ZmGHwa7wQw1wp+OJ4ogo3Fqd8HXqmad0nRwri
         LF+g==
X-Gm-Message-State: AOAM532BuspKugdnxwUU4lnv41Of6dIEfEP6UyZMk+qz3TI450uVu/+I
        RtUWLMHOn3GdWtc+G+16ANgD1w==
X-Google-Smtp-Source: ABdhPJyr4+FDQhdh89BUmzSIjsRGqspGifOq9EFk98mTWNY5QzdbOWU/MzX74WAMHruIcCQ1orU0Hg==
X-Received: by 2002:a05:6402:142:: with SMTP id s2mr42955620edu.2.1615999522029;
        Wed, 17 Mar 2021 09:45:22 -0700 (PDT)
Received: from alco.lan ([80.71.134.83])
        by smtp.gmail.com with ESMTPSA id hy25sm12088128ejc.119.2021.03.17.09.45.21
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
Subject: [PATCH v6 13/17] media: uvcvideo: Increase the size of UVC_METADATA_BUF_SIZE
Date:   Wed, 17 Mar 2021 17:45:07 +0100
Message-Id: <20210317164511.39967-14-ribalda@chromium.org>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
In-Reply-To: <20210317164511.39967-1-ribalda@chromium.org>
References: <20210317164511.39967-1-ribalda@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hans has discovered that in his test device, for the H264 format
bytesused goes up to about 570, for YUYV it will actually go up
to a bit over 5000 bytes, and for MJPG up to about 2706 bytes.

We should also, according to V4L2_META_FMT_UVC docs, drop headers when
the buffer is full.

Credit-to: Hans Verkuil <hverkuil@xs4all.nl>
Reviewed-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_video.c | 8 +++++---
 drivers/media/usb/uvc/uvcvideo.h  | 2 +-
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
index 25fd8aa23529..ea2903dc3252 100644
--- a/drivers/media/usb/uvc/uvc_video.c
+++ b/drivers/media/usb/uvc/uvc_video.c
@@ -1244,11 +1244,13 @@ static void uvc_video_decode_meta(struct uvc_streaming *stream,
 	if (!meta_buf || length == 2)
 		return;
 
+	/*
+	 * According to V4L2_META_FMT_UVC docs, we should drop headers when
+	 * the buffer is full.
+	 */
 	if (meta_buf->length - meta_buf->bytesused <
-	    length + sizeof(meta->ns) + sizeof(meta->sof)) {
-		meta_buf->error = 1;
+	    length + sizeof(meta->ns) + sizeof(meta->sof))
 		return;
-	}
 
 	has_pts = mem[1] & UVC_STREAM_PTS;
 	has_scr = mem[1] & UVC_STREAM_SCR;
diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
index b81d3f65e52e..a26bbec8d37b 100644
--- a/drivers/media/usb/uvc/uvcvideo.h
+++ b/drivers/media/usb/uvc/uvcvideo.h
@@ -527,7 +527,7 @@ struct uvc_stats_stream {
 	unsigned int max_sof;		/* Maximum STC.SOF value */
 };
 
-#define UVC_METADATA_BUF_SIZE 1024
+#define UVC_METADATA_BUF_SIZE 10240
 
 /**
  * struct uvc_copy_op: Context structure to schedule asynchronous memcpy
-- 
2.31.0.rc2.261.g7f71774620-goog

