Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3A343836DA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 17:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244231AbhEQPgy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 11:36:54 -0400
Received: from foss.arm.com ([217.140.110.172]:55282 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244281AbhEQPTz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 11:19:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BBC02106F;
        Mon, 17 May 2021 08:18:38 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 390A23F73B;
        Mon, 17 May 2021 08:18:35 -0700 (PDT)
Subject: Re: [PATCH v3 5/6] sched/fair: Consider SMT in ASYM_PACKING load
 balance
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Len Brown <len.brown@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        Quentin Perret <qperret@google.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, Aubrey Li <aubrey.li@intel.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
References: <20210513154909.6385-1-ricardo.neri-calderon@linux.intel.com>
 <20210513154909.6385-6-ricardo.neri-calderon@linux.intel.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <3e346f3d-45c4-bd8c-57d9-a11feda42834@arm.com>
Date:   Mon, 17 May 2021 17:18:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210513154909.6385-6-ricardo.neri-calderon@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/05/2021 17:49, Ricardo Neri wrote:

[...]

> @@ -8447,6 +8456,89 @@ group_type group_classify(unsigned int imbalance_pct,
>  	return group_has_spare;
>  }
>  
> +/**
> + * asym_can_pull_tasks - Check whether the load balancing CPU can pull tasks
> + * @dst_cpu:	Destination CPU of the load balancing
> + * @sds:	Load-balancing data with statistics of the local group
> + * @sgs:	Load-balancing statistics of the candidate busiest group
> + * @sg:		The candidate busiet group
> + *
> + * Check the state of the SMT siblings of both @sds::local and @sg and decide
> + * if @dst_cpu can pull tasks. If @dst_cpu does not have SMT siblings, it can
> + * pull tasks if two or more of the SMT siblings of @sg are busy. If only one
> + * CPU in @sg is busy, pull tasks only if @dst_cpu has higher priority.
> + *
> + * If both @dst_cpu and @sg have SMT siblings. Even the number of idle CPUs
> + * between @sds::local and @sg. Thus, pull tasks from @sg if the difference
> + * between the number of busy CPUs is 2 or more. If the difference is of 1,
> + * only pull if @dst_cpu has higher priority. If @sg does not have SMT siblings
> + * only pull tasks if all of the SMT siblings of @dst_cpu are idle and @sg
> + * has lower priority.
> + */
> +static bool asym_can_pull_tasks(int dst_cpu, struct sd_lb_stats *sds,
> +				struct sg_lb_stats *sgs, struct sched_group *sg)
> +{
> +#ifdef CONFIG_SCHED_SMT
> +	int cpu, local_busy_cpus, sg_busy_cpus;
> +	bool local_is_smt, sg_is_smt;
> +
> +	cpu = group_first_cpu(sg);

Looks like `cpu` isn't used.

[...]
