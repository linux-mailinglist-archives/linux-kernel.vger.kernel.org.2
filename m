Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 823B44047A2
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 11:16:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232805AbhIIJRs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 05:17:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232842AbhIIJRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 05:17:42 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C39FFC0613C1
        for <linux-kernel@vger.kernel.org>; Thu,  9 Sep 2021 02:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=n2DH43SZuDqrFURFi4S+W0v5BSKMq9WBJQx1w/5wfhg=; b=eGT5/EE4UI8Lp94CyqPGd631u5
        I1h8pfWZw8/bHP1zUehg9AYA8b/85RtQi+rCQKezQlZBuxywjs1DS/xQHClIan0VBZzEzwXNZPZXF
        ZaDo1DDF8m1rL439tzpbxtOqa0dAqc/m01y78yP+9zxLy+RqxM4seqbGEYEvj2ppZUxiNlqtx5uk2
        iGmm3vGnzOxfMxMjXjE20JAXWMqXaO4XleJLYFLigLtn7BJULc8Qz3qHclN0mEaPceTncy+FPoP7l
        scToS2Pmch/45VQUJdjFNnx7RLH/Fcquxy23TBZiJbihrM+S5/Msh90KOKyfdX1wxD1IRk+K1hu4e
        Stcl2FSA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mOGAT-001psG-HC; Thu, 09 Sep 2021 09:16:25 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 248B3300094;
        Thu,  9 Sep 2021 11:16:25 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 15F0D2C625915; Thu,  9 Sep 2021 11:16:25 +0200 (CEST)
Date:   Thu, 9 Sep 2021 11:16:25 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Stephane Eranian <eranian@google.com>
Cc:     linux-kernel@vger.kernel.org, acme@redhat.com, jolsa@redhat.com,
        kim.phillips@amd.com, namhyung@kernel.org, irogers@google.com
Subject: Re: [PATCH v1 08/13] perf/x86/core: add idle hooks
Message-ID: <YTnQ6Wxoz8LYmtPS@hirez.programming.kicks-ass.net>
References: <20210909075700.4025355-1-eranian@google.com>
 <20210909075700.4025355-9-eranian@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210909075700.4025355-9-eranian@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 09, 2021 at 12:56:55AM -0700, Stephane Eranian wrote:

> diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
> index 14ce130aee1b..c0ddc3c32a33 100644
> --- a/kernel/sched/idle.c
> +++ b/kernel/sched/idle.c
> @@ -179,7 +179,6 @@ static void cpuidle_idle_call(void)
>  	 */
>  	if (need_resched()) {
>  		local_irq_enable();
> -		perf_lopwr_cb(false);
>  		return;
>  	}
>  
> @@ -230,6 +229,9 @@ static void cpuidle_idle_call(void)
>  		tick_nohz_idle_stop_tick();
>  
>  		next_state = cpuidle_find_deepest_state(drv, dev, max_latency_ns);
> +		if (!cpu_idle_force_poll)
> +			perf_lopwr_cb(true);
> +
>  		call_cpuidle(drv, dev, next_state);
>  	} else {
>  		bool stop_tick = true;
> @@ -244,12 +246,17 @@ static void cpuidle_idle_call(void)
>  		else
>  			tick_nohz_idle_retain_tick();
>  
> +		if (!cpu_idle_force_poll)
> +			perf_lopwr_cb(true);
> +
>  		entered_state = call_cpuidle(drv, dev, next_state);
>  		/*
>  		 * Give the governor an opportunity to reflect on the outcome
>  		 */
>  		cpuidle_reflect(dev, entered_state);
>  	}
> +	if (!cpu_idle_force_poll)
> +		perf_lopwr_cb(false);
>  
>  exit_idle:
>  	__current_set_polling();
> @@ -259,7 +266,6 @@ static void cpuidle_idle_call(void)
>  	 */
>  	if (WARN_ON_ONCE(irqs_disabled())) {
>  		local_irq_enable();
> -		perf_lopwr_cb(false);
>  	}
>  }
>  
> @@ -293,8 +299,6 @@ static void do_idle(void)
>  	while (!need_resched()) {
>  		rmb();
>  
> -		perf_lopwr_cb(true);
> -
>  		local_irq_disable();
>  
>  		if (cpu_is_offline(cpu)) {

Why are you sendimg me a patch that undoes most of what the previous
patch does? That's just bad form.
