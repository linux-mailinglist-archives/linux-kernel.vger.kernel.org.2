Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABE4D410424
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 07:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232514AbhIRFNC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Sep 2021 01:13:02 -0400
Received: from out0.migadu.com ([94.23.1.103]:48041 "EHLO out0.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229956AbhIRFNB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 01:13:01 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1631941896;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=tIpz/vQt5m//qlOJB1Vj/w3Nj+YVa8d0qtyjrn/UxR0=;
        b=BTDgERYztcKOq3bzFmCITxI9zZtOajzzJoMmSLz83iIJS2QpG9AXp3MVq1LHghgSrTLrVx
        pq07bF+u1P7/V1jk3akyTQ73DK+mGjxVVFk3rzYgPI+IXDXxbiK8sWoxSX2kteKJySOvgH
        vhrji7rxlyBSkQd0U8DkdyZxGXC4ZKY=
From:   Jackie Liu <liu.yun@linux.dev>
To:     rostedt@goodmis.org, mingo@redhat.com
Cc:     linux-kernel@vger.kernel.org, bristot@redhat.com, liu.yun@linux.dev
Subject: [PATCH] tracing: fix missing osnoise tracer on max_latency
Date:   Sat, 18 Sep 2021 13:11:18 +0800
Message-Id: <20210918051118.1096575-1-liu.yun@linux.dev>
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

BTW, Fixed the conflicting defined comment information.

Fixes: bce29ac9ce0b ("trace: Add osnoise tracer")
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
---
 kernel/trace/trace.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 7896d30d90f7..d7e3ed82fafd 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -1744,11 +1744,7 @@ void latency_fsnotify(struct trace_array *tr)
 	irq_work_queue(&tr->fsnotify_irqwork);
 }
 
-/*
- * (defined(CONFIG_TRACER_MAX_TRACE) || defined(CONFIG_HWLAT_TRACER)) && \
- *  defined(CONFIG_FSNOTIFY)
- */
-#else
+#else /* LATENCY_FS_NOTIFY */
 
 #define trace_create_maxlat_file(tr, d_tracer)				\
 	trace_create_file("tracing_max_latency", 0644, d_tracer,	\
@@ -9473,7 +9469,8 @@ init_tracer_tracefs(struct trace_array *tr, struct dentry *d_tracer)
 
 	create_trace_options_dir(tr);
 
-#if defined(CONFIG_TRACER_MAX_TRACE) || defined(CONFIG_HWLAT_TRACER)
+#if defined(CONFIG_TRACER_MAX_TRACE) || defined(CONFIG_HWLAT_TRACER) \
+	|| defined(CONFIG_OSNOISE_TRACER)
 	trace_create_maxlat_file(tr, d_tracer);
 #endif
 
-- 
2.25.1

