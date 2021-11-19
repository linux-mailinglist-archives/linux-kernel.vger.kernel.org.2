Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6172245694E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 05:40:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233895AbhKSEno (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 23:43:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232046AbhKSEni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 23:43:38 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BFD0C06173E
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 20:40:37 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id y13so37046652edd.13
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 20:40:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zHbg/Ya59O4aUOQIYFUOEf0G01wJB9EeNDGBnqX7BE0=;
        b=Lu4O2MzUiwMbyGngbljb1XjUByeTzK37CKfszPJfjAoQwO/8L/USd4IJlp89QILQGh
         VEZpcV6+SzMptIiyCUkXBrl86WrHKneEPh91lbfqugktJ8wHJ0JRo4kVy6huqjFgx4yg
         FAOrypiMAyiYXuP23KlLzZb3I2IN8VlQj31HhJkQj73F9m5T//GS3U3XQeqxbyGJ2zM5
         /lx0yksYMyxcopUQLVnSt+MrgMni/y82IB3GQgU88MeJaWTcAF/Gazkkvj6sNYSSvxBe
         1uKoZ/yv9NNKmzHVbjBVZr1xJHnhPCWYuqR8xg6bI7fTs9WKol/tBQpLVB6RkANXeXzY
         x+Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zHbg/Ya59O4aUOQIYFUOEf0G01wJB9EeNDGBnqX7BE0=;
        b=Y2R7Y9/NoleTZkCLfEOCWurhvnPhaOoxf/iuiuKvgjxtnMl+t42CpFh8wZfDMgcXlQ
         G3MRtQVew31Wj+r9IXNpuQBGlh8zTKowMTSh3l3L0oW34ETKg3peRd79XQ54046QkoSw
         wsAV7H1iPy4w4ATe1vbcpb1CfuJIb0nv75MFVfZeWHBU4fDE41dnOB6q3h3ouo8IEnd5
         P0kEbylzwMzj2oa9xjlbPsI/DEE6yG7AJN7TWXz7RBjQmHDetfR/h5GFb3II1dp904Fh
         jPTr7Y3fdgcsCyiwKfJp6YiCDB3gYJKTJ/MVNQ++KQqBoVTTwxg21k9icn40NdqJoicO
         wkQQ==
X-Gm-Message-State: AOAM530whsbb488pbAtMgV3EyUYk6OF3vva93g8XXWioXzg3j8t96ARd
        rUHF2/3Y33eN4ozCLvVZ0JJUS+e7d1YozQ==
X-Google-Smtp-Source: ABdhPJykfBnSs0q9Qzi47myLupd/GFPoV5Zo45Sv+HZJf/ZGkJq+GcAeOo85Xv+jr45HeKKmmBD2DA==
X-Received: by 2002:a17:907:9707:: with SMTP id jg7mr3737247ejc.533.1637296835737;
        Thu, 18 Nov 2021 20:40:35 -0800 (PST)
Received: from oberon.zico.biz.zico.biz ([83.222.187.186])
        by smtp.gmail.com with ESMTPSA id lv19sm694709ejb.54.2021.11.18.20.40.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 20:40:35 -0800 (PST)
From:   "Tzvetomir Stoyanov (VMware)" <tz.stoyanov@gmail.com>
To:     rostedt@goodmis.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] [WiP] tracing: Set new size of the ring buffer sub page
Date:   Fri, 19 Nov 2021 06:40:30 +0200
Message-Id: <20211119044030.85368-5-tz.stoyanov@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211119044030.85368-1-tz.stoyanov@gmail.com>
References: <20211119044030.85368-1-tz.stoyanov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two approaches when changing the size of the ring buffer
sub page:
 1. Destroying all pages and allocating new pages with the new size.
 2. Allocating new pages, copying the content of the old pages before
    destroying them.
The first approach is easier, it is selected in the proposed
implementation. Changing the ring buffer sub page size is supposed to
not happen frequently. Usually, that size should be set only once,
when the buffer is not in use yet and is supposed to be empty.

Signed-off-by: Tzvetomir Stoyanov (VMware) <tz.stoyanov@gmail.com>
---
 kernel/trace/ring_buffer.c | 82 ++++++++++++++++++++++++++++++++++----
 1 file changed, 75 insertions(+), 7 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 489b8a4c6d77..e75504d537b3 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -323,6 +323,7 @@ struct buffer_page {
 	unsigned	 read;		/* index for next read */
 	local_t		 entries;	/* entries on this page */
 	unsigned long	 real_end;	/* real end of data */
+	unsigned	 order;		/* order of the page */
 	struct buffer_data_page *page;	/* Actual data page */
 };
 
@@ -352,7 +353,7 @@ static void rb_init_page(struct buffer_data_page *bpage)
  */
 static void free_buffer_page(struct buffer_page *bpage)
 {
-	free_page((unsigned long)bpage->page);
+	free_pages((unsigned long)bpage->page, bpage->order);
 	kfree(bpage);
 }
 
