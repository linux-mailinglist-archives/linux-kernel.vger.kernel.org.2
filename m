Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64C33333D6D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 14:12:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232088AbhCJNLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 08:11:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232091AbhCJNLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 08:11:37 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41700C061760
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 05:11:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bcNBBAlW5/JNcYoIITrENNhoDL7w1CSQllDiwTdQ788=; b=hUFLYbjpfFVHzIBvCBfMpYN86l
        WRSTHeLeass4Lv4YeOvgzi6ODhezwsExnwGBZzdcfcd4kJ8qPQvNml1qz7THBYCmyk9wW0H+qqW2J
        d7r6vlrJGWPMLvrSW8Jz+P/YcCcoOiUQ8Jr1jNkAH03bKpCCcznwBUroIi9XAKcbMjRlmYqlMXF2E
        v1rPBLqxhyZnIb2JGlizl+j3IkEQLWyAWdWzO5vuGhyDv2SSyzmLqCTGxc3IooJnrW0g+7bEA7H+/
        UuMrFcgq2YbRXuUOppiufMlfDZTjGjao20Bl/aQTeACKe6WECMc+XjXnCq54j3OotU270Z/J8+csZ
        j/iMc7hA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lJycI-003V66-Hg; Wed, 10 Mar 2021 13:11:12 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id EE2EA3059C0;
        Wed, 10 Mar 2021 14:10:56 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D000B20D7207B; Wed, 10 Mar 2021 14:10:56 +0100 (CET)
Date:   Wed, 10 Mar 2021 14:10:56 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Huaixin Chang <changhuaixin@linux.alibaba.com>
Cc:     bsegall@google.com, dietmar.eggemann@arm.com,
        juri.lelli@redhat.com, khlebnikov@yandex-team.ru,
        linux-kernel@vger.kernel.org, mgorman@suse.de, mingo@redhat.com,
        pauld@redhead.com, pjt@google.com, rostedt@goodmis.org,
        shanpeic@linux.alibaba.com, vincent.guittot@linaro.org,
        xiyou.wangcong@gmail.com
Subject: Re: [PATCH v3 3/4] sched/fair: Add cfs bandwidth burst statistics
Message-ID: <YEjFYAnvL+gFf+Ar@hirez.programming.kicks-ass.net>
References: <20210121110453.18899-1-changhuaixin@linux.alibaba.com>
 <20210121110453.18899-4-changhuaixin@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210121110453.18899-4-changhuaixin@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 21, 2021 at 07:04:52PM +0800, Huaixin Chang wrote:
> Introduce statistics exports for the burstable cfs bandwidth
> controller.
> 
> The following exports are included:
> 
> current_bw: current runtime in global pool
> nr_burst:   number of periods bandwidth burst occurs
> burst_time: cumulative wall-time that any cpus has
> 	    used above quota in respective periods
> 
> Signed-off-by: Huaixin Chang <changhuaixin@linux.alibaba.com>
> Signed-off-by: Shanpei Chen <shanpeic@linux.alibaba.com>

Consistently fail.

> ---
>  kernel/sched/core.c  |  6 ++++++
>  kernel/sched/fair.c  | 12 +++++++++++-
>  kernel/sched/sched.h |  3 +++
>  3 files changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index fecf0f05ef0c..80ca763ca492 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -7986,6 +7986,8 @@ static int tg_set_cfs_bandwidth(struct task_group *tg, u64 period, u64 quota,
>  		cfs_b->runtime = min(max_cfs_runtime, cfs_b->runtime);
>  	}
>  
> +	cfs_b->previous_runtime = cfs_b->runtime;
> +
>  	/* Restart the period timer (if active) to handle new period expiry: */
>  	if (runtime_enabled)
>  		start_cfs_bandwidth(cfs_b, 1);
> @@ -8234,6 +8236,10 @@ static int cpu_cfs_stat_show(struct seq_file *sf, void *v)
>  		seq_printf(sf, "wait_sum %llu\n", ws);
>  	}
>  
> +	seq_printf(sf, "current_bw %llu\n", cfs_b->runtime);
> +	seq_printf(sf, "nr_burst %d\n", cfs_b->nr_burst);
> +	seq_printf(sf, "burst_time %llu\n", cfs_b->burst_time);
> +
>  	return 0;
>  }
>  #endif /* CONFIG_CFS_BANDWIDTH */

This is ABI; and the Changelog has no justification what so ever...

