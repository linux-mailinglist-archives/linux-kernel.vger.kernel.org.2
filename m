Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4E053C7068
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 14:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236338AbhGMMhS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 08:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236281AbhGMMhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 08:37:16 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A41E8C0613EE;
        Tue, 13 Jul 2021 05:34:26 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id w2so7871581qvh.13;
        Tue, 13 Jul 2021 05:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=29CzU2MfFBs4HO+dO2xwX2Fgs88EDaKTdZ9XTaknGkI=;
        b=IeOWxRo4tqNrv4YId8Eu1dbiR6YhzdOXXZzZJs5iaGGoV7aTDKfkeTJmi+/OEwJggw
         /k+N7bnzmP7CERbXzTbovF8OI80AZg0al219BF/iaB1LUyjEC7ZdLski3/pBW2/pKTyH
         wE0UKqmJjW4Z4WJBCHb5bVWlPD3kHCwtzvGrPquuKUBF+ivYHXtj7ugTsJBPzOJfqUhf
         1fmTPcBEWae8TY2uidOhBJ1kapFWJOn+iTWSIhB88z5JAJznTO+SSlTbymuY5v/J+EY+
         9ijFsYGDn13TIvAoRu7pInjO3Lkiq8Lboy1bRajqAoEmwnngDdpON6pz5J49n7LN30hh
         SLuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=29CzU2MfFBs4HO+dO2xwX2Fgs88EDaKTdZ9XTaknGkI=;
        b=RJbSRvuyLGfWPFUMXfn/U55+pn1Zm4OWPELKJSFHk6TZY1Mt7SX73vHKpR6sW7s7gP
         IdV06AeJol2BLqUXPdvjyC7zEdZ+esgZIczUpOw7UwtRSFxUMtCu/3Z1tPToUOf0zvzi
         8E3embzAy6q+xbvyD3ZG6EH67xFIfw+l7EnqndKLUBnD9T1jgplIqIxuUZCzDiAcYVwB
         pgaDEFGycLuvIRQfSJrzhruDczv4Vr5hXzPkF9Ynykb4BxV7T36ISCUYdpwymIzl2+uk
         KKQTy0OVlzl2H6hTsO8UzIBVOqkueZiBOkhFAGAUGt1b6tpi1GP1FMD5wuAOahgD8Fci
         c17g==
X-Gm-Message-State: AOAM5316S92XaA5VG7rnNil0utXmHCp2XioZTqh/6eHv5Qx6VDmwAHSt
        h0oEOXMEPfmd7yE6g+I95L0=
X-Google-Smtp-Source: ABdhPJyqxX0dI0ttajKo6Fh4sb0degnyLatfj//Ins/NeU6wzqtnIVZnKYZAbOu9psWnURy/ew1UHw==
X-Received: by 2002:a0c:9ac7:: with SMTP id k7mr4504097qvf.49.1626179665872;
        Tue, 13 Jul 2021 05:34:25 -0700 (PDT)
Received: from localhost.localdomain (ec2-35-169-212-159.compute-1.amazonaws.com. [35.169.212.159])
        by smtp.gmail.com with ESMTPSA id k14sm6849327qtm.18.2021.07.13.05.34.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 05:34:25 -0700 (PDT)
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
Subject: [PATCH v33 06/13] mm/damon: Add a tracepoint
Date:   Tue, 13 Jul 2021 12:33:49 +0000
Message-Id: <20210713123356.6924-7-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210713123356.6924-1-sj38.park@gmail.com>
References: <20210713123356.6924-1-sj38.park@gmail.com>
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
Acked-by: Shakeel Butt <shakeelb@google.com>
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
index 28a2c78914fa..ee24d64e8019 100644
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
 
@@ -387,8 +390,10 @@ static void kdamond_reset_aggregated(struct damon_ctx *c)
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

