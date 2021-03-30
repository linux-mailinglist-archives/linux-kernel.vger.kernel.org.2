Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F88734F3EC
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 00:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232700AbhC3WDK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 18:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232672AbhC3WCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 18:02:42 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19431C061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 15:02:42 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id c204so13093301pfc.4
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 15:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x1Tf27hLCUXsjwagiwK93HjbjfAF6ka0w+D0kxkF1lk=;
        b=djaOrOd+quxNbbpMA1466B+wEKnLIJ+8ATvawoG8KLRyViDGl0fiuPZSh+cx5BJUU7
         iI5tZmzhdQM2VIpNmSM79wh2vAbouDnhYY64qaWiTyhx4KURake8hHoGw3o0nJ6rLhuI
         ps39DrukwlADP9bc5sfoofgY7gXXOuuK9tkTfaYTNBRCfiX9ldTH1xWQ26qCMGDgOTQ9
         49dL6JYYNBtFLVzsEsBC5Ujkq6WCH3ve3GKLAjIIF/t2AxArj45qE+DiNAGNT2p1bW05
         0UMaep2f+QbmSx3y4jzppWR5jRz/AjLC81pr7mz5q7oDI0+RE4kWamkWL+fOwkdCfILf
         dq5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=x1Tf27hLCUXsjwagiwK93HjbjfAF6ka0w+D0kxkF1lk=;
        b=oIre1Cxk9Rncdw//NjR4jg421fidCNWkckVj6Erj8wDUrBw15RyxtEBZAtpOk7qIQh
         uVvNy6bQwiucLD5Zy/6Je/0n8n8gIP1LWpIDUawxgsyQmJiBReXsVcdoaKFUOvG3lqVR
         wVmwb5ojLybjQguRRIVekTWgV3iy0CRjktUPamisDBXrcgty9tMfe9C8ktjfvM0Nz5Hl
         YgPA4YHhYZOPOtlhIcoRmbKXvzRHBU/dTx6t5HVdNXw6pDNXBTarxkbvU4u9eeKI0UIo
         Runfq/4n7TF7QJW5pdk+dvMAQSsU46wvblnM3whctlreI8O0OEyK3pGi2biCX+/kY3vM
         /WkQ==
X-Gm-Message-State: AOAM531c08SxQeUy9nwVTWJ6aPxjkQpXQ9sf/vKyEr3WjxrOeXQR2ext
        iu+lH02Xbru3ttJFKo7T9P2nZQ+BtOI=
X-Google-Smtp-Source: ABdhPJzgSUBmlDaRWfK168J1PvsA7rY0M8T60O6r6My0ulvn35+8mKjSkpiW/P59T2O4J3jmYmyBuA==
X-Received: by 2002:a63:3686:: with SMTP id d128mr213051pga.331.1617141761684;
        Tue, 30 Mar 2021 15:02:41 -0700 (PDT)
Received: from bbox-1.mtv.corp.google.com ([2620:15c:211:201:e1ca:cef0:ac9e:7cda])
        by smtp.gmail.com with ESMTPSA id i17sm24882pfq.135.2021.03.30.15.02.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 15:02:40 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        joaodias@google.com, Minchan Kim <minchan@kernel.org>,
        Liam Mark <lmark@codeaurora.org>,
        Georgi Djakov <georgi.djakov@linaro.org>
Subject: [PATCH] mm: cma: add the CMA instance name to cma trace events
Date:   Tue, 30 Mar 2021 15:02:37 -0700
Message-Id: <20210330220237.748899-1-minchan@kernel.org>
X-Mailer: git-send-email 2.31.0.208.g409f899ff0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There were missing places to add cma instance name. To identify
each CMA instance, let's add the name for every cma trace.
This patch also changes the existing cma_trace_alloc to
cma_trace_finish since we have cma_alloc_start[1].

[1] https://lore.kernel.org/linux-mm/20210324160740.15901-1-georgi.djakov@linaro.org

Cc: Liam Mark <lmark@codeaurora.org>
Cc: Georgi Djakov <georgi.djakov@linaro.org>
Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 include/trace/events/cma.h | 28 +++++++++++++++++-----------
 mm/cma.c                   |  7 ++++---
 2 files changed, 21 insertions(+), 14 deletions(-)

