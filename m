Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5BD3FE11C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 19:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344571AbhIAR1H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 13:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344491AbhIAR1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 13:27:05 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2610C061575
        for <linux-kernel@vger.kernel.org>; Wed,  1 Sep 2021 10:26:08 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id e21so623364ejz.12
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 10:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sp7XBpDsEWktebv2KujX7GIfrROhmlrwow2+XWTBKgA=;
        b=S8CnjdOpj1yWZxAPozi1aKqrUt6D2+mKIIRSpT8IaKG6MZnc566+G2YjaELRMbA/EF
         8MH0AyCUuSminMsWPbEVWaGoQo5MCZihJcGoP81f0s72L26RhuJrdXLto/fR1JU2UCou
         gfj3tI4JYQp1O3spGM+JjDbf2P/HOo6dzoYfF3ykrl+k/ijI7jEOyNvw+LpW4M1g9Ilu
         lmX5yK6G9cHzmhLzJ8viNYPpEnB9ECc5CotfiOyP36zAlSAHsMYdDjloK4Cr+OVXzshs
         P02GIa3xin37g3+iXJHpZbTHNbp8WmEuDvakWYJfpiV3qsvDp0UgWbwH124JEqDGfGSm
         90PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sp7XBpDsEWktebv2KujX7GIfrROhmlrwow2+XWTBKgA=;
        b=V3IF/7u+gsw++nchYeJ3MWonSoTjFB8c2ODrDf6bn+/UHYuwPCA73GPP9zgzECMd1h
         tsBAb4KfasN4VEVNnFYnrUjQVUyP+LStTC/VKHmz0hr1Q1H4OoLYCsyJVvSlDmmrSaE2
         VlBYB5KvIcPmc/eRqRGS+L/JR8vXxS66oW3WNQaj8aDG0GPJaj4P4SJ7f/x1Tb5bJhMy
         kf77eGmaIG7JwMiQW6pVybOODZkviVilavOYsgzgEZHP0dSikzeZCZu8GsspnZFOgir9
         oGKJIot3xno8/CpdJ+6uBQepTuSmDjbEct9V2fnJG8oGcm2GW2LkfL5zmPbGYq10NnyG
         CGOA==
X-Gm-Message-State: AOAM531bmdZHID9Z35b/zFZ7BlcG5veTufDm/xRIaJBnrnFdJ8iI79Iw
        TJJCGNn3X24WpORUJfiaTRYOJ5fjm9BhbYmAd4ut+v6gGD0=
X-Google-Smtp-Source: ABdhPJx1SUHv7MuyaoC+T7PFlhNvDfFhkTJJ6L2plSxYx0lYk02nP3kpVVQd7lSS6i++h7JLyOHc23F3u3RZZAansG4=
X-Received: by 2002:a17:906:cc81:: with SMTP id oq1mr608346ejb.25.1630517166010;
 Wed, 01 Sep 2021 10:26:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210817202146.3218-1-shy828301@gmail.com> <CAHbLzkpkDXyEZ2izMwpkwLg9fN7qsQ+soR+iu6sd8RfOSqhS-A@mail.gmail.com>
 <20210831233839.afaenhn32nx6m2fq@box.shutemov.name> <CAHbLzkrXOM0Ow3YbZnj9RyvTJ8fwaUCzAizOMR5MP=TkxeLywg@mail.gmail.com>
 <07fd6599-88cc-e353-26f0-5de3eeea5b9f@suse.cz>
In-Reply-To: <07fd6599-88cc-e353-26f0-5de3eeea5b9f@suse.cz>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 1 Sep 2021 10:25:53 -0700
Message-ID: <CAHbLzkoHghYQaqridYuWY=YUm4AB7sQDbCjbmGgr5iXx=nsETg@mail.gmail.com>
Subject: Re: [RFC PATCH] mm: khugepaged: don't carry huge page to the next
 loop for !CONFIG_NUMA
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 1, 2021 at 3:26 AM Vlastimil Babka <vbabka@suse.cz> wrote:
>
> On 9/1/21 05:46, Yang Shi wrote:
> > On Tue, Aug 31, 2021 at 4:38 PM Kirill A. Shutemov <kirill@shutemov.name> wrote:
> >>
> >> On Mon, Aug 30, 2021 at 11:49:43AM -0700, Yang Shi wrote:
> >> > Gently ping...
> >> >
> >> > Does this patch make sense? BTW, I have a couple of other khugepaged
> >> > related patches in my queue. I plan to send them with this patch
> >> > together. It would be great to hear some feedback before resending
> >> > this one.
> >>
> >> I don't really care for !NUMA optimization. I believe that most of setups
> >> that benefit from THP has NUMA enabled compile time.
> >
> > Agreed.
> >
> >>
> >> But if you wanna to go this path, make an effort to cleanup other
> >> artifacts for the !NUMA optimization: the ifdef has to be gone and all
> >> callers of these helpers has to be revisited. There's more opportunities to
> >> cleanup. Like it is very odd that khugepaged_prealloc_page() frees the
> >> page.
> >
> > Yes, they are gone in this patch. The only remaining for !NUMA is
> > khugepaged_find_target_node() which just returns 0.
>
> As Kirill pointed out, there's also khugepaged_prealloc_page() where the
> only remaining variant does actually no preallocation, just freeing of an
> unused page and some kind of "sleep after first alloc fail, break after
> second alloc fail" logic.
> This could now be moved to khugepaged_do_scan() loop itself and maybe it
> will be easier to follow.

Aha, I see. Misunderstood him. I'm supposed that you mean move into
khugepaged_scan_mm_slot().

>
> >>
> >>
> >> --
> >>  Kirill A. Shutemov
> >
>
