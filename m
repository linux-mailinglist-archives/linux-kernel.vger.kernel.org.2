Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15ECE36DB3B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 17:24:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235271AbhD1PKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 11:10:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:60222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229920AbhD1PKn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 11:10:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 93A8D613F1;
        Wed, 28 Apr 2021 15:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619622598;
        bh=zfZBsF0nlx3jPpL8Pj7qRtfJrcsoEwL61cXgYA0V1HI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bFbgW35ShYJfLrxmGPS8gcSH7tupL6CIXpbQP2F0Vx98SAR7/AK/AAhMkbTdBPHTn
         qpMnX9iAzTM1fQF6a5f194/q4EnmEwf1lJ9pDQEG08nIpBudo628+9SopwI5Qu/YtB
         AfIK4L1q26qntnlvZpYeIUWRatAYm8Uqfs8Y6AtfkSw5tokTbuO5AXtK1zXQskW8T/
         46lJ1O1z3ENQZSMtXqe3/cxL9L6jRtz3CQU5wAqvKa9D52KbHmBPoP8LvpZgiOQ6y1
         Vi+CYzggC2W8n1+rCkgxebcenVC6xis3tXpXMN4craPpSYJBBBbaxMXi9i/WgJ+HMT
         42HYqSHZWPAjA==
Date:   Wed, 28 Apr 2021 17:09:52 +0200
From:   Alexey Gladkov <legion@kernel.org>
To:     Oliver Sang <oliver.sang@intel.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        0day robot <lkp@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        "Huang, Ying" <ying.huang@intel.com>,
        Feng Tang <feng.tang@intel.com>, zhengjun.xing@intel.com,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Jann Horn <jannh@google.com>, Jens Axboe <axboe@kernel.dk>,
        Kees Cook <keescook@chromium.org>,
        Oleg Nesterov <oleg@redhat.com>
Subject: Re: 08ed4efad6: stress-ng.sigsegv.ops_per_sec -41.9% regression
Message-ID: <20210428150952.mdnvl7i4kimgwswh@example.org>
References: <7abe5ab608c61fc2363ba458bea21cf9a4a64588.1617814298.git.gladkov.alexey@gmail.com>
 <20210408083026.GE1696@xsang-OptiPlex-9020>
 <CAHk-=wigPx+MMQMQ-7EA0pq5_5+kMCNV4qFsOss-WwdCSQmb-w@mail.gmail.com>
 <m1im4wmx9g.fsf@fess.ebiederm.org>
 <20210423024722.GA13968@xsang-OptiPlex-9020>
 <20210423074431.7ob6aqasome2zjbk@example.org>
 <20210428143008.GA19916@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210428143008.GA19916@xsang-OptiPlex-9020>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 28, 2021 at 10:36:40PM +0800, Oliver Sang wrote:
> hi, Alexey Gladkov,
> 
> On Fri, Apr 23, 2021 at 09:44:31AM +0200, Alexey Gladkov wrote:
> > On Fri, Apr 23, 2021 at 10:47:22AM +0800, Oliver Sang wrote:
> > > hi, Eric,
> > > 
> > > On Thu, Apr 08, 2021 at 01:44:43PM -0500, Eric W. Biederman wrote:
> > > > Linus Torvalds <torvalds@linux-foundation.org> writes:
> > > > 
> > > > > On Thu, Apr 8, 2021 at 1:32 AM kernel test robot <oliver.sang@intel.com> wrote:
> > > > >>
> > > > >> FYI, we noticed a -41.9% regression of stress-ng.sigsegv.ops_per_sec due to commit
> > > > >> 08ed4efad684 ("[PATCH v10 6/9] Reimplement RLIMIT_SIGPENDING on top of ucounts")
> > > > >
> > > > > Ouch.
> > > > 
> > > > We were cautiously optimistic when no test problems showed up from
> > > > the last posting that there was nothing to look at here.
> > > > 
> > > > Unfortunately it looks like the bots just missed the last posting. 
> > > 
> > > this report is upon v10. do you have newer version which hope bot test?
> > 
> > Yes. I posted a new version of this patch set. I would be very grateful if
> > you could test it.
> > 
> > https://lore.kernel.org/lkml/cover.1619094428.git.legion@kernel.org/
> >
> 
> we tested this v11 version, and found the regression reduced to about 1.6%.
> please be noted, according to our previous experience, the stress-ng is
> kind of sensitive testsuite, so we normally wouldn't report <3% regression.

