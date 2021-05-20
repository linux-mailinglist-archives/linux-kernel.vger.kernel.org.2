Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95EC6389F43
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 09:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbhETH6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 03:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231197AbhETH6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 03:58:23 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB854C06138A;
        Thu, 20 May 2021 00:56:59 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id k4so4199049qkd.0;
        Thu, 20 May 2021 00:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CvzI94r9LiC7RH+dtcaRZqda/Y720VadPnKc/47pvNM=;
        b=Bhg1YtV/hP0o+cBIzin0UJ4XNbvDPsgiPTqj6LYjtc4hWNO3pO41z1GYqyjTDFyfDy
         TXmfRhkiglA4UcyGJMBa0fBkfsEzH1vzUCNpyaigGoJcuRIMInA5ce0EXoO8P7lI2IPm
         HrZ0im4nhQW1haTmeXuBhupPsHiu2c+Tv2/DX8LmexRmKlqU8CnT7FRS8OWeyDrMPM3Z
         UnYV163cQVlAiY3H1OW5qwNcrHxuBocyuutu9beubB5bAvXycuT/QQG+UmDkPMaKJv5E
         2IB734K2gCNcTa1rpFncK8Qq2K/ZYR85FNXH2NCehY/fXLS/KdqsDp2qTfeUunU7pBM9
         u/qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CvzI94r9LiC7RH+dtcaRZqda/Y720VadPnKc/47pvNM=;
        b=llYLpMdS9dBbY5SL+eqJaw8gAmy95FCFjbL7v3kcurGl89Io2Oi7lOVCyzEG05SZfG
         kyvGvSwqowgw0itiJYCUPwsgRKKCngL5+W9ZzE1ntWcvOnQKnmyGuHpbn7NMNwVS2CRw
         Ji331YrY99g/vf1i7yO0oANqe84lDaiqP2lz0ZVBi3LmGYFVjVhdFSCd4lymO/vSPkcy
         q2WkIjk4ObxX8Rs4s4wQeJGyTbxU9oIndKzDYH8bHddP2HmNVSktT7hnq2ysjXeYDAps
         mSyMe0FoEo3bmG4PZLpMectmKbQyi9usu4fnd4OiGwIxVrMaCL2q4SEhVa1hk3q0fCuH
         /ylQ==
X-Gm-Message-State: AOAM532/RhF042rFYUGSe640dIwupour6c/WL1dWrsbNTfX9dnXRLURs
        wQA2ByW12BBwGOgZR6CVin8=
X-Google-Smtp-Source: ABdhPJxOdaEP0dtzhXEhIXz86XbsK3RVnunca+ppIbbsXU5xw9H05LVMgFm8rLaOBYFO548CQPl3CQ==
X-Received: by 2002:a05:620a:cf6:: with SMTP id c22mr3564689qkj.123.1621497419049;
        Thu, 20 May 2021 00:56:59 -0700 (PDT)
Received: from localhost.localdomain (ec2-35-169-212-159.compute-1.amazonaws.com. [35.169.212.159])
        by smtp.gmail.com with ESMTPSA id g9sm1478254qka.38.2021.05.20.00.56.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 00:56:58 -0700 (PDT)
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
Subject: [PATCH v29 06/13] mm/damon: Add a tracepoint
Date:   Thu, 20 May 2021 07:56:22 +0000
Message-Id: <20210520075629.4332-7-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210520075629.4332-1-sj38.park@gmail.com>
References: <20210520075629.4332-1-sj38.park@gmail.com>
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

