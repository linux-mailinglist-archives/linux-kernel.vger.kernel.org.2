Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6C33D6FE9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 09:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235778AbhG0HFx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 03:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235753AbhG0HFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 03:05:48 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1286C061764
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 00:05:48 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id ca5so4091874pjb.5
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 00:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uXIygArbnqshrZ8S+Y5OwiBL87kWbue240bYBuorW3c=;
        b=fWHIWJuiMKWEzPCJOjS1fS+g7jvxzqH39dlKbeXPL1OjPydIRUx+rMqLqyUUPlDS1m
         VGPcRE+JmbKgwfQr5OlieFG05xoWPQZERlmF5nNVI4rigScHPKJ9qL4Sh3JLHh/IdPg0
         qDutNSxcMfCoR5jLmrcWfqqSS8YH0xf+SE9oY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uXIygArbnqshrZ8S+Y5OwiBL87kWbue240bYBuorW3c=;
        b=petI7zfo+v0m7BCqEp5h1V9woQwozEbiLtY1hDD0eFslK6nbrMoCle/ve+asd5WbNp
         QkvG4epSHU8k2Dc79s/amKtZ6xy57i3pw2Oiz0YOTA3S0Eiho5JNPT691l+qLI8/CgG+
         8Cy8X29o+P8vka5vmibEVkTqNvQ4FosmOHmwqOhaSGj26XF1hN3Y1n3DKLO985w4ws/L
         I1a6GME1czigyuxj1O9AFLVlVoMl5oMHoEPpSXUuVucMNtBTEp5tH2M0/zRVNOB4Vaul
         Sfcs4gZ7z839eOKLXBhwl8WAc4tlpgAc481AUWXB3kGviqxEakr+AqjQXgsDwwJt6CiP
         jw4w==
X-Gm-Message-State: AOAM533hK2IR6BzYGFqzYt7tencbS1cYCLKe2YEiBytRcp1ZMNXr2/UX
        0rPYxyy79nzdPwyjp1b6zSs+tw==
X-Google-Smtp-Source: ABdhPJylcX1n9taGQPxHFyDQgk7Hzs2dqqWqE7W7MQIyorOgEeUg1TIMjphpNMuqj/wYBkgD0SdH9g==
X-Received: by 2002:a63:d04:: with SMTP id c4mr22626121pgl.368.1627369548584;
        Tue, 27 Jul 2021 00:05:48 -0700 (PDT)
Received: from senozhatsky.flets-east.jp ([2409:10:2e40:5100:ba3e:509b:495:ec84])
        by smtp.gmail.com with ESMTPSA id 30sm2343447pgq.31.2021.07.27.00.05.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 00:05:48 -0700 (PDT)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Tomasz Figa <tfiga@chromium.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
        Ricardo Ribalda <ribalda@chromium.org>,
        Christoph Hellwig <hch@lst.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv4 5/8] videobuf2: add V4L2_MEMORY_FLAG_NON_COHERENT flag
Date:   Tue, 27 Jul 2021 16:05:14 +0900
Message-Id: <20210727070517.443167-6-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.32.0.432.gabb21c7263-goog
In-Reply-To: <20210727070517.443167-1-senozhatsky@chromium.org>
References: <20210727070517.443167-1-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By setting or clearing V4L2_MEMORY_FLAG_NON_COHERENT flag
user-space should be able to hint vb2 that either a non-coherent
(if supported) or coherent memory should be used for the buffer
allocation.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 .../userspace-api/media/v4l/buffer.rst        | 40 ++++++++++++++++++-
 .../media/v4l/vidioc-reqbufs.rst              |  5 ++-
 include/uapi/linux/videodev2.h                |  2 +
 3 files changed, 43 insertions(+), 4 deletions(-)

diff --git a/Documentation/userspace-api/media/v4l/buffer.rst b/Documentation/userspace-api/media/v4l/buffer.rst
index e991ba73d873..4638ec64db00 100644
--- a/Documentation/userspace-api/media/v4l/buffer.rst
+++ b/Documentation/userspace-api/media/v4l/buffer.rst
@@ -676,8 +676,6 @@ Buffer Flags
 
     \normalsize
 
