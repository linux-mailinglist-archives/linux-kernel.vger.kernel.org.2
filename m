Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9943B427DFD
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Oct 2021 00:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231152AbhJIWyX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Oct 2021 18:54:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbhJIWyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Oct 2021 18:54:18 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B6AFC061570
        for <linux-kernel@vger.kernel.org>; Sat,  9 Oct 2021 15:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HlKWYN2dw8uuQPxr2tgsDfcykAdf/apHp3S9FQkV370=; b=qk9H63EqlV+cMSj2hs8OSZ5oac
        RtLNYC37cNC862LycoSvAKYfUanYEXUG9Det5ZBNgpP98WCYlwhsERVwlJLbfUYItiX7wzoeLTKVv
        swRoqZgcvoO5HBHXijyx71h0r+Z2IctlwhtuksO/1HfO1a1Renjx5O9kNvNXseoJV1SJ39QLmDgTI
        FjIYaG/a1/feq0Z9kTpHvlbt2NHb66HF2Hqfwu2UFnha2CIAFP2FT/7tH5YLMriDErMpk08Yagi/n
        XlLDvKtXpSySU/KGObNuAejiBxzk/vVmqzao2YoLVwhVS5tPzNnInsm1NEjiz384fomLpIV/lCTwm
        fdE7z7FQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mZLBB-004SNm-LJ; Sat, 09 Oct 2021 22:51:09 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 414639811D4; Sun, 10 Oct 2021 00:50:57 +0200 (CEST)
Date:   Sun, 10 Oct 2021 00:50:57 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Tao Zhou <tao.zhou@linux.dev>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH] sched/fair: Check idle_cpu in select_idle_core/cpu()
Message-ID: <20211009225057.GB174703@worktop.programming.kicks-ass.net>
References: <20211009180941.20458-1-tao.zhou@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211009180941.20458-1-tao.zhou@linux.dev>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 10, 2021 at 02:09:41AM +0800, Tao Zhou wrote:
> In select_idle_core(), the idle core returned may have no cpu
> allowed. I think the idle core returned for the task is the one
> that can be allowed to run. I insist on this semantics.
> 
> In select_idle_cpu(), if select_idle_core() can not find the
> idle core, one reason is that the core is not allowed for the
> task, but the core itself is idle from the point of
> sds->has_idle_cores. I insist on this semantics.
> 
> No others, just two additional check.
> ---
>  kernel/sched/fair.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index f6a05d9b5443..a44aca5095d3 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6213,7 +6213,7 @@ static int select_idle_core(struct task_struct *p, int core, struct cpumask *cpu
>  			*idle_cpu = cpu;
>  	}
>  
> -	if (idle)
> +	if (idle && *idle_cpu != -1)
>  		return core;

In that case, core would be nr_cpu_ids (==nr_cpumask_bits), and then the caller checks:

	(unsigned)i < nr_cpumask_bits

>  	cpumask_andnot(cpus, cpus, cpu_smt_mask(core));
> @@ -6324,7 +6324,7 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
>  		}
>  	}
>  
> -	if (has_idle_core)
> +	if (has_idle_core && *idle_cpu != -1)
>  		set_idle_cores(target, false);

And this one I'm completely failing, why shouldn't we mark the core as
non-idle when there is a single idle CPU found? That's just worng.
