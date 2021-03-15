Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB23033AA02
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 04:35:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbhCODe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Mar 2021 23:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbhCODen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Mar 2021 23:34:43 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79E75C061574
        for <linux-kernel@vger.kernel.org>; Sun, 14 Mar 2021 20:34:42 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id w34so18591528pga.8
        for <linux-kernel@vger.kernel.org>; Sun, 14 Mar 2021 20:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6VIIUS0tZ0JnFTqnDnQ/7/2RW34umf7gFYzWJr0+m3o=;
        b=Y/5Gc4o1Gqzv86W3RPb71k7jiPj3qdZezB+p3c0FKKVLJFfCj2OWINcxvyKBbbHFAh
         6YoBRvNEoKaLZSo6n2UVvau9l9/9oNfwNLRV+oekckJ3QqqAz5jsk1CMF08MWCGD0X9G
         kBURJWGXbQAD8NXPBUyMUkFGI5M0Mxe4LEqnR4fq/QlXB7i9YxIF2og3ZCvIGRWcfgxi
         Wx2qvGYyyeUo/9sDw4n6/Nij53h//9VTFnSZmaVK29jTHN3YOwb/ixteW5gQSIQuNawa
         slOM1Py1D7w3tMC3RY81jk/CoPU/zRGclCRk+UpTqeuYbI/DfSZvjcrxpicbLI9i5vU6
         S65w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=6VIIUS0tZ0JnFTqnDnQ/7/2RW34umf7gFYzWJr0+m3o=;
        b=fU65J040DV8cKF1x38HnByYkmhpwqX27BLVLHVrstBekzHEcMLtHFQu2igYMKmNBPb
         iEoyfBBE11/5vbVvg3Yw/Rg8zpa0T4ztgdHMyYr6ZCMaeFtjoGkenGmZvHnaTB0/4Sck
         Yt62chQEiBX5fOPPI0JD2mtCBVLiRUzkT1NFNfCg3u9ZMqy/ze9KA4dcdBYWtjesarx4
         +l2Inyg6FImLmRVAmBfo7VkePmtLucPgQYN6FH166Ob3HXKMGnmSqKHFqd4YrLUlHkW3
         YS65/XKY17gn/c7Hr9BrKiJUQvufBDgklEfJG5K7xK92XiWGQey9ZaxH3vpzTZPzYLna
         DwxA==
X-Gm-Message-State: AOAM530mig+Z5SWLzaHVt7Up2oqayrqxQJ/vyDMoyc/L8oVlGyBxQJFY
        VEI+nlrhysl3aiS6frxNBow=
X-Google-Smtp-Source: ABdhPJztwtobjan2Dfug5TIrICsytT1Z0o/Bo+OfJPASSkKnd9KrBN4xc/0LkY4JxJBPuR4LhcjbrA==
X-Received: by 2002:a63:141e:: with SMTP id u30mr21887639pgl.31.1615779281733;
        Sun, 14 Mar 2021 20:34:41 -0700 (PDT)
Received: from balhae.roam.corp.google.com ([101.235.31.111])
        by smtp.gmail.com with ESMTPSA id fs9sm8322700pjb.40.2021.03.14.20.34.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Mar 2021 20:34:41 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>
Subject: [PATCH] perf core: Allocate perf_buffer in the target node memory
Date:   Mon, 15 Mar 2021 12:34:36 +0900
Message-Id: <20210315033436.682438-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I found the ring buffer pages are allocated in the node but the ring
buffer itself is not.  Let's convert it to use kzalloc_node() too.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 kernel/events/ring_buffer.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index ef91ae75ca56..bd55ccc91373 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -804,7 +804,7 @@ struct perf_buffer *rb_alloc(int nr_pages, long watermark, int cpu, int flags)
 {
 	struct perf_buffer *rb;
 	unsigned long size;
-	int i;
+	int i, node;
 
 	size = sizeof(struct perf_buffer);
 	size += nr_pages * sizeof(void *);
@@ -812,7 +812,8 @@ struct perf_buffer *rb_alloc(int nr_pages, long watermark, int cpu, int flags)
 	if (order_base_2(size) >= PAGE_SHIFT+MAX_ORDER)
 		goto fail;
 
-	rb = kzalloc(size, GFP_KERNEL);
+	node = (cpu == -1) ? cpu : cpu_to_node(cpu);
+	rb = kzalloc_node(size, GFP_KERNEL, node);
 	if (!rb)
 		goto fail;
 
@@ -906,11 +907,13 @@ struct perf_buffer *rb_alloc(int nr_pages, long watermark, int cpu, int flags)
 	struct perf_buffer *rb;
 	unsigned long size;
 	void *all_buf;
+	int node;
 
 	size = sizeof(struct perf_buffer);
 	size += sizeof(void *);
 
-	rb = kzalloc(size, GFP_KERNEL);
+	node = (cpu == -1) ? cpu : cpu_to_node(cpu);
+	rb = kzalloc_node(size, GFP_KERNEL, node);
 	if (!rb)
 		goto fail;
 
-- 
2.31.0.rc2.261.g7f71774620-goog

