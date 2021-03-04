Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA62232D52E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 15:22:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241792AbhCDOVk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 09:21:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:44844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240323AbhCDOVM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 09:21:12 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D19E64F42;
        Thu,  4 Mar 2021 14:20:32 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1lHoq7-001nwC-7M; Thu, 04 Mar 2021 09:20:31 -0500
Message-ID: <20210304142031.106033386@goodmis.org>
User-Agent: quilt/0.66
Date:   Thu, 04 Mar 2021 09:19:55 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Rolf Eike Beer <eb@emlix.com>
Subject: [for-linus][PATCH 3/5] tracing: Fix help text of TRACEPOINT_BENCHMARK in Kconfig
References: <20210304141952.446924335@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rolf Eike Beer <eb@emlix.com>

It's "cond_resched()" not "cond_sched()".

Link: https://lkml.kernel.org/r/1863065.aFVDpXsuPd@devpool47

Signed-off-by: Rolf Eike Beer <eb@emlix.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index 9c266b93cbc0..7fa82778c3e6 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -694,7 +694,7 @@ config TRACEPOINT_BENCHMARK
 	help
 	 This option creates the tracepoint "benchmark:benchmark_event".
 	 When the tracepoint is enabled, it kicks off a kernel thread that
-	 goes into an infinite loop (calling cond_sched() to let other tasks
+	 goes into an infinite loop (calling cond_resched() to let other tasks
 	 run), and calls the tracepoint. Each iteration will record the time
 	 it took to write to the tracepoint and the next iteration that
 	 data will be passed to the tracepoint itself. That is, the tracepoint
-- 
2.30.0