Thank you very much for testing and good news for me !!!

Do you have a place where its possible to see if the patch has been tested?
I mean test passed or not.

> =========================================================================================
> class/compiler/cpufreq_governor/disk/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime/ucode:
>   interrupt/gcc-9/performance/1HDD/x86_64-rhel-8.3/100%/debian-10.4-x86_64-20200603.cgz/lkp-ivb-2ep1/sigsegv/stress-ng/60s/0x42e
> 
> commit:
>   00a58a6af1c4 ("Reimplement RLIMIT_MSGQUEUE on top of ucounts")
>   8932738fc10c ("Reimplement RLIMIT_SIGPENDING on top of ucounts")
> 
> 00a58a6af1c473c5 8932738fc10c4398521892adfe6
> ---------------- ---------------------------
>          %stddev     %change         %stddev
>              \          |                \
>  4.745e+08            -1.6%  4.669e+08        stress-ng.sigsegv.ops
>    7908964            -1.6%    7781343        stress-ng.sigsegv.ops_per_sec
> 
> Below is some data of results from your new branch and base.
> b3ad8e1fa3fd8 ucounts: Set ucount_max to the largest positive value the type can hold  7783421.61 7794441.59 7775793.52 7773683.6 7760744.1 7757720.33
> 8932738fc10c4 Reimplement RLIMIT_SIGPENDING on top of ucounts                          7755985.06 7780646.72 7783944.12 7809090.98 7798193.32 7760202.59
> 00a58a6af1c47 Reimplement RLIMIT_MSGQUEUE on top of ucounts                            7940474.72 7912442.26 7879195.61 7869803.63 7912693.69 7939175.48
> e75074781f173 selftests/resctrl: Change a few printed messages                         7660254.5 7676124.45 7745330.79 7736754.88 7716834.93 7660143.13
> 87f1c20e2effd Documentation: kselftest: fix path to test module files                  7729609.16 7726906.92 7760819.26
> 06bd03a57f8c2 selftests/resctrl: Fix MBA/MBM results reporting format                  7692866.06 7730606.11 7681414.48
> a38fd87484648 Linux 5.12-rc2                                                           7724932.06 
> 
>  
> > > please be noted, sorry to say, due to various reasons, it will be a
> > > big challenge for us to capture each version of a patch set.
> > > 
> > > e.g. we didn't make out a similar performance regression for
> > > v8/v9 version of this one..
> > > 
> > > > 
> > > > So it seems we are finally pretty much at correct code in need
> > > > of performance tuning.
> > > > 
> > > > > I *think* this test may be testing "send so many signals that it
> > > > > triggers the signal queue overflow case".
> > > > >
> > > > > And I *think* that the performance degradation may be due to lots of
> > > > > unnecessary allocations, because ity looks like that commit changes
> > > > > __sigqueue_alloc() to do
> > > > >
> > > > >         struct sigqueue *q = kmem_cache_alloc(sigqueue_cachep, flags);
> > > > >
> > > > > *before* checking the signal limit, and then if the signal limit was
> > > > > exceeded, it will just be free'd instead.
> > > > >
> > > > > The old code would check the signal count against RLIMIT_SIGPENDING
> > > > > *first*, and if there were m ore pending signals then it wouldn't do
> > > > > anything at all (including not incrementing that expensive atomic
> > > > > count).
> > > > 
> > > > This is an interesting test in a lot of ways as it is testing the
> > > > synchronous signal delivery path caused by an exception.  The test
> > > > is either executing *ptr = 0 (where ptr points to a read-only page)
> > > > or it executes an x86 instruction that is excessively long.
> > > > 
> > > > I have found the code but I haven't figured out how it is being
> > > > called yet.  The core loop is just:
> > > > 	for(;;) {
> > > > 		sigaction(SIGSEGV, &action, NULL);
> > > > 		sigaction(SIGILL, &action, NULL);
> > > > 		sigaction(SIGBUS, &action, NULL);
> > > > 
> > > > 		ret = sigsetjmp(jmp_env, 1);
> > > > 		if (done())
> > > >                 	break;
> > > > 		if (ret) {
> > > >                 	/* verify signal */
> > > >                 } else {
> > > >                 	*ptr = 0;
> > > >                 }
> > > > 	}
> > > > 
> > > > Code like that fundamentally can not be multi-threaded.  So the only way
> > > > the sigpending limit is being hit is if there are more processes running
> > > > that code simultaneously than the size of the limit.
> > > > 
> > > > Further it looks like stress-ng pushes RLIMIT_SIGPENDING as high as it
> > > > will go before the test starts.
> > > > 
> > > > 
> > > > > Also, the old code was very careful to only do the "get_user()" for
> > > > > the *first* signal it added to the queue, and do the "put_user()" for
> > > > > when removing the last signal. Exactly because those atomics are very
> > > > > expensive.
> > > > >
> > > > > The new code just does a lot of these atomics unconditionally.
> > > > 
> > > > Yes. That seems a likely culprit.
> > > > 
> > > > > I dunno. The profile data in there is a bit hard to read, but there's
> > > > > a lot more cachee misses, and a *lot* of node crossers:
> > > > >
> > > > >>    5961544          +190.4%   17314361        perf-stat.i.cache-misses
> > > > >>   22107466          +119.2%   48457656        perf-stat.i.cache-references
> > > > >>     163292 ą  3%   +4582.0%    7645410        perf-stat.i.node-load-misses
> > > > >>     227388 ą  2%   +3708.8%    8660824        perf-stat.i.node-loads
> > > > >
> > > > > and (probably as a result) average instruction costs have gone up enormously:
> > > > >
> > > > >>       3.47           +66.8%       5.79        perf-stat.overall.cpi
> > > > >>      22849           -65.6%       7866        perf-stat.overall.cycles-between-cache-misses
> > > > >
> > > > > and it does seem to be at least partly about "put_ucounts()":
> > > > >
> > > > >>       0.00            +4.5        4.46        perf-profile.calltrace.cycles-pp.put_ucounts.__sigqueue_free.get_signal.arch_do_signal_or_restart.exit_to_user_mode_prepare
> > > > >
> > > > > and a lot of "get_ucounts()".
> > > > >
> > > > > But it may also be that the new "get sigpending" is just *so* much
> > > > > more expensive than it used to be.
> > > > 
> > > > That too is possible.
> > > > 
> > > > That node-load-misses number does look like something is bouncing back
> > > > and forth between the nodes a lot more.  So I suspect stress-ng is
> > > > running multiple copies of the sigsegv test in different processes at
> > > > once.
> > > > 
> > > > 
> > > > 
> > > > That really suggests cache line ping pong from get_ucounts and
> > > > incrementing sigpending.
> > > > 
> > > > It surprises me that obtaining the cache lines exclusively is
> > > > the dominant cost on this code path but obtaining two cache lines
> > > > exclusively instead of one cache cache line exclusively is consistent
> > > > with a causing the exception delivery to take nearly twice as long.
> > > > 
> > > > For the optimization we only care about the leaf count so with a little
> > > > care we can restore the optimization.  So that is probably the thing
> > > > to do here.  The fewer changes to worry about the less likely to find
> > > > surprises.
> > > > 
> > > > 
> > > > 
> > > > That said for this specific case there is a lot of potential room for
> > > > improvement.  As this is a per thread signal the code update sigpending
> > > > in commit_cred and never worry about needing to pin the struct
> > > > user_struct or struct ucounts.  As this is a synchronous signal we could
> > > > skip the sigpending increment, skip the signal queue entirely, and
> > > > deliver the signal to user-space immediately.  The removal of all cache
> > > > ping pongs might make it worth it.
> > > > 
> > > > There is also Thomas Gleixner's recent optimization to cache one
> > > > sigqueue entry per task to give more predictable behavior.  That
> > > > would remove the cost of the allocation.
> > > > 
> > > > Eric
> > > 
> > 
> > -- 
> > Rgrds, legion
> > 
> 

-- 
Rgrds, legion

