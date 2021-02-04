Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A764030F5DE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 16:11:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237132AbhBDPLB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 10:11:01 -0500
Received: from foss.arm.com ([217.140.110.172]:59756 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237015AbhBDO6A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 09:58:00 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1988511D4;
        Thu,  4 Feb 2021 06:57:08 -0800 (PST)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 18A773F718;
        Thu,  4 Feb 2021 06:57:05 -0800 (PST)
Subject: Re: [PATCH 5/8] sched/fair: Make check_misfit_status() only compare
 dynamic capacities
To:     Valentin Schneider <valentin.schneider@arm.com>,
        Qais Yousef <qais.yousef@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Quentin Perret <qperret@google.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Rik van Riel <riel@surriel.com>
References: <20210128183141.28097-1-valentin.schneider@arm.com>
 <20210128183141.28097-6-valentin.schneider@arm.com>
 <20210203151546.rwkbdjxc2vgiodvx@e107158-lin>
 <f1ea5b53-5953-15dc-6b67-9b6d520c61fc@arm.com> <jhja6sk2hip.mognet@arm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <1c4c5ff0-f29e-3f08-7ba0-6173bda888cd@arm.com>
Date:   Thu, 4 Feb 2021 15:57:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <jhja6sk2hip.mognet@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/02/2021 12:34, Valentin Schneider wrote:
> On 04/02/21 11:49, Dietmar Eggemann wrote:
>> On 03/02/2021 16:15, Qais Yousef wrote:
>>> On 01/28/21 18:31, Valentin Schneider wrote:

[...]

> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 21bd71f58c06..ea7f0155e268 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -1482,6 +1482,33 @@ DECLARE_PER_CPU(struct sched_domain __rcu *, sd_asym_packing);
>  DECLARE_PER_CPU(struct sched_domain __rcu *, sd_asym_cpucapacity);
>  extern struct static_key_false sched_asym_cpucapacity;
>  
> +/*
> + * Note that the static key is system-wide, but the visibility of
> + * SD_ASYM_CPUCAPACITY isn't. Thus the static key being enabled does not
> + * imply all CPUs can see asymmetry.
> + *
> + * Consider an asymmetric CPU capacity system such as:
> + *
> + * MC [           ]
> + *     0 1 2 3 4 5
> + *     L L L L B B
> + *
> + * w/ arch_scale_cpu_capacity(L) < arch_scale_cpu_capacity(B)
> + *
> + * By default, booting this system will enable the sched_asym_cpucapacity
> + * static key, and all CPUs will see SD_ASYM_CPUCAPACITY set at their MC
> + * sched_domain.
> + *
> + * Further consider exclusive cpusets creating a "symmetric island":
> + *
> + * MC [   ][      ]
> + *     0 1  2 3 4 5
> + *     L L  L L B B
> + *
> + * Again, booting this will enable the static key, but CPUs 0-1 will *not* have
> + * SD_ASYM_CPUCAPACITY set in any of their sched_domain. This is the intending

s/intending/intended

> + * behaviour, as CPUs 0-1 should be treated as a regular, isolated SMP system.
> + */

LGTM.
