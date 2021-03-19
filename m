Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 050973422FF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 18:10:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbhCSRJ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 13:09:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbhCSRJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 13:09:20 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABA32C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 10:09:19 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id j3so11603111edp.11
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 10:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LCfiO2M8eBv1nSfw6SX3LELyYme5LYmWED/jUeSNqLo=;
        b=kjr9tZbznaeFl6HWz/rwMdKT2ISc0FR/LpL3NwSr7swGHdqmzOgwQBIDhqCmmUkLrj
         CmvZIgdbkiaZTgqDGNvmvSn9vCGl8ozcGRbByuLl32hG5boArbav4LXZ7ZKbXdH5NgbG
         P3EzkNDI9IVgf9iNiF1e47aWlV//b1smLgSI8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LCfiO2M8eBv1nSfw6SX3LELyYme5LYmWED/jUeSNqLo=;
        b=d1hOId81STtxxr9oFqVT67x8s3eKHF34nvTOLIHg47VyHN/QukwxpOsMCsKhBr3Ev9
         X6Qo/QOiiz1MWVZt8A7l+RgX/HqbQNcYZDLQkhtbaMF+OA64+7ikoX2iyopKuPkXN67j
         YAEezOSaBnOLnQkQlExZZzspcr+NKCQhsSZQto/feUoEd4SYI2Ua9A+p9ALEjuJV5Ldk
         qolGuLY2FvCNzJ3nvTVKvKGJ3hu27QJ9ulJmJB0sATRazPVGZKPYg2PrAe3874BCDqGc
         oIOCzyDNLZfKi6AaVyt9OBtaDR+aTQLVm7dQnha4pnYhGQSpNSfJY4+vBSP749+SDk/g
         n/iQ==
X-Gm-Message-State: AOAM531LtiK35IH2y8CHqaLY3nJo53OHWsEg5tWP7XGjVHdGRsyRr7os
        LgWqxqaMz3vBZIGxMNVPAbOOvA==
X-Google-Smtp-Source: ABdhPJy1KayEIWB+qOiq33IQWAhlr3+ZFlraJR0i1ckjD+zyzwGLO0K62nuC2V0OHHuNMtAz9ZOZfg==
X-Received: by 2002:aa7:d987:: with SMTP id u7mr10621016eds.326.1616173758425;
        Fri, 19 Mar 2021 10:09:18 -0700 (PDT)
Received: from alco.lan ([80.71.134.83])
        by smtp.gmail.com with ESMTPSA id be27sm4506050edb.47.2021.03.19.10.09.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 10:09:17 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        tfiga@chromium.org
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v8 12/19] media: uvcvideo: Increase the size of UVC_METADATA_BUF_SIZE
Date:   Fri, 19 Mar 2021 18:08:59 +0100
Message-Id: <20210319170906.278238-13-ribalda@chromium.org>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
In-Reply-To: <20210319170906.278238-1-ribalda@chromium.org>
References: <20210319170906.278238-1-ribalda@chromium.org>
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

