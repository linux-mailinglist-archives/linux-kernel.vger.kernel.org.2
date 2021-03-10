Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 014FE3346A2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 19:25:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232330AbhCJSYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 13:24:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233130AbhCJSYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 13:24:20 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43ECBC061760
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 10:24:20 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id p15so26797060ljc.13
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 10:24:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uM8pUZ0KtpIP4tmwMWGoiI2kI1p+H+zJasTko8V61Mw=;
        b=qK+Eak/IUin0xvRSRy/doM8DVPq6tgbzFJp2RqOhLyzg39iiQj/3VtuCR4uh4V0taP
         NsJH1HKbhu0DA0STZiobO4FRclLpJEt1UW0057VMAwvwB0/2Lvpz5cfmnFJqoyJrkDK/
         qnXIiaQfNmk+AncdFYYrid1iADXijko36+wbl2oEEZOV/VkpbNPsp1eGwRqPOtkBa7w2
         N+TD887AuLjcacHbPDsBdHa03V9wJo3qc5Zl7T8H5uqlUZziiDR8MCOBQXh131LMdOff
         0jh07+UhYLy4Kwk5TlToV6EcfCjmg03X+58fhcS4z17+rkIb17h+VG85eIIeBDMRwJW7
         Ipow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uM8pUZ0KtpIP4tmwMWGoiI2kI1p+H+zJasTko8V61Mw=;
        b=SEVnPWnPd7Pp5DtY1hNZrZkxNSe7UOQ0Ny6/mDIgCOoI/cyhjbYkTNYuX7jlIBPJlv
         xUjccUpvto/p0Emycubsj8sr+6VLuqsKhR63geCQiyfxafPvtW/nbDeRJiyIs9nfK8Ps
         8rOXtrN6EX+gQk309cqZouUYY9nRkj5+OO2Lufc2zE7RWS+PNKOohfmIaKGw+pPPLWc7
         +zXepokeivKzmpvjbd+DUJ+vs/qOHfya7QjdMesKT0bWx26EU2C7MmwQpugNLUjghIrp
         lcNQl0dYYUh1dBtK2St4wjCX3Vf7SOSfUbRsZ8GInAJKSyDgQDxJJNm4IPLTTtPKhnV9
         eybA==
X-Gm-Message-State: AOAM532OWaks9FnNRfiOiwcf4qJ7vuQrXlLD38nki/2+XTuw37lCChY7
        im8o6EPMnP70KcIRbdj0JbJSxNHXy54Sl60PQe/XWg==
X-Google-Smtp-Source: ABdhPJwd9A8937MRDsobC/NbdnlGRgLFg6wQJm3RHO2xVNlco62TixObhQVwvQCnX4kNOVtcvAu23vTVZ6Boxb6yHMc=
X-Received: by 2002:a2e:8984:: with SMTP id c4mr2444913lji.456.1615400658479;
 Wed, 10 Mar 2021 10:24:18 -0800 (PST)
MIME-Version: 1.0
References: <20210310174603.5093-1-shy828301@gmail.com> <20210310174603.5093-14-shy828301@gmail.com>
In-Reply-To: <20210310174603.5093-14-shy828301@gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 10 Mar 2021 10:24:06 -0800
Message-ID: <CALvZod5q5LDEfUMuvO7V2hTf+oCsBGXKZn3tBByOXL952wqbRw@mail.gmail.com>
Subject: Re: [v9 PATCH 13/13] mm: vmscan: shrink deferred objects proportional
 to priority
To:     Yang Shi <shy828301@gmail.com>
Cc:     Roman Gushchin <guro@fb.com>, Kirill Tkhai <ktkhai@virtuozzo.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dave Chinner <david@fromorbit.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 10, 2021 at 9:46 AM Yang Shi <shy828301@gmail.com> wrote:
>
> The number of deferred objects might get windup to an absurd number, and it
> results in clamp of slab objects.  It is undesirable for sustaining workingset.
>
> So shrink deferred objects proportional to priority and cap nr_deferred to twice
> of cache items.
>
> The idea is borrowed from Dave Chinner's patch:
> https://lore.kernel.org/linux-xfs/20191031234618.15403-13-david@fromorbit.com/
>
> Tested with kernel build and vfs metadata heavy workload in our production
> environment, no regression is spotted so far.

Did you run both of these workloads in the same cgroup or separate cgroups?

>
> Signed-off-by: Yang Shi <shy828301@gmail.com>
> ---
>  mm/vmscan.c | 46 +++++++++++-----------------------------------
>  1 file changed, 11 insertions(+), 35 deletions(-)
>
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 9a2dfeaa79f4..6a0a91b23597 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -662,7 +662,6 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
>          */
>         nr = xchg_nr_deferred(shrinker, shrinkctl);
>
> -       total_scan = nr;
>         if (shrinker->seeks) {
>                 delta = freeable >> priority;
>                 delta *= 4;
> @@ -676,37 +675,9 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
>                 delta = freeable / 2;
>         }
>
> +       total_scan = nr >> priority;
>         total_scan += delta;
> -       if (total_scan < 0) {
> -               pr_err("shrink_slab: %pS negative objects to delete nr=%ld\n",
> -                      shrinker->scan_objects, total_scan);
> -               total_scan = freeable;
> -               next_deferred = nr;
> -       } else
> -               next_deferred = total_scan;
> -
> -       /*
> -        * We need to avoid excessive windup on filesystem shrinkers
> -        * due to large numbers of GFP_NOFS allocations causing the
> -        * shrinkers to return -1 all the time. This results in a large
> -        * nr being built up so when a shrink that can do some work
> -        * comes along it empties the entire cache due to nr >>>
> -        * freeable. This is bad for sustaining a working set in
> -        * memory.
> -        *
> -        * Hence only allow the shrinker to scan the entire cache when
> -        * a large delta change is calculated directly.
> -        */
> -       if (delta < freeable / 4)
> -               total_scan = min(total_scan, freeable / 2);
> -
> -       /*
> -        * Avoid risking looping forever due to too large nr value:
> -        * never try to free more than twice the estimate number of
> -        * freeable entries.
> -        */
> -       if (total_scan > freeable * 2)
> -               total_scan = freeable * 2;
> +       total_scan = min(total_scan, (2 * freeable));
>
>         trace_mm_shrink_slab_start(shrinker, shrinkctl, nr,
>                                    freeable, delta, total_scan, priority);
> @@ -745,10 +716,15 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
>                 cond_resched();
>         }
>
> -       if (next_deferred >= scanned)
> -               next_deferred -= scanned;
> -       else
> -               next_deferred = 0;
> +       /*
> +        * The deferred work is increased by any new work (delta) that wasn't
> +        * done, decreased by old deferred work that was done now.
> +        *
> +        * And it is capped to two times of the freeable items.
> +        */
> +       next_deferred = max_t(long, (nr + delta - scanned), 0);
> +       next_deferred = min(next_deferred, (2 * freeable));
> +
>         /*
>          * move the unused scan count back into the shrinker in a
>          * manner that handles concurrent updates.
> --
> 2.26.2
>
