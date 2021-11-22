Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38B684594DB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 19:41:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240171AbhKVSoR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 13:44:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233219AbhKVSoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 13:44:15 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8287C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 10:41:07 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id u3so84358828lfl.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 10:41:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vMBMH3nxAgqI4nR+9LTYPLCFPERH9Hzssq8tQRoSaGI=;
        b=Y0OIjE1vDrlexxo0+110L50WfDc4kTctY9TPA9hVk36RaoQCVI1iim1Q5nQ7CEe1uE
         m9eHvSD0Ce4cnZlIv38oUWKgsykKE5y3in/OekCyDuxahfNQbiKDa+5hocHbH6b0JMNm
         noMXAh8jw8uZqHTytdffuWlu22jXBpRdnsbA84sL9yn1zwVB3xr4p2vfXXjq3hQQTmoX
         8xz3DaYHSdUAfeH0NVsYa7IlIrn7DI02aLW1OGIUjSy6t/1A6j+81JdRf9nTKmTd3Nlp
         uK6v+Y+rZsLCoiAPzFHmZtBHJYFAQrFW46UJtldLZXWLivpQpmhV7Jf/IEeS0YjRVYxR
         mkaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vMBMH3nxAgqI4nR+9LTYPLCFPERH9Hzssq8tQRoSaGI=;
        b=vQMK4+l1mX/7EzuWfTVEqbv3kp03GiCLD+0laqiGK0BybeCfWod9+BYZSdaM+DVQFQ
         zig/73tgTXboR2hjVu3BeQgcPHc/3Iy585hKxT7mRUC3DhEMdh9R3YmyZ8czRUndiXyM
         96lZyieqQPmMwgl2f1gqaCBxDuuQmSXqZDxmgLCuQvSFd5F2ThfHfBGgMsbqQuOzjNni
         A4B+JZJuHnMBm7wJ++rSDzk7X93QcwmmOEU5Gtgy+BVcQH9De6nqSJcY4wrtXKarrTJQ
         SxASZ3dqkpNOHvup4n0nQWWDxsfF/IOCK8B2FubSFNPyx5Hp5vpuZram02rR3ivB1nB7
         jT6Q==
X-Gm-Message-State: AOAM530lOKUdbgdFgn43EPravr+zXe0txE5HgSk9vSNaaoFCPgSB1Hb5
        EXwf/R/QaiMH2fnEbuvssNRXnxNzRVKjbgMkqV3BePDDmSs=
X-Google-Smtp-Source: ABdhPJxNjhxtgSjAfzMzTYV16WCiCzzXlQWQNLKgZY+GlWQaGMfo/XwM3kpeXQXhUmRHojCW01u5D+v7spCSniELBhE=
X-Received: by 2002:a05:6512:1113:: with SMTP id l19mr59438709lfg.184.1637606465730;
 Mon, 22 Nov 2021 10:41:05 -0800 (PST)
MIME-Version: 1.0
References: <20211120201230.920082-1-shakeelb@google.com> <25b36a5c-5bbd-5423-0c67-05cd6c1432a7@redhat.com>
In-Reply-To: <25b36a5c-5bbd-5423-0c67-05cd6c1432a7@redhat.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 22 Nov 2021 10:40:54 -0800
Message-ID: <CALvZod5L1C1DV_DVs9O3xZm6CJnriunAoj89YLDdCp7ef5yBxA@mail.gmail.com>
Subject: Re: [PATCH] mm: split thp synchronously on MADV_DONTNEED
To:     David Hildenbrand <david@redhat.com>
Cc:     "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 22, 2021 at 12:32 AM David Hildenbrand <david@redhat.com> wrote:
>
> On 20.11.21 21:12, Shakeel Butt wrote:
> > Many applications do sophisticated management of their heap memory for
> > better performance but with low cost. We have a bunch of such
> > applications running on our production and examples include caching and
> > data storage services. These applications keep their hot data on the
> > THPs for better performance and release the cold data through
> > MADV_DONTNEED to keep the memory cost low.
> >
> > The kernel defers the split and release of THPs until there is memory
> > pressure. This causes complicates the memory management of these
> > sophisticated applications which then needs to look into low level
> > kernel handling of THPs to better gauge their headroom for expansion.
>
> Can you elaborate a bit on that point? What exactly does such an
> application do? I would have assumed that it's mostly transparent for
> applications.
>

The application monitors its cgroup usage to decide if it can expand
the memory footprint or release some (unneeded/cold) buffer. It
releases madvise(MADV_DONTNEED) to release the memory which basically
puts the THP into defer list. These deferred THPs are still charged to
the cgroup which leads to bloated usage read by the application and
making wrong decisions. Internally we added a cgroup interface to
trigger the split of deferred THPs for that cgroup but this is hacky
and exposing kernel internals to users. I want to solve this problem
in a more general way for the users.

> > In
> > addition these applications are very latency sensitive and would prefer
> > to not face memory reclaim due to non-deterministic nature of reclaim.
>
> That makes sense.
>
> >
> > This patch let such applications not worry about the low level handling
> > of THPs in the kernel and splits the THPs synchronously on
> > MADV_DONTNEED.
>
> The main user I'm concerned about is virtio-balloon, which ends up
> discarding VM memory via MADV_DONTNEED when inflating the balloon in the
> guest in 4k granularity, but also during "free page reporting"
> continuously when e.g., a 2MiB page becomes free in the guest. We want
> both activities to be fast, and especially during "free page reporting",
> to defer any heavy work.

Thanks for the info. What is the source virtio-balloon used for free pages?

>
> Do we have a performance evaluation how much overhead is added e.g., for
> a single 4k MADV_DONTNEED call on a THP or on a MADV_DONTNEED call that
> covers the whole THP?

I did a simple benchmark of madvise(MADV_DONTNEED) on 10000 THPs on
x86 for both settings you suggested. I don't see any statistically
significant difference with and without the patch. Let me know if you
want me to try something else.

Thanks for the review.
Shakeel
