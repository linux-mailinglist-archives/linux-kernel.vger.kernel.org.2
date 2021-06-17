Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFD923AB2D9
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 13:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232305AbhFQLoq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 07:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231386AbhFQLoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 07:44:44 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 491DAC061574
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 04:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8BIxhj5QKfYLR1liX8JDscZ6nru/56SmCyiireWTWeU=; b=ZTTmRqssGyBkiMDTa9Nrj0Mjfv
        xAb6y3d5LmThOEPRKDTdkmDpGBH9QP1JyQyHfjUYxwYCSi5gk40pFZeFvB0Z5Ltgv6qfGSuzFRAXn
        EN/YYMuGok4nAhlQSiqor7G7lUEkYGNosDqbRmGphMdcLkzEBqb3tKMIOQhdG/9yzwF22J58Y8TDJ
        o05Ldqo/QRA6FQ2s030PsuHvgbWLjUwSn2EoL1DVsc/x6Ed/zDTdKW67mD/YzWJJtA9HPUUDZ/8ac
        nH6Ad3KElBpqo8AVbrkQ/XEpc008nizQKHCzGVyBi7ir2atYFZo3AhrSgkYb+Orf1FbK5BYSCkgJ3
        gfekIqcA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ltqPE-0094ub-EW; Thu, 17 Jun 2021 11:42:03 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3372E300204;
        Thu, 17 Jun 2021 13:33:00 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 26F832BE7F448; Thu, 17 Jun 2021 13:33:00 +0200 (CEST)
Date:   Thu, 17 Jun 2021 13:33:00 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org, acme@kernel.org,
        mark.rutland@arm.com, ak@linux.intel.com,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        jolsa@redhat.com
Subject: Re: [PATCH 0/4] perf: Fix the ctx->pmu for a hybrid system
Message-ID: <YMsy7BuGT8nBTspT@hirez.programming.kicks-ass.net>
References: <1623869734-133974-1-git-send-email-kan.liang@linux.intel.com>
 <YMsiiuUsjsrh8ZAC@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YMsiiuUsjsrh8ZAC@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 17, 2021 at 12:23:06PM +0200, Peter Zijlstra wrote:
> On Wed, Jun 16, 2021 at 11:55:30AM -0700, kan.liang@linux.intel.com wrote:
> 
> > To fix the issue, the generic perf codes have to understand the
> > supported CPU mask of a specific hybrid PMU. So it can update the
> > ctx->pmu accordingly, when a task is scheduled on a CPU which has
> > a different type of PMU from the previous CPU. The supported_cpus
> > has to be moved to the struct pmu.
> 
> Urghh.. I so hate this :-/
> 
> I *did* point you to:
> 
>   https://lore.kernel.org/lkml/20181010104559.GO5728@hirez.programming.kicks-ass.net/
> 
> when you started this whole hybrid crud, and I think that's still the
> correct thing to do.
> 
> Still, let me consider if there's a workable short-term cludge I hate
> less.

How's this? We already have x86_pmu_update_cpu_context() setting the
'correct' pmu in the cpuctx, so we can simply fold that back into the
task context.

For normal use this is a no-op.

Now I need to go audit all ctx->pmu usage :-(

---
diff --git a/kernel/events/core.c b/kernel/events/core.c
index db4604c4c502..6a496c29ef00 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -3822,9 +3822,16 @@ static void perf_event_context_sched_in(struct perf_event_context *ctx,
 					struct task_struct *task)
 {
 	struct perf_cpu_context *cpuctx;
-	struct pmu *pmu = ctx->pmu;
+	struct pmu *pmu;
 
 	cpuctx = __get_cpu_context(ctx);
+
+	/*
+	 * HACK; for HETEROGENOUS the task context might have switched to a
+	 * different PMU, don't bother gating this.
+	 */
+	pmu = ctx->pmu = cpuctx->ctx.pmu;
+
 	if (cpuctx->task_ctx == ctx) {
 		if (cpuctx->sched_cb_usage)
 			__perf_pmu_sched_task(cpuctx, true);
