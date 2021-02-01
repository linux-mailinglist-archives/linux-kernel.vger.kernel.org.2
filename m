Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 192D830A6ED
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 12:56:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbhBAL4Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 06:56:24 -0500
Received: from foss.arm.com ([217.140.110.172]:57552 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229707AbhBAL4W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 06:56:22 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BC30CED1;
        Mon,  1 Feb 2021 03:55:36 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9EE813F718;
        Mon,  1 Feb 2021 03:55:35 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, peterz@infradead.org, vincent.guittot@linaro.org,
        morten.rasmussen@arm.com, mgorman@suse.de,
        song.bao.hua@hisilicon.com
Subject: Re: [PATCH 1/1] sched/topology: Make sched_init_numa() use a set for the deduplicating sort
In-Reply-To: <6000e39e-7d28-c360-9cd6-8798fd22a9bf@arm.com>
References: <20210122123943.1217-1-valentin.schneider@arm.com> <20210122123943.1217-2-valentin.schneider@arm.com> <6000e39e-7d28-c360-9cd6-8798fd22a9bf@arm.com>
User-Agent: Notmuch/0.21 (http://notmuchmail.org) Emacs/26.3 (x86_64-pc-linux-gnu)
Date:   Mon, 01 Feb 2021 11:55:30 +0000
Message-ID: <jhj1re00zpp.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/02/21 10:53, Dietmar Eggemann wrote:
> On 22/01/2021 13:39, Valentin Schneider wrote:
>
> [...]
>
>> @@ -1705,7 +1702,7 @@ void sched_init_numa(void)
>>      /* Compute default topology size */
>>      for (i = 0; sched_domain_topology[i].mask; i++);
>>
>> -	tl = kzalloc((i + level + 1) *
>> +	tl = kzalloc((i + nr_levels) *
>>                      sizeof(struct sched_domain_topology_level), GFP_KERNEL);
>>      if (!tl)
>>              return;
>
> This hunk creates issues during startup on my Arm64 juno board on tip/sched/core.
>
> ---8<---
>
> From: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Date: Mon, 1 Feb 2021 09:58:04 +0100
> Subject: [PATCH] sched/topology: Fix sched_domain_topology_level alloc in
>  sched_init_numa
>
> Commit "sched/topology: Make sched_init_numa() use a set for the
> deduplicating sort" allocates 'i + nr_levels (level)' instead of
> 'i + nr_levels + 1' sched_domain_topology_level.
>
> This led to an Oops (on Arm64 juno with CONFIG_SCHED_DEBUG):
>
> sched_init_domains
>   build_sched_domains()
>     __free_domain_allocs()
>       __sdt_free() {
>       ...
>         for_each_sd_topology(tl)
>         ...
>           sd = *per_cpu_ptr(sdd->sd, j); <--
>         ...
>       }
>
> Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>

Damn, I forgot the topology level stuff must terminate in a NULL'd
sentinel! Vincent fixed the same thing a few years ago...

  c515db8cd311 ("sched/numa: Fix initialization of sched_domain_topology for NUMA")

Thanks for fixing up my mistake, I ought to have tested !NUMA setups.
