Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9E163281EB
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 16:13:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236966AbhCAPMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 10:12:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236946AbhCAPLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 10:11:06 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36A6AC061756
        for <linux-kernel@vger.kernel.org>; Mon,  1 Mar 2021 07:10:25 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id y12so6879043ljj.12
        for <linux-kernel@vger.kernel.org>; Mon, 01 Mar 2021 07:10:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FqEasT/CcfZgJ5sVq0zoEEbPXzj4gEZQSUG9/1WN1Do=;
        b=qRoGU2wohpJbUgLEd98urVPFt7jw5V4xjVOmoQ/mcoIONClUYY4pc7fZPnsT8/eaRe
         Jcm9qw83ze6XBT0PNhWMfTEOr9vqGzJwyOWPrrBWBJI6pM6AWXpfAl2AM92TSFjFMTku
         nJ4QESmGf3h8gLAd5iITcfCuL6j8inhDnQyVW2S7faUUCsSew+UyLsv+qo/32IKNjdNr
         IsmUplL4/SsVIIxgTnhySm59IemXwlhJknJIjLSwOPzdQwUnSCg29w594Yd9w5Sp+VOF
         JSXiHgk5k18LDWcDy7vDvDpeNPz9M13kvd/PYv/n7R0NVhQZvOARy1JqhOJfbaiz+qEI
         9wtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FqEasT/CcfZgJ5sVq0zoEEbPXzj4gEZQSUG9/1WN1Do=;
        b=lc2l7IVeQ3ga4Wdk4k7V83HuINJNakF6g6xwN+YtVZm833UwsBEP2ExV1yDzFzhuHP
         vl+QssIDcNF2zndIucQaPvQ1hAL/c7vpdrvfbP+mQj7f3d8DWaAa9YVw8ndgeFDsuLLM
         fP2Ykv7f1nhve8MIiN4ebKPiAlcWa7VLo+YYNyk2YmSTWDWap0gaP9yxh2Ch+qTUOt7k
         c8S/SPJzNZR2tDETgz/DjpNcnGZz5zwsS5itndBQsZWsBDG7CXHwUDN2DRQWIrRzI6iw
         YtV3HT9csMoBPLh9eTSByORZN6sHPI+YB772K8jpZHHgEiPPO7vEmrVsiEi/uhyoRIEF
         sqPg==
X-Gm-Message-State: AOAM530yJr5SmMp0AnB+mF+ZyN+K43s2fU9YXQ6nKIBRCpBheKw+uZWw
        PJP2eYn3WV6sErXxpKsEAZRBOP1iImgE2sY4fvOxHQ==
X-Google-Smtp-Source: ABdhPJzYMlV3say0EDik5yoGswKhTchbG/yK2wzysG+tJfg23isFoGyFOtdQgaZvIkuwCzw90uj3upS1wU2GP43BFT0=
X-Received: by 2002:a2e:5c02:: with SMTP id q2mr9379535ljb.81.1614611423221;
 Mon, 01 Mar 2021 07:10:23 -0800 (PST)
MIME-Version: 1.0
References: <000000000000f1c03b05bc43aadc@google.com> <CALvZod4vGj0P6WKncdKpGaVEb1Ui_fyHm+-hbCJTmbvo43CJ=A@mail.gmail.com>
 <7b7c4f41-b72e-840f-278a-320b9d97f887@oracle.com> <CALvZod5qODDSxqHqQ=_1roYVGVVvEvP3FnYMnAPQZgvUjxotsw@mail.gmail.com>
 <YDzaAWK41K4gD35V@dhcp22.suse.cz>
In-Reply-To: <YDzaAWK41K4gD35V@dhcp22.suse.cz>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 1 Mar 2021 07:10:11 -0800
Message-ID: <CALvZod4DqOkrJG+7dki=VfzHD1z9jD3XhObpk887zKy=kEk1tA@mail.gmail.com>
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

On Mon, Mar 1, 2021 at 4:12 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Fri 26-02-21 16:00:30, Shakeel Butt wrote:
> > On Fri, Feb 26, 2021 at 3:14 PM Mike Kravetz <mike.kravetz@oracle.com> wrote:
> > >
> > > Cc: Michal
> > >
> > > On 2/26/21 2:44 PM, Shakeel Butt wrote:
> > > > On Fri, Feb 26, 2021 at 2:09 PM syzbot
> > > > <syzbot+506c8a2a115201881d45@syzkaller.appspotmail.com> wrote:
> > > <snip>
> > > >> other info that might help us debug this:
> > > >>
> > > >>  Possible interrupt unsafe locking scenario:
> > > >>
> > > >>        CPU0                    CPU1
> > > >>        ----                    ----
> > > >>   lock(hugetlb_lock);
> > > >>                                local_irq_disable();
> > > >>                                lock(slock-AF_INET);
> > > >>                                lock(hugetlb_lock);
> > > >>   <Interrupt>
> > > >>     lock(slock-AF_INET);
> > > >>
> > > >>  *** DEADLOCK ***
> > > >
> > > > This has been reproduced on 4.19 stable kernel as well [1] and there
> > > > is a reproducer as well.
> > > >
> > > > It seems like sendmsg(MSG_ZEROCOPY) from a buffer backed by hugetlb. I
> > > > wonder if we just need to make hugetlb_lock softirq-safe.
> > > >
> > > > [1] https://syzkaller.appspot.com/bug?extid=6383ce4b0b8ec575ad93
> > >
> > > Thanks Shakeel,
> > >
> > > Commit c77c0a8ac4c5 ("mm/hugetlb: defer freeing of huge pages if in non-task
> > > context") attempted to address this issue.  It uses a work queue to
> > > acquire hugetlb_lock if the caller is !in_task().
> > >
> > > In another recent thread, there was the suggestion to change the
> > > !in_task to in_atomic.
> > >
> > > I need to do some research on the subtle differences between in_task,
> > > in_atomic, etc.  TBH, I 'thought' !in_task would prevent the issue
> > > reported here.  But, that obviously is not the case.
> >
> > I think the freeing is happening in the process context in this report
> > but it is creating the lock chain from softirq-safe slock to
> > irq-unsafe hugetlb_lock. So, two solutions I can think of are: (1)
> > always defer the freeing of hugetlb pages to a work queue or (2) make
> > hugetlb_lock softirq-safe.
>
> There is __do_softirq so this should be in the soft IRQ context no?
> Is this really reproducible with kernels which have c77c0a8ac4c5
> applied?

Yes this is softirq context and syzbot has reproduced this on
linux-next 20210224.

>
> Btw. making hugetlb lock irq safe has been already discussed and it
> seems to be much harder than expected as some heavy operations are done
> under the lock. This is really bad.

What about just softirq-safe i.e. spin_[un]lock_bh()? Will it still be that bad?

> Postponing the whole freeing
> operation into a worker context is certainly possible but I would
> consider it rather unfortunate. We would have to add some sync mechanism
> to wait for hugetlb pages in flight to prevent from external
> observability to the userspace. E.g. when shrinking the pool.

I think in practice recycling of hugetlb pages is a rare event, so we
might get away without the sync mechanism. How about start postponing
the freeing without sync mechanism and add it later if there are any
user reports complaining?

> --
> Michal Hocko
> SUSE Labs