diff --git a/include/trace/events/cma.h b/include/trace/events/cma.h
index be1525a10457..5cf385ae7c08 100644
--- a/include/trace/events/cma.h
+++ b/include/trace/events/cma.h
@@ -10,12 +10,13 @@
 
 DECLARE_EVENT_CLASS(cma_alloc_class,
 
-	TP_PROTO(unsigned long pfn, const struct page *page,
+	TP_PROTO(const char *name, unsigned long pfn, const struct page *page,
 		 unsigned int count, unsigned int align),
 
-	TP_ARGS(pfn, page, count, align),
+	TP_ARGS(name, pfn, page, count, align),
 
 	TP_STRUCT__entry(
+		__string(name, name)
 		__field(unsigned long, pfn)
 		__field(const struct page *, page)
 		__field(unsigned int, count)
@@ -23,13 +24,15 @@ DECLARE_EVENT_CLASS(cma_alloc_class,
 	),
 
 	TP_fast_assign(
+		__assign_str(name, name);
 		__entry->pfn = pfn;
 		__entry->page = page;
 		__entry->count = count;
 		__entry->align = align;
 	),
 
-	TP_printk("pfn=%lx page=%p count=%u align=%u",
+	TP_printk("name=%s pfn=%lx page=%p count=%u align=%u",
+		  __get_str(name),
 		  __entry->pfn,
 		  __entry->page,
 		  __entry->count,
@@ -38,24 +41,27 @@ DECLARE_EVENT_CLASS(cma_alloc_class,
 
 TRACE_EVENT(cma_release,
 
-	TP_PROTO(unsigned long pfn, const struct page *page,
+	TP_PROTO(const char *name, unsigned long pfn, const struct page *page,
 		 unsigned int count),
 
-	TP_ARGS(pfn, page, count),
+	TP_ARGS(name, pfn, page, count),
 
 	TP_STRUCT__entry(
+		__string(name, name)
 		__field(unsigned long, pfn)
 		__field(const struct page *, page)
 		__field(unsigned int, count)
 	),
 
 	TP_fast_assign(
+		__assign_str(name, name);
 		__entry->pfn = pfn;
 		__entry->page = page;
 		__entry->count = count;
 	),
 
-	TP_printk("pfn=%lx page=%p count=%u",
+	TP_printk("name=%s pfn=%lx page=%p count=%u",
+		  __get_str(name),
 		  __entry->pfn,
 		  __entry->page,
 		  __entry->count)
@@ -85,20 +91,20 @@ TRACE_EVENT(cma_alloc_start,
 		  __entry->align)
 );
 
-DEFINE_EVENT(cma_alloc_class, cma_alloc,
+DEFINE_EVENT(cma_alloc_class, cma_alloc_finish,
 
-	TP_PROTO(unsigned long pfn, const struct page *page,
+	TP_PROTO(const char *name, unsigned long pfn, const struct page *page,
 		 unsigned int count, unsigned int align),
 
-	TP_ARGS(pfn, page, count, align)
+	TP_ARGS(name, pfn, page, count, align)
 );
 
 DEFINE_EVENT(cma_alloc_class, cma_alloc_busy_retry,
 
-	TP_PROTO(unsigned long pfn, const struct page *page,
+	TP_PROTO(const char *name, unsigned long pfn, const struct page *page,
 		 unsigned int count, unsigned int align),
 
-	TP_ARGS(pfn, page, count, align)
+	TP_ARGS(name, pfn, page, count, align)
 );
 
 #endif /* _TRACE_CMA_H */
diff --git a/mm/cma.c b/mm/cma.c
index b2393b892d3b..de6b9f01be53 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -486,12 +486,13 @@ struct page *cma_alloc(struct cma *cma, size_t count, unsigned int align,
 		pr_debug("%s(): memory range at %p is busy, retrying\n",
 			 __func__, pfn_to_page(pfn));
 
-		trace_cma_alloc_busy_retry(pfn, pfn_to_page(pfn), count, align);
+		trace_cma_alloc_busy_retry(cma->name, pfn, pfn_to_page(pfn),
+					   count, align);
 		/* try again with a bit different memory target */
 		start = bitmap_no + mask + 1;
 	}
 
-	trace_cma_alloc(pfn, page, count, align);
+	trace_cma_alloc_finish(cma->name, pfn, page, count, align);
 
 	/*
 	 * CMA can allocate multiple page blocks, which results in different
@@ -551,7 +552,7 @@ bool cma_release(struct cma *cma, const struct page *pages, unsigned int count)
 
 	free_contig_range(pfn, count);
 	cma_clear_bitmap(cma, pfn, count);
-	trace_cma_release(pfn, pages, count);
+	trace_cma_release(cma->name, pfn, pages, count);
 
 	return true;
 }
-- 
2.31.0.208.g409f899ff0-goog

