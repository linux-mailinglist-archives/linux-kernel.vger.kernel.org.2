Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E10D432A7CA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 18:26:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1839650AbhCBQhh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 11:37:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351310AbhCBOPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 09:15:17 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E12BC06121D
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 06:12:06 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id u18so10467737ljd.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 06:12:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FYb7g69Q0S9UsKHByH7hMr9k6tWP4qu2tZDkFJoG0tM=;
        b=G+uutoapwSZWV779FqAhTz3xP8N7wFsDQ5uvwDaB8qke9uuQ62RmrK27+IbwDKzVts
         ic4rLiHcWcMmPqBZ88LB9yD1w09dSOaX829srODh+nGKhR6VHvvo6MsDyfaQtqBPcj8z
         Y16MEdrgn8q9Ht1pZRQEk90VyQDAm1QEHNidD+vgrcoMlou7XrQTYAco/BOUtomMX7pr
         R2vpEtZ/7HP16/t3eidN9EqgCBG8H2+i27h38iR1S6+4nyXHqbM/wSpyK4d/b7lp7UWy
         43RzNQao5xO18M59yQR14zxZf7iyDtVRzXTxujCXYTWWnK+WUhAMsHAT5mxoGeKWAQJn
         UEZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FYb7g69Q0S9UsKHByH7hMr9k6tWP4qu2tZDkFJoG0tM=;
        b=qnyeSDedm2jPEPNCZ1joa5O1zoErrEZ3YL9tu5FJx+4YoZuCtjkWTVdhpSPlJ1Q9ar
         /NeOH548GOi9Z/hfXRHD5K1ezImB7XSuMpNyqMXodnZBLY7H+v0T7OVXAiLbdlgjXj6c
         zA1Y+S8pStg37YdjyqLTcK0f8IqtF69Pz17DqVERho9yioKjtQeDBNLriXzYbsYAjjtI
         6xp/w0dHktAVNvzkwfXBmBfNndj0qKeoyWJFG2/Zv1YaV6NNJwagPVFHLrJzX0BThGmN
         XNgDF2SL40qEo0FZQTlYBOxTjsfD8PBiaU9xVPnhL9TZsd43VIh6+FCaoExMI/0FGkA3
         JbUA==
X-Gm-Message-State: AOAM532s3in/0yd3EIxc5jYasXCm/vMNeDPR9/U1xMVkEAMc+AB+YHw/
        w+h+zojxVpwYTOg/EVPU3XHhHO19qY9bnuoS3f6QKQ==
X-Google-Smtp-Source: ABdhPJyVRNEFpFpX/SuhVlD9Ppnl2Fau87w3eqhkeKtx6mOvlNT3LfnPO0guMPr4mCILZi6TYELnwSgU5llsAcinhTY=
X-Received: by 2002:a2e:7d03:: with SMTP id y3mr10563012ljc.0.1614694323839;
 Tue, 02 Mar 2021 06:12:03 -0800 (PST)
MIME-Version: 1.0
References: <000000000000f1c03b05bc43aadc@google.com> <CALvZod4vGj0P6WKncdKpGaVEb1Ui_fyHm+-hbCJTmbvo43CJ=A@mail.gmail.com>
 <7b7c4f41-b72e-840f-278a-320b9d97f887@oracle.com> <CALvZod5qODDSxqHqQ=_1roYVGVVvEvP3FnYMnAPQZgvUjxotsw@mail.gmail.com>
 <YDzaAWK41K4gD35V@dhcp22.suse.cz> <CALvZod4DqOkrJG+7dki=VfzHD1z9jD3XhObpk887zKy=kEk1tA@mail.gmail.com>
 <YD0OzXTmYm8M58Vo@dhcp22.suse.cz> <CALvZod789kHFAjWA8W7=r2=YxJ86uc4WhfgW1juN_YEMCApgqw@mail.gmail.com>
 <YD0jLTciK0M7P+Hc@dhcp22.suse.cz> <122e8c5d-60b8-52d9-c6a1-00cd61b2e1b6@oracle.com>
 <YD4I+VPr3UNt063H@dhcp22.suse.cz>
