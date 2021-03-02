Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D15BB32A88D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 18:52:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351791AbhCBRtl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 12:49:41 -0500
Received: from mx2.suse.de ([195.135.220.15]:51960 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1574223AbhCBPO2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 10:14:28 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1614695381; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wUWlX6XFsup9fg8TMDk+EZFrxnEmvEB1W0zT6P/g0lg=;
        b=WGJFddT1h/cWi7GZzbQf1RzmgR2/OafQDJYF9QBnP67kgRGzbN7Ai9A/qw1mpw+Gh7cw8u
        Ywawb8gccT4mhwEPhreQwAcEvcCi4nvu+3TvLEysAXCvNAhzx82lrVn+JUf+2a3RDzxMnI
        kqETNGHJkt6NOEX1/ZuvQPNZ13WiN4M=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 04352ADDD;
        Tue,  2 Mar 2021 14:29:41 +0000 (UTC)
Date:   Tue, 2 Mar 2021 15:29:40 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        syzbot <syzbot+506c8a2a115201881d45@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Eric Dumazet <edumazet@google.com>,
        Mina Almasry <almasrymina@google.com>
Subject: Re: possible deadlock in sk_clone_lock
Message-ID: <YD5L1K3EWVWh1ULr@dhcp22.suse.cz>
References: <7b7c4f41-b72e-840f-278a-320b9d97f887@oracle.com>
 <CALvZod5qODDSxqHqQ=_1roYVGVVvEvP3FnYMnAPQZgvUjxotsw@mail.gmail.com>
 <YDzaAWK41K4gD35V@dhcp22.suse.cz>
 <CALvZod4DqOkrJG+7dki=VfzHD1z9jD3XhObpk887zKy=kEk1tA@mail.gmail.com>
 <YD0OzXTmYm8M58Vo@dhcp22.suse.cz>
 <CALvZod789kHFAjWA8W7=r2=YxJ86uc4WhfgW1juN_YEMCApgqw@mail.gmail.com>
 <YD0jLTciK0M7P+Hc@dhcp22.suse.cz>
 <122e8c5d-60b8-52d9-c6a1-00cd61b2e1b6@oracle.com>
 <YD4I+VPr3UNt063H@dhcp22.suse.cz>
 <CALvZod7XHbjfoGGVH=h17u8-FruMaiPMWxXJz5JBmeJkNHBqNQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod7XHbjfoGGVH=h17u8-FruMaiPMWxXJz5JBmeJkNHBqNQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 02-03-21 06:11:51, Shakeel Butt wrote:
> On Tue, Mar 2, 2021 at 1:44 AM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Mon 01-03-21 17:16:29, Mike Kravetz wrote:
> > > On 3/1/21 9:23 AM, Michal Hocko wrote:
> > > > On Mon 01-03-21 08:39:22, Shakeel Butt wrote:
> > > >> On Mon, Mar 1, 2021 at 7:57 AM Michal Hocko <mhocko@suse.com> wrote:
> > > > [...]
> > > >>> Then how come this can ever be a problem? in_task() should exclude soft
> > > >>> irq context unless I am mistaken.
> > > >>>
> > > >>
> > > >> If I take the following example of syzbot's deadlock scenario then
> > > >> CPU1 is the one freeing the hugetlb pages. It is in the process
> > > >> context but has disabled softirqs (see __tcp_close()).
> > > >>
> > > >>         CPU0                    CPU1
> > > >>         ----                    ----
> > > >>    lock(hugetlb_lock);
> > > >>                                 local_irq_disable();
> > > >>                                 lock(slock-AF_INET);
> > > >>                                 lock(hugetlb_lock);
> > > >>    <Interrupt>
> > > >>      lock(slock-AF_INET);
> > > >>
[...]
> > Wouldn't something like this help? It is quite ugly but it would be
> > simple enough and backportable while we come up with a more rigorous
> > solution. What do you think?
> >
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index 4bdb58ab14cb..c9a8b39f678d 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -1495,9 +1495,11 @@ static DECLARE_WORK(free_hpage_work, free_hpage_workfn);
> >  void free_huge_page(struct page *page)
> >  {
> >         /*
> > -        * Defer freeing if in non-task context to avoid hugetlb_lock deadlock.
> > +        * Defer freeing if in non-task context or when put_page is called
> > +        * with IRQ disabled (e.g from via TCP slock dependency chain) to
> > +        * avoid hugetlb_lock deadlock.
> >          */
> > -       if (!in_task()) {
> > +       if (!in_task() || irqs_disabled()) {
> 
> Does irqs_disabled() also check softirqs?

Nope it doesn't AFAICS. I was referring to the above lockdep splat which
claims irq disabled to be the trigger. But now that you are mentioning
that it would be better to replace in_task() along the way. We have
discussed that in another email thread and I was suggesting to use
in_atomic() which should catch also bh disabled situation. The big IF is
that this needs preempt count to be enabled unconditionally. There are
changes in the RCU tree heading that direction.
-- 
Michal Hocko
SUSE Labs
