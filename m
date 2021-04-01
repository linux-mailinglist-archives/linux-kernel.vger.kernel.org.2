Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1DB6351D99
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 20:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240293AbhDASaB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 14:30:01 -0400
Received: from foss.arm.com ([217.140.110.172]:45900 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236931AbhDASHu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 14:07:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 33A1F1424;
        Thu,  1 Apr 2021 11:07:43 -0700 (PDT)
Received: from [192.168.1.22] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9406F3F719;
        Thu,  1 Apr 2021 11:07:40 -0700 (PDT)
Subject: Re: [PATCH] sched/fair: use signed long when compute energy delta in
 eas
To:     Quentin Perret <qperret@google.com>,
        Xuewen Yan <xuewen.yan94@gmail.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, rostedt@goodmis.org,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        linux-kernel@vger.kernel.org, quentin.perret@arm.com,
        zhang.lyra@gmail.com, xuewyan@foxmail.com,
        Pierre Gondois <pierre.gondois@arm.com>
References: <20210330052154.26861-1-xuewen.yan94@gmail.com>
 <YGLzQAvVqlrKb8AB@google.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <34ce11ad-9c20-7ba7-90d8-4830725bf38a@arm.com>
Date:   Thu, 1 Apr 2021 20:07:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <YGLzQAvVqlrKb8AB@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+cc: Pierre Gondois <pierre.gondois@arm.com>

On 30/03/2021 11:45, Quentin Perret wrote:
> Hi,
> 
> On Tuesday 30 Mar 2021 at 13:21:54 (+0800), Xuewen Yan wrote:
>> From: Xuewen Yan <xuewen.yan@unisoc.com>
>>
>> now the energy delta compute as follow:
>>
>> base_energy_pd = compute_energy(p, -1, pd);
>> 	--->Traverse all CPUs in pd
>> 	--->em_pd_energy()
>> ----------------------------------------------------- \
>> search for the max_sapre_cap_cpu                       \
>> ---------------------------------                       search time
>> cur_delta = compute_energy(p, max_spare_cap_cpu, pd);  /
>> 	--->Traverse all CPUs in pd                   /
>> ---------------------------------------------------- /
>> 	--->em_pd_energy()
>> cur_delta -= base_energy_pd;
>>
>> During the search_time, or when calculate the cpu_util in
>> compute_energy(), there may occurred task dequeue or cpu_util change,
>> it may cause the cur_energy < base_energy_pd, so the cur_delta
>> would be negative. But the cur_delta is unsigned long, at this time,
>> the cur_delta would always bigger than best_delta of last pd.
>>
>> Change the vars to signed long.
> 
> Is that really helping though?
> 
> Yes you will not overflow, but the decision is still 'wrong' if the util
> values are not stable for the entire wake-up. I think folks on the Arm
> side had patches to try and cache the util values upfront, and then use
> them throughout feec() and compute_energy(), which I think would be a
> better fix.
> 
> Dietmar, wdyt?

Yes, we have some patches from Pierre Gondois which introduce a pd cache
to store the CPU utilization values so they can be reused for 'cpu !=
dst_cpu' calculations within find_energy_efficient_cpu() (feec()).

We did run them in our Jan 2021 EAS integration:

https://gitlab.arm.com/linux-arm/linux-power/-/commits/eas/next/integration-20210129

  sched: Allocate pd_cache when EAS is enabled
  sched/fair: Use pd_cache to speed up find_energy_efficient_cpu()

We haven't posted them since we're still looking for a story to justify
the extra complexity. The experiments on Arm64 Juno (2 big, 4 little
CPUs) showed 1-2% failure due to changes of CPU utilization values
during feec(). There was a 5% (big CPU)-10% (little CPU) runtime
reduction for feec() with the patches.