In-Reply-To: <YD4I+VPr3UNt063H@dhcp22.suse.cz>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 2 Mar 2021 06:11:51 -0800
Message-ID: <CALvZod7XHbjfoGGVH=h17u8-FruMaiPMWxXJz5JBmeJkNHBqNQ@mail.gmail.com>
Subject: Re: possible deadlock in sk_clone_lock
To:     Michal Hocko <mhocko@suse.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
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

On Tue, Mar 2, 2021 at 1:44 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Mon 01-03-21 17:16:29, Mike Kravetz wrote:
> > On 3/1/21 9:23 AM, Michal Hocko wrote:
> > > On Mon 01-03-21 08:39:22, Shakeel Butt wrote:
> > >> On Mon, Mar 1, 2021 at 7:57 AM Michal Hocko <mhocko@suse.com> wrote:
> > > [...]
> > >>> Then how come this can ever be a problem? in_task() should exclude soft
> > >>> irq context unless I am mistaken.
> > >>>
> > >>
> > >> If I take the following example of syzbot's deadlock scenario then
> > >> CPU1 is the one freeing the hugetlb pages. It is in the process
> > >> context but has disabled softirqs (see __tcp_close()).
> > >>
> > >>         CPU0                    CPU1
> > >>         ----                    ----
> > >>    lock(hugetlb_lock);
> > >>                                 local_irq_disable();
> > >>                                 lock(slock-AF_INET);
> > >>                                 lock(hugetlb_lock);
> > >>    <Interrupt>
> > >>      lock(slock-AF_INET);
> > >>
> > >> So, this deadlock scenario is very much possible.
> > >
> > > OK, I see the point now. I was focusing on the IRQ context and hugetlb
> > > side too much. We do not need to be freeing from there. All it takes is
> > > to get a dependency chain over a common lock held here. Thanks for
> > > bearing with me.
> > >
> > > Let's see whether we can make hugetlb_lock irq safe.
> >
> > I may be confused, but it seems like we have a general problem with
> > calling free_huge_page (as a result of put_page) with interrupts
> > disabled.
> >
> > Consider the current free_huge_page code.  Today, we drop the lock
> > when processing gigantic pages because we may need to block on a mutex
> > in cma code.  If our caller has disabled interrupts, then it doesn't
> > matter if the hugetlb lock is irq safe, when we drop it interrupts will
> > still be disabled we can not block .  Right?  If correct, then making
> > hugetlb_lock irq safe would not help.
> >
> > Again, I may be missing something.
> >
> > Note that we also are considering doing more with the hugetlb lock
> > dropped in this path in the 'free vmemmap of hugetlb pages' series.
> >
> > Since we need to do some work that could block in this path, it seems
> > like we really need to use a workqueue.  It is too bad that there is not
> > an interface to identify all the cases where interrupts are disabled.
>
> Wouldn't something like this help? It is quite ugly but it would be
> simple enough and backportable while we come up with a more rigorous
> solution. What do you think?
>
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 4bdb58ab14cb..c9a8b39f678d 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1495,9 +1495,11 @@ static DECLARE_WORK(free_hpage_work, free_hpage_workfn);
>  void free_huge_page(struct page *page)
>  {
>         /*
> -        * Defer freeing if in non-task context to avoid hugetlb_lock deadlock.
> +        * Defer freeing if in non-task context or when put_page is called
> +        * with IRQ disabled (e.g from via TCP slock dependency chain) to
> +        * avoid hugetlb_lock deadlock.
>          */
> -       if (!in_task()) {
> +       if (!in_task() || irqs_disabled()) {

Does irqs_disabled() also check softirqs?
