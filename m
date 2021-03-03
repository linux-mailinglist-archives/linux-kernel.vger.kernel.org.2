Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A668A32BAA4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 21:58:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232776AbhCCLpq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 06:45:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352668AbhCCEAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 23:00:18 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12978C061797
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 19:59:38 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id e7so34902212lft.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 19:59:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bKpoC3J4YgBOA8Lql8xpYica6gBEcGbcCojRmFUiU44=;
        b=QJY+fdcAWaHs2JlBp+MFbv/MUjuLEpDoEM2RYzK/clfBJqqjFCpeD87HhHTnvb3Nwr
         usvG5G0Pritxbdrr8e5XahEZe13S85WimA82MjZbWMHjF2QCry/H5shU+MBvTCyDE0wY
         dYwScetM1lY0U10eFHy+84DJwxcMzGKIauKINBgPp318lIZ/2AunSsQdPv8TKhfAoKs9
         Una+VZNVkdxX2iPEAAgLBXq6BTjlrR6XNL7+qulk1tToP484csKnymL/IQTrlzZFP+Ri
         36zQ+6B+VGTQbXQk+L9jxqtB7nCcLpl7NghErrmNR/OcQB42WAcECHv/GPCXoYWwtaWE
         4P/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bKpoC3J4YgBOA8Lql8xpYica6gBEcGbcCojRmFUiU44=;
        b=ltfaiW3t9+ft/jCozZOD7JsnTiUu4qPIuLG/Zygq5hObanyWCV4RQpT47sDxVvLAjc
         xdXr5LDj3vwEOdELs5gjRHw+Cxj0nNs8zyCtM8h9E1Lio9SewdvxznGnwy7cKSmz8YPF
         V/ruSFCPEcjXrMmob2EgSMnbg/9VrbhOkW2eFvSuPUVpjKZ/A6Bfep0zchTmfUywF70I
         QoywDh0I2tYrCV/nUNcV1Ezq46BURE5B+itCAe6ATva1raBCeVe7F8DOUW2qkvjAWSWw
         mRy1sCC3NQMZbfM/+0FGQ1aZLE00Jvps0nsBLNd6avEnBt+8crIz7wPFh7AXQnWrUIWf
         KDxQ==
X-Gm-Message-State: AOAM5322bdYIyT3YKlfQO5bzQSuIdRb+8tC+eev2wTLTKHeOPgwyzOuR
        HXiCF8kVZUS90KtmkJlFp3AExo5qM3AU9ZKQNvnkGQ==
X-Google-Smtp-Source: ABdhPJx3IcTjNJQcxvnUo6pt+ZuB5f+NIxbcFmdB/KskCL7IZtwIqr8wPqsD8EI70PiGIwabnTAwBGagj9Ui9tVGeuk=
X-Received: by 2002:a19:ee19:: with SMTP id g25mr13603347lfb.83.1614743975183;
 Tue, 02 Mar 2021 19:59:35 -0800 (PST)
MIME-Version: 1.0
References: <7b7c4f41-b72e-840f-278a-320b9d97f887@oracle.com>
 <CALvZod5qODDSxqHqQ=_1roYVGVVvEvP3FnYMnAPQZgvUjxotsw@mail.gmail.com>
 <YDzaAWK41K4gD35V@dhcp22.suse.cz> <CALvZod4DqOkrJG+7dki=VfzHD1z9jD3XhObpk887zKy=kEk1tA@mail.gmail.com>
 <YD0OzXTmYm8M58Vo@dhcp22.suse.cz> <CALvZod789kHFAjWA8W7=r2=YxJ86uc4WhfgW1juN_YEMCApgqw@mail.gmail.com>
 <YD0jLTciK0M7P+Hc@dhcp22.suse.cz> <122e8c5d-60b8-52d9-c6a1-00cd61b2e1b6@oracle.com>
 <YD4I+VPr3UNt063H@dhcp22.suse.cz> <CALvZod7XHbjfoGGVH=h17u8-FruMaiPMWxXJz5JBmeJkNHBqNQ@mail.gmail.com>
 <YD5L1K3EWVWh1ULr@dhcp22.suse.cz> <06edda9a-dce9-accd-11a3-97f6d5243ed1@oracle.com>
In-Reply-To: <06edda9a-dce9-accd-11a3-97f6d5243ed1@oracle.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 2 Mar 2021 19:59:22 -0800
Message-ID: <CALvZod6VdegSbtWTrL8wnxhPmtrqC8mKULVR1VeND31m0KftVg@mail.gmail.com>
Subject: Re: possible deadlock in sk_clone_lock
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        syzbot <syzbot+506c8a2a115201881d45@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Eric Dumazet <edumazet@google.com>,
        Mina Almasry <almasrymina@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 2, 2021 at 1:19 PM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> On 3/2/21 6:29 AM, Michal Hocko wrote:
