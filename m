Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CACD034E3F2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 11:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231645AbhC3JGl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 05:06:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231622AbhC3JGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 05:06:09 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66E0BC061762;
        Tue, 30 Mar 2021 02:06:09 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id g24so11379564qts.6;
        Tue, 30 Mar 2021 02:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CvzI94r9LiC7RH+dtcaRZqda/Y720VadPnKc/47pvNM=;
        b=R5PUWdERG+RkIKWxog/OwoHO5kXT1/1TlXkHhb3aLxDwHrGIsXYqKYLOS4HpzvjMeI
         SLJJ06ttW25PdsqtX+CXByEAMhTtGk7tgvyocRjXEJnCcTD12ijROBeYC4FucKjuHB/E
         IgpJOFD+hLyRkuv0Ey5DurWKSokHx4RcljxJrCRHPSXYbNWgDyvIhXGwOTl0IugQNdem
         lS5G86JTzLvcePdylQe3NG+ZOdem5sY791uiYtTBzg/8v6wqXcXUuOFj+JWxRbduO2B/
         vJbW4yUno7gduLt2Fw4CU6FQrjZylzprzcLrWi4t3TMGIyxvIb8uroenBzxK2uDwSHqQ
         ZsTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CvzI94r9LiC7RH+dtcaRZqda/Y720VadPnKc/47pvNM=;
        b=ihOhrqTh017IRihblTmOkhJ/8Zk4o+uG56StqF/v6yzUuv0Bu/kr72BtvEwckokj3K
         dtHFdf8b/O5rIjP133nRFu/VGvbOnoLgZsX5Ms+B1CIYzLwHT8X5QoJL5+1pIA+G9oNo
         ZMozE3UnkrP96mE4Xzl6EwdC2kOrcrOCoAhaCVSK71saF/IzgICgPw8TcfzGQTDxr9wu
         S2Ei2VgN3UZXW5kefgq0QSAvuPvEDV+/42AhChb0foGsJJBX4nW/bD3ubQjC9Bx1wCjh
         64Okl2OWbvuvUBXMIfvjBTWMR/xmkUr+QFeU8fI9pTrmvHhF2SXNUZ0PVsGh8gVyGRtw
         dAQA==
X-Gm-Message-State: AOAM533p6BWNNkd5GarN+f5lTAZfYNTFjRRTKkatHbaHEQvnosN+1/Gv
        c5i5n93mT0p5pQl8lOphvco=
X-Google-Smtp-Source: ABdhPJw/fcEzbKkgvJDaEm+Jful1mHeW1N2jv4YLlOgs/xUbbkQnP+Cj1nNonnxoZvS68qpQvVPZlQ==
X-Received: by 2002:ac8:431e:: with SMTP id z30mr26040963qtm.216.1617095168611;
        Tue, 30 Mar 2021 02:06:08 -0700 (PDT)
Received: from localhost.localdomain (ec2-35-169-212-159.compute-1.amazonaws.com. [35.169.212.159])
        by smtp.gmail.com with ESMTPSA id 8sm14630011qkc.32.2021.03.30.02.06.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 02:06:08 -0700 (PDT)
From:   sj38.park@gmail.com
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
Subject: [PATCH v26 06/13] mm/damon: Add a tracepoint
Date:   Tue, 30 Mar 2021 09:05:30 +0000
Message-Id: <20210330090537.12143-7-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210330090537.12143-1-sj38.park@gmail.com>
References: <20210330090537.12143-1-sj38.park@gmail.com>
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

