Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92A853A9402
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 09:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232115AbhFPHeB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 03:34:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231922AbhFPHdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 03:33:50 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E795C061767;
        Wed, 16 Jun 2021 00:31:45 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id c9so1713451qkm.0;
        Wed, 16 Jun 2021 00:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1zu0WYClyfacDsFFRCEQTOIcpTHcWHl9R8Gyi1zT/pM=;
        b=mHmmMaaQvVbhpBuxnNP1A7Kr7U+m/yXQ1UseAiyX0iAcki43VhRnJCZL/7cluUO0cV
         +EaisFnEBxomYtmHs/IhAbvZeFzgEjwFIdxqoRYN+Y8f1MN3Gx5AR4fO1YaTg7VFnJDD
         tB1WiXljUktfouPUeRqh6ZqfdYI2J+34VBHD5Xhfdqgac3lOM79d3sfD3jDqsMLX5QIy
         6efwDvZOn/NKjhxSBvkMJNJPsVTspbrZox52iKRcNV4WKwIdqECIpuKHcGLlorycyGey
         w2i/9Ghn2rqwCcVju6jIDVykVcyR/T+k4vlJC7pQdVzxvnO2RWlaB6UPAt1Vb33YuMEF
         JbBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1zu0WYClyfacDsFFRCEQTOIcpTHcWHl9R8Gyi1zT/pM=;
        b=krZ7aC40WtK+tzVdD1uNnjyxz11U7ReE77lxEDO040EnGHLv8BlWdG07FakkLEOMnw
         Roo5QQ4M51fmS0WDWWdm2T0/d/Sc+v5w3kVFga0+SL5cYqZPzFUhePRpok55PvjdEqGm
         W89AAy5YbmRFu/ijbzRTCmEUjeteFUzTu1AS5Y0Fr8qsRmLLHjQQYf9RgQWv0gg8vd2l
         SN2UILhWWVda8eX8ChKdOR2qrvr55gI+K06VjXHDXFnBTbRn7KcASSmlvq7/QBHxq65Y
         ksLgQK+Qh9vOe3gmu/LqbBH9ntje4QXR7gbh7h+R0MudedMsLu+dbTkq37ntE9ia+cl3
         XDRA==
X-Gm-Message-State: AOAM531xhfQYdRQoZVtQqbdGC2GS+yUTD5YgPAxoH5lrGkv7CVEC9EhP
        2+f636xhA5zCne9asA01lzE=
X-Google-Smtp-Source: ABdhPJzW4yZt+8bnHjIp1dYpccpo7B/EUy7Bsoq+GcynkMpTpQGrgHlMxGUKAVr83ns4060elU7MhA==
X-Received: by 2002:a05:620a:2221:: with SMTP id n1mr3669595qkh.317.1623828704369;
        Wed, 16 Jun 2021 00:31:44 -0700 (PDT)
Received: from localhost.localdomain (ec2-35-169-212-159.compute-1.amazonaws.com. [35.169.212.159])
        by smtp.gmail.com with ESMTPSA id h5sm1080697qkg.122.2021.06.16.00.31.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 00:31:43 -0700 (PDT)
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
Subject: [PATCH v30 06/13] mm/damon: Add a tracepoint
Date:   Wed, 16 Jun 2021 07:31:12 +0000
Message-Id: <20210616073119.16758-7-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210616073119.16758-1-sj38.park@gmail.com>
References: <20210616073119.16758-1-sj38.park@gmail.com>
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

