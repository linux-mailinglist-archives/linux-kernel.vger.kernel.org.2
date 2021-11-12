Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 586C444E866
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 15:17:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235147AbhKLOTy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 09:19:54 -0500
Received: from foss.arm.com ([217.140.110.172]:38394 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235189AbhKLOTu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 09:19:50 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0AE4FED1;
        Fri, 12 Nov 2021 06:17:00 -0800 (PST)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1D0E63F70D;
        Fri, 12 Nov 2021 06:16:57 -0800 (PST)
Subject: Re: [Resend PATCH] psi : calc cfs task memstall time more precisely
To:     Xuewen Yan <xuewen.yan94@gmail.com>
Cc:     Zhaoyang Huang <huangzhaoyang@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        xuewen.yan@unisoc.com, Ke Wang <Ke.Wang@unisoc.com>
References: <1634278612-17055-1-git-send-email-huangzhaoyang@gmail.com>
 <YYGV1TxsZXzGXFmx@cmpxchg.org>
 <CAGWkznEaEEz=m5UmPXRECiizwht7+8Zw_xH9V7Wwyd__10eJDA@mail.gmail.com>
 <CAGWkznFuX=6mSnj7J7=t7et5QO-GB2BKCMRiHoU37jcH9dPhLA@mail.gmail.com>
 <78b3f72b-3fe7-f2e0-0e6b-32f28b8ce777@arm.com>
 <CAGWkznF_8iBp57BPoQKvG4VuNYep=g+ZxgO7D4e0wMDLipJ8uw@mail.gmail.com>
 <85c81ab7-49ed-aba5-6221-ea6a8f37f8ad@arm.com>
 <CAB8ipk_0YxWnS-k+HLPnL7DRR1MM+WH-xQfna7jD_+TQ0vKi8Q@mail.gmail.com>
 <05a2e61e-9c55-8f8d-5e72-9854613e53c9@arm.com>
 <CAB8ipk-r0LOudU7+ijVGS5mu2stKY8DBZ3BhKfbFcOgZj2VaQA@mail.gmail.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <1aa4afe4-3c30-a9c9-561b-bd692c569ae0@arm.com>
Date:   Fri, 12 Nov 2021 15:16:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAB8ipk-r0LOudU7+ijVGS5mu2stKY8DBZ3BhKfbFcOgZj2VaQA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/11/2021 06:36, Xuewen Yan wrote:
> Hi Dietmar
> On Tue, Nov 9, 2021 at 5:43 PM Dietmar Eggemann
> <dietmar.eggemann@arm.com> wrote:
>>
>> On 08/11/2021 09:49, Xuewen Yan wrote:
>>> Hi Dietmar
>>>
>>> On Sat, Nov 6, 2021 at 1:20 AM Dietmar Eggemann
>>> <dietmar.eggemann@arm.com> wrote:
>>>>
>>>> On 05/11/2021 06:58, Zhaoyang Huang wrote:

[...]

>>>> Even the CFS part (cpu_rq(CPUx)->cfs.avg.util_avg) can be larger than
>>>> the original cpu capacity (rq->cpu_capacity_orig).
>>>>
>>>> Have a look at cpu_util(). capacity_orig_of(CPUx) and
>>>> arch_scale_cpu_capacity(CPUx) both returning rq->cpu_capacity_orig.
>>>>
>>>
>>> Well, your means is we should not use the 1024 and should use the
>>> original cpu capacity?
>>> And maybe use the "sched_cpu_util()" is a good choice just like this:
>>>
>>> +       if (current->in_memstall)
>>> +               growth_fixed = div64_ul(cpu_util_cfs(rq) * growth,
>>> sched_cpu_util(rq->cpu, capacity_orig_of(rq->cpu)));
>>
>> Not sure about this. In case util_cfs=0 you would get scale=0.
> 
> Yes , we should consider it. In addition, it also should be considered
> when util_cfs > capacity_orig because of the UTIL_EST......

We should ]-clamp cpu_util_cfs() with capacity_orig_of(), like we
currently do for the CFS internal cpu_util(). In fact, we should only
use one function for this. Sent a patch out:

https://lkml.kernel.org/r/20211112141349.155713-1-dietmar.eggemann@arm.com%3E

[...]
