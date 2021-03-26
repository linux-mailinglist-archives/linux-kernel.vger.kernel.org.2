Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0459D34A7DB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 14:13:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbhCZNMb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 09:12:31 -0400
Received: from foss.arm.com ([217.140.110.172]:59118 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229882AbhCZNL6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 09:11:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B66CD143D;
        Fri, 26 Mar 2021 06:11:56 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 736913F7D7;
        Fri, 26 Mar 2021 06:11:54 -0700 (PDT)
Subject: Re: [PATCH 7/9] sched,debug: Convert sysctl sched_domains to debugfs
To:     Peter Zijlstra <peterz@infradead.org>, mingo@kernel.org,
        mgorman@suse.de, juri.lelli@redhat.com, vincent.guittot@linaro.org,
        rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com,
        joshdon@google.com, valentin.schneider@arm.com
Cc:     linux-kernel@vger.kernel.org, greg@kroah.com
References: <20210326103352.603456266@infradead.org>
 <20210326103935.264012208@infradead.org>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <edd14b50-41d5-8c04-6bb6-9a821e33695f@arm.com>
Date:   Fri, 26 Mar 2021 14:11:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210326103935.264012208@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/03/2021 11:33, Peter Zijlstra wrote:
> Stop polluting sysctl, move to debugfs for SCHED_DEBUG stuff.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  kernel/sched/debug.c    |  255 ++++++++++--------------------------------------
>  kernel/sched/sched.h    |    2 
>  kernel/sched/topology.c |    1 
>  3 files changed, 59 insertions(+), 199 deletions(-)

Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>

[...]

> +#define SDM(type, mode, member)	\
> +	debugfs_create_##type(#member, mode, parent, &sd->member)
>  
> -		WARN_ON(sd_ctl_dir[0].child);
> -		sd_ctl_dir[0].child = cpu_entries;
> -	}
> +	SDM(ulong, 0644, min_interval);
> +	SDM(ulong, 0644, max_interval);
> +	SDM(u64,   0644, max_newidle_lb_cost);
> +	SDM(u32,   0644, busy_factor);
> +	SDM(u32,   0644, imbalance_pct);
> +	SDM(u32,   0644, cache_nice_tries);
> +//	SDM(x32,   0444, flags);

Can be removed.

> +	SDM(str,   0444, name);
>  
> -	if (!cpu_idx) {
> -		struct ctl_table *e = cpu_entries;
> +#undef SDM
>  
> -		cpu_idx = kcalloc(nr_cpu_ids, sizeof(struct ctl_table*), GFP_KERNEL);
> -		if (!cpu_idx)
> -			return;
> +	debugfs_create_file("flags", 0444, parent, &sd->flags, &sd_flags_fops);
> +}

[...]
