Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92F183E4E74
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 23:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235549AbhHIV1Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 17:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbhHIV1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 17:27:24 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D5B7C0613D3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 14:27:03 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id z11so26758923edb.11
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 14:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YaV9NVqoq9LCYplA+3/Ve0aFKd3h4CZcYgQ/yOddy8s=;
        b=Fc3jp/RgzdpnTTYxJuiI7fECrVZDYD0kt6WXyXJePKxxM5pEaaLSQYOn/fatlEdB3U
         csfWHPef2oifE09OKSaRhovvzfLpxRq1I7NhUYsk67BhgQ7dLSOcX94L/wkRxMcpTS//
         4rz2OFcbbI2b8Z45IrUwOUmo0F/ktKBvWj+KAUhEDITeRdUsxFKjhN3scrtx2pTHtrKg
         NXGEnggrVZPwaOZ6/y8GF0LFEEUjai2kaeN5B7OuN2ejTZaR88ryybv9RQG+QXpdkAGL
         Ysbg+ktIs+d9KlzRQ5Z5JDI3Y+LWf0HTbIlY0yQp1QdPje8qrY88jbJSILlSFU+Mo+lg
         mtzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YaV9NVqoq9LCYplA+3/Ve0aFKd3h4CZcYgQ/yOddy8s=;
        b=NeptwsCwlVGc8iBHVgtFuYnuVsRVod3ogisxYqzsnxhk7ka+dwJ5zBFYLLs1hACrf2
         54WPbUhHW0Hjj84mX6hQ+BKKuB2y/ojGMPmBBwpgbTX4y/fu+hdPKlIffZ5oq3RoBWtR
         JfzcDGKIROJKmtYNFSRjEHfzI0c6v16DkpidjkTSY5bZ8qOOj5bb9gkgrpEfKswcj3uF
         Gd13IbAt+xl0ah6KCFy3tMFGAcVOHzyHTzEJG7uTCRaj59bV/ibucfDsrKmezrye9JmC
         YoSOiqhK5GMXjcYsn1yqWL/lLKwqZ5ssKXx1cM5RBPR9aK6WgZaERnmF/MLEHkHVvd/7
         zvEw==
X-Gm-Message-State: AOAM530ZPXjVgfaInpLSCvoDZ5HnXOoAiFZUKVVN+iWvqy18QBnsR8nq
        uzgbgNXkUUactBGo5MDTh8y2A75NCoQNIIpUOXE=
X-Google-Smtp-Source: ABdhPJxK4WIpED+2en208KMp3JeUS6egiEIT7y2XiERNvp30tEwuM3WCVX87z79otzyWldkaaGq3JK2cL/46JdWYrEs=
X-Received: by 2002:a05:6402:b72:: with SMTP id cb18mr422927edb.290.1628544421850;
 Mon, 09 Aug 2021 14:27:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210723080000.93953-1-ying.huang@intel.com> <24187e5e-069-9f3f-cefe-39ac70783753@google.com>
 <YPs6cQo7iG1JcOn8@casper.infradead.org> <8735rr54i9.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <YQkwBdpWTPjv4xIx@casper.infradead.org> <704d597-443b-32f-84eb-524a58dd8ef@google.com>
 <CAHbLzkrShKORwU-Zrf5_5c6_o_iVwoXRTT+7ABZALLj7p0w-Ug@mail.gmail.com>
 <d1c768c-8b6-6a9d-ddde-39ac51286927@google.com> <CAHbLzkrqY=L2bEeEfAkApkoz=sRUk-Nk_KBDWGAbsqapY+xG1Q@mail.gmail.com>
In-Reply-To: <CAHbLzkrqY=L2bEeEfAkApkoz=sRUk-Nk_KBDWGAbsqapY+xG1Q@mail.gmail.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Mon, 9 Aug 2021 14:26:49 -0700
Message-ID: <CAHbLzko7LJmxkVuZTX35Aj65V29ukXmioJtrkiTtGrTyK9q7Sw@mail.gmail.com>
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

On Fri, Aug 6, 2021 at 1:37 PM Yang Shi <shy828301@gmail.com> wrote:
>
> On Thu, Aug 5, 2021 at 11:01 PM Hugh Dickins <hughd@google.com> wrote:
> >
> > On Thu, 5 Aug 2021, Yang Shi wrote:
> > > On Tue, Aug 3, 2021 at 10:34 PM Hugh Dickins <hughd@google.com> wrote:
> > > >
> > > > I've never seen the swapoff race claimed by Miaohe, and don't expect to;
> > > > but he's probably right, given the current code.  I just dislike adding
> > > > unnecessary complexity, and siting it in the wrong place (mm/shmem.c).
> > > >
> > > > Yang, is it possible that 5.1 commit 8fd2e0b505d1 ("mm: swap: check if
> > > > swap backing device is congested or not") was actually developed and
> > > > measured on 4.1 or earlier, which still had blk_set_queue_congested()?
> > >
> > > I forgot the exact version, but definitely not 4.1 or earlier. Maybe
> > > 4.19 or earlier. I'm not familiar with how block layer detect
> > > congestion, if the logic was changed, hence the optimization doesn't
> > > stand anymore nowadays, I'm totally fine to remove it.
> >
> > You drove me back to look more closely.  blk_set_queue_congested()
> > vanished from include/linux/blkdev.h in 4.2, but blk_set_congested()
> > appeared then in block/blk-core.c to replace it.  blk_set_congested()
> > vanished (along with all references to "congested" in blk-core.c) in
> > 5.0, then your commit (most probably tested on 4.19) went into 5.1 -
> > just after it had become redundant!
> >
> > Thanks, yes, let's revert that and Miaohe's and Huang's, later on.
>
> It should be easier to revert Huang Ying's , then Miaohe's, then mine.

Hi Ying,

I just prepared the reverts since I need to revert yours and Miaohe's
in order to revert my problematic commit.

>
> >
> > Hugh
