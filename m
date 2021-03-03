Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6A932C127
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:02:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1836773AbhCCSsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 13:48:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:39292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1577654AbhCCSA1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 13:00:27 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1A79964EF0;
        Wed,  3 Mar 2021 17:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614794386;
        bh=n2SVrZTA5iizXm4rhS7o1b4X+2vVSPfTGVJVkr5YBLM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=sq7u1H0vWaVD0UzqqiFca4MgalpAnzOphcg7PTiSaBLSNTtwlFK2T2wrT6xZ5+tvq
         IYfsX9SttJA0S7f8A3HSD+SCXLFZ5bDZdQ3H640tMhjZPRbsujYFroagJS3+RvRxba
         y9j05XHlg56mNaPyGhYwvq7XrByFiszgOLv/LgSB1vcbvU+dAsRvd1C8UzoKqxbIGU
         tqeRb04LTULgeiUkq7tX/7s4jrkA6xYei1xT8ivdSIwlRsabNCyR2xKuo+hu2erbvs
         IyIwVCYCt56JBNncjUQ03YxP/ySUwklANS3MZ8N3epDgF7kVZzhia/NlyFdvx0XFJ4
         DXGq67w9JEfyA==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id B4B5F35237A1; Wed,  3 Mar 2021 09:59:45 -0800 (PST)
Date:   Wed, 3 Mar 2021 09:59:45 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Shakeel Butt <shakeelb@google.com>,
        syzbot <syzbot+506c8a2a115201881d45@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Eric Dumazet <edumazet@google.com>,
        Mina Almasry <almasrymina@google.com>, tglx@linutronix.de,
        john.ogness@linutronix.de, urezki@gmail.com, ast@fb.com
Subject: Re: possible deadlock in sk_clone_lock
Message-ID: <20210303175945.GE2696@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <CALvZod4DqOkrJG+7dki=VfzHD1z9jD3XhObpk887zKy=kEk1tA@mail.gmail.com>
 <YD0OzXTmYm8M58Vo@dhcp22.suse.cz>
 <CALvZod789kHFAjWA8W7=r2=YxJ86uc4WhfgW1juN_YEMCApgqw@mail.gmail.com>
 <YD0jLTciK0M7P+Hc@dhcp22.suse.cz>
 <122e8c5d-60b8-52d9-c6a1-00cd61b2e1b6@oracle.com>
 <YD4I+VPr3UNt063H@dhcp22.suse.cz>
 <CALvZod7XHbjfoGGVH=h17u8-FruMaiPMWxXJz5JBmeJkNHBqNQ@mail.gmail.com>
 <YD5L1K3EWVWh1ULr@dhcp22.suse.cz>
 <06edda9a-dce9-accd-11a3-97f6d5243ed1@oracle.com>
 <YD9CzzypRyUPT0Jh@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YD9CzzypRyUPT0Jh@dhcp22.suse.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 03, 2021 at 09:03:27AM +0100, Michal Hocko wrote:
