Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63F823E3067
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 22:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244996AbhHFUhw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 16:37:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbhHFUhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 16:37:50 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B8AEC0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Aug 2021 13:37:33 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id hw6so17051049ejc.10
        for <linux-kernel@vger.kernel.org>; Fri, 06 Aug 2021 13:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rnRuiZF4wapvbgI++n47Sa9nKibpjHl8Lh0ADOaBeYg=;
        b=eEpzkK2dRVMf/opaWqwbLuvJtTGiaJXKGDN98t+EJ342zn+WVqt6eNMxsKTSZLbXm7
         RVaORxR4atyRFqcAjJokFF4tnTXEsMZ/hu54tSlzvqlW9OCiTkFrW81yjfl6JTH50xL5
         OUoJJD+Jc7YclzZH4YkXumgKS2LlDWJZC0axi3GJUADrtSZ/RoJy7EkzE03VnQU5HH3e
         KYRkP+LvLk2RBAJtnI1DIl439EdeHFz/ECDYsr+k4OVt1DGqCmwxRQAOOwSGTvdeftT4
         WNE1l5+VWfm/ceS6Qni4vK4I/kxKoQkjGfPT2EB7brSanD8A5TnIZpNfDwoEKLOR1Kaq
         HpDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rnRuiZF4wapvbgI++n47Sa9nKibpjHl8Lh0ADOaBeYg=;
        b=qRucTkZ0DaE0mHoEUxtRuMpmlk7wEgpkkQUj+gsHIBYPTjafgme8MMrRuuqcdJbd9H
         OqLPh3Xkj9hJdSmvsM5eJ8BSXsKPf0FTCnoY7ZFdv9kekhPSkTywHTEwzo7LtvHzNZPB
         Dg0galB3BsOcODqJP6nHhTg79beCd+Q8Iu4K3b2gXxK+20p30khzn6QS/AdKPq1LbFJ0
         WslEPfapwC/LP15PW9ia4hfiuWOD895qimo/J4wRq6yQ2uYI5JDnqdd8cFaMTBU6fWIo
         VrQM5raAGGOJbt+QGtmzpzCArU7gHzZ7OW1VdWP66okv5EqTqHYNK3aSi4ck/hM/wq1S
         F3Eg==
X-Gm-Message-State: AOAM533nM1Jdp2bc0TUbLz2k/tmW4dyGzPbjZ9OGNMv1geqVpA8gWbUU
        S5xBOk2cdpGFzt0nlpY27bfAfVzA7PStoKQYvt4=
X-Google-Smtp-Source: ABdhPJwCI64DMpKDOlHMB7D/lwU06tFEdyqcc6roHwThIvbe/hrLvCwmmHPtT48NkvvEdb/Ad/cTWgiGTrl10MaBlqs=
X-Received: by 2002:a17:906:c182:: with SMTP id g2mr11279686ejz.507.1628282252280;
 Fri, 06 Aug 2021 13:37:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210723080000.93953-1-ying.huang@intel.com> <24187e5e-069-9f3f-cefe-39ac70783753@google.com>
 <YPs6cQo7iG1JcOn8@casper.infradead.org> <8735rr54i9.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <YQkwBdpWTPjv4xIx@casper.infradead.org> <704d597-443b-32f-84eb-524a58dd8ef@google.com>
 <CAHbLzkrShKORwU-Zrf5_5c6_o_iVwoXRTT+7ABZALLj7p0w-Ug@mail.gmail.com> <d1c768c-8b6-6a9d-ddde-39ac51286927@google.com>
In-Reply-To: <d1c768c-8b6-6a9d-ddde-39ac51286927@google.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Fri, 6 Aug 2021 13:37:19 -0700
Message-ID: <CAHbLzkrqY=L2bEeEfAkApkoz=sRUk-Nk_KBDWGAbsqapY+xG1Q@mail.gmail.com>
Subject: Re: [PATCH] mm,shmem: Fix a typo in shmem_swapin_page()
To:     Hugh Dickins <hughd@google.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        "Huang, Ying" <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Minchan Kim <minchan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 5, 2021 at 11:01 PM Hugh Dickins <hughd@google.com> wrote:
>
> On Thu, 5 Aug 2021, Yang Shi wrote:
> > On Tue, Aug 3, 2021 at 10:34 PM Hugh Dickins <hughd@google.com> wrote:
> > >
> > > I've never seen the swapoff race claimed by Miaohe, and don't expect to;
> > > but he's probably right, given the current code.  I just dislike adding
> > > unnecessary complexity, and siting it in the wrong place (mm/shmem.c).
> > >
> > > Yang, is it possible that 5.1 commit 8fd2e0b505d1 ("mm: swap: check if
> > > swap backing device is congested or not") was actually developed and
> > > measured on 4.1 or earlier, which still had blk_set_queue_congested()?
> >
> > I forgot the exact version, but definitely not 4.1 or earlier. Maybe
> > 4.19 or earlier. I'm not familiar with how block layer detect
> > congestion, if the logic was changed, hence the optimization doesn't
> > stand anymore nowadays, I'm totally fine to remove it.
>
> You drove me back to look more closely.  blk_set_queue_congested()
> vanished from include/linux/blkdev.h in 4.2, but blk_set_congested()
> appeared then in block/blk-core.c to replace it.  blk_set_congested()
> vanished (along with all references to "congested" in blk-core.c) in
> 5.0, then your commit (most probably tested on 4.19) went into 5.1 -
> just after it had become redundant!
>
> Thanks, yes, let's revert that and Miaohe's and Huang's, later on.

It should be easier to revert Huang Ying's , then Miaohe's, then mine.

>
> Hugh
