Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F4165328BA2
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 19:40:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240245AbhCASiU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 13:38:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233299AbhCAQkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 11:40:16 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBD13C06178B
        for <linux-kernel@vger.kernel.org>; Mon,  1 Mar 2021 08:39:35 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id z11so26473014lfb.9
        for <linux-kernel@vger.kernel.org>; Mon, 01 Mar 2021 08:39:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8RorKlKUIwAeZ2vu8I46zt7CBWlrUNEpLpF3jdorkm8=;
        b=Hx5rm6bgWnW2rzcg2ftQXDvzUq9+b9iZL+48q+8+FVQIhe6LJSSulGtfBsHTS3gkns
         4oDOY3TvQLXS9UMnfUpKBGeLsmOQoJojGPdx8k3ndakA4m87/EgWxdg5pSOAdnG+g9Bn
         mzK0T+tRjpSvPlBF/8obIi7KyX0lPLpsKMm6yi+wP4Gx9klCmizayy1TpFqUR4wFLqwi
         heoKUIkdL09+MasjGb9IM0eI0alY97t9dxVgdKvPxZ9j9ZupH53PSBcQ/g2E9ixxeVTM
         rEB7rFK05UxoTMMiy78IXLK2TmBvobe9M3FA6wc3TKZg3JyjAUm3L6WIW3u2PniUcELi
         uVTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8RorKlKUIwAeZ2vu8I46zt7CBWlrUNEpLpF3jdorkm8=;
        b=uLPe3BfcnH6zOWaABXmFRAti9r4Tmanx7tWU3oz3QO0Arm5szuvi9YeP7tGcyhGN6I
         vMtdELpyBzCTc9gPdt3Tr1QxgE9GX94I09kSOgOkDmlYX2RmB6EvZqiK6sMMkMGzKsko
         Jl+As1/MfmA/6CVSvFmSU8sy+GPAbO+9Yes9YcBt0GehRIzkDFcd1k4o0BWLT6qWecE5
         i3etJegnl4Z7NOoXgnt3r6vhW2965u+azvDvzXiKCR93i+T6p4ksARr3dSeyad+PUncH
         a5vhFbDUpj3TTiLKXp0AHKxLGfvPAtBsp1V51ybI9DxMrfjn9T8j6WyKapnV1tvUnwfy
         CCOA==
X-Gm-Message-State: AOAM533DaA0+pU1QlqbFaX0v2gnKdgX0Cw6lqxkDf0xJl6s5A9RHHrSO
        /8OaRGm75v2p6jWz6NLB4mfuy+QD2nOmyo4HVnyODA==
X-Google-Smtp-Source: ABdhPJx0KbzhJIVoM4/GcjChCBVWTV/vBF4C/e1Kdb2FPa+us+EDkJoa0wsgIaAANgRdocbZkBVKQCHsKYU/dtN/IeA=
X-Received: by 2002:a05:6512:942:: with SMTP id u2mr10175495lft.117.1614616774183;
 Mon, 01 Mar 2021 08:39:34 -0800 (PST)
MIME-Version: 1.0
References: <000000000000f1c03b05bc43aadc@google.com> <CALvZod4vGj0P6WKncdKpGaVEb1Ui_fyHm+-hbCJTmbvo43CJ=A@mail.gmail.com>
 <7b7c4f41-b72e-840f-278a-320b9d97f887@oracle.com> <CALvZod5qODDSxqHqQ=_1roYVGVVvEvP3FnYMnAPQZgvUjxotsw@mail.gmail.com>
 <YDzaAWK41K4gD35V@dhcp22.suse.cz> <CALvZod4DqOkrJG+7dki=VfzHD1z9jD3XhObpk887zKy=kEk1tA@mail.gmail.com>
 <YD0OzXTmYm8M58Vo@dhcp22.suse.cz>
