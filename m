Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED4C9401901
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 11:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241363AbhIFJlo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 05:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237787AbhIFJlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 05:41:39 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E569EC061575
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 02:40:34 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1630921232;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=B35/74/vPVvxqBdea39TqMoDWR268nsogO/a8Xnp5sU=;
        b=Dawfia27WzISBBhrGTYaf1oPF1mCUnva3fPNXoA9ZnPFTJzx4VTzvl0w9qxC28CRcXHCkt
        GhKMplLI30c9BPcclazxrawHSoz65G4JT1ClzeJELf6PtZ/AnBXRI8Jf5TvUgMB903DH72
        bB51tOtFRuJtNRIWpDn0bgJDIANgmgo=
From:   Jackie Liu <liu.yun@linux.dev>
To:     rostedt@goodmis.org, mingo@redhat.com
Cc:     linux-kernel@vger.kernel.org, liu.yun@linux.dev
Subject: [PATCH] trace_osnoise: rename main to trace_main to avoid Werror=main
Date:   Mon,  6 Sep 2021 17:40:03 +0800
Message-Id: <20210906094003.948975-1-liu.yun@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: liu.yun@linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jackie Liu <liuyun01@kylinos.cn>

kernel builds with -Werror=main, gcc report failed.

Avoids warnings like:
kernel/trace/trace_osnoise.c:1515:8: error: ‘main’ is usually a function [-Werror=main]

Fixes: a955d7eac177 ("trace: Add timerlat tracer")
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@redhat.com>
Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
---
 kernel/trace/trace_osnoise.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index b61eefe5ccf5..938e2791010a 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -1512,20 +1512,20 @@ static void stop_per_cpu_kthreads(void)
 static int start_kthread(unsigned int cpu)
 {
 	struct task_struct *kthread;
-	void *main = osnoise_main;
+	void *trace_main = osnoise_main;
 	char comm[24];
 
 #ifdef CONFIG_TIMERLAT_TRACER
 	if (osnoise_data.timerlat_tracer) {
 		snprintf(comm, 24, "timerlat/%d", cpu);
-		main = timerlat_main;
+		trace_main = timerlat_main;
 	} else {
 		snprintf(comm, 24, "osnoise/%d", cpu);
 	}
 #else
 	snprintf(comm, 24, "osnoise/%d", cpu);
 #endif
-	kthread = kthread_create_on_cpu(main, NULL, cpu, comm);
+	kthread = kthread_create_on_cpu(trace_main, NULL, cpu, comm);
 
 	if (IS_ERR(kthread)) {
 		pr_err(BANNER "could not start sampling thread\n");
-- 
2.25.1

