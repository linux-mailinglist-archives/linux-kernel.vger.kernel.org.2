Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48F033DE8E7
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 10:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234888AbhHCIuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 04:50:25 -0400
Received: from gateway32.websitewelcome.com ([192.185.145.187]:18890 "EHLO
        gateway32.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234902AbhHCIuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 04:50:23 -0400
X-Greylist: delayed 1323 seconds by postgrey-1.27 at vger.kernel.org; Tue, 03 Aug 2021 04:50:23 EDT
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway32.websitewelcome.com (Postfix) with ESMTP id D0AFC93F99
        for <linux-kernel@vger.kernel.org>; Tue,  3 Aug 2021 03:28:07 -0500 (CDT)
Received: from gator4132.hostgator.com ([192.185.4.144])
        by cmsmtp with SMTP
        id ApmRmM3vO7sOiApmRmyKC4; Tue, 03 Aug 2021 03:28:07 -0500
X-Authority-Reason: nr=8
Received: from host-95-239-202-226.retail.telecomitalia.it ([95.239.202.226]:59954 helo=f34.bristot.me)
        by gator4132.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <bristot@kernel.org>)
        id 1mApmQ-003t1l-Nz; Tue, 03 Aug 2021 03:28:07 -0500
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: [PATCH] trace/osnoise: Rename main variable to tracer_main
Date:   Tue,  3 Aug 2021 10:28:00 +0200
Message-Id: <fc62f7deb2258f6068d77c3e734633e3c3511464.1627977494.git.bristot@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4132.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - kernel.org
X-BWhitelist: no
X-Source-IP: 95.239.202.226
X-Source-L: No
X-Exim-ID: 1mApmQ-003t1l-Nz
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: host-95-239-202-226.retail.telecomitalia.it (f34.bristot.me) [95.239.202.226]:59954
X-Source-Auth: kernel@bristot.me
X-Email-Count: 8
X-Source-Cap: YnJpc3RvdG1lO2JyaXN0b3RtZTtnYXRvcjQxMzIuaG9zdGdhdG9yLmNvbQ==
X-Local-Domain: no
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The *main variable in start_kthread() is causing warnings in some
compilers/analyzers. Although it is not necessarily a problem, it is
not a problem changing the variable name too.

Rename the *main variable to *tracer_main.

No functional change.

Fixes: c8895e271f79 ("trace/osnoise: Support hotplug operations")
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
---
 kernel/trace/trace_osnoise.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index 0b11db9595b6..eda10d39da47 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -1576,20 +1576,20 @@ static void stop_per_cpu_kthreads(void)
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
2.31.1

