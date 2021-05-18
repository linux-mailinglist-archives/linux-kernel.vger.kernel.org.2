Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 556233875EF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 12:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348265AbhERKEX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 06:04:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242636AbhERKEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 06:04:22 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE89AC061573
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 03:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YMIlqPQlrSuQ3HrEKrVM+TVsdQve/BhZYX34rN6joXA=; b=g8fiufCLdjeUqhVQao/BO1Wu36
        aaA98EXGyW++2rmcT29meAwuoYRQ+1tYQpGi3cYc9bk8eCdKlMAPbzl4MMy+2fuOaOACywIZmC+F6
        iBLH3WUqRe+WphRX1wzaXOXH2vqsp38N+5cOl/pbjLEWaUw+0J4fkm5CU87EoFCs+pcmBlRkg4iFb
        qs71SZLEXL/aTOlID/KtKeB2E5wKyC4W/B1XhoElfiJ6epCr4fF9X8RX7nmSf0glKv3A0m5nz5VpR
        +hy2Csox8VZiHNXMIZe4AeOvRqaWKNbjzrUnddv4DNH1BFif94ZqgYI3R1KLI3Q9/sm4rkk60y5ow
        4s5XOTTg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1liwYO-00Drxk-U0; Tue, 18 May 2021 10:02:27 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 04E23300233;
        Tue, 18 May 2021 12:02:18 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DE6BE2BE6E8C2; Tue, 18 May 2021 12:02:17 +0200 (CEST)
Date:   Tue, 18 May 2021 12:02:17 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Like Xu <like.xu@linux.intel.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>, seanjc@google.com,
        x86@kernel.org
Subject: Re: [PATCH v2 2/2] perf/x86/lbr: Move cpuc->lbr_xsave allocation out
 of sleeping region
Message-ID: <YKOQqT+Ktc4C2kQp@hirez.programming.kicks-ass.net>
References: <20210430052247.3079672-1-like.xu@linux.intel.com>
 <20210430052247.3079672-2-like.xu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210430052247.3079672-2-like.xu@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 30, 2021 at 01:22:47PM +0800, Like Xu wrote:
> If the kernel is compiled with the CONFIG_LOCKDEP option, the conditional
> might_sleep_if() deep in kmem_cache_alloc() will generate the following
> trace, and potentially cause a deadlock when another LBR event is added:

...

> One of the solution is to use GFP_ATOMIC, but it will make the code less
> reliable under memory pressue. Let's move the memory allocation out of
> the sleeping region and put it into the intel_pmu_hw_config(). The LBR
> xsave buffer is a per-CPU buffer, not a per-event buffer. This buffer is
> allocated once when initializing the LBR event.
> 
> The disadvantage of this fix is that the cpuc->lbr_xsave memory
> will be allocated for each cpu like the legacy ds_buffer.
> 
> Fixes: c085fb8774 ("perf/x86/intel/lbr: Support XSAVES for arch LBR read")
> Tested-by: Kan Liang <kan.liang@linux.intel.com>
> Signed-off-by: Like Xu <like.xu@linux.intel.com>
> ---
> v1->v2 Changelog:
> - Frob reserve_lbr_buffers() in intel_pmu_hw_config().
> 
>  arch/x86/events/intel/core.c |  2 ++
>  arch/x86/events/intel/lbr.c  | 25 +++++++++++++++++++------
>  arch/x86/events/perf_event.h |  6 ++++++
>  3 files changed, 27 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index 456aa6ffd9a1..19027aa01f82 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -3745,6 +3745,8 @@ static int intel_pmu_hw_config(struct perf_event *event)
>  
>  			event->destroy = hw_perf_lbr_event_destroy;
>  		}
> +
> +		reserve_lbr_buffers(event);

Ok, so this would actually work..

