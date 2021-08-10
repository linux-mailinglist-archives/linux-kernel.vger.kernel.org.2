Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA6213E5089
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 03:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236420AbhHJBMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 21:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbhHJBMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 21:12:19 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62E1BC0613D3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 18:11:58 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id go31so32316428ejc.6
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 18:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hvASQKCQgVsj9cz4DvexOkfUTzkqdld5caICujbsG0k=;
        b=WEPcUrMwhSjCtvJr3lyiXiHfyBIWI/dBFaI+nTWK3mC6PRHJLUW+ATiQj+s931uS+r
         VJUGI5iNFFr0DvdUQxR5Ptjv7LkWoV9a+YjnI70JgDOAKDY8Du2+0Agx6kA7u5RoXf20
         m2Q6KRNvk981oAJal7PWR9XS9+484N8y4nzcL7+otaEx+0gSOHZr1G9e4Jxjm6rwiD2u
         nE/3f06zyjFdqFGwPVDattiqHZlzuZfxTwvG8nJNHM3TcB4Q4Eo7K7AQQWXk49n9//z+
         EdOctC1inxYYK+CFwSKhU0C91CHBHJCHwFInHiTZ38tQh00nJ4liyneelrnzU/z4+kl3
         hXyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hvASQKCQgVsj9cz4DvexOkfUTzkqdld5caICujbsG0k=;
        b=Bk2jGHrBouKfJACGjrzkj+gih77v66EwK5vmc3GO7X5nhIHbStYMvEKjXa/fV5T41C
         7kvuFyDnI7WluxjUOfu9ZYIgGjmZwc1jM10x9DdDpMQ8w/GXdnn/1s94F4t3MXBmrOTq
         qaz/fcl/UR85pO06TfZcdEZV6XA48YXUEUq/MljWOCnfh9sPm/HvInug3BGQ5V/LLJls
         IrgJiYzwt8ssJMA+ajT4ccC66Sas2tYRpAGGiIUURf4rAVs5CzUTqrzoYcYaaLLz1sEr
         1UVfWsKEhiuiLLFbQxbzfx+K3O3cAHTlU5SQpdH8so9yl6xOp25wxHEuGQUdRpjY4BVA
         1k7g==
X-Gm-Message-State: AOAM530qMN/C975aM/BTERftpXYajS17+RZ7w2GaKUVNA7EQabZFUsFa
        SmoRaM0MxESwMJe0yH9yQm6VUI/asSacUoeCxV4=
X-Google-Smtp-Source: ABdhPJxETQSYPTlkhLypxsgjH//7erh8bjX1ZUBvk7A9JqFItJjDkcwXB0U04+GoDyt3ksy0/foVCQCfRl1K8tewwd4=
X-Received: by 2002:a17:907:76a1:: with SMTP id jw1mr10657633ejc.238.1628557917058;
 Mon, 09 Aug 2021 18:11:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210723080000.93953-1-ying.huang@intel.com> <24187e5e-069-9f3f-cefe-39ac70783753@google.com>
 <YPs6cQo7iG1JcOn8@casper.infradead.org> <8735rr54i9.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <YQkwBdpWTPjv4xIx@casper.infradead.org> <704d597-443b-32f-84eb-524a58dd8ef@google.com>
 <CAHbLzkrShKORwU-Zrf5_5c6_o_iVwoXRTT+7ABZALLj7p0w-Ug@mail.gmail.com>
 <d1c768c-8b6-6a9d-ddde-39ac51286927@google.com> <CAHbLzkrqY=L2bEeEfAkApkoz=sRUk-Nk_KBDWGAbsqapY+xG1Q@mail.gmail.com>
 <CAHbLzko7LJmxkVuZTX35Aj65V29ukXmioJtrkiTtGrTyK9q7Sw@mail.gmail.com> <87k0ku89ql.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87k0ku89ql.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Mon, 9 Aug 2021 18:11:44 -0700
Message-ID: <CAHbLzkrB7FRqgFKErFP0BEjgWhnOpwjZCk5qHHxkkUYPFuT6aw@mail.gmail.com>
Subject: Re: [PATCH] mm,shmem: Fix a typo in shmem_swapin_page()
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>,
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

On Mon, Aug 9, 2021 at 4:43 PM Huang, Ying <ying.huang@intel.com> wrote:
>
> Yang Shi <shy828301@gmail.com> writes:
>
> > On Fri, Aug 6, 2021 at 1:37 PM Yang Shi <shy828301@gmail.com> wrote:
> >>
> >> On Thu, Aug 5, 2021 at 11:01 PM Hugh Dickins <hughd@google.com> wrote:
> >> >
> >> > On Thu, 5 Aug 2021, Yang Shi wrote:
> >> > > On Tue, Aug 3, 2021 at 10:34 PM Hugh Dickins <hughd@google.com> wrote:
> >> > > >
> >> > > > I've never seen the swapoff race claimed by Miaohe, and don't expect to;
> >> > > > but he's probably right, given the current code.  I just dislike adding
> >> > > > unnecessary complexity, and siting it in the wrong place (mm/shmem.c).
> >> > > >
> >> > > > Yang, is it possible that 5.1 commit 8fd2e0b505d1 ("mm: swap: check if
> >> > > > swap backing device is congested or not") was actually developed and
> >> > > > measured on 4.1 or earlier, which still had blk_set_queue_congested()?
> >> > >
> >> > > I forgot the exact version, but definitely not 4.1 or earlier. Maybe
> >> > > 4.19 or earlier. I'm not familiar with how block layer detect
> >> > > congestion, if the logic was changed, hence the optimization doesn't
> >> > > stand anymore nowadays, I'm totally fine to remove it.
> >> >
> >> > You drove me back to look more closely.  blk_set_queue_congested()
> >> > vanished from include/linux/blkdev.h in 4.2, but blk_set_congested()
> >> > appeared then in block/blk-core.c to replace it.  blk_set_congested()
> >> > vanished (along with all references to "congested" in blk-core.c) in
> >> > 5.0, then your commit (most probably tested on 4.19) went into 5.1 -
> >> > just after it had become redundant!
> >> >
> >> > Thanks, yes, let's revert that and Miaohe's and Huang's, later on.
> >>
> >> It should be easier to revert Huang Ying's , then Miaohe's, then mine.
> >
> > Hi Ying,
> >
> > I just prepared the reverts since I need to revert yours and Miaohe's
> > in order to revert my problematic commit.
>
> If your original commit will be reverted, then mine and Miaohe's can be
> reverted from the race condition point of view.

Yes, this is exactly what I did.

>
> Although I still think it's better to call get/put_swap_device() in
> shmem_swapin_page(), that can be discussed with another patch.

Any additional change could be based off the reverts.

>
> Best Regards,
> Huang, Ying
