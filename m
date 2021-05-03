Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C034137156E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 14:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233786AbhECMxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 08:53:14 -0400
Received: from foss.arm.com ([217.140.110.172]:40128 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230246AbhECMxL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 08:53:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 43B4EED1;
        Mon,  3 May 2021 05:52:18 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 90A173F70D;
        Mon,  3 May 2021 05:52:15 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] sched/fair: Only compute base_energy_pd if
 necessary
To:     Pierre.Gondois@arm.com, linux-kernel@vger.kernel.org,
        xuewen.yan@unisoc.com, qperret@qperret.net
Cc:     Lukasz.Luba@arm.com, Vincent.Donnefort@arm.com, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, rostedt@goodmis.org,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com
References: <20210429101948.31224-1-Pierre.Gondois@arm.com>
 <20210429101948.31224-2-Pierre.Gondois@arm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <ac10c924-78fc-259c-245d-c7f69f2aa17a@arm.com>
Date:   Mon, 3 May 2021 14:52:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210429101948.31224-2-Pierre.Gondois@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/04/2021 12:19, Pierre.Gondois@arm.com wrote:
> From: Pierre Gondois <Pierre.Gondois@arm.com>
> 
> find_energy_efficient_cpu() searches the best energy CPU
> to place a task on. To do so, the energy of each performance domain
> (pd) is computed w/ and w/o the task placed in each pd.

s/in each pd/on it ?

> 
> The energy of a pd w/o the task (base_energy_pd) is computed prior
> knowing whether a CPU is available in the pd.
> 
> Move the base_energy_pd computation after looping through the CPUs
> of a pd and only computes it if at least one CPU is available.

s/computes/compute

[...]

> +		if (max_spare_cap_cpu < 0 && !compute_prev_delta)
> +			continue;
> +
> +		/* Compute the 'base' energy of the pd, without @p */
> +		base_energy_pd = compute_energy(p, -1, pd);
> +		base_energy += base_energy_pd;
> +

                /* Evaluate the energy impact of using prev_cpu. */

You agreed on this one during v1 review ;-)

> +		if (compute_prev_delta) {
> +			prev_delta = compute_energy(p, prev_cpu, pd);
> +			prev_delta -= base_energy_pd;
> +			best_delta = min(best_delta, prev_delta);
> +		}
> +
>  		/* Evaluate the energy impact of using this CPU. */

better:

            /* Evaluate the energy impact of using max_spare_cap_cpu. */

'this' has lost its context and people might read it as 'this_cpu' or
smp_processor_id().


> -		if (max_spare_cap_cpu >= 0 && max_spare_cap_cpu != prev_cpu) {
> +		if (max_spare_cap_cpu >= 0) {
>  			cur_delta = compute_energy(p, max_spare_cap_cpu, pd);
>  			cur_delta -= base_energy_pd;
>  			if (cur_delta < best_delta) {
> 

With these minor things sorted:

Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