>  	}
>  
>  	if (event->attr.aux_output) {

> @@ -722,6 +716,25 @@ void release_lbr_buffers(void)
>  	}
>  }
>  
> +void reserve_lbr_buffers(struct perf_event *event)
> +{
> +	struct kmem_cache *kmem_cache;
> +	struct cpu_hw_events *cpuc;
> +	int cpu;
> +
> +	if (!static_cpu_has(X86_FEATURE_ARCH_LBR))
> +		return;
> +
> +	for_each_possible_cpu(cpu) {
> +		cpuc = per_cpu_ptr(&cpu_hw_events, cpu);
> +		kmem_cache = x86_get_pmu(cpu)->task_ctx_cache;
> +		if (kmem_cache && !cpuc->lbr_xsave && !event->attr.precise_ip)
> +			cpuc->lbr_xsave =
> +				kmem_cache_alloc_node(kmem_cache, GFP_KERNEL,
> +						      cpu_to_node(cpu));

(coding style fail)

But then I looked at this function, and srlsy that !precise_ip is the
only thing you need @event for? Why do we care?

> +	}
> +}


Without that silly @event dependency you can go back to the original
form, which makes much more sense since now reserve and release are
symmetric.

---
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -396,10 +396,12 @@ int x86_reserve_hardware(void)
 	if (!atomic_inc_not_zero(&pmc_refcount)) {
 		mutex_lock(&pmc_reserve_mutex);
 		if (atomic_read(&pmc_refcount) == 0) {
-			if (!reserve_pmc_hardware())
+			if (!reserve_pmc_hardware()) {
 				err = -EBUSY;
-			else
+			} else {
 				reserve_ds_buffers();
+				reserve_lbr_buffers();
+			}
 		}
 		if (!err)
 			atomic_inc(&pmc_refcount);
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -658,7 +658,6 @@ static inline bool branch_user_callstack
 
 void intel_pmu_lbr_add(struct perf_event *event)
 {
-	struct kmem_cache *kmem_cache = event->pmu->task_ctx_cache;
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 
 	if (!x86_pmu.lbr_nr)
@@ -696,11 +695,6 @@ void intel_pmu_lbr_add(struct perf_event
 	perf_sched_cb_inc(event->ctx->pmu);
 	if (!cpuc->lbr_users++ && !event->total_time_running)
 		intel_pmu_lbr_reset();
-
-	if (static_cpu_has(X86_FEATURE_ARCH_LBR) &&
-	    kmem_cache && !cpuc->lbr_xsave &&
-	    (cpuc->lbr_users != cpuc->lbr_pebs_users))
-		cpuc->lbr_xsave = kmem_cache_alloc(kmem_cache, GFP_KERNEL);
 }
 
 void release_lbr_buffers(void)
@@ -722,6 +716,26 @@ void release_lbr_buffers(void)
 	}
 }
 
+void reserve_lbr_buffers(void)
+{
+	struct kmem_cache *kmem_cache;
+	struct cpu_hw_events *cpuc;
+	int cpu;
+
+	if (!static_cpu_has(X86_FEATURE_ARCH_LBR))
+		return;
+
+	for_each_possible_cpu(cpu) {
+		cpuc = per_cpu_ptr(&cpu_hw_events, cpu);
+		kmem_cache = x86_get_pmu(cpu)->task_ctx_cache;
+		if (!kmem_cache || cpuc->lbr_xsave)
+			continue;
+
+		cpuc->lbr_xsave = kmem_cache_alloc_node(kmem_cache, GFP_KERNEL,
+							cpu_to_node(cpu));
+	}
+}
+
 void intel_pmu_lbr_del(struct perf_event *event)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -1244,6 +1244,8 @@ void reserve_ds_buffers(void);
 
 void release_lbr_buffers(void);
 
+void reserve_lbr_buffers(void);
+
 extern struct event_constraint bts_constraint;
 extern struct event_constraint vlbr_constraint;
 
@@ -1393,6 +1395,10 @@ static inline void release_lbr_buffers(v
 {
 }
 
+static inline void reserve_lbr_buffers(void)
+{
+}
+
 static inline int intel_pmu_init(void)
 {
 	return 0;