@@ -1551,6 +1552,7 @@ static int __rb_allocate_pages(struct ring_buffer_per_cpu *cpu_buffer,
 	 */
 	if (user_thread)
 		set_current_oom_origin();
+
 	for (i = 0; i < nr_pages; i++) {
 		struct page *page;
 
@@ -1563,10 +1565,12 @@ static int __rb_allocate_pages(struct ring_buffer_per_cpu *cpu_buffer,
 
 		list_add(&bpage->list, pages);
 
-		page = alloc_pages_node(cpu_to_node(cpu_buffer->cpu), mflags, 0);
+		page = alloc_pages_node(cpu_to_node(cpu_buffer->cpu), mflags,
+					cpu_buffer->buffer->subbuf_order);
 		if (!page)
 			goto free_pages;
 		bpage->page = page_address(page);
+		bpage->order = cpu_buffer->buffer->subbuf_order;
 		rb_init_page(bpage->page);
 
 		if (user_thread && fatal_signal_pending(current))
@@ -1645,7 +1649,8 @@ rb_allocate_cpu_buffer(struct trace_buffer *buffer, long nr_pages, int cpu)
 	rb_check_bpage(cpu_buffer, bpage);
 
 	cpu_buffer->reader_page = bpage;
-	page = alloc_pages_node(cpu_to_node(cpu), GFP_KERNEL, 0);
+
+	page = alloc_pages_node(cpu_to_node(cpu), GFP_KERNEL, cpu_buffer->buffer->subbuf_order);
 	if (!page)
 		goto fail_free_reader;
 	bpage->page = page_address(page);
@@ -1725,6 +1730,7 @@ struct trace_buffer *__ring_buffer_alloc(unsigned long size, unsigned flags,
 		goto fail_free_buffer;
 
 	/* Default buffer page size - one system page */
+	buffer->subbuf_order = 0;
 	buffer->subbuf_size = PAGE_SIZE - BUF_PAGE_HDR_SIZE;
 
 	/* Max payload is buffer page size - header (8bytes) */
@@ -5434,8 +5440,8 @@ void *ring_buffer_alloc_read_page(struct trace_buffer *buffer, int cpu)
 	if (bpage)
 		goto out;
 
-	page = alloc_pages_node(cpu_to_node(cpu),
-				GFP_KERNEL | __GFP_NORETRY, 0);
+	page = alloc_pages_node(cpu_to_node(cpu), GFP_KERNEL | __GFP_NORETRY,
+				cpu_buffer->buffer->subbuf_order);
 	if (!page)
 		return ERR_PTR(-ENOMEM);
 
@@ -5479,7 +5485,7 @@ void ring_buffer_free_read_page(struct trace_buffer *buffer, int cpu, void *data
 	local_irq_restore(flags);
 
  out:
-	free_page((unsigned long)bpage);
+	free_pages((unsigned long)bpage, buffer->subbuf_order);
 }
 EXPORT_SYMBOL_GPL(ring_buffer_free_read_page);
 
@@ -5719,7 +5725,14 @@ EXPORT_SYMBOL_GPL(ring_buffer_subbuf_order_get);
  */
 int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
 {
+	struct ring_buffer_per_cpu **cpu_buffers;
+	int old_order, old_size;
+	int nr_pages;
+	int ret = 0;
 	int psize;
+	int bsize;
+	int err;
+	int cpu;
 
 	if (!buffer || order < 0)
 		return -EINVAL;
@@ -5731,12 +5744,67 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
 	if (psize <= BUF_PAGE_HDR_SIZE)
 		return -EINVAL;
 
+	bsize = sizeof(void *) * buffer->cpus;
+	cpu_buffers = kzalloc(bsize, GFP_KERNEL);
+	if (!cpu_buffers)
+		return -ENOMEM;
+
+	old_order = buffer->subbuf_order;
+	old_size = buffer->subbuf_size;
+
+	/* prevent another thread from changing buffer sizes */
+	mutex_lock(&buffer->mutex);
+	atomic_inc(&buffer->record_disabled);
+
+	/* Make sure all commits have finished */
+	synchronize_rcu();
+
 	buffer->subbuf_order = order;
 	buffer->subbuf_size = psize - BUF_PAGE_HDR_SIZE;
 
-	/* Todo: reset the buffer with the new page size */
+	/* Make sure all new buffers are allocated, before deleting the old ones */
+	for_each_buffer_cpu(buffer, cpu) {
+		if (!cpumask_test_cpu(cpu, buffer->cpumask))
+			continue;
+
+		nr_pages = buffer->buffers[cpu]->nr_pages;
+		cpu_buffers[cpu] = rb_allocate_cpu_buffer(buffer, nr_pages, cpu);
+		if (!cpu_buffers[cpu]) {
+			err = -ENOMEM;
+			goto error;
+		}
+	}
+
+	for_each_buffer_cpu(buffer, cpu) {
+		if (!cpumask_test_cpu(cpu, buffer->cpumask))
+			continue;
+
+		rb_free_cpu_buffer(buffer->buffers[cpu]);
+		buffer->buffers[cpu] = cpu_buffers[cpu];
+	}
+
+	atomic_dec(&buffer->record_disabled);
+	mutex_unlock(&buffer->mutex);
+
+	kfree(cpu_buffers);
 
 	return 0;
+
+error:
+	buffer->subbuf_order = old_order;
+	buffer->subbuf_size = old_size;
+
+	atomic_dec(&buffer->record_disabled);
+	mutex_unlock(&buffer->mutex);
+
+	for_each_buffer_cpu(buffer, cpu) {
+		if (!cpu_buffers[cpu])
+			continue;
+		kfree(cpu_buffers[cpu]);
+	}
+	kfree(cpu_buffers);
+
+	return err;
 }
 EXPORT_SYMBOL_GPL(ring_buffer_subbuf_order_set);
 
-- 
2.31.1

