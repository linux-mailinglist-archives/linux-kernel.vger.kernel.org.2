Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D053137FA2D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 17:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234701AbhEMPDl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 11:03:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233075AbhEMPD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 11:03:29 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF68AC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 08:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=k+k4sEYiLZKBnj1Lq1JGtd6aySWBq+j2yywEobZWkiw=; b=FrJ401vF29y4Aw85CzGB4FO6fH
        KVeHP3fABsl2OBv5Pz++qJ0y1Pge0JdmzvxW09bJR+O63+LxMiwaRkXU3cALdnLG8zeZ10heKVLIT
        6UML546IA3fEVqTSTEUxL0gPpbo9ZY9toDC4GK0UU/TBAFf9pgkyblKGE2BjW7yGzfY0APYOt1LMu
        U61OQXY6SZj8/y/+UIyCQ6eblremhNGMwOrqqgUUEnp2vtlOgRKJUAwqqs/lVC47+0l30ioOVVWzb
        Gz6T29fnY24JV4bAGTriV/bmbjc5zlQBDrnO2v9WFvAH3NZ8XGIUaYvY+qEx9rjWmYx5ktgLRuylk
        WEomcIaA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lhCqo-005p2u-OB; Thu, 13 May 2021 15:02:10 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 08B383001E1;
        Thu, 13 May 2021 17:02:07 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E49622D8E4AFC; Thu, 13 May 2021 17:02:06 +0200 (CEST)
Date:   Thu, 13 May 2021 17:02:06 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org, robh@kernel.org,
        ak@linux.intel.com, acme@kernel.org, mark.rutland@arm.com,
        luto@amacapital.net, eranian@google.com, namhyung@kernel.org
Subject: Re: [PATCH V7 2/2] perf/x86: Reset the dirty counter to prevent the
 leak for an RDPMC task
Message-ID: <YJ0/bjek1ihh/2Ea@hirez.programming.kicks-ass.net>
References: <1620915782-50154-1-git-send-email-kan.liang@linux.intel.com>
 <1620915782-50154-2-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1620915782-50154-2-git-send-email-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 13, 2021 at 07:23:02AM -0700, kan.liang@linux.intel.com wrote:

> +	if (x86_pmu.sched_task && event->hw.target) {
> +		atomic_inc(&event->pmu->sched_cb_usage);
> +		local_irq_save(flags);
> +		x86_pmu_clear_dirty_counters();
> +		local_irq_restore(flags);
> +	}

So what happens if our mmap() happens after we've already created two
(or more) threads in the process, all of who already have a counter (or
more) on?

Shouldn't this be something like?

--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2474,7 +2474,7 @@ static int x86_pmu_event_init(struct per
 	return err;
 }
 
-static void x86_pmu_clear_dirty_counters(void)
+static void x86_pmu_clear_dirty_counters(void *unused)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	int i;
@@ -2512,9 +2512,9 @@ static void x86_pmu_event_mapped(struct
 	 */
 	if (x86_pmu.sched_task && event->hw.target) {
 		atomic_inc(&event->pmu->sched_cb_usage);
-		local_irq_save(flags);
-		x86_pmu_clear_dirty_counters();
-		local_irq_restore(flags);
+		on_each_cpu_mask(mm_cpumask(mm),
+				 x86_pmu_clear_dirty_counters,
+				 NULL, true);
 	}
 
 	/*
@@ -2653,7 +2653,7 @@ static void x86_pmu_sched_task(struct pe
 	 */
 	if (sched_in && ctx && READ_ONCE(x86_pmu.attr_rdpmc) &&
 	    current->mm && atomic_read(&current->mm->context.perf_rdpmc_allowed))
-		x86_pmu_clear_dirty_counters();
+		x86_pmu_clear_dirty_counters(NULL);
 }
 
 static void x86_pmu_swap_task_ctx(struct perf_event_context *prev,
