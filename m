Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD42736F8F6
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 13:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbhD3LN4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 07:13:56 -0400
Received: from foss.arm.com ([217.140.110.172]:46080 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229543AbhD3LNz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 07:13:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BC676ED1;
        Fri, 30 Apr 2021 04:13:06 -0700 (PDT)
Received: from [10.57.29.245] (unknown [10.57.29.245])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ABFCD3F70D;
        Fri, 30 Apr 2021 04:13:03 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] sched/fair: Fix negative energy delta in
 find_energy_efficient_cpu()
To:     Pierre.Gondois@arm.com
Cc:     linux-kernel@vger.kernel.org, xuewen.yan@unisoc.com,
        qperret@qperret.net, dietmar.eggemann@arm.com,
        Vincent.Donnefort@arm.com, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com
References: <20210429101948.31224-1-Pierre.Gondois@arm.com>
 <20210429101948.31224-3-Pierre.Gondois@arm.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <49c159b6-ebd7-e5fc-29ca-70a1e3dcf0f1@arm.com>
Date:   Fri, 30 Apr 2021 12:13:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20210429101948.31224-3-Pierre.Gondois@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/29/21 11:19 AM, Pierre.Gondois@arm.com wrote:
> From: Pierre Gondois <Pierre.Gondois@arm.com>
> 
> find_energy_efficient_cpu() (feec()) searches the best energy CPU
> to place a task on. To do so, compute_energy() estimates the energy
> impact of placing the task on a CPU, based on CPU and task utilization
> signals.
> 
> Utilization signals can be concurrently updated while evaluating a
> performance domain (pd). In some cases, this leads to having a
> 'negative delta', i.e. placing the task in the pd is seen as an
> energy gain. Thus, any further energy comparison is biased.
> 
> In case of a 'negative delta', return prev_cpu since:
> 1. a 'negative delta' happens in less than 0.5% of feec() calls,
>     on a Juno with 6 CPUs (4 little, 2 big)
> 2. it is unlikely to have two consecutive 'negative delta' for
>     a task, so if the first call fails, feec() will correctly
>     place the task in the next feec() call
> 3. EAS current behavior tends to select prev_cpu if the task
>     doesn't raise the OPP of its current pd. prev_cpu is EAS's
>     generic decision
> 4. prev_cpu should be preferred to returning an error code.
>     In the latter case, select_idle_sibling() would do the placement,
>     selecting a big (and not energy efficient) CPU. As 3., the task
>     would potentially reside on the big CPU for a long time
> 
> Reported-by: Xuewen Yan <xuewen.yan@unisoc.com>
> Suggested-by: Xuewen Yan <xuewen.yan@unisoc.com>
> Signed-off-by: Pierre Gondois <Pierre.Gondois@arm.com>
> ---
>   kernel/sched/fair.c | 28 ++++++++++++++++------------
>   1 file changed, 16 insertions(+), 12 deletions(-)
> 


Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

Regards,
Lukasz