-.. _memory-flags:
-
 enum v4l2_memory
 ================
 
@@ -701,6 +699,44 @@ enum v4l2_memory
       - 4
       - The buffer is used for :ref:`DMA shared buffer <dmabuf>` I/O.
 
+.. _memory-flags:
+
+Memory Consistency Flags
+------------------------
+
+.. raw:: latex
+
+    \small
+
+.. tabularcolumns:: |p{7.0cm}|p{2.1cm}|p{8.4cm}|
+
+.. cssclass:: longtable
+
+.. flat-table::
+    :header-rows:  0
+    :stub-columns: 0
+    :widths:       3 1 4
+
+    * .. _`V4L2-MEMORY-FLAG-NON-COHERENT`:
+
+      - ``V4L2_MEMORY_FLAG_NON_COHERENT``
+      - 0x00000001
+      - A buffer is allocated either in coherent (it will be automatically
+	coherent between the CPU and the bus) or non-coherent memory. The
+	latter can provide performance gains, for instance the CPU cache
+	sync/flush operations can be avoided if the buffer is accessed by the
+	corresponding device only and the CPU does not read/write to/from that
+	buffer. However, this requires extra care from the driver -- it must
+	guarantee memory consistency by issuing a cache flush/sync when
+	consistency is needed. If this flag is set V4L2 will attempt to
+	allocate the buffer in non-coherent memory. The flag takes effect
+	only if the buffer is used for :ref:`memory mapping <mmap>` I/O and the
+	queue reports the :ref:`V4L2_BUF_CAP_SUPPORTS_MMAP_CACHE_HINTS
+	<V4L2-BUF-CAP-SUPPORTS-MMAP-CACHE-HINTS>` capability.
+
+.. raw:: latex
+
+    \normalsize
 
 Timecodes
 =========
diff --git a/Documentation/userspace-api/media/v4l/vidioc-reqbufs.rst b/Documentation/userspace-api/media/v4l/vidioc-reqbufs.rst
index 50ea72043bb0..e59306aba2b0 100644
--- a/Documentation/userspace-api/media/v4l/vidioc-reqbufs.rst
+++ b/Documentation/userspace-api/media/v4l/vidioc-reqbufs.rst
@@ -158,8 +158,9 @@ aborting or finishing any DMA in progress, an implicit
       - This capability is set by the driver to indicate that the queue supports
         cache and memory management hints. However, it's only valid when the
         queue is used for :ref:`memory mapping <mmap>` streaming I/O. See
-        :ref:`V4L2_BUF_FLAG_NO_CACHE_INVALIDATE <V4L2-BUF-FLAG-NO-CACHE-INVALIDATE>` and
-        :ref:`V4L2_BUF_FLAG_NO_CACHE_CLEAN <V4L2-BUF-FLAG-NO-CACHE-CLEAN>`.
+        :ref:`V4L2_BUF_FLAG_NO_CACHE_INVALIDATE <V4L2-BUF-FLAG-NO-CACHE-INVALIDATE>`,
+        :ref:`V4L2_BUF_FLAG_NO_CACHE_CLEAN <V4L2-BUF-FLAG-NO-CACHE-CLEAN>` and
+        :ref:`V4L2_MEMORY_FLAG_NON_COHERENT <V4L2-MEMORY-FLAG-NON-COHERENT>`.
 
 .. raw:: latex
 
diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
index 9260791b8438..9d11e1d9c934 100644
--- a/include/uapi/linux/videodev2.h
+++ b/include/uapi/linux/videodev2.h
@@ -956,6 +956,8 @@ struct v4l2_requestbuffers {
 	__u32			reserved[1];
 };
 
+#define V4L2_MEMORY_FLAG_NON_COHERENT			(1 << 0)
+
 /* capabilities for struct v4l2_requestbuffers and v4l2_create_buffers */
 #define V4L2_BUF_CAP_SUPPORTS_MMAP			(1 << 0)
 #define V4L2_BUF_CAP_SUPPORTS_USERPTR			(1 << 1)
-- 
2.32.0.432.gabb21c7263-goog

