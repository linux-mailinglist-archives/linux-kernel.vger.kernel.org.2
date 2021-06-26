Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C4E93B4EAA
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jun 2021 15:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbhFZNIf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Jun 2021 09:08:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:33894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230099AbhFZNIB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jun 2021 09:08:01 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1600861C4D;
        Sat, 26 Jun 2021 13:05:39 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1lx80A-000EoO-57; Sat, 26 Jun 2021 09:05:38 -0400
Message-ID: <20210626130538.003082428@goodmis.org>
User-Agent: quilt/0.66
Date:   Sat, 26 Jun 2021 09:04:23 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel test robot <lkp@intel.com>
Subject: [for-next][PATCH 19/24] tracing: Add LATENCY_FS_NOTIFY to define if latency_fsnotify() is
 defined
References: <20210626130404.033700863@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

With the coming addition of the osnoise tracer, the configs needed to
include the latency_fsnotify() has become more complex, and to keep the
declaration in the header file the same as in the C file, just have the
logic needed to define it in one place, and that defines LATENCY_FS_NOTIFY
which will be used in the C code.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 3 +--
 kernel/trace/trace.h | 6 +++---
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 27bf203ef05a..60492464281e 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -1690,8 +1690,7 @@ static ssize_t trace_seq_to_buffer(struct trace_seq *s, void *buf, size_t cnt)
 unsigned long __read_mostly	tracing_thresh;
 static const struct file_operations tracing_max_lat_fops;
 
-#if (defined(CONFIG_TRACER_MAX_TRACE) || defined(CONFIG_HWLAT_TRACER)) && \
-	defined(CONFIG_FSNOTIFY)
+#ifdef LATENCY_FS_NOTIFY
 
 static struct workqueue_struct *fsnotify_wq;
 
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 22f8c652ef8b..87588d1e24ca 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -677,13 +677,13 @@ void update_max_tr_single(struct trace_array *tr,
 
 #if (defined(CONFIG_TRACER_MAX_TRACE) || defined(CONFIG_HWLAT_TRACER)) && \
 	defined(CONFIG_FSNOTIFY)
+#define LATENCY_FS_NOTIFY
+#endif
 
+#ifdef LATENCY_FS_NOTIFY
 void latency_fsnotify(struct trace_array *tr);
-
 #else
-
 static inline void latency_fsnotify(struct trace_array *tr) { }
-
 #endif
 
 #ifdef CONFIG_STACKTRACE
-- 
2.30.2
