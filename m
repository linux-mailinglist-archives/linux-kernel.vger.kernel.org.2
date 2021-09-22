Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC6BE413FC6
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 04:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbhIVCxT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 22:53:19 -0400
Received: from out0.migadu.com ([94.23.1.103]:27659 "EHLO out0.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229909AbhIVCxR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 22:53:17 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1632279107;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=QFo1JYYJw2ONRAZwKeFn7U/3j7Fl6ZYTm3LRZ0wPvF4=;
        b=QB3FUXdG41HgT+WTz7+YSxpv1AoIwFa3PD4M/snAdvgtChNuWJlcoQxN2bfBjA5NEAtf45
        whi3H0qaM4FPP7nWyWHpFc6SbDiyPX/sKL2ocLNJoTkqeVl6biPCmnSfLXRC+Y2l/de2eM
        UNv9aEpA9sEkuPV865mgDe/jWuF3UR8=
From:   Jackie Liu <liu.yun@linux.dev>
To:     rostedt@goodmis.org, mingo@redhat.com
Cc:     bristot@redhat.com, linux-kernel@vger.kernel.org, liu.yun@linux.dev
Subject: [PATCH v2] tracing: fix missing osnoise tracer on max_latency
Date:   Wed, 22 Sep 2021 10:51:22 +0800
Message-Id: <20210922025122.3268022-1-liu.yun@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: liu.yun@linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jackie Liu <liuyun01@kylinos.cn>

The compiler warns when the data are actually unused:

  kernel/trace/trace.c:1712:13: error: ‘trace_create_maxlat_file’ defined but not used [-Werror=unused-function]
   1712 | static void trace_create_maxlat_file(struct trace_array *tr,
        |             ^~~~~~~~~~~~~~~~~~~~~~~~

[Why]
CONFIG_HWLAT_TRACER=n, CONFIG_TRACER_MAX_TRACE=n, CONFIG_OSNOISE_TRACER=y
gcc report warns.

[How]
Now trace_create_maxlat_file will only take effect when
CONFIG_HWLAT_TRACER=y or CONFIG_TRACER_MAX_TRACE=y. In fact, after
adding osnoise trace, it also needs to take effect.

Fixes: bce29ac9ce0b ("trace: Add osnoise tracer")
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
---
 kernel/trace/trace.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 7896d30d90f7..bc677cd64224 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -1744,16 +1744,15 @@ void latency_fsnotify(struct trace_array *tr)
 	irq_work_queue(&tr->fsnotify_irqwork);
 }
 
-/*
- * (defined(CONFIG_TRACER_MAX_TRACE) || defined(CONFIG_HWLAT_TRACER)) && \
- *  defined(CONFIG_FSNOTIFY)
- */
-#else
+#elif defined(CONFIG_TRACER_MAX_TRACE) || defined(CONFIG_HWLAT_TRACER)	\
+	|| defined(CONFIG_OSNOISE_TRACER)
 
 #define trace_create_maxlat_file(tr, d_tracer)				\
 	trace_create_file("tracing_max_latency", 0644, d_tracer,	\
 			  &tr->max_latency, &tracing_max_lat_fops)
 
+#else
+#define trace_create_maxlat_file(tr, d_tracer)	 do { } while (0)
 #endif
 
 #ifdef CONFIG_TRACER_MAX_TRACE
@@ -9473,9 +9472,7 @@ init_tracer_tracefs(struct trace_array *tr, struct dentry *d_tracer)
 
 	create_trace_options_dir(tr);
 
-#if defined(CONFIG_TRACER_MAX_TRACE) || defined(CONFIG_HWLAT_TRACER)
 	trace_create_maxlat_file(tr, d_tracer);
-#endif
 
 	if (ftrace_create_function_files(tr, d_tracer))
 		MEM_FAIL(1, "Could not allocate function filter files");
-- 
2.25.1

