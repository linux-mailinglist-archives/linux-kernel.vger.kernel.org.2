Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A40CE347D4B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 17:08:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236969AbhCXQIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 12:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236957AbhCXQHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 12:07:45 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25BECC061763
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 09:07:45 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id w203-20020a1c49d40000b029010c706d0642so2977552wma.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 09:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F2eqQNnQaTW/PNnGt9t5T4vwku4oA90ao2tJhJGZtFI=;
        b=HAQORczoTucalytDwswGXDAXkcdld38VvF7BNDmuZcSWktS0OE7md++8dl9QagYDkJ
         q9oG0x93CIYIIGKujpP2XdBZdaNGh5AnsFraA2FqC1QVpEe80uEHi6B3gPKjdZ0NSsn1
         DFQNaenUu0Rngbw0nuwt6sQB3N/DbXitukuvoSoS44ETLH7MEyuwan7qm+4+p/5gqTQB
         3vJzJTGSg4weivupcML8hFFDrMT7hDiu0LNXvKJNit7LVtAXt2MTChUGgX64J0I0BV9i
         b6BLh46tIwO5qrF8/aL1xK3BNGY6Ho/Z/toSlhNAzVmMExFES992s0kO2r8nydv/OTkQ
         eT5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F2eqQNnQaTW/PNnGt9t5T4vwku4oA90ao2tJhJGZtFI=;
        b=Ld+BhgdyWACUh8+xdMhquYyrwNWG/D2QSZ4NHJOImFADYRiNapJ6v85VuiNGeneqFt
         0J34uLfHAnRRgKSIL/GdytaPYDhD/bTGJX0UmGgF9cYew0BBqb+zxPdyIyYYjVT8avsz
         W1eLb2LM35ivY1LOR1XGYPkMbt+9VtcDz7TlApVfp/vvCydmg8b9fUsb/fIrUCiNJq2x
         fB+Gm9PM+CAKvLOGmTYVDhlogGDPMPFre8Nvr/szThSCdTwr5WqpmAsxVqwAZL7760Hq
         y0ILPt5xNA8BhAIlKAueIyfZLQ4BCWw8PsKyzHzcixLqEtElGqj2V4nU1xTOlgQCSe14
         VJ2g==
X-Gm-Message-State: AOAM531YlzTOAM8JFtpBHKMC+Feb/7iWYsdmWhPGkw+/9A/u3vrZWqDM
        XmQHvZ/8J8dOX8Y20qE6ecHYTKPQwki+Ag==
X-Google-Smtp-Source: ABdhPJx8ZI9d6RduR34n9l4iaYqCLnlMKGLEHsiZVILBJSM9xXv0/DbPfnkW/rUOoy2qarPbLtTOBw==
X-Received: by 2002:a05:600c:4ba2:: with SMTP id e34mr3680336wmp.121.1616602063812;
        Wed, 24 Mar 2021 09:07:43 -0700 (PDT)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id y205sm3463588wmc.18.2021.03.24.09.07.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Mar 2021 09:07:43 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     rostedt@goodmis.org, akpm@linux-foundation.org
Cc:     mingo@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        georgi.djakov@linaro.org, Liam Mark <lmark@codeaurora.org>
Subject: [PATCH] mm: cma: add trace events for CMA alloc perf testing
Date:   Wed, 24 Mar 2021 18:07:40 +0200
Message-Id: <20210324160740.15901-1-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liam Mark <lmark@codeaurora.org>

Add cma and migrate trace events to enable CMA allocation
performance to be measured via ftrace.

Signed-off-by: Liam Mark <lmark@codeaurora.org>
Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 include/trace/events/cma.h     | 39 +++++++++++++++++++++++++++++++++-
 include/trace/events/migrate.h | 22 +++++++++++++++++++
 mm/cma.c                       |  4 ++++
 mm/migrate.c                   |  2 ++
 4 files changed, 66 insertions(+), 1 deletion(-)

diff --git a/include/trace/events/cma.h b/include/trace/events/cma.h
index 5017a8829270..cdfd06afb39a 100644
--- a/include/trace/events/cma.h
+++ b/include/trace/events/cma.h
@@ -8,7 +8,7 @@
 #include <linux/types.h>
 #include <linux/tracepoint.h>
 
