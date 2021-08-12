Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC503E9BDA
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 03:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233318AbhHLBO1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 21:14:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:37926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233020AbhHLBOY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 21:14:24 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C1BEB60FE6;
        Thu, 12 Aug 2021 01:13:55 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1mDzIA-003pFG-L9; Wed, 11 Aug 2021 21:13:54 -0400
Message-ID: <20210812011354.496043454@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 11 Aug 2021 21:12:51 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Daniel Bristot de Oliveira <bristot@kernel.org>
Subject: [for-linus][PATCH 1/7] trace/osnoise: Rename main variable to tracer_main
References: <20210812011250.954353252@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Bristot de Oliveira <bristot@kernel.org>

The *main variable in start_kthread() is causing warnings in some
compilers/analyzers. Although it is not necessarily a problem, it is
not a problem changing the variable name too.

Rename the *main variable to *tracer_main.

No functional change.

Link: https://lkml.kernel.org/r/fc62f7deb2258f6068d77c3e734633e3c3511464.1627977494.git.bristot@kernel.org

Cc: Matthew Wilcox <willy@infradead.org>
Fixes: c8895e271f79 ("trace/osnoise: Support hotplug operations")
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_osnoise.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index a7e3c24dee13..912036d6a668 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -1458,20 +1458,20 @@ static void stop_per_cpu_kthreads(void)
 static int start_kthread(unsigned int cpu)
 {
 	struct task_struct *kthread;
-	void *main = osnoise_main;
+	void *tracer_main = osnoise_main;
 	char comm[24];
 
 #ifdef CONFIG_TIMERLAT_TRACER
 	if (osnoise_data.timerlat_tracer) {
 		snprintf(comm, 24, "timerlat/%d", cpu);
-		main = timerlat_main;
+		tracer_main = timerlat_main;
 	} else {
 		snprintf(comm, 24, "osnoise/%d", cpu);
 	}
 #else
 	snprintf(comm, 24, "osnoise/%d", cpu);
 #endif
-	kthread = kthread_create_on_cpu(main, NULL, cpu, comm);
+	kthread = kthread_create_on_cpu(tracer_main, NULL, cpu, comm);
 
 	if (IS_ERR(kthread)) {
 		pr_err(BANNER "could not start sampling thread\n");
-- 
2.30.2
