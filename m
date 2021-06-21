Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AF273AEA48
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 15:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbhFUNqX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 09:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbhFUNqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 09:46:22 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA848C061574
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 06:44:06 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id dm5so16518131ejc.9
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 06:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5soY3HyPbor821JO5cARDGNRoIkWjaPVD2fQn2uf7Zk=;
        b=RyY8RdikoQZ2dmqn/Gg3YjFfiQhjjUbhm/wS/MtHg1jafeWLi1VA+wQIGoLYVyd7HP
         iPovzF/r1kAUnFyxQ6XCmAGpIDSMHf2Ze/8Z9SZ0FwJk4ucUntixraFVXgjjHhD8KjiU
         kM6WCMtqiWU2hlla7vvrDHJoJw6NIiq2tZ1kRTNrCPy4aEG94r+fQP6gyBe9a8qWHiBa
         mtwHyAb86cb4vxMCJFR3SPJrgloDzk1q6kiKZUx2zXPcrsyyynB57FbEjg16AQmclqCZ
         CtYQhiMr/qxSv4EKm0h+U8HmsIxLk37Qpo7g6LvmKytSqyUgJM3lFHhidpN7SRkjkM4M
         5fjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5soY3HyPbor821JO5cARDGNRoIkWjaPVD2fQn2uf7Zk=;
        b=iT0zjBok0YE8kg6y08h38BYMbuZJ7LSLzcAnAzCbdSiH1FMmhg35AI9dmHuCOg8LX2
         qMiQwg1j4E1rTJpq/zbyFR7Q3I9zJzbhibcAIslFP1AiecpyJHwMBf2YQR8RV+9kNzh1
         SdNy+8pRjOY5mNYx3MzCoJaWaig+WXtUxTiWE5SEGx2iGu7dYyZYlTTlvMhP5XLxfCiB
         M5sZWrFpSdh3UYaVePjEE7UnTEcomSmF0Q7aBQjPPaOMO2jK8hRxkp1jXHm3GMUMfnow
         w8+7DvTEbgsbxJzfMEpACE8AfLwvulZS73fXUHC7m+knR/QT/ov33+BErjs/Pjfogb9Y
         e4DA==
X-Gm-Message-State: AOAM533YoMQhtU09Pna6r91yUjrGV1y9/A8hNtbj309/dmeUp1FQUyUE
        HO5qXOipJ3GWmmrOcDrBUVU0iturzrmdQQkemkM=
X-Google-Smtp-Source: ABdhPJzkkAPtw7uQVKRKlC0LY93RoiWTQR+H6uYLMvEVBXq2A1wUe3EvWKd6TVK4iQQwnAqaGsOGoiPz/zE4ND4qME8=
X-Received: by 2002:a17:906:dbe1:: with SMTP id yd1mr6196853ejb.114.1624283039449;
 Mon, 21 Jun 2021 06:43:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210601033319.100737-1-gshan@redhat.com> <76516781-6a70-f2b0-f3e3-da999c84350f@redhat.com>
 <0c0eb8c8-463d-d6f1-3cec-bbc0af0a229c@redhat.com> <b45b26ea-a6ac-934c-2467-c6e829b5d3ad@redhat.com>
 <CAKgT0Ue9SQ8=ju1m6ftKTb4Tai9EJ5NQhnB_uk-DzMc19-R4cQ@mail.gmail.com>
 <63c06446-3b10-762c-3a29-464854b74e08@redhat.com> <CAKgT0UfSx+qhfLvnukag+Z4Ab72Lyg8UXBvduiswm2BnFZH9vw@mail.gmail.com>
 <5a74f8ed-8579-290b-758f-faa24d2afa70@redhat.com>
