Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 300723BF208
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 00:22:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbhGGWZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 18:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbhGGWZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 18:25:34 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6581C061574
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jul 2021 15:22:52 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id f12so4550993ils.11
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jul 2021 15:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ANpnS5wfzyTQytr/LbOWVJj4UFY0hFcVyXu5UlKrAIM=;
        b=S8luKxNvVsP9qLL5333nqvhLQUZ+s2mAtAYb5+HJcG7n/eBbOwsQqHwFZBbisyIYZ5
         I8GWaadMU49vq+nwhPO0XK19nFlaGjdHg5LrGMsD6VFB0XPVRrLlLxwVGhEi36YRZNEh
         bdgql+J7CtFci/ZJZFZeVhfkg2ydNseee4Phg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ANpnS5wfzyTQytr/LbOWVJj4UFY0hFcVyXu5UlKrAIM=;
        b=M2BEkNtY2itVgqxKa1r6O4JDmoVH4w8csWwQaCxM1HhEaB12iZP6NCx6j5PSRAT3jw
         78CZEkcEHgD9ZSm65VXzFwlMtDVdSRj/yPjxhEjKfPjHivnnWZ83vbVTJIt5yRSmHJxn
         UYM8k/QQ+hjow7QQSV7qo38s6ld5f+bILomStEJdZabRWYq+8qM69iF07C09UVsAiLmr
         Wht/SBYD4PG9vEWTnuXx+Ns1ygW4cmf/tT3zbhj3GGb4KjUYjqd9O037SIlVoo6gtwHR
         A41jkfQEa9Uu88z6UuIDxkpVlyiTJeN0LtnhKnlJt/uMUkEah4cVhPsO6DH+vhqfyE0z
         PSdA==
X-Gm-Message-State: AOAM531thg/OtpdTLUfp2w3Ace4AmNriUTxfhq6hkFkB6mRE1FIw7NTz
        dmTHO+INKkFZkB9F7AajRt2u47fWnW43nw==
X-Google-Smtp-Source: ABdhPJwRBQcMhvIHNMe1wiqmGlAYYTG/N0HwP35IJPUTV6I97AQ23iffAGml0wLrnHLSS5HAmS4IxQ==
X-Received: by 2002:a92:8e45:: with SMTP id k5mr20903518ilh.116.1625696571948;
        Wed, 07 Jul 2021 15:22:51 -0700 (PDT)
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com. [209.85.166.176])
        by smtp.gmail.com with ESMTPSA id k2sm204395ili.57.2021.07.07.15.22.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jul 2021 15:22:50 -0700 (PDT)
Received: by mail-il1-f176.google.com with SMTP id o10so4606873ils.6
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jul 2021 15:22:50 -0700 (PDT)
X-Received: by 2002:a92:7c11:: with SMTP id x17mr18495985ilc.224.1625696570114;
 Wed, 07 Jul 2021 15:22:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210630100432.v1.1.I09866d90c6de14f21223a03e9e6a31f8a02ecbaf@changeid>
 <c178b1f1-73ee-d5a8-dfda-b2d53aa8d83d@redhat.com>
In-Reply-To: <c178b1f1-73ee-d5a8-dfda-b2d53aa8d83d@redhat.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Wed, 7 Jul 2021 15:22:14 -0700
X-Gmail-Original-Message-ID: <CAE=gft7dCZ90QmmmiEs_hFeW322jEyLcYoRx9DSWUS3ZRcaq8Q@mail.gmail.com>
Message-ID: <CAE=gft7dCZ90QmmmiEs_hFeW322jEyLcYoRx9DSWUS3ZRcaq8Q@mail.gmail.com>
Subject: Re: [PATCH v1] mm: Enable suspend-only swap spaces
To:     David Hildenbrand <david@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alex Shi <alexs@kernel.org>,
        Alistair Popple <apopple@nvidia.com>,
        Jens Axboe <axboe@kernel.dk>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Minchan Kim <minchan@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 5, 2021 at 12:44 AM David Hildenbrand <david@redhat.com> wrote:
>
> On 30.06.21 19:07, Evan Green wrote:
> > Currently it's not possible to enable hibernation without also enabling
> > generic swap for a given swap area. These two use cases are not the
> > same. For example there may be users who want to enable hibernation,
> > but whose drives don't have the write endurance for generic swap
> > activities.
> >
> > Add a new SWAP_FLAG_NOSWAP that adds a swap region but refuses to allow
> > generic swapping to it. This region can still be wired up for use in
> > suspend-to-disk activities, but will never have regular pages swapped to
> > it.
>
> Just to confirm: things like /proc/meminfo won't show this "swap that's
> not actually swap" as free/total swap, correct? Maybe it's worth
> spelling the expected system behavior out here.

Currently these noswap regions do still count in /proc/meminfo. I
suppose as you say it makes more sense for it not to count. I should
be able to carefully put some conditionals around the nr_swap_pages
and total_swap_pages accounting to fix that. I'll also document this
in the commit text as suggested.

When looking at that, I realized something else. Hibernate uses
swap_free() to release its image pages, which calls free_swap_slot().
That may land the page in a swap_slots_cache, causing it to possibly
leak back into general usage. I'm thinking I should just call
swap_entry_free() directly if NOSWAP is set. I gave that a quick test
and so far it looks good.

Other random musings I had while staring that this code:

It surprised me that there's swap_entry_free() and
__swap_entry_free(), but the one without underscores is the lower
level one (ie __swap_entry_free() winds through the cache,
swap_entry_free() just does it). I'm not really sure if renaming those
is worth the churn or not: leaning towards no.

It's also interesting that scan_swap_map_slots() chooses whether or
not to attempt reclaim based on vm_swap_full(). vm_swap_full() returns
true if swap globally is 50% full or not. But hibernate is restricted
to a single swap device. So you could find yourself in a situation
where the hibernate device was full-but-reclaimable, and other areas
aren't very full. This might cause hibernations to fail because we
never attempted to reclaim swap. Maybe this never comes up in practice
because people don't use multiple swap devices. Or maybe we naturally
tend to spread the swap load evenly such that looking at the global
counts is roughly equivalent to looking at a single one. Shower
thoughts. I'll keep this in mind when I'm doing my own testing to see
if it ever comes up.

Thanks for the review, I'll plan to post a v2 in the next couple days.
-Evan