In-Reply-To: <YD0OzXTmYm8M58Vo@dhcp22.suse.cz>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 1 Mar 2021 08:39:22 -0800
Message-ID: <CALvZod789kHFAjWA8W7=r2=YxJ86uc4WhfgW1juN_YEMCApgqw@mail.gmail.com>
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

On Mon, Mar 1, 2021 at 7:57 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Mon 01-03-21 07:10:11, Shakeel Butt wrote:
> > On Mon, Mar 1, 2021 at 4:12 AM Michal Hocko <mhocko@suse.com> wrote:
> > >
> > > On Fri 26-02-21 16:00:30, Shakeel Butt wrote:
> > > > On Fri, Feb 26, 2021 at 3:14 PM Mike Kravetz <mike.kravetz@oracle.com> wrote:
> > > > >
> > > > > Cc: Michal
> > > > >
> > > > > On 2/26/21 2:44 PM, Shakeel Butt wrote:
> > > > > > On Fri, Feb 26, 2021 at 2:09 PM syzbot
> > > > > > <syzbot+506c8a2a115201881d45@syzkaller.appspotmail.com> wrote:
> > > > > <snip>
> > > > > >> other info that might help us debug this:
> > > > > >>
> > > > > >>  Possible interrupt unsafe locking scenario:
> > > > > >>
> > > > > >>        CPU0                    CPU1
> > > > > >>        ----                    ----
> > > > > >>   lock(hugetlb_lock);
> > > > > >>                                local_irq_disable();
> > > > > >>                                lock(slock-AF_INET);
> > > > > >>                                lock(hugetlb_lock);
> > > > > >>   <Interrupt>
> > > > > >>     lock(slock-AF_INET);
> > > > > >>
> > > > > >>  *** DEADLOCK ***
> > > > > >
> > > > > > This has been reproduced on 4.19 stable kernel as well [1] and there
> > > > > > is a reproducer as well.
> > > > > >
> > > > > > It seems like sendmsg(MSG_ZEROCOPY) from a buffer backed by hugetlb. I
> > > > > > wonder if we just need to make hugetlb_lock softirq-safe.
> > > > > >
> > > > > > [1] https://syzkaller.appspot.com/bug?extid=6383ce4b0b8ec575ad93
> > > > >
> > > > > Thanks Shakeel,
> > > > >
> > > > > Commit c77c0a8ac4c5 ("mm/hugetlb: defer freeing of huge pages if in non-task
> > > > > context") attempted to address this issue.  It uses a work queue to
> > > > > acquire hugetlb_lock if the caller is !in_task().
> > > > >
> > > > > In another recent thread, there was the suggestion to change the
> > > > > !in_task to in_atomic.
> > > > >
> > > > > I need to do some research on the subtle differences between in_task,
> > > > > in_atomic, etc.  TBH, I 'thought' !in_task would prevent the issue
> > > > > reported here.  But, that obviously is not the case.
> > > >
> > > > I think the freeing is happening in the process context in this report
> > > > but it is creating the lock chain from softirq-safe slock to
> > > > irq-unsafe hugetlb_lock. So, two solutions I can think of are: (1)
> > > > always defer the freeing of hugetlb pages to a work queue or (2) make
> > > > hugetlb_lock softirq-safe.
> > >
> > > There is __do_softirq so this should be in the soft IRQ context no?
> > > Is this really reproducible with kernels which have c77c0a8ac4c5
> > > applied?
> >
> > Yes this is softirq context and syzbot has reproduced this on
> > linux-next 20210224.
>
> Then how come this can ever be a problem? in_task() should exclude soft
> irq context unless I am mistaken.
>

If I take the following example of syzbot's deadlock scenario then
CPU1 is the one freeing the hugetlb pages. It is in the process
context but has disabled softirqs (see __tcp_close()).

        CPU0                    CPU1
        ----                    ----
   lock(hugetlb_lock);
                                local_irq_disable();
                                lock(slock-AF_INET);
                                lock(hugetlb_lock);
   <Interrupt>
     lock(slock-AF_INET);

So, this deadlock scenario is very much possible.
