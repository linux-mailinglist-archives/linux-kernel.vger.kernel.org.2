Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 158833AE4E8
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 10:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbhFUIeK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 04:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbhFUIdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 04:33:55 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5763DC0617AD;
        Mon, 21 Jun 2021 01:31:38 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id bm25so13451313qkb.0;
        Mon, 21 Jun 2021 01:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1zu0WYClyfacDsFFRCEQTOIcpTHcWHl9R8Gyi1zT/pM=;
        b=AhJmMsHuvux473ssX67iSLtzoDbC5F/2Is2iRw0EAHb0zvIbaTjlQqbNyodiUIvHHn
         mrboWHkzXpsrHJAHOmuOUytqYqiupTI2aoWLGtnGpEcf2NsdksJ/VD+A4YIR3IgmgR7e
         ha/VI+olVxH4bZ5WOMBDtF1RY+I7u/UjeYOnbAH4Hxp0XwuMebIHh+i5oEwDzLcCfh7X
         dR45RpyVN4N8VJ9PbWALJGlOEZg2/jSLUzikxVqYAE6vI+tCsEDAAelLpNhkO9T6AdDG
         oi7dP2JXV6fSUGgJpzVj+MWFs62v9+KV5QyRhVJBICgo4ZqiBPB25WlagtwU6zSAk1RS
         KOcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1zu0WYClyfacDsFFRCEQTOIcpTHcWHl9R8Gyi1zT/pM=;
        b=SEtfHzHsXAwSsMU3Jxl6pHyE6UKg0N6hhdQqdcRgUMO1SqYjRrMsHp4y0BKQUII+Vg
         IbYJKEyr7RsIVWqVQ9mgCdxneR30ZnkxYqBqDXIe9DTjZOi8+6E86lFS5foVjx6hig8y
         0Mi/7h763VROL3kQ3pkjFDQ+Q1NvpDhspilioCKC5MEcuAx1yADeYnKRhh5RoRoRa6A8
         67LwQVL1h9OtyFHSMpfILuaciIB2QvZm4mEC6xJnKq3hbCPjjITMWAEzFxS2RlB4cA3e
         2Ye6mht8YMcLQCNjszipAf2U7MsTRnJ19M9A0Xq73yQ+lautqQ8UU4wrt/YbbtaRF1IU
         v90w==
X-Gm-Message-State: AOAM531zysY/9ztb97YizGfdOIAVm7zS6iPVVOjUT/b71qV3n/5gZRx2
        zGOcvwn6lGauPCn2WGaAhxo=
X-Google-Smtp-Source: ABdhPJzgb3yHEuStbFfGe7oGAUFwXd+vYlodWPGKyDVBOsCxe+bbUZS537cTSPoTRtBxQ5y5Tn23iA==
X-Received: by 2002:a37:43c3:: with SMTP id q186mr21470562qka.419.1624264297564;
        Mon, 21 Jun 2021 01:31:37 -0700 (PDT)
Received: from localhost.localdomain (ec2-35-169-212-159.compute-1.amazonaws.com. [35.169.212.159])
        by smtp.gmail.com with ESMTPSA id l23sm9852581qtp.28.2021.06.21.01.31.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 01:31:37 -0700 (PDT)
From:   SeongJae Park <sj38.park@gmail.com>
To:     akpm@linux-foundation.org
Cc:     SeongJae Park <sjpark@amazon.de>, Jonathan.Cameron@Huawei.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        amit@kernel.org, benh@kernel.crashing.org,
        brendanhiggins@google.com, corbet@lwn.net, david@redhat.com,
        dwmw@amazon.com, elver@google.com, fan.du@intel.com,
        foersleo@amazon.de, greg@kroah.com, gthelen@google.com,
        guoju.fgj@alibaba-inc.com, jgowans@amazon.com, mgorman@suse.de,
        mheyne@amazon.de, minchan@kernel.org, mingo@redhat.com,
        namhyung@kernel.org, peterz@infradead.org, riel@surriel.com,
        rientjes@google.com, rostedt@goodmis.org, rppt@kernel.org,
        shakeelb@google.com, shuah@kernel.org, sieberf@amazon.com,
        sj38.park@gmail.com, snu@zelle79.org, vbabka@suse.cz,
        vdavydov.dev@gmail.com, zgf574564920@gmail.com,
        linux-damon@amazon.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v31 06/13] mm/damon: Add a tracepoint
Date:   Mon, 21 Jun 2021 08:31:01 +0000
Message-Id: <20210621083108.17589-7-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210621083108.17589-1-sj38.park@gmail.com>
References: <20210621083108.17589-1-sj38.park@gmail.com>
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
Reviewed-by: Fernand Sieber <sieberf@amazon.com>
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

