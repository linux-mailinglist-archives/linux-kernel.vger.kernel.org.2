Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE6F434A526
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 11:00:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbhCZJ7d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 05:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbhCZJ6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 05:58:54 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19357C0613B1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 02:58:54 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id l18so5603228edc.9
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 02:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WPoNB75fJwZV+y8PhAr8AbPUzITMD6gvcbvvfafRqw4=;
        b=d98UqYMXLh1GkS3X5Ql8jf2Aczve63UXC4yRrXWMAFlK5udcI8Wqr5ceV5yAw3xbQD
         G/abC/fdt3CAX5k/Ti85iqgCRhqPhF77mp56lGYkD7Si4mtlAE7bGanoiUtrtMpufIcO
         pZjQsY3PPZhDUThTpB0i/NwrDB98rQzpnnlCc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WPoNB75fJwZV+y8PhAr8AbPUzITMD6gvcbvvfafRqw4=;
        b=dCrgy5FYWIxEPCv0bSKSK6BGrJHnF+9s0G2QNckvQ7uCvINHMeQPWZzHU7DQIzhorn
         09a4mca2d1BdW/xvR8cykR9JSEV0oJcF18qdpUw2xPpkQLMQ8UN5yvpoALQTDjigWFeD
         kE8uH8UvP8DIOe8Hnk9bhWRxwMVTpN9I3DICXSKGz9MayNDbblLEJk1oZXUSiymB1wTU
         0NxhMbcLT39qtNSt2h8MZ23B7omcZVnnLcL9HxaMV6QfGCAEA2BBXEI/OMFf9CXxkV6g
         tujOlnfvgXpqGxzUrhdLFcxsGrWEgafzlqIC52siPV3Frdnxufq1slF5mCEUreMruCq6
         PEZg==
X-Gm-Message-State: AOAM530QkNUhybi35LKKjMwr2HZx36AuD7U+cwh39J3vDT7bokS5AJcE
        tAHjs17pjIQh82V+SzUCUeCtcQ==
X-Google-Smtp-Source: ABdhPJx1/JwKWXs8e2CRjTdMucZluWeL5p4upcohqZa3Q2v31JS3h3uRlrc/K5+ofzsTIKVlmqX/+g==
X-Received: by 2002:a05:6402:31e9:: with SMTP id dy9mr14210544edb.186.1616752732658;
        Fri, 26 Mar 2021 02:58:52 -0700 (PDT)
Received: from alco.lan ([80.71.134.83])
        by smtp.gmail.com with ESMTPSA id h13sm4036658edz.71.2021.03.26.02.58.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 02:58:52 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        tfiga@chromium.org
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v9 12/22] media: uvcvideo: Increase the size of UVC_METADATA_BUF_SIZE
Date:   Fri, 26 Mar 2021 10:58:30 +0100
Message-Id: <20210326095840.364424-13-ribalda@chromium.org>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
In-Reply-To: <20210326095840.364424-1-ribalda@chromium.org>
References: <20210326095840.364424-1-ribalda@chromium.org>
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
2.31.0.291.g576ba9dcdaf-goog

