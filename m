Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65019357F3C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 11:33:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbhDHJd4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 05:33:56 -0400
Received: from foss.arm.com ([217.140.110.172]:42142 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229640AbhDHJdx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 05:33:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 127F5D6E;
        Thu,  8 Apr 2021 02:33:42 -0700 (PDT)
Received: from [10.57.43.11] (unknown [10.57.43.11])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 66BEA3F694;
        Thu,  8 Apr 2021 02:33:39 -0700 (PDT)
From:   Pierre <pierre.gondois@arm.com>
Subject: Re: [PATCH] sched/fair: use signed long when compute energy delta in
 eas
To:     Xuewen Yan <xuewen.yan94@gmail.com>,
        Dietmar Eggemann <Dietmar.Eggemann@arm.com>
Cc:     Quentin Perret <qperret@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Benjamin Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Ryan Y <xuewyan@foxmail.com>
References: <20210330052154.26861-1-xuewen.yan94@gmail.com>
 <YGLzQAvVqlrKb8AB@google.com> <34ce11ad-9c20-7ba7-90d8-4830725bf38a@arm.com>
 <CAB8ipk9JATYxJBnpVFfH_XHLqh=yHesbo73wx=Mm7t8mSqW_Gg@mail.gmail.com>
 <1ebddd33-4666-1e6e-7788-a3fe28c9e99c@arm.com>
 <CAB8ipk9+fdGMY6cYoHnicPUOdd+meJo+EaGaaVZTgoxQ84+Wiw@mail.gmail.com>
Message-ID: <d85a1db9-4680-1d31-d3e7-6a081f652c5e@arm.com>
Date:   Thu, 8 Apr 2021 10:33:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <CAB8ipk9+fdGMY6cYoHnicPUOdd+meJo+EaGaaVZTgoxQ84+Wiw@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
> Hi
>
> On Wed, Apr 7, 2021 at 10:11 PM Pierre <pierre.gondois@arm.com> wrote:
> >
> > Hi,
> > > I test the patch, but the overflow still exists.
> > > In the "sched/fair: Use pd_cache to speed up 
> find_energy_efficient_cpu()"
> > > I wonder why recompute the cpu util when cpu==dst_cpu in 
> compute_energy(),
> > > when the dst_cpu's util change, it also would cause the overflow.
> >
> > The patches aim to cache the energy values for the CPUs whose
> > utilization is not modified (so we don't have to compute it multiple
> > times). The values cached are the 'base values' of the CPUs, i.e. when
> > the task is not placed on the CPU. When (cpu==dst_cpu) in
> > compute_energy(), it means the energy values need to be updated instead
> > of using the cached ones.
> >
> well, is it better to use the task_util(p) + cache values ? but in
> this case, the cache
> values may need more parameters.

This patch-set is not significantly improving the execution time of 
feec(). The results we have so far are an improvement of 5-10% in 
execution time, with feec() being executed in < 10us. So the gain is not 
spectacular.

>
> > You are right, there is still a possibility to have a negative delta
> > with the patches at:
> > 
> https://gitlab.arm.com/linux-arm/linux-power/-/commits/eas/next/integration-20210129 
> <https://gitlab.arm.com/linux-arm/linux-power/-/commits/eas/next/integration-20210129>
> > Adding a check before subtracting the values, and bailing out in such
> > case would avoid this, such as at:
> > https://gitlab.arm.com/linux-arm/linux-pg/-/commits/feec_bail_out/ 
> <https://gitlab.arm.com/linux-arm/linux-pg/-/commits/feec_bail_out/>
> >
> In your patch, you bail out the case by "go to fail", that means you
> don't use eas in such
> case. However, in the actual scene, the case often occurr when select
> cpu for small task.
> As a result, the small task would not select cpu according to the eas,
> it may affect
> power consumption?
With this patch (bailing out), the percentage of feec() returning due to 
a negative delta I get are:
on a Juno-r2, with 2 big CPUs and 4 CPUs (capacity of 383), with a 
workload running during 5s with task having a period of 16 ms and:
  - 50 tasks at 1%:   0.14%
  - 30 tasks at 1%:   0.54%
  - 10 tasks at 1%: < 0.1%
  - 30 tasks at 5%: < 0.1%
  - 10 tasks at 5%: < 0.1%
It doesn't happen so often to me.If we bail out of feec(), the task will 
still have another opportunity in the next call. However I agree this 
can lead to a bad placement when this happens.
>
> > I think a similar modification should be done in your patch. Even though
> > this is a good idea to group the calls to compute_energy() to reduce the
> > chances of having updates of utilization values in between the
> > compute_energy() calls,
> > there is still a chance to have updates. I think it happened when I
> > applied your patch.
> >
> > About changing the delta(s) from 'unsigned long' to 'long', I am not
> > sure of the meaning of having a negative delta. I thing it would be
> > better to check and fail before it happens instead.
> >
> > Regards
> >



