Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B886325BC6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 03:55:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbhBZCzE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 21:55:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:46724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229885AbhBZCzC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 21:55:02 -0500
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A6F564EE1;
        Fri, 26 Feb 2021 02:54:19 +0000 (UTC)
Date:   Thu, 25 Feb 2021 21:54:17 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Colin Ian King <colin.king@canonical.com>,
        Jacob Wen <jian.w.wen@oracle.com>
Subject: [GIT PULL] Tracing: Fixes for 5.12
Message-ID: <20210225215417.1e19b408@oasis.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Tracing: Fixes for 5.12

Two fixes:

 - Fix an unsafe printf string usage in a kmem trace event
 - Fix spelling in output from the latency-collector tool

Note, since the broken commit was not in my tree, nor was it in any of
your tags, I just based this on top of the broken commit.

I also included a spelling fix patch to the latency-collector tool as
it doesn't affect any other part of the kernel.

Please pull the latest trace-v5.12-2 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
trace-v5.12-2

Tag SHA1: c07e93a2a5d138b7efadb97045f77d736d5079b8
Head SHA1: c1d96fa61eb74b1e211f1653acc5b68ac62c8ef4


Colin Ian King (1):
      tracing/tools: fix a couple of spelling mistakes

Steven Rostedt (VMware) (1):
      mm, tracing: Fix kmem_cache_free trace event to not print stale pointers

----
 include/trace/events/kmem.h               | 6 +++---
 tools/tracing/latency/latency-collector.c | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)
---------------------------
diff --git a/include/trace/events/kmem.h b/include/trace/events/kmem.h
index 40845b0d5dad..3a60b6b6db32 100644
--- a/include/trace/events/kmem.h
+++ b/include/trace/events/kmem.h
@@ -144,17 +144,17 @@ TRACE_EVENT(kmem_cache_free,
 	TP_STRUCT__entry(
 		__field(	unsigned long,	call_site	)
 		__field(	const void *,	ptr		)
-		__field(	const char *,	name		)
+		__string(	name,	name	)
 	),
 
 	TP_fast_assign(
 		__entry->call_site	= call_site;
 		__entry->ptr		= ptr;
-		__entry->name		= name;
+		__assign_str(name, name);
 	),
 
 	TP_printk("call_site=%pS ptr=%p name=%s",
-		  (void *)__entry->call_site, __entry->ptr, __entry->name)
+		  (void *)__entry->call_site, __entry->ptr, __get_str(name))
 );
 
 TRACE_EVENT(mm_page_free,
diff --git a/tools/tracing/latency/latency-collector.c b/tools/tracing/latency/latency-collector.c
index 57b20802e71b..b69de9263ee6 100644
--- a/tools/tracing/latency/latency-collector.c
+++ b/tools/tracing/latency/latency-collector.c
@@ -1650,7 +1650,7 @@ static void start_printthread(void)
 		if (ufd <  0 ||
 		    read(ufd, seed, sizeof(*seed)) != sizeof(*seed)) {
 			printf(
-"Warning! Using trivial random nummer seed, since %s not available\n",
+"Warning! Using trivial random number seed, since %s not available\n",
 			DEV_URANDOM);
 			fflush(stdout);
 			*seed = i;
@@ -1711,8 +1711,8 @@ static void show_usage(void)
 "\t\t\tbeginning, end, and backtrace.\n\n"
 
 "-g, --graph\t\tEnable the display-graph option in trace_option. This\n"
-"\t\t\toption causes ftrace to show the functionph of how\n"
-"\t\t\tfunctions are calling other functions.\n\n"
+"\t\t\toption causes ftrace to show the graph of how functions\n"
+"\t\t\tare calling other functions.\n\n"
 
 "-c, --policy POL\tRun the program with scheduling policy POL. POL can be\n"
 "\t\t\tother, batch, idle, rr or fifo. The default is rr. When\n"
