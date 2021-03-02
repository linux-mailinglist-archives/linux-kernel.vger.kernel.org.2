Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCFE632A3F2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 16:22:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349508AbhCBKEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 05:04:24 -0500
Received: from mx2.suse.de ([195.135.220.15]:42508 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1577603AbhCBJp2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 04:45:28 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1614678281; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=K5EC/lW+d5RI0Djt8pb1SFdBoprOPWC87EKxv3dKexc=;
        b=FF9HEh/kUpLfyFACCKNp8Yt9tc44VdTh0x86sIwgkdhBFMqYAqajJ0eaFecdsdsKuxmI/z
        29L3Kr251SxRq4VVQI/TY13Mh0h6ut/R6Qo+XisFznWiU24QsPUYND7QdsrVHsv2dXwLMg
        4YVQjgwf1/SoXkLF0LjellKxfIa/V74=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 45906ABF4;
        Tue,  2 Mar 2021 09:44:41 +0000 (UTC)
Date:   Tue, 2 Mar 2021 10:44:25 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Shakeel Butt <shakeelb@google.com>,
        syzbot <syzbot+506c8a2a115201881d45@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Eric Dumazet <edumazet@google.com>,
        Mina Almasry <almasrymina@google.com>
Subject: Re: possible deadlock in sk_clone_lock
Message-ID: <YD4I+VPr3UNt063H@dhcp22.suse.cz>
References: <000000000000f1c03b05bc43aadc@google.com>
 <CALvZod4vGj0P6WKncdKpGaVEb1Ui_fyHm+-hbCJTmbvo43CJ=A@mail.gmail.com>
 <7b7c4f41-b72e-840f-278a-320b9d97f887@oracle.com>
 <CALvZod5qODDSxqHqQ=_1roYVGVVvEvP3FnYMnAPQZgvUjxotsw@mail.gmail.com>
 <YDzaAWK41K4gD35V@dhcp22.suse.cz>
 <CALvZod4DqOkrJG+7dki=VfzHD1z9jD3XhObpk887zKy=kEk1tA@mail.gmail.com>
 <YD0OzXTmYm8M58Vo@dhcp22.suse.cz>
 <CALvZod789kHFAjWA8W7=r2=YxJ86uc4WhfgW1juN_YEMCApgqw@mail.gmail.com>
 <YD0jLTciK0M7P+Hc@dhcp22.suse.cz>
 <122e8c5d-60b8-52d9-c6a1-00cd61b2e1b6@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <122e8c5d-60b8-52d9-c6a1-00cd61b2e1b6@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 01-03-21 17:16:29, Mike Kravetz wrote:
> On 3/1/21 9:23 AM, Michal Hocko wrote:
> > On Mon 01-03-21 08:39:22, Shakeel Butt wrote:
> >> On Mon, Mar 1, 2021 at 7:57 AM Michal Hocko <mhocko@suse.com> wrote:
> > [...]
> >>> Then how come this can ever be a problem? in_task() should exclude soft
> >>> irq context unless I am mistaken.
> >>>
> >>
> >> If I take the following example of syzbot's deadlock scenario then
> >> CPU1 is the one freeing the hugetlb pages. It is in the process
> >> context but has disabled softirqs (see __tcp_close()).
> >>
> >>         CPU0                    CPU1
> >>         ----                    ----
> >>    lock(hugetlb_lock);
> >>                                 local_irq_disable();
> >>                                 lock(slock-AF_INET);
> >>                                 lock(hugetlb_lock);
> >>    <Interrupt>
> >>      lock(slock-AF_INET);
> >>
> >> So, this deadlock scenario is very much possible.
> > 
> > OK, I see the point now. I was focusing on the IRQ context and hugetlb
> > side too much. We do not need to be freeing from there. All it takes is
> > to get a dependency chain over a common lock held here. Thanks for
> > bearing with me.
> > 
> > Let's see whether we can make hugetlb_lock irq safe.
> 
> I may be confused, but it seems like we have a general problem with
> calling free_huge_page (as a result of put_page) with interrupts
> disabled.
> 
> Consider the current free_huge_page code.  Today, we drop the lock
> when processing gigantic pages because we may need to block on a mutex
> in cma code.  If our caller has disabled interrupts, then it doesn't
> matter if the hugetlb lock is irq safe, when we drop it interrupts will
> still be disabled we can not block .  Right?  If correct, then making
> hugetlb_lock irq safe would not help.
> 
> Again, I may be missing something.
> 
> Note that we also are considering doing more with the hugetlb lock
> dropped in this path in the 'free vmemmap of hugetlb pages' series.
> 
> Since we need to do some work that could block in this path, it seems
> like we really need to use a workqueue.  It is too bad that there is not
> an interface to identify all the cases where interrupts are disabled.

Wouldn't something like this help? It is quite ugly but it would be
simple enough and backportable while we come up with a more rigorous 
solution. What do you think?

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 4bdb58ab14cb..c9a8b39f678d 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1495,9 +1495,11 @@ static DECLARE_WORK(free_hpage_work, free_hpage_workfn);
 void free_huge_page(struct page *page)
 {
 	/*
-	 * Defer freeing if in non-task context to avoid hugetlb_lock deadlock.
+	 * Defer freeing if in non-task context or when put_page is called
+	 * with IRQ disabled (e.g from via TCP slock dependency chain) to
+	 * avoid hugetlb_lock deadlock.
 	 */
-	if (!in_task()) {
+	if (!in_task() || irqs_disabled()) {
 		/*
 		 * Only call schedule_work() if hpage_freelist is previously
 		 * empty. Otherwise, schedule_work() had been called but the
-- 
Michal Hocko
SUSE Labs
