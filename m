Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1137E32A12A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 14:45:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381227AbhCBEts (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 23:49:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1445264AbhCBC5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 21:57:31 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD229C061793
        for <linux-kernel@vger.kernel.org>; Mon,  1 Mar 2021 18:56:37 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id d2so943846pjs.4
        for <linux-kernel@vger.kernel.org>; Mon, 01 Mar 2021 18:56:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qLXJJyTj2yGmwufJrM80dinHQtmlczvZXDaE20Ufino=;
        b=htFcUre7nmJ937TM3BXjnoM2/k9jS0HNIBATgAqlEiVfL9DmC9GCGhliVgBKQ0mW0q
         KSNhTijHLDFsuBUkzog/Ge0LuUq49qwdfqMo7d6xKfuFj15nX0fCIv033jIIOPT22C8c
         Adks/asM17AtDNgEx+9zIgi4GvJ2ZG0J7QmxiR5LxhzKJOhYh67DgOd6lgYFE93Rej0q
         MOGxYRsCUSV2r69BKt4OInL1gGNV5935enQ85wzw/1gYbK1Kb7synjizSroNH31eHCMb
         ceowi6mkHPHx6dZwMJmEddKkmEMCv1Q57MPtKJxWjxpx7OwiHqVcr3ogjnkm7gHAOM68
         TM4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qLXJJyTj2yGmwufJrM80dinHQtmlczvZXDaE20Ufino=;
        b=iCgUztG7yR9AysqM7UatwrBy/yZ23vPy5r27vY0vb8/bE56e2C+CMYqn9/XmJXqdQI
         DRM30IARE68YqLyOzORo3miivp7LUXncgZf2UPWMcu8ITUReQSqwSsNhQ3AA0VbmtxdM
         tvZK+zW88k/ZlSh+eBIB4Z5wJMX7Q1fBuSPxFHm27WBMNke06PXq213+Ty21mf1bh+CG
         s6CrTWrUJYrMAoZJY4es09g6wwStQcxWfI9jqVsZDh3XBH0VNkYw9epjJ1VdoGL9Bm/H
         V7gsopDJcV7qT78hHgri7lQm5nPaN6ZsG0feUmNKciQe2Yol0mbuxT+o4tA2NZ0hI7vd
         dDNA==
X-Gm-Message-State: AOAM531Nm5zjIdRkt+qsnE3nLolmL6zqORx4XXIvBZbwhcVmidU6OWdd
        bi+PkiCs5z1Zg+dW2E38U4zEopwy7wVCsA==
X-Google-Smtp-Source: ABdhPJxBHNAF2OwS2gBChuYXTnwdjSw4f0lQ7k1NHAI6CiKbCqzF3nuyVHTR6ygWHmzZuPm/qFfgtQ==
X-Received: by 2002:a17:902:e20c:b029:e4:7a08:8452 with SMTP id u12-20020a170902e20cb02900e47a088452mr1563793plb.74.1614653796901;
        Mon, 01 Mar 2021 18:56:36 -0800 (PST)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id r16sm18928400pfh.168.2021.03.01.18.56.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Mar 2021 18:56:36 -0800 (PST)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Chris Goldsworthy <cgoldswo@codeaurora.org>,
        Laura Abbott <labbott@kernel.org>,
        Brian Starkey <Brian.Starkey@arm.com>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Daniel Mentz <danielmentz@google.com>,
        =?UTF-8?q?=C3=98rjan=20Eide?= <orjan.eide@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Simon Ser <contact@emersion.fr>,
        James Jones <jajones@nvidia.com>, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: [RESEND][PATCH v2 2/2] dma-buf: heaps: Fix the name used when exporting dmabufs to be the actual heap name
Date:   Tue,  2 Mar 2021 02:56:29 +0000
Message-Id: <20210302025629.2558215-2-john.stultz@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210302025629.2558215-1-john.stultz@linaro.org>
References: <20210302025629.2558215-1-john.stultz@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By default dma_buf_export() sets the exporter name to be
KBUILD_MODNAME. Unfortunately this may not be identical to the
string used as the heap name (ie: "system" vs "system_heap").

This can cause some minor confusion with tooling, and there is
the future potential where multiple heap types may be exported
by the same module (but would all have the same name).

So to avoid all this, set the exporter exp_name to the heap name.

Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Sumit Semwal <sumit.semwal@linaro.org>
Cc: Liam Mark <lmark@codeaurora.org>
Cc: Chris Goldsworthy <cgoldswo@codeaurora.org>
Cc: Laura Abbott <labbott@kernel.org>
Cc: Brian Starkey <Brian.Starkey@arm.com>
Cc: Hridya Valsaraju <hridya@google.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Sandeep Patil <sspatil@google.com>
Cc: Daniel Mentz <danielmentz@google.com>
Cc: Ørjan Eide <orjan.eide@arm.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Ezequiel Garcia <ezequiel@collabora.com>
Cc: Simon Ser <contact@emersion.fr>
Cc: James Jones <jajones@nvidia.com>
Cc: linux-media@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 drivers/dma-buf/heaps/cma_heap.c    | 1 +
 drivers/dma-buf/heaps/system_heap.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/dma-buf/heaps/cma_heap.c b/drivers/dma-buf/heaps/cma_heap.c
index 5d64eccd21d6..0c05b79870f9 100644
--- a/drivers/dma-buf/heaps/cma_heap.c
+++ b/drivers/dma-buf/heaps/cma_heap.c
@@ -339,6 +339,7 @@ static struct dma_buf *cma_heap_allocate(struct dma_heap *heap,
 	buffer->pagecount = pagecount;
 
 	/* create the dmabuf */
+	exp_info.exp_name = dma_heap_get_name(heap);
 	exp_info.ops = &cma_heap_buf_ops;
 	exp_info.size = buffer->len;
 	exp_info.flags = fd_flags;
diff --git a/drivers/dma-buf/heaps/system_heap.c b/drivers/dma-buf/heaps/system_heap.c
index 29e49ac17251..23a7e74ef966 100644
--- a/drivers/dma-buf/heaps/system_heap.c
+++ b/drivers/dma-buf/heaps/system_heap.c
@@ -390,6 +390,7 @@ static struct dma_buf *system_heap_allocate(struct dma_heap *heap,
 	}
 
 	/* create the dmabuf */
+	exp_info.exp_name = dma_heap_get_name(heap);
 	exp_info.ops = &system_heap_buf_ops;
 	exp_info.size = buffer->len;
 	exp_info.flags = fd_flags;
-- 
2.25.1

