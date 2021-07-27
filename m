Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04DC83D6FE5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 09:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235731AbhG0HFq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 03:05:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235668AbhG0HFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 03:05:41 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F1B8C061757
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 00:05:42 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id k4-20020a17090a5144b02901731c776526so2785655pjm.4
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 00:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IMIWcCNrYG3++gOMQ5fg0hO2NDL6fmjrUrBo2IIuc5E=;
        b=T5gDMaPZeXNLCposuSKhzRgHAPYCDs5khqoIGrDEEokvlDVW5D/FQ9tVugGHjiZQ8o
         qIEryWM/OmiDvx22ezEQi52qe9H62gGO6Dy1EKpgCJzFrteAhjwFzEf2U+jpcn5NefQZ
         aMPKBPSIchzy2XkWDYlk2lZsfqBmpJ/x8W20M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IMIWcCNrYG3++gOMQ5fg0hO2NDL6fmjrUrBo2IIuc5E=;
        b=Lhc07kvQi2Oq0IHMH2VQCWChC+5lScDHzuAXMU23CitY/n4lW0DZuf7iy3dQZXWJw2
         bGBaVyR4c+m1J6/X0GxfLBbM5AqarRXJvdFJOr+RD9QWoLkrcRb7SJJvD6yg3W473qhY
         N/I3t3IBLnOsdhMA3C01PXbsxx3FC8juBoTJ4K9FoDq/Rdgb0qXYolU/uPMOfKL8p6Lw
         /bLUTA7Av+GE9aILsjFu7dGN09VjJI3qQZhwrtbHZ/XXOEVkL1ag9ylATy83JmGMK+km
         JvBOiRMTxE1qWDaXaeYq+sjsexYwBs5hw0ht9bEZQXv/CwlOUkl6YD6s6mDUhVnUsoJw
         LEdw==
X-Gm-Message-State: AOAM533rinXkNkVM49Vg6sXJ2Rb5QL4JsLqTp6Z2HoZTNg9ZsOe5H6ap
        V83QHvxN0XMDvCpdGN+mCDljfw==
X-Google-Smtp-Source: ABdhPJyqUc36XIQVu3lIe+mfW0qu4aTjjMzjwgrq2KG9n0s17D9f/YZQaC1wJqQpDGqr/kddkgjDRQ==
X-Received: by 2002:a05:6a00:d5f:b029:32c:7264:2f65 with SMTP id n31-20020a056a000d5fb029032c72642f65mr21873637pfv.40.1627369541725;
        Tue, 27 Jul 2021 00:05:41 -0700 (PDT)
Received: from senozhatsky.flets-east.jp ([2409:10:2e40:5100:ba3e:509b:495:ec84])
        by smtp.gmail.com with ESMTPSA id 30sm2343447pgq.31.2021.07.27.00.05.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 00:05:41 -0700 (PDT)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Tomasz Figa <tfiga@chromium.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
        Ricardo Ribalda <ribalda@chromium.org>,
        Christoph Hellwig <hch@lst.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv4 3/8] videobuf2: split buffer cache_hints initialisation
Date:   Tue, 27 Jul 2021 16:05:12 +0900
Message-Id: <20210727070517.443167-4-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.32.0.432.gabb21c7263-goog
In-Reply-To: <20210727070517.443167-1-senozhatsky@chromium.org>
References: <20210727070517.443167-1-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V4L2 is not the perfect place to manage vb2 buffer cache hints.
It works for V4L2 users, but there are backends that use vb2 core
and don't use V4L2. Factor buffer cache hints init and call it
when we allocate vb2 buffer.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 .../media/common/videobuf2/videobuf2-core.c   | 22 +++++++++++++++++++
 .../media/common/videobuf2/videobuf2-v4l2.c   | 18 ---------------
 2 files changed, 22 insertions(+), 18 deletions(-)

diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/media/common/videobuf2/videobuf2-core.c
index 23e41fec9880..76210c006958 100644
--- a/drivers/media/common/videobuf2/videobuf2-core.c
+++ b/drivers/media/common/videobuf2/videobuf2-core.c
@@ -382,6 +382,27 @@ static void __setup_offsets(struct vb2_buffer *vb)
 	}
 }
 
+static void init_buffer_cache_hints(struct vb2_queue *q, struct vb2_buffer *vb)
+{
+	/*
+	 * DMA exporter should take care of cache syncs, so we can avoid
+	 * explicit ->prepare()/->finish() syncs. For other ->memory types
+	 * we always need ->prepare() or/and ->finish() cache sync.
+	 */
+	if (q->memory == VB2_MEMORY_DMABUF) {
+		vb->skip_cache_sync_on_finish = 1;
+		vb->skip_cache_sync_on_prepare = 1;
+		return;
+	}
+
+	/*
+	 * ->finish() cache sync can be avoided when queue direction is
+	 * TO_DEVICE.
+	 */
+	if (q->dma_dir == DMA_TO_DEVICE)
+		vb->skip_cache_sync_on_finish = 1;
+}
+
 /*
  * __vb2_queue_alloc() - allocate videobuf buffer structures and (for MMAP type)
  * video buffer memory for all buffers/planes on the queue and initializes the
@@ -415,6 +436,7 @@ static int __vb2_queue_alloc(struct vb2_queue *q, enum vb2_memory memory,
 		vb->index = q->num_buffers + buffer;
 		vb->type = q->type;
 		vb->memory = memory;
+		init_buffer_cache_hints(q, vb);
 		for (plane = 0; plane < num_planes; ++plane) {
 			vb->planes[plane].length = plane_sizes[plane];
 			vb->planes[plane].min_length = plane_sizes[plane];
diff --git a/drivers/media/common/videobuf2/videobuf2-v4l2.c b/drivers/media/common/videobuf2/videobuf2-v4l2.c
index 454d58268602..2fbae9bd7b52 100644
--- a/drivers/media/common/videobuf2/videobuf2-v4l2.c
+++ b/drivers/media/common/videobuf2/videobuf2-v4l2.c
@@ -345,17 +345,6 @@ static void set_buffer_cache_hints(struct vb2_queue *q,
 				   struct vb2_buffer *vb,
 				   struct v4l2_buffer *b)
 {
-	/*
-	 * DMA exporter should take care of cache syncs, so we can avoid
-	 * explicit ->prepare()/->finish() syncs. For other ->memory types
-	 * we always need ->prepare() or/and ->finish() cache sync.
-	 */
-	if (q->memory == VB2_MEMORY_DMABUF) {
-		vb->skip_cache_sync_on_finish = 1;
-		vb->skip_cache_sync_on_prepare = 1;
-		return;
-	}
-
 	if (!vb2_queue_allows_cache_hints(q)) {
 		/*
 		 * Clear buffer cache flags if queue does not support user
@@ -367,13 +356,6 @@ static void set_buffer_cache_hints(struct vb2_queue *q,
 		return;
 	}
 
-	/*
-	 * ->finish() cache sync can be avoided when queue direction is
-	 * TO_DEVICE.
-	 */
-	if (q->dma_dir == DMA_TO_DEVICE)
-		vb->skip_cache_sync_on_finish = 1;
-
 	if (b->flags & V4L2_BUF_FLAG_NO_CACHE_INVALIDATE)
 		vb->skip_cache_sync_on_finish = 1;
 
-- 
2.32.0.432.gabb21c7263-goog