> [Add Paul]
> 
> On Tue 02-03-21 13:19:34, Mike Kravetz wrote:
> > On 3/2/21 6:29 AM, Michal Hocko wrote:
> > > On Tue 02-03-21 06:11:51, Shakeel Butt wrote:
> > >> On Tue, Mar 2, 2021 at 1:44 AM Michal Hocko <mhocko@suse.com> wrote:
> > >>>
> > >>> On Mon 01-03-21 17:16:29, Mike Kravetz wrote:
> > >>>> On 3/1/21 9:23 AM, Michal Hocko wrote:
> > >>>>> On Mon 01-03-21 08:39:22, Shakeel Butt wrote:
> > >>>>>> On Mon, Mar 1, 2021 at 7:57 AM Michal Hocko <mhocko@suse.com> wrote:
> > >>>>> [...]
> > >>>>>>> Then how come this can ever be a problem? in_task() should exclude soft
> > >>>>>>> irq context unless I am mistaken.
> > >>>>>>>
> > >>>>>>
> > >>>>>> If I take the following example of syzbot's deadlock scenario then
> > >>>>>> CPU1 is the one freeing the hugetlb pages. It is in the process
> > >>>>>> context but has disabled softirqs (see __tcp_close()).
> > >>>>>>
> > >>>>>>         CPU0                    CPU1
> > >>>>>>         ----                    ----
> > >>>>>>    lock(hugetlb_lock);
> > >>>>>>                                 local_irq_disable();
> > >>>>>>                                 lock(slock-AF_INET);
> > >>>>>>                                 lock(hugetlb_lock);
> > >>>>>>    <Interrupt>
> > >>>>>>      lock(slock-AF_INET);
> > >>>>>>
> > > [...]
> > >>> Wouldn't something like this help? It is quite ugly but it would be
> > >>> simple enough and backportable while we come up with a more rigorous
> > >>> solution. What do you think?
> > >>>
> > >>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > >>> index 4bdb58ab14cb..c9a8b39f678d 100644
> > >>> --- a/mm/hugetlb.c
> > >>> +++ b/mm/hugetlb.c
> > >>> @@ -1495,9 +1495,11 @@ static DECLARE_WORK(free_hpage_work, free_hpage_workfn);
> > >>>  void free_huge_page(struct page *page)
> > >>>  {
> > >>>         /*
> > >>> -        * Defer freeing if in non-task context to avoid hugetlb_lock deadlock.
> > >>> +        * Defer freeing if in non-task context or when put_page is called
> > >>> +        * with IRQ disabled (e.g from via TCP slock dependency chain) to
> > >>> +        * avoid hugetlb_lock deadlock.
> > >>>          */
> > >>> -       if (!in_task()) {
> > >>> +       if (!in_task() || irqs_disabled()) {
> > >>
> > >> Does irqs_disabled() also check softirqs?
> > > 
> > > Nope it doesn't AFAICS. I was referring to the above lockdep splat which
> > > claims irq disabled to be the trigger. But now that you are mentioning
> > > that it would be better to replace in_task() along the way. We have
> > > discussed that in another email thread and I was suggesting to use
> > > in_atomic() which should catch also bh disabled situation. The big IF is
> > > that this needs preempt count to be enabled unconditionally. There are
> > > changes in the RCU tree heading that direction.
> > 
> > I have not been following developments in preemption and the RCU tree. 
> > The comment for in_atomic() says:
> > 
> > /*
> >  * Are we running in atomic context?  WARNING: this macro cannot
> >  * always detect atomic context; in particular, it cannot know about
> >  * held spinlocks in non-preemptible kernels.  Thus it should not be
> >  * used in the general case to determine whether sleeping is possible.
> >  * Do not use in_atomic() in driver code.
> >  */
> > 
> > That does seem to be the case.  I verified in_atomic can detect softirq
> > context even in non-preemptible kernels.  But, as the comment says it
> > will not detect a held spinlock in non-preemptible kernels.  So, I think
> > in_atomic would be better than the current check for !in_task.  That
> > would handle this syzbot issue, but we could still have issues if the
> > hugetlb put_page path is called while someone is holding a spinlock with
> > all interrupts enabled.  Looks like there is no way to detect this
> > today in non-preemptible kernels.  in_atomic does detect spinlocks held
> > in preemptible kernels.
> 
> Paul what is the current plan with in_atomic to be usable for !PREEMPT
> configurations?

Ah, thank you for the reminder!  I have rebased that series on top of
v5.12-rc1 on -rcu branch tglx-pc.2021.03.03a.

The current state is that Linus is not convinced that this change is
worthwhile given that only RCU and printk() want it.  (BPF would use
it if it were available, but is willing to live without it, at least in
the short term.)

But maybe Linus will be convinced given your additional use case.
Here is hoping!

							Thanx, Paul
