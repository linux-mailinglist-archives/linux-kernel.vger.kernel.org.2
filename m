Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00F3734E312
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 10:23:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231445AbhC3IWr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 04:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbhC3IWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 04:22:23 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D868DC061762
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 01:22:21 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id v3so11205061pgq.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 01:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WmJ21fc08wsM4/Y/mftNY0QYOCA3T7/Fy8IF01quWa8=;
        b=NfcIqc8VdHrkD+lX9suAICo1FeGZMq3e27Xkf+RaCaoQZ9CaMjV2lY8ksfyQg4VHPV
         qMyeMaGerEb/O7jf6LatoAgKpGStyGsPnpT2y3gYYWuSykwT4PfcOBXq3L2/+izLA6ia
         32wgxSe/yZF/0UGWaD39wJohfqc8wG5Pnj1sSEYLOpnLbOYVR7fLKmFdL0j86LWrJLBW
         X8ntKkJ3F+j2bTdYwgguPd75b+EbT6R4TlldDx/IFb1zcPzw8LIotPPV7JhZEaCGT0nE
         qYKyy+X08vJaaHLi2XW+SD2GDonOK2tpXvr+rsTepyphsxQRmqVk1wcFW1qQPplqrfNM
         WzQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WmJ21fc08wsM4/Y/mftNY0QYOCA3T7/Fy8IF01quWa8=;
        b=WVf11jJjO3jZsTaG1knhvcZd9IQmoSk58Oyk3FpN4nyyNeRpOyz1WzsGUvWOV1qfA1
         F0ReA4c9miIKNRX0hFkh1XEVQ/sNltjwsNVYQ0FIlpSTR5u7cv2ZcLi+hQLC0tRj/t7A
         v6NOJJYoaIR8qG/jU1qFXImIIWN0qtQCzJSF8zlDh/Rgnh1E8wJ/85HIlUqlePfFadI2
         nD+DH+9K1AE6rVBqCGyxionT57Zl3EOPyEhWaxS4+UJ0JC9aUFsBt9Cwyum31NG5HtMt
         fYaKGMS1r6AzDlEor8b7Q4TJk55uUqoz/AJW9Xm7Bsm4qcz+hKJikC9q4gkoEKNH5i1w
         gw/w==
X-Gm-Message-State: AOAM531PmryoDAQrQ7xVAn0SyJ1z/gPi5gWvvZreibTiWMQ2ErgpVcqN
        AwHcs0jw2jbM3GOdHnAdVfYqclsbVquABb5oaLi7Cg2j/j8nFw==
X-Google-Smtp-Source: ABdhPJyEYtkzl2Pc0ZLvbiKG2dJH0aZ2VdnUWyan/CC1FU6krgOdjR6GEt/fVzUEUN/ZZfNluPSw9rEEQ3dNiNmlLFA=
X-Received: by 2002:aa7:9e5b:0:b029:1f1:5ba4:57a2 with SMTP id
 z27-20020aa79e5b0000b02901f15ba457a2mr28836298pfq.59.1617092541436; Tue, 30
 Mar 2021 01:22:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210329232402.575396-1-mike.kravetz@oracle.com>
 <20210329232402.575396-2-mike.kravetz@oracle.com> <YGLayMqYOrMMQ841@dhcp22.suse.cz>
 <CAMZfGtUv4O_+W5rHt0P4Xbw=WXJ-ZwHYMrg=iJa2CEkfxb91gA@mail.gmail.com> <YGLe31q/4kAoLmmr@dhcp22.suse.cz>
In-Reply-To: <YGLe31q/4kAoLmmr@dhcp22.suse.cz>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Tue, 30 Mar 2021 16:21:45 +0800
Message-ID: <CAMZfGtWOY+gxSkfVNdW-GfKfZXKCgjwYGo=Y6ABk5L=HDsxhVg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2 1/8] mm/cma: change cma mutex to irq
 safe spinlock
To:     Michal Hocko <mhocko@suse.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        HORIGUCHI NAOYA <naoya.horiguchi@nec.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Waiman Long <longman@redhat.com>, Peter Xu <peterx@redhat.com>,
        Mina Almasry <almasrymina@google.com>,
        Hillf Danton <hdanton@sina.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 30, 2021 at 4:18 PM Michal Hocko <mhocko@suse.com> wrote:
>
> On Tue 30-03-21 16:08:36, Muchun Song wrote:
> > On Tue, Mar 30, 2021 at 4:01 PM Michal Hocko <mhocko@suse.com> wrote:
> > >
> > > On Mon 29-03-21 16:23:55, Mike Kravetz wrote:
> > > > Ideally, cma_release could be called from any context.  However, that is
> > > > not possible because a mutex is used to protect the per-area bitmap.
> > > > Change the bitmap to an irq safe spinlock.
> > >
> > > I would phrase the changelog slightly differerent
> > > "
> > > cma_release is currently a sleepable operatation because the bitmap
> > > manipulation is protected by cma->lock mutex. Hugetlb code which relies
> > > on cma_release for CMA backed (giga) hugetlb pages, however, needs to be
> > > irq safe.
> > >
> > > The lock doesn't protect any sleepable operation so it can be changed to
> > > a (irq aware) spin lock. The bitmap processing should be quite fast in
> > > typical case but if cma sizes grow to TB then we will likely need to
> > > replace the lock by a more optimized bitmap implementation.
> > > "
> > >
> > > it seems that you are overusing irqsave variants even from context which
> > > are never called from the IRQ context so they do not need storing flags.
> > >
> > > [...]
> > > > @@ -391,8 +391,9 @@ static void cma_debug_show_areas(struct cma *cma)
> > > >       unsigned long start = 0;
> > > >       unsigned long nr_part, nr_total = 0;
> > > >       unsigned long nbits = cma_bitmap_maxno(cma);
> > > > +     unsigned long flags;
> > > >
> > > > -     mutex_lock(&cma->lock);
> > > > +     spin_lock_irqsave(&cma->lock, flags);
> > >
> > > spin_lock_irq should be sufficient. This is only called from the
> > > allocation context and that is never called from IRQ context.
> >
> > This makes me think more. I think that spin_lock should be
> > sufficient. Right?
>
> Nope. Think of the following scenario
>         spin_lock(cma->lock);
>         <IRQ>
>         put_page
>           __free_huge_page
>             cma_release
>               spin_lock_irqsave() DEADLOCK

Got it. Thanks.

> --
> Michal Hocko
> SUSE Labs