In-Reply-To: <5a74f8ed-8579-290b-758f-faa24d2afa70@redhat.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Mon, 21 Jun 2021 06:43:48 -0700
Message-ID: <CAKgT0Uc9wt2SZ6hPK+y135sL-Hpvy5==NP2Uq6DCNP1BZ927Cg@mail.gmail.com>
Subject: Re: [RFC PATCH] mm/page_reporting: Adjust threshold according to MAX_ORDER
To:     Gavin Shan <gshan@redhat.com>
Cc:     David Hildenbrand <david@redhat.com>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        shan.gavin@gmail.com, Anshuman Khandual <anshuman.khandual@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 20, 2021 at 10:51 PM Gavin Shan <gshan@redhat.com> wrote:
>
> On 6/17/21 12:15 AM, Alexander Duyck wrote:
> > On Wed, Jun 16, 2021 at 12:10 AM Gavin Shan <gshan@redhat.com> wrote:
> >> On 6/15/21 12:26 PM, Alexander Duyck wrote:
> >>> On Mon, Jun 14, 2021 at 4:03 AM David Hildenbrand <david@redhat.com> wrote:
> >>>> On 11.06.21 09:44, Gavin Shan wrote:
> >>>>> On 6/1/21 6:01 PM, David Hildenbrand wrote:
> >>>>>> On 01.06.21 05:33, Gavin Shan wrote:
>
> [...]
>
> >>>
> >>> Yes, generally reporting pages comes at a fairly high cost so it is
> >>> important to find the right trade-off between the size of the page and
> >>> the size of the batch of pages being reported. If the size of the
> >>> pages is reduced it maybe important to increase the batch size in
> >>> order to avoid paying too much in the way of overhead.
> >>>
> >>> The other main reason for holding to pageblock_order on x86 is to
> >>> avoid THP splitting. Anything smaller than pageblock_order will
> >>> trigger THP splitting which will significantly hurt the performance of
> >>> the VM in general as it forces it down to order 0 pages.
> >>>
> >>
> >> Alex, Thanks for your reply and sorry for taking your time to this
> >> discussion.
> >>
> >> Could you please confirm it's PAGE_REPORTING_CAPACITY or the budget
> >> used in page_reporting_cycle() when you're talking about "batch"?
> >
> > Yes, when I refer to batch it is how many pages we are processing in a
> > single call. That is limited by PAGE_REPORTING_CAPACITY.
> >
>
> Alex, It seems the batch mechanism is to avoid heavy contention on
> zone's lock if I'm correct? The current design is to report all pages
> in the corresponding free list within 17 calls to page_reporting_cycle().
> Could you please explain why 17 was chosen? :)
>
>     budget = DIV_ROUND_UP(area->nr_free, PAGE_REPORTING_CAPACITY * 16);

It isn't that 17 was chosen. The idea was to only process 1/16th of
the free list at a time. The general idea is that by doing that and
limiting the page reporting to an interval of once every 2 seconds we
should have the entire guest reported out after about 30 seconds
assuming it is idle. If it isn't idle then the overhead for reporting
only 1/16th of the guest memory should be fairly low.

> It's related to the magic number ("16"). With the threshold is decreased,
> for example from 512MB to 2MB on arm64 with 64KB base page size, more
> page reporting activities will be introduced. From this regard, it's
> reasonable to increase the magic number as well, so that more calls
> to page_reporting_cycle() to avoid the contention to zone's lock.
>
> If you agree, I will come up with something, similar to what we do for
> the threshold. However, I'm not sure if 64 is reasonable cycles to have
> for this particular case.
>
>     in arch/arm64/include/asm/page.h
>        #ifdef CONFIG_ARM64_64K_PAGES
>        #define PAGE_REPORTING_ORDER    5
>        #define PAGE_REPORTING_CYCLES   64
>        #endif

You mentioned going from 512MB to 2MB pages. What is the MAX_ORDER for
the arm architecture you are working with? One concern I have is that
order 5 pages may not be high enough order to keep the page reporting
from interfering with the guest memory allocations since you are
having to cover so many free areas.

Ideally with page reporting we were aiming for MAX_ORDER and MAX_ORDER
- 1 as being the main targets for page reporting. The advantage there
is that on x86 that also allowed us to avoid splitting THP pages. The
other advantage is that when combined with the 16 and the fact that we
were rounding up the budget it should come out to about one minute to
fully flush out all the memory on an idle guest.

If anything we would want to take the (MAX_ORDER -
PAGE_REPORTING_ORDER)/2 and use that as a multiple for the 16 value as
that would give us the upper limit on how long it should take to
report all of the pages in a given block. It gets us to the same
value, but does a better job of explaining why.

>     in mm/page_reporting.h
>        #ifndef PAGE_REPORTING_CYCLES
>        #define PAGE_REPORTING_CYCLES   16
>        #endif
>     in mm/page_reporting.c::page_reporting_cycle()
>        budget = DIV_ROUND_UP(area->nr_free,
>                              PAGE_REPORTING_CAPACITY * PAGE_REPORTING_CYCLES);
>
> Thanks,
> Gavin

The 16 isn't about cycles, it is about how fast we want to leak the
memory out of the guest. You don't want this to go too fast otherwise
you are going to be fighting with anything that is trying to allocate
memory. In theory you should only be reporting pages in the top tiers
of the memory hierarchy so that it is not very active.

One way to think about page reporting is as a leaky bucket approach.
After a minute or so you want the bucket to drain assuming the memory
allocations/frees for a guest have become inactive. However it the VM
is active you want it to do very little in way of page reporting so
that you are not having to fault back in a ton of memory.
