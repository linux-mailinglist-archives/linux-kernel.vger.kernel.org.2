Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47489358539
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 15:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231873AbhDHNt4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 09:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231782AbhDHNth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 09:49:37 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96423C0613D8;
        Thu,  8 Apr 2021 06:49:23 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id x14so2166855qki.10;
        Thu, 08 Apr 2021 06:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CvzI94r9LiC7RH+dtcaRZqda/Y720VadPnKc/47pvNM=;
        b=c609lG+HTEb25pe72HNvixW5DeVX+C4ibOhrZzqHuaEj2DiRt7/W+geT4Hk/o6AYdj
         F1fUXxefZ6pqAtcjiiO8wB/MpQGTaq6Onb+uFj8+GHVyC4PwkLD130w63ytopha7jrEw
         8SZEzewaY5f0Pfm+K7b9TyR8C/wOLVfKcIvaNAk/VJsJ6ewYwf+fhL5AR6YSYjKr2EtN
         K2g1h8m4GaHzqEYUahZVXCJbRYMAZy8QxulLENJedeXup2RfooJF+7GdqCCp/FZi1btz
         hqbVnZ94fdkOjqCYR51QyGq+Zp2UTbq60fS/jOkWOw59qav/1zSokLErd1bxDwB9mf47
         Z0sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CvzI94r9LiC7RH+dtcaRZqda/Y720VadPnKc/47pvNM=;
        b=CZOxTE4nocc02d4aJMZAt0qDuu0gt3LyK8xpDzxUXx27XoIsiPzimODA+tFz1yhMiA
         dq9ipF7nl+ZsknDokJ5F6e3ChIZNb5Yys19EImBI3SL27DSuRVmtVudYSlTe/fJxPUNU
         MW6ljuAHy0fGGaWoJizLWDJaNSZrFSPaW07+qocULn4MPIdKQKXbuxwb6xpUH2a9q+Jp
         7AdDDYZan2rRW7YESHi1bqE1OC4sVn2MiYIf9S0HSh0tufQcLFZYQVlu0V5xKP27uM51
         dRUajRUYy/++rV85+09jcoIrGcC54UYaRHIQSyEbbZGibq0kE5RHbqlIbNdAJ1k9VmeR
         4U8A==
X-Gm-Message-State: AOAM533EdAwVWUFHMn5B2FB6Khwr/vmjTCl2EWmADifF7yImodlYcT8+
        pxGTSJ8p5i5v+PCAZ/8msaM=
X-Google-Smtp-Source: ABdhPJw0X+prD7R85i3w0WLX8/YqfSkjIbHJ3zaZMsC+CY22wbUSFkb1EVgp61S9CHC0bIJbfgjTcw==
X-Received: by 2002:a05:620a:1133:: with SMTP id p19mr8768886qkk.340.1617889762521;
        Thu, 08 Apr 2021 06:49:22 -0700 (PDT)
Received: from localhost.localdomain (ec2-35-169-212-159.compute-1.amazonaws.com. [35.169.212.159])
        by smtp.gmail.com with ESMTPSA id h16sm506094qkh.18.2021.04.08.06.49.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 06:49:22 -0700 (PDT)
From:   SeongJae Park <sj38.park@gmail.com>
To:     akpm@linux-foundation.org
Cc:     SeongJae Park <sjpark@amazon.de>, Jonathan.Cameron@Huawei.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        amit@kernel.org, benh@kernel.crashing.org,
        brendanhiggins@google.com, corbet@lwn.net, david@redhat.com,
        dwmw@amazon.com, elver@google.com, fan.du@intel.com,
        foersleo@amazon.de, greg@kroah.com, gthelen@google.com,
        guoju.fgj@alibaba-inc.com, mgorman@suse.de, minchan@kernel.org,
        mingo@redhat.com, namhyung@kernel.org, peterz@infradead.org,
        riel@surriel.com, rientjes@google.com, rostedt@goodmis.org,
        rppt@kernel.org, shakeelb@google.com, shuah@kernel.org,
        sj38.park@gmail.com, snu@amazon.de, vbabka@suse.cz,
        vdavydov.dev@gmail.com, zgf574564920@gmail.com,
        linux-damon@amazon.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v27 06/13] mm/damon: Add a tracepoint
Date:   Thu,  8 Apr 2021 13:48:47 +0000
Message-Id: <20210408134854.31625-7-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210408134854.31625-1-sj38.park@gmail.com>
References: <20210408134854.31625-1-sj38.park@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

This commit adds a tracepoint for DAMON.  It traces the monitoring
results of each region for each aggregation interval.  Using this, DAMON
can easily integrated with tracepoints supporting tools such as perf.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
Reviewed-by: Leonard Foerster <foersleo@amazon.de>
Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/trace/events/damon.h | 43 ++++++++++++++++++++++++++++++++++++
 mm/damon/core.c              |  7 +++++-
 2 files changed, 49 insertions(+), 1 deletion(-)
 create mode 100644 include/trace/events/damon.h

diff --git a/include/trace/events/damon.h b/include/trace/events/damon.h
new file mode 100644
index 000000000000..2f422f4f1fb9
--- /dev/null
+++ b/include/trace/events/damon.h
@@ -0,0 +1,43 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM damon
+
+#if !defined(_TRACE_DAMON_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_DAMON_H
+
+#include <linux/damon.h>
+#include <linux/types.h>
+#include <linux/tracepoint.h>
+
+TRACE_EVENT(damon_aggregated,
+
+	TP_PROTO(struct damon_target *t, struct damon_region *r,
+		unsigned int nr_regions),
+
+	TP_ARGS(t, r, nr_regions),
+
+	TP_STRUCT__entry(
+		__field(unsigned long, target_id)
+		__field(unsigned int, nr_regions)
+		__field(unsigned long, start)
+		__field(unsigned long, end)
+		__field(unsigned int, nr_accesses)
+	),
+
+	TP_fast_assign(
+		__entry->target_id = t->id;
+		__entry->nr_regions = nr_regions;
+		__entry->start = r->ar.start;
+		__entry->end = r->ar.end;
+		__entry->nr_accesses = r->nr_accesses;
+	),
+
+	TP_printk("target_id=%lu nr_regions=%u %lu-%lu: %u",
+			__entry->target_id, __entry->nr_regions,
+			__entry->start, __entry->end, __entry->nr_accesses)
+);
+
+#endif /* _TRACE_DAMON_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
diff --git a/mm/damon/core.c b/mm/damon/core.c
index b36b6bdd94e2..912112662d0c 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -13,6 +13,9 @@
 #include <linux/random.h>
 #include <linux/slab.h>
 
+#define CREATE_TRACE_POINTS
+#include <trace/events/damon.h>
+
 /* Get a random number in [l, r) */
 #define damon_rand(l, r) (l + prandom_u32_max(r - l))
 
@@ -388,8 +391,10 @@ static void kdamond_reset_aggregated(struct damon_ctx *c)
 	damon_for_each_target(t, c) {
 		struct damon_region *r;
 
-		damon_for_each_region(r, t)
+		damon_for_each_region(r, t) {
+			trace_damon_aggregated(t, r, damon_nr_regions(t));
 			r->nr_accesses = 0;
+		}
 	}
 }
 
-- 
2.17.1