> > On Tue 02-03-21 06:11:51, Shakeel Butt wrote:
> >> On Tue, Mar 2, 2021 at 1:44 AM Michal Hocko <mhocko@suse.com> wrote:
> >>>
> >>> On Mon 01-03-21 17:16:29, Mike Kravetz wrote:
> >>>> On 3/1/21 9:23 AM, Michal Hocko wrote:
> >>>>> On Mon 01-03-21 08:39:22, Shakeel Butt wrote:
> >>>>>> On Mon, Mar 1, 2021 at 7:57 AM Michal Hocko <mhocko@suse.com> wrote:
> >>>>> [...]
> >>>>>>> Then how come this can ever be a problem? in_task() should exclude soft
> >>>>>>> irq context unless I am mistaken.
> >>>>>>>
> >>>>>>
> >>>>>> If I take the following example of syzbot's deadlock scenario then
> >>>>>> CPU1 is the one freeing the hugetlb pages. It is in the process
> >>>>>> context but has disabled softirqs (see __tcp_close()).
> >>>>>>
> >>>>>>         CPU0                    CPU1
> >>>>>>         ----                    ----
> >>>>>>    lock(hugetlb_lock);
> >>>>>>                                 local_irq_disable();
> >>>>>>                                 lock(slock-AF_INET);
> >>>>>>                                 lock(hugetlb_lock);
> >>>>>>    <Interrupt>
> >>>>>>      lock(slock-AF_INET);
> >>>>>>
> > [...]
> >>> Wouldn't something like this help? It is quite ugly but it would be
> >>> simple enough and backportable while we come up with a more rigorous
> >>> solution. What do you think?
> >>>
> >>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> >>> index 4bdb58ab14cb..c9a8b39f678d 100644
> >>> --- a/mm/hugetlb.c
> >>> +++ b/mm/hugetlb.c
> >>> @@ -1495,9 +1495,11 @@ static DECLARE_WORK(free_hpage_work, free_hpage_workfn);
> >>>  void free_huge_page(struct page *page)
> >>>  {
> >>>         /*
> >>> -        * Defer freeing if in non-task context to avoid hugetlb_lock deadlock.
> >>> +        * Defer freeing if in non-task context or when put_page is called
> >>> +        * with IRQ disabled (e.g from via TCP slock dependency chain) to
> >>> +        * avoid hugetlb_lock deadlock.
> >>>          */
> >>> -       if (!in_task()) {
> >>> +       if (!in_task() || irqs_disabled()) {
> >>
> >> Does irqs_disabled() also check softirqs?
> >
> > Nope it doesn't AFAICS. I was referring to the above lockdep splat which
> > claims irq disabled to be the trigger. But now that you are mentioning
> > that it would be better to replace in_task() along the way. We have
> > discussed that in another email thread and I was suggesting to use
> > in_atomic() which should catch also bh disabled situation. The big IF is
> > that this needs preempt count to be enabled unconditionally. There are
> > changes in the RCU tree heading that direction.
>
> I have not been following developments in preemption and the RCU tree.
> The comment for in_atomic() says:
>
> /*
>  * Are we running in atomic context?  WARNING: this macro cannot
>  * always detect atomic context; in particular, it cannot know about
>  * held spinlocks in non-preemptible kernels.  Thus it should not be
>  * used in the general case to determine whether sleeping is possible.
>  * Do not use in_atomic() in driver code.
>  */
>
> That does seem to be the case.  I verified in_atomic can detect softirq
> context even in non-preemptible kernels.  But, as the comment says it
> will not detect a held spinlock in non-preemptible kernels.  So, I think
> in_atomic would be better than the current check for !in_task.  That
> would handle this syzbot issue, but we could still have issues if the
> hugetlb put_page path is called while someone is holding a spinlock with
> all interrupts enabled.  Looks like there is no way to detect this
> today in non-preemptible kernels.  in_atomic does detect spinlocks held
> in preemptible kernels.
>
> I might suggest changing !in_task to in_atomic for now, and then work on
> a more robust solution.  I'm afraid such a robust solution will
> require considerable effort.  It would need to handle put_page being
> called in any context: hardirq, softirq, spinlock held ...  The
> put_page/free_huge_page path will need to offload (workqueue or
> something else) any processing that can possibly sleep.
>
> Is it worth making the in_atomic change now, or should we just start
> working on the more robust complete solution?

IMHO the change to in_atomic is beneficial because it will at least
fix this specific issue. No reason to keep the users of TCP TX
zerocopy from hugetlb pages broken for a more comprehensive solution.
