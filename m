Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B4F33282E2
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 16:58:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237482AbhCAP5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 10:57:50 -0500
Received: from mx2.suse.de ([195.135.220.15]:33604 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237445AbhCAP5t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 10:57:49 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1614614222; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jEMLd+8QwG0qM6Ywh0J3rChAMkV49Kqjdwq8Zo3TTnc=;
        b=YWq5yRLYt45aCcw4QbD8nB6AbXIPl6KxmjoPhKZDaMcdVnvqBxwDAQgddKSz/LD5VqWYvi
        MICsxh1rObrONr37HbMxKUjrsC4BzAWovbHGGdIkbXY5y2H36PKpA6RMda8D35iD+AszTs
        N3lSjtmaOyTCu08PpwblQwl+37TTT1k=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 91E3AAFFB;
        Mon,  1 Mar 2021 15:57:02 +0000 (UTC)
Date:   Mon, 1 Mar 2021 16:57:01 +0100
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
Message-ID: <YD0OzXTmYm8M58Vo@dhcp22.suse.cz>
References: <000000000000f1c03b05bc43aadc@google.com>
 <CALvZod4vGj0P6WKncdKpGaVEb1Ui_fyHm+-hbCJTmbvo43CJ=A@mail.gmail.com>
 <7b7c4f41-b72e-840f-278a-320b9d97f887@oracle.com>
 <CALvZod5qODDSxqHqQ=_1roYVGVVvEvP3FnYMnAPQZgvUjxotsw@mail.gmail.com>
 <YDzaAWK41K4gD35V@dhcp22.suse.cz>
 <CALvZod4DqOkrJG+7dki=VfzHD1z9jD3XhObpk887zKy=kEk1tA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod4DqOkrJG+7dki=VfzHD1z9jD3XhObpk887zKy=kEk1tA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 01-03-21 07:10:11, Shakeel Butt wrote:
> On Mon, Mar 1, 2021 at 4:12 AM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Fri 26-02-21 16:00:30, Shakeel Butt wrote:
> > > On Fri, Feb 26, 2021 at 3:14 PM Mike Kravetz <mike.kravetz@oracle.com> wrote:
> > > >
> > > > Cc: Michal
> > > >
> > > > On 2/26/21 2:44 PM, Shakeel Butt wrote:
> > > > > On Fri, Feb 26, 2021 at 2:09 PM syzbot
> > > > > <syzbot+506c8a2a115201881d45@syzkaller.appspotmail.com> wrote:
> > > > <snip>
> > > > >> other info that might help us debug this:
> > > > >>
> > > > >>  Possible interrupt unsafe locking scenario:
> > > > >>
> > > > >>        CPU0                    CPU1
> > > > >>        ----                    ----
> > > > >>   lock(hugetlb_lock);
> > > > >>                                local_irq_disable();
> > > > >>                                lock(slock-AF_INET);
> > > > >>                                lock(hugetlb_lock);
> > > > >>   <Interrupt>
> > > > >>     lock(slock-AF_INET);
> > > > >>
> > > > >>  *** DEADLOCK ***
> > > > >
> > > > > This has been reproduced on 4.19 stable kernel as well [1] and there
> > > > > is a reproducer as well.
> > > > >
> > > > > It seems like sendmsg(MSG_ZEROCOPY) from a buffer backed by hugetlb. I
> > > > > wonder if we just need to make hugetlb_lock softirq-safe.
> > > > >
> > > > > [1] https://syzkaller.appspot.com/bug?extid=6383ce4b0b8ec575ad93
> > > >
> > > > Thanks Shakeel,
> > > >
> > > > Commit c77c0a8ac4c5 ("mm/hugetlb: defer freeing of huge pages if in non-task
> > > > context") attempted to address this issue.  It uses a work queue to
> > > > acquire hugetlb_lock if the caller is !in_task().
> > > >
> > > > In another recent thread, there was the suggestion to change the
> > > > !in_task to in_atomic.
> > > >
> > > > I need to do some research on the subtle differences between in_task,
> > > > in_atomic, etc.  TBH, I 'thought' !in_task would prevent the issue
> > > > reported here.  But, that obviously is not the case.
> > >
> > > I think the freeing is happening in the process context in this report
> > > but it is creating the lock chain from softirq-safe slock to
> > > irq-unsafe hugetlb_lock. So, two solutions I can think of are: (1)
> > > always defer the freeing of hugetlb pages to a work queue or (2) make
> > > hugetlb_lock softirq-safe.
> >
> > There is __do_softirq so this should be in the soft IRQ context no?
> > Is this really reproducible with kernels which have c77c0a8ac4c5
> > applied?
> 
> Yes this is softirq context and syzbot has reproduced this on
> linux-next 20210224.

Then how come this can ever be a problem? in_task() should exclude soft
irq context unless I am mistaken.
 
> > Btw. making hugetlb lock irq safe has been already discussed and it
> > seems to be much harder than expected as some heavy operations are done
> > under the lock. This is really bad.
> 
> What about just softirq-safe i.e. spin_[un]lock_bh()? Will it still be that bad?

This would be a similar problem to the irq variant. It would just result
in soft irq being delayed potentially.

> > Postponing the whole freeing
> > operation into a worker context is certainly possible but I would
> > consider it rather unfortunate. We would have to add some sync mechanism
> > to wait for hugetlb pages in flight to prevent from external
> > observability to the userspace. E.g. when shrinking the pool.
> 
> I think in practice recycling of hugetlb pages is a rare event, so we
> might get away without the sync mechanism. How about start postponing
> the freeing without sync mechanism and add it later if there are any
> user reports complaining?

I think this should be a last resort. Maybe we can come up with
something better. E.g. break down the hugetlb_lock and use something
different for expensive operations.
-- 
Michal Hocko
SUSE Labs
