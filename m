Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAC2E37FA00
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 16:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234708AbhEMOvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 10:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234683AbhEMOtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 10:49:06 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9F2FC061574
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 07:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GC0BeLIwJitw/05Pke8b1fCxtksraUnKyqn+n8GWAYw=; b=FsomFeG80mvBh+5IqrBYn6Li6V
        YG2ivLD67q4AhekjxKXEnigL2BWmeB/yubGnP3eFlLgLn2an3p3L0JuvBHmkOaDPI/h+9PQWaKO0l
        mk83yBJXOR1vuUs6sG0K9X98c3+GJdNM/DYpbpYe31KXqzYEbuw6llCMOZn1d248xLg1dvt6oGNTQ
        TzOpmiH2yAQa65OtHKbBJ8+6+EY784Tnb+xAsnCbzfVF7j+B0CXM5lwHxLeHlnLpJs8dPFEA2kMQW
        nftbYlCHuZir6ZwsiEt+oz0+F0anKD5+T+JvZgZi5YMaoZOnDqZm4SHx31C3jn+cXCimYFhTpV6dC
        DV9KraYw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lhCct-005nP3-1a; Thu, 13 May 2021 14:47:47 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C29D53001E1;
        Thu, 13 May 2021 16:42:57 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9DC4D2D1A9B5D; Thu, 13 May 2021 16:42:57 +0200 (CEST)
Date:   Thu, 13 May 2021 16:42:57 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org, robh@kernel.org,
        ak@linux.intel.com, acme@kernel.org, mark.rutland@arm.com,
        luto@amacapital.net, eranian@google.com, namhyung@kernel.org
Subject: Re: [PATCH V7 1/2] perf: Track per-PMU sched_task() callback users
Message-ID: <YJ068cA0bGJA0C0T@hirez.programming.kicks-ass.net>
References: <1620915782-50154-1-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1620915782-50154-1-git-send-email-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 13, 2021 at 07:23:01AM -0700, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> Current perf only tracks the per-CPU sched_task() callback users, which
> doesn't work if a callback user is a task. For example, the dirty
> counters have to be cleared to prevent data leakage when a new RDPMC
> task is scheduled in. The task may be created on one CPU but running on
> another CPU. It cannot be tracked by the per-CPU variable. A global
> variable is not going to work either because of the hybrid PMUs.
> Add a per-PMU variable to track the callback users.
> 
> In theory, the per-PMU variable should be checked everywhere the
> sched_task() can be called. But the X86 RDPMC is the only user for the
> per-PMU sched_cb_usage. A callback for the X86 RDPMC is required only
> when a different context is scheduled in. To avoid unnecessary
> sched_task() invoke, the per-PMU sched_cb_usage is only checked there.
> Should there be any other ARCHs which require it in the other places,
> it can be added later separately.
> 
> Suggested-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> ---
> 
> - New patch. Split the V6 to core and x86 parts.
> 
>  include/linux/perf_event.h | 3 +++
>  kernel/events/core.c       | 9 ++++++++-
>  2 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index c8a3388..c6ee202 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -301,6 +301,9 @@ struct pmu {
>  	/* number of address filters this PMU can do */
>  	unsigned int			nr_addr_filters;
>  
> +	/* Track the per PMU sched_task() callback users */
> +	atomic_t			sched_cb_usage;
> +
>  	/*
>  	 * Fully disable/enable this PMU, can be used to protect from the PMI
>  	 * as well as for lazy/batch writing of the MSRs.
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 1574b70..286b718 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -3851,7 +3851,14 @@ static void perf_event_context_sched_in(struct perf_event_context *ctx,
>  		cpu_ctx_sched_out(cpuctx, EVENT_FLEXIBLE);
>  	perf_event_sched_in(cpuctx, ctx, task);
>  
> -	if (cpuctx->sched_cb_usage && pmu->sched_task)
> +	/*
> +	 * X86 RDPMC is the only user for the per-PMU sched_cb_usage.

I think we can do without this line; since we know ARM64 also
potentially wants this.

> +	 * A callback for the X86 RDPMC is required only when a

Also, I think we spell it: x86.

> +	 * different context is scheduled in.
> +	 * To avoid unnecessary sched_task() invoke, the per-PMU
> +	 * sched_cb_usage is only checked here.
> +	 */
> +	if (pmu->sched_task && (cpuctx->sched_cb_usage || atomic_read(&pmu->sched_cb_usage)))
>  		pmu->sched_task(cpuctx->task_ctx, true);
>  
>  	perf_pmu_enable(pmu);

I'll sit on these patches a wee bit until Rob has provided feedback, but
I'm thinking this should do.
