Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 751EA31025E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 02:46:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232951AbhBEBqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 20:46:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231650AbhBEBpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 20:45:41 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65DBCC0613D6
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 17:44:55 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id a1so5834911wrq.6
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 17:44:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7UMwdaHyyHv0tHFbd3G67+onVWpDFqTXMlcalyPzKs4=;
        b=H3Jxne9YFSw4SZ0Af2wo1mnJcL6VkMlA7qSuh7l61KB2fSQaIJ8CcdXiUuadI5NAGo
         0dOJ2Xmj8/cCJOXg7U1GEu8qemNplA2S4CpYvHoFTXnsjw/ODgJar3TiR/dBT0Tii3fv
         dgFGTmFZXdj8lPLGHVck0FLcmRXte0ls8Yyy8F2uQlh4gpCGaFk3BUkrr3eaOpYGDJ3/
         7gn3yYqUS2+dshVxaJVdtpZi3wfS5e35doTcIaD+PQbRDGl2BniVy9TaNAMmwAWzS31h
         A9G5PxzG5lON+vmWFt4N35ZXAymM1ZRfnvpj06aUEX9FpT24bry/WnW8BbFBL15VKVOI
         cTgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7UMwdaHyyHv0tHFbd3G67+onVWpDFqTXMlcalyPzKs4=;
        b=HHUf7jIZ4j7y9/pnW5u+7DiWSMfKJljKYyLQ7G/NwHAK1JmpTvcF65B5NDqjxnL4y5
         I3SWyKsyszw0hTsHm8B1t6E0nQyLKyf3EDH6kSJ1Me/8PWr6HNahfHYHk9qsOWei3efW
         DItzN59KFHIrz0wzwUaTdMynNND7Maamj+krx2GywgTtf96j3p/4ziSAe3GH2r1ki6cU
         Fcq1k7i29D2emQQxbf85/V3WDQj7ytMiYmgju/B17Dk+vzqeWDbzY9WH+STq8piEPSCK
         pI7VAjVojcUfmNQGwmuysFtD2t355ZK1P/hE8H+3OhvMcw8ePaoD0+82UJGdlsP93e7u
         CdDQ==
X-Gm-Message-State: AOAM5307J8zrp4HSp4erd47zu4qIO6nHcpqf9E3D5b/wAEGPzNpSmpVV
        T/WbQDo4rksatROYxo9+34lv1zlyrq5y/q65+8SQRA==
X-Google-Smtp-Source: ABdhPJynJ6JrBMa/DQKWCpk0FS7dcRHP2n2WhTiiNNQikExYOU1sXMFDwlWSecS21j+vYcVyZjB4A/DDYkstJDHDhTg=
X-Received: by 2002:a5d:453b:: with SMTP id j27mr2242917wra.92.1612489493985;
 Thu, 04 Feb 2021 17:44:53 -0800 (PST)
MIME-Version: 1.0
References: <20210203155001.4121868-1-minchan@kernel.org> <7e7c01a7-27fe-00a3-f67f-8bcf9ef3eae9@nvidia.com>
 <YBxT9XFE6QAQ4T9N@google.com> <cda5547b-0c78-756b-bd0c-f3e534d04bff@nvidia.com>
 <CAJuCfpG_J_XkaK=1z2oHkTpq7Pw1qvZLKuYrs7aG5b9yVwvEag@mail.gmail.com>
 <CAJuCfpFAsM86cKbBrhZx0WPFH5HGCYW4gK_EPtDU=gnhkiDSPw@mail.gmail.com>
 <9900858e-4d9b-5111-e695-fd2bb7463af9@nvidia.com> <96bc11de-fe47-c7d3-6e61-5a5a5b6d2f4c@nvidia.com>
In-Reply-To: <96bc11de-fe47-c7d3-6e61-5a5a5b6d2f4c@nvidia.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 4 Feb 2021 17:44:42 -0800
Message-ID: <CAJuCfpEgx3PqpV40NA+-f8xdXT1Z2FpAiOL+dGihZbommfZEKg@mail.gmail.com>
Subject: Re: [PATCH] mm: cma: support sysfs
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John Dias <joaodias@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 4, 2021 at 4:34 PM John Hubbard <jhubbard@nvidia.com> wrote:
>
> On 2/4/21 4:25 PM, John Hubbard wrote:
> > On 2/4/21 3:45 PM, Suren Baghdasaryan wrote:
> > ...
> >>>>>> 2) The overall CMA allocation attempts/failures (first two items above) seem
> >>>>>> an odd pair of things to track. Maybe that is what was easy to track, but I'd
> >>>>>> vote for just omitting them.
> >>>>>
> >>>>> Then, how to know how often CMA API failed?
> >>>>
> >>>> Why would you even need to know that, *in addition* to knowing specific
> >>>> page allocation numbers that failed? Again, there is no real-world motivation
> >>>> cited yet, just "this is good data". Need more stories and support here.
> >>>
> >>> IMHO it would be very useful to see whether there are multiple
> >>> small-order allocation failures or a few large-order ones, especially
> >>> for CMA where large allocations are not unusual. For that I believe
> >>> both alloc_pages_attempt and alloc_pages_fail would be required.
> >>
> >> Sorry, I meant to say "both cma_alloc_fail and alloc_pages_fail would
> >> be required".
> >
> > So if you want to know that, the existing items are still a little too indirect
> > to really get it right. You can only know the average allocation size, by
> > dividing. Instead, we should provide the allocation size, for each count.
> >
> > The limited interface makes this a little awkward, but using zones/ranges could
> > work: "for this range of allocation sizes, there were the following stats". Or,
> > some other technique that I haven't thought of (maybe two items per file?) would
> > be better.
> >
> > On the other hand, there's an argument for keeping this minimal and simple. That
> > would probably lead us to putting in a couple of items into /proc/vmstat, as I
> > just mentioned in my other response, and calling it good.

True. I was thinking along these lines but per-order counters felt
like maybe an overkill? I'm all for keeping it simple.

>

> ...and remember: if we keep it nice and minimal and clean, we can put it into
> /proc/vmstat and monitor it.

No objections from me.

>
> And then if a problem shows up, the more complex and advanced debugging data can
> go into debugfs's CMA area. And you're all set.
>
> If Android made up some policy not to use debugfs, then:
>
> a) that probably won't prevent engineers from using it anyway, for advanced debugging,
> and
>
> b) If (a) somehow falls short, then we need to talk about what Android's plans are to
> fill the need. And "fill up sysfs with debugfs items, possibly duplicating some of them,
> and generally making an unecessary mess, to compensate for not using debugfs" is not
> my first choice. :)
>
>
> thanks,
> --
> John Hubbard
> NVIDIA
