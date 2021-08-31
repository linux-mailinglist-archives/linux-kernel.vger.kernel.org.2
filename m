Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2DDE3FC57F
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 12:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240930AbhHaKQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 06:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240908AbhHaKQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 06:16:44 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EA70C061575;
        Tue, 31 Aug 2021 03:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=njPlijGyRQWc3gvnaRTeTQR76HHFKSvP+XgdGVpDBZQ=; b=hfOM+OZt66gWAyzTgeoymAHRWI
        IDcVoiXocczDPt3S0JPYzXoutMJucn/+Ap44DYw38oU19vx70gRl1Vv0BKIGSbiffM0/vsFyxb/D8
        FsciU9R/ejMM0C8Iyt/lAB8KPxVOuY+Cb7UBvdRFXanzEroRH/6MCCRdwknUMDLhEhdm0V1EVpag5
        lmpOkrDoL76SMuvWyqOy2YzpExyxcOeSkxMHp4s2uBWuR7ACe1YP5ZOqt6i4dklkKOw47FnsaPmkT
        4XEgY0NetZll2knWR8FVl9HS7uyvVjAho+fz47M6P1bGq41FMqI8V1OND+ux5Vy87ROr/j1eyeG7k
        Euo1NBmw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mL0mP-0015MA-RC; Tue, 31 Aug 2021 10:14:18 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C4DC9300299;
        Tue, 31 Aug 2021 12:14:08 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8254B2C83EADA; Tue, 31 Aug 2021 12:14:08 +0200 (CEST)
Date:   Tue, 31 Aug 2021 12:14:08 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     mingo@redhat.com, mgorman@suse.de, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com,
        achaiken@aurora.tech, lkp@intel.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v3 2/7] sched: make struct sched_statistics independent
 of fair sched class
Message-ID: <YS4A8Jld5zC5qbAx@hirez.programming.kicks-ass.net>
References: <20210824112946.9324-1-laoar.shao@gmail.com>
 <20210824112946.9324-3-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210824112946.9324-3-laoar.shao@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 24, 2021 at 11:29:41AM +0000, Yafang Shao wrote:
> diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
> index 49716228efb4..4cfee2aa1a2d 100644
> --- a/kernel/sched/debug.c
> +++ b/kernel/sched/debug.c

> @@ -442,9 +442,11 @@ static void print_cfs_group_stats(struct seq_file *m, int cpu, struct task_group
>  	struct sched_entity *se = tg->se[cpu];
>  
>  #define P(F)		SEQ_printf(m, "  .%-30s: %lld\n",	#F, (long long)F)
> -#define P_SCHEDSTAT(F)	SEQ_printf(m, "  .%-30s: %lld\n",	#F, (long long)schedstat_val(F))
> +#define P_SCHEDSTAT(F)	SEQ_printf(m, "  .%-30s: %lld\n",	\
> +		"se->statistics."#F, (long long)schedstat_val(tg->stats[cpu]->F))
>  #define PN(F)		SEQ_printf(m, "  .%-30s: %lld.%06ld\n", #F, SPLIT_NS((long long)F))
> -#define PN_SCHEDSTAT(F)	SEQ_printf(m, "  .%-30s: %lld.%06ld\n", #F, SPLIT_NS((long long)schedstat_val(F)))
> +#define PN_SCHEDSTAT(F)	SEQ_printf(m, "  .%-30s: %lld.%06ld\n", \
> +		"se->statistics."#F, SPLIT_NS((long long)schedstat_val(tg->stats[cpu]->F)))
>  
>  	if (!se)
>  		return;

> @@ -948,8 +950,8 @@ void proc_sched_show_task(struct task_struct *p, struct pid_namespace *ns,
>  		"---------------------------------------------------------"
>  		"----------\n");
>  
> -#define P_SCHEDSTAT(F)  __PS(#F, schedstat_val(p->F))
> -#define PN_SCHEDSTAT(F) __PSN(#F, schedstat_val(p->F))
> +#define P_SCHEDSTAT(F)  __PS("se.statistics."#F, schedstat_val(p->stats.F))
> +#define PN_SCHEDSTAT(F) __PSN("se.statistics."#F, schedstat_val(p->stats.F))
>  
>  	PN(se.exec_start);
>  	PN(se.vruntime);

That's sad... can't we keep it #F, this is all SCHED_DEBUG code anyway.
