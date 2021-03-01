Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4142F327DF6
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 13:14:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233518AbhCAMMz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 07:12:55 -0500
Received: from mx2.suse.de ([195.135.220.15]:36318 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232283AbhCAMMw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 07:12:52 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1614600723; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bA6FPiajLwsJsKRo9IkNEVfF/BrE7ZaCRdL4La1+kYI=;
        b=vUbJUkdNuEka6AAHYqQMFnJiePnYCZgXl0XA74JhC0EHtPLIU8pSgphmTJ4uKCVTqd2HbU
        cB6FWkXpJ4DRFRoPbvM31jnY8z0LfieQyi2oVxrO20I0Yu84Z57Q1iTvYFtczMeiIOetVU
        X5EbN1+6xIn/SNoLhuMWKlhM5QI7RwY=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6F222AE1B;
        Mon,  1 Mar 2021 12:12:03 +0000 (UTC)
Date:   Mon, 1 Mar 2021 13:11:57 +0100
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
Message-ID: <YDzaAWK41K4gD35V@dhcp22.suse.cz>
References: <000000000000f1c03b05bc43aadc@google.com>
 <CALvZod4vGj0P6WKncdKpGaVEb1Ui_fyHm+-hbCJTmbvo43CJ=A@mail.gmail.com>
 <7b7c4f41-b72e-840f-278a-320b9d97f887@oracle.com>
 <CALvZod5qODDSxqHqQ=_1roYVGVVvEvP3FnYMnAPQZgvUjxotsw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod5qODDSxqHqQ=_1roYVGVVvEvP3FnYMnAPQZgvUjxotsw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 26-02-21 16:00:30, Shakeel Butt wrote:
> On Fri, Feb 26, 2021 at 3:14 PM Mike Kravetz <mike.kravetz@oracle.com> wrote:
> >
> > Cc: Michal
> >
> > On 2/26/21 2:44 PM, Shakeel Butt wrote:
> > > On Fri, Feb 26, 2021 at 2:09 PM syzbot
> > > <syzbot+506c8a2a115201881d45@syzkaller.appspotmail.com> wrote:
> > <snip>
> > >> other info that might help us debug this:
> > >>
> > >>  Possible interrupt unsafe locking scenario:
> > >>
> > >>        CPU0                    CPU1
> > >>        ----                    ----
> > >>   lock(hugetlb_lock);
> > >>                                local_irq_disable();
> > >>                                lock(slock-AF_INET);
> > >>                                lock(hugetlb_lock);
> > >>   <Interrupt>
> > >>     lock(slock-AF_INET);
> > >>
> > >>  *** DEADLOCK ***
> > >
> > > This has been reproduced on 4.19 stable kernel as well [1] and there
> > > is a reproducer as well.
> > >
> > > It seems like sendmsg(MSG_ZEROCOPY) from a buffer backed by hugetlb. I
> > > wonder if we just need to make hugetlb_lock softirq-safe.
> > >
> > > [1] https://syzkaller.appspot.com/bug?extid=6383ce4b0b8ec575ad93
> >
> > Thanks Shakeel,
> >
> > Commit c77c0a8ac4c5 ("mm/hugetlb: defer freeing of huge pages if in non-task
> > context") attempted to address this issue.  It uses a work queue to
> > acquire hugetlb_lock if the caller is !in_task().
> >
> > In another recent thread, there was the suggestion to change the
> > !in_task to in_atomic.
> >
> > I need to do some research on the subtle differences between in_task,
> > in_atomic, etc.  TBH, I 'thought' !in_task would prevent the issue
> > reported here.  But, that obviously is not the case.
> 
> I think the freeing is happening in the process context in this report
> but it is creating the lock chain from softirq-safe slock to
> irq-unsafe hugetlb_lock. So, two solutions I can think of are: (1)
> always defer the freeing of hugetlb pages to a work queue or (2) make
> hugetlb_lock softirq-safe.

There is __do_softirq so this should be in the soft IRQ context no?
Is this really reproducible with kernels which have c77c0a8ac4c5
applied?

Btw. making hugetlb lock irq safe has been already discussed and it
seems to be much harder than expected as some heavy operations are done
under the lock. This is really bad. Postponing the whole freeing
operation into a worker context is certainly possible but I would
consider it rather unfortunate. We would have to add some sync mechanism
to wait for hugetlb pages in flight to prevent from external
observability to the userspace. E.g. when shrinking the pool.
-- 
Michal Hocko
SUSE Labs
