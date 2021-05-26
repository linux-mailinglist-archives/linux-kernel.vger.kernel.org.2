Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6FD039222F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 23:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233969AbhEZVj4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 26 May 2021 17:39:56 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:3953 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233550AbhEZVjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 17:39:54 -0400
Received: from dggems702-chm.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Fr44G6SSFz80wY;
        Thu, 27 May 2021 05:35:26 +0800 (CST)
Received: from dggpeml100024.china.huawei.com (7.185.36.115) by
 dggems702-chm.china.huawei.com (10.3.19.179) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 27 May 2021 05:38:19 +0800
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggpeml100024.china.huawei.com (7.185.36.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Thu, 27 May 2021 05:38:19 +0800
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.2176.012;
 Thu, 27 May 2021 05:38:19 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "bsegall@google.com" <bsegall@google.com>,
        "mgorman@suse.de" <mgorman@suse.de>,
        "valentin.schneider@arm.com" <valentin.schneider@arm.com>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "bristot@redhat.com" <bristot@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "guodong.xu@linaro.org" <guodong.xu@linaro.org>,
        yangyicong <yangyicong@huawei.com>,
        tangchengchang <tangchengchang@huawei.com>,
        Linuxarm <linuxarm@huawei.com>
Subject: RE: [PATCH] sched: fair: don't depend on wake_wide if waker and wakee
 are already in same LLC
Thread-Topic: [PATCH] sched: fair: don't depend on wake_wide if waker and
 wakee are already in same LLC
Thread-Index: AQHXUhAXdUizMfoReUmU6BSpTsz4hqr1J2iAgAEbn9A=
Date:   Wed, 26 May 2021 21:38:19 +0000
Message-ID: <7dd00a98d6454d5e92a7d9b936d1aa1c@hisilicon.com>
References: <20210526091057.1800-1-song.bao.hua@hisilicon.com>
 <YK474+4xpYlAha+2@hirez.programming.kicks-ass.net>
In-Reply-To: <YK474+4xpYlAha+2@hirez.programming.kicks-ass.net>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.202.79]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Peter Zijlstra [mailto:peterz@infradead.org]
> Sent: Thursday, May 27, 2021 12:16 AM
> To: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>
> Cc: vincent.guittot@linaro.org; mingo@redhat.com; dietmar.eggemann@arm.com;
> rostedt@goodmis.org; bsegall@google.com; mgorman@suse.de;
> valentin.schneider@arm.com; juri.lelli@redhat.com; bristot@redhat.com;
> linux-kernel@vger.kernel.org; guodong.xu@linaro.org; yangyicong
> <yangyicong@huawei.com>; tangchengchang <tangchengchang@huawei.com>;
> Linuxarm <linuxarm@huawei.com>
> Subject: Re: [PATCH] sched: fair: don't depend on wake_wide if waker and wakee
> are already in same LLC
> 
> 
> $subject is weird; sched/fair: is the right tag, and then start with a
> capital letter.
> 
> On Wed, May 26, 2021 at 09:10:57PM +1200, Barry Song wrote:
> > when waker and wakee are already in the same LLC, it is pointless to worry
> > about the competition caused by pulling wakee to waker's LLC domain.
> 
> But there's more than LLC.

I suppose other concerns might be about the "idle" and "load" of
waker's cpu and wakee's prev_cpu. Here even though we disable
wake_wide(), wake_affine() still has chance to select wakee's
prev_cpu rather than pulling to waker. So disabling wake_wide()
doesn't mean we will 100% pull.

static int wake_affine(struct sched_domain *sd, struct task_struct *p,
		       int this_cpu, int prev_cpu, int sync)
{
	int target = nr_cpumask_bits;

	if (sched_feat(WA_IDLE))
		target = wake_affine_idle(this_cpu, prev_cpu, sync);

	if (sched_feat(WA_WEIGHT) && target == nr_cpumask_bits)
		target = wake_affine_weight(sd, p, this_cpu, prev_cpu, sync);

	if (target == nr_cpumask_bits)
		return prev_cpu;

	..
	return target;
}

Furthermore, select_idle_sibling() can also pick wakee's prev_cpu
if it is idle:

static int select_idle_sibling(struct task_struct *p, int prev, int target)
{
	...

	/*
	 * If the previous CPU is cache affine and idle, don't be stupid:
	 */
	if (prev != target && cpus_share_cache(prev, target) &&
	    (available_idle_cpu(prev) || sched_idle_cpu(prev)) &&
	    asym_fits_capacity(task_util, prev))
		return prev;
	...
}

Except those, could you please give me some clue about what else
you have concerns on?

> 
> > Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
> > ---
> >  kernel/sched/fair.c | 10 +++++++++-
> >  1 file changed, 9 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 3248e24a90b0..cfb1bd47acc3 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -6795,7 +6795,15 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu,
> int wake_flags)
> >  			new_cpu = prev_cpu;
> >  		}
> >
> > -		want_affine = !wake_wide(p) && cpumask_test_cpu(cpu, p->cpus_ptr);
> > +		/*
> > +		 * we use wake_wide to make smarter pull and avoid cruel
> > +		 * competition because of jam-packed tasks in waker's LLC
> > +		 * domain. But if waker and wakee have been already in
> > +		 * same LLC domain, it seems it is pointless to depend
> > +		 * on wake_wide
> > +		 */
> > +		want_affine = (cpus_share_cache(cpu, prev_cpu) || !wake_wide(p)) &&
> > +				cpumask_test_cpu(cpu, p->cpus_ptr);
> >  	}
> 
> And no supportive numbers...

Sorry for the confusion.

I actually put some supportive numbers at the below thread which
derived this patch:
https://lore.kernel.org/lkml/bbc339cef87e4009b6d56ee37e202daf@hisilicon.com/

when I tried to give Dietmar some pgbench data in that thread,
I found in kunpeng920, while software ran in one die/numa with
24cores sharing LLC, disabling wake_wide() brought the best
pgbench result.

                llc_as_factor          don't_use_wake_wide
Hmean     1     10869.27 (   0.00%)    10723.08 *  -1.34%*
Hmean     8     19580.59 (   0.00%)    19469.34 *  -0.57%*
Hmean     12    29643.56 (   0.00%)    29520.16 *  -0.42%*
Hmean     24    43194.47 (   0.00%)    43774.78 *   1.34%*
Hmean     32    40163.23 (   0.00%)    40742.93 *   1.44%*
Hmean     48    42249.29 (   0.00%)    48329.00 *  14.39%*

The test was done by https://github.com/gormanm/mmtests
and
./run-mmtests.sh --config ./configs/config-db-pgbench-timed-ro-medium test_tag

Commit "sched: Implement smarter wake-affine logic"
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=62470419
says pgbench can improve by wake_wide(), but I've actually
seen the opposite result while waker and wakee are already
in one LLC.

Not quite sure if it is specific to kunpeng920, perhaps
I need to run the same test on some x86 machines.

Thanks
Barry