-TRACE_EVENT(cma_alloc,
+DECLARE_EVENT_CLASS(cma_alloc_class,
 
 	TP_PROTO(unsigned long pfn, const struct page *page,
 		 unsigned int count, unsigned int align),
@@ -61,6 +61,43 @@ TRACE_EVENT(cma_release,
 		  __entry->count)
 );
 
+TRACE_EVENT(cma_alloc_start,
+
+	TP_PROTO(unsigned int count, unsigned int align),
+
+	TP_ARGS(count, align),
+
+	TP_STRUCT__entry(
+		__field(unsigned int, count)
+		__field(unsigned int, align)
+	),
+
+	TP_fast_assign(
+		__entry->count = count;
+		__entry->align = align;
+	),
+
+	TP_printk("count=%u align=%u",
+		  __entry->count,
+		  __entry->align)
+);
+
+DEFINE_EVENT(cma_alloc_class, cma_alloc,
+
+	TP_PROTO(unsigned long pfn, const struct page *page,
+		 unsigned int count, unsigned int align),
+
+	TP_ARGS(pfn, page, count, align)
+);
+
+DEFINE_EVENT(cma_alloc_class, cma_alloc_busy_retry,
+
+	TP_PROTO(unsigned long pfn, const struct page *page,
+		 unsigned int count, unsigned int align),
+
+	TP_ARGS(pfn, page, count, align)
+);
+
 #endif /* _TRACE_CMA_H */
 
 /* This part must be outside protection */
diff --git a/include/trace/events/migrate.h b/include/trace/events/migrate.h
index 363b54ce104c..9fb2a3bbcdfb 100644
--- a/include/trace/events/migrate.h
+++ b/include/trace/events/migrate.h
@@ -82,6 +82,28 @@ TRACE_EVENT(mm_migrate_pages,
 		__print_symbolic(__entry->mode, MIGRATE_MODE),
 		__print_symbolic(__entry->reason, MIGRATE_REASON))
 );
+
+TRACE_EVENT(mm_migrate_pages_start,
+
+	TP_PROTO(enum migrate_mode mode, int reason),
+
+	TP_ARGS(mode, reason),
+
+	TP_STRUCT__entry(
+		__field(enum migrate_mode, mode)
+		__field(int, reason)
+	),
+
+	TP_fast_assign(
+		__entry->mode	= mode;
+		__entry->reason	= reason;
+	),
+
+	TP_printk("mode=%s reason=%s",
+		  __print_symbolic(__entry->mode, MIGRATE_MODE),
+		  __print_symbolic(__entry->reason, MIGRATE_REASON))
+);
+
 #endif /* _TRACE_MIGRATE_H */
 
 /* This part must be outside protection */
diff --git a/mm/cma.c b/mm/cma.c
index 90e27458ddb7..984c85fd16ec 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -443,6 +443,8 @@ struct page *cma_alloc(struct cma *cma, size_t count, unsigned int align,
 	if (!count)
 		goto out;
 
+	trace_cma_alloc_start(count, align);
+
 	mask = cma_bitmap_aligned_mask(cma, align);
 	offset = cma_bitmap_aligned_offset(cma, align);
 	bitmap_maxno = cma_bitmap_maxno(cma);
@@ -483,6 +485,8 @@ struct page *cma_alloc(struct cma *cma, size_t count, unsigned int align,
 
 		pr_debug("%s(): memory range at %p is busy, retrying\n",
 			 __func__, pfn_to_page(pfn));
+
+		trace_cma_alloc_busy_retry(pfn, pfn_to_page(pfn), count, align);
 		/* try again with a bit different memory target */
 		start = bitmap_no + mask + 1;
 	}
diff --git a/mm/migrate.c b/mm/migrate.c
index 47df0df8f21a..58b1b03e0c98 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1445,6 +1445,8 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 	int rc, nr_subpages;
 	LIST_HEAD(ret_pages);
 
+	trace_mm_migrate_pages_start(mode, reason);
+
 	if (!swapwrite)
 		current->flags |= PF_SWAPWRITE;
 
