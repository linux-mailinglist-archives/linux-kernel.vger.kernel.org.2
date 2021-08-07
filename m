Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD2DB3E3275
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 03:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbhHGBBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 21:01:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbhHGBBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 21:01:22 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F23BC0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Aug 2021 18:01:04 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id m18so3052747ljo.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Aug 2021 18:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lFDTbK4kGubvDTyFFXN3Ym+4Q093+Na93/G8Bi3cS7Y=;
        b=mCJbnKvLyEzDA6Cn+iY7Em+qPhsjpXa35c4YZ3tPOVSxV8PBNCDEp4UZYCkweIEP1w
         ZCiqocBVjnSqOXDak709uHM3k1oeHnIDr0E4MJtV9MWGOdhm4L3sPfbzyZT3X+D1eEMQ
         Dxgh4Ob3VChTev2EhE5PWaNjti+LKd0x1bHcdtR5mDFQUBjsXdJd8kzFhIf835E2W6av
         hpEhXS96oZSr9Z172xksyL2DOk8TcorIyBgrTuCbQiMssxzqdSUtisFEsMyNQ+3Vzz7o
         tFEs21rmI2n8WycYzqP4N3lVNolh4ZhiEUJ8xMw+tOGLSVwEeLTok/D/r5iJDkaDW6sl
         7cbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lFDTbK4kGubvDTyFFXN3Ym+4Q093+Na93/G8Bi3cS7Y=;
        b=RxDCnrYB2qFeNDp9VbH9UH5W6x1+6gL9Jxb1nDSR1iPoItEgyaPpAvdsv0dkOaGO/c
         E/D1BRPtMHijJTJZkAk/GOfDc+YOekr5nSQ9OAU40CDgOSeUtaEds/CFPIpp8uTy1PSE
         rThv3LTyg00GX7cw6oX0DfkJGm9m+PBLxg5HC5k7azcSWz7IoQ4ZqXm2CP13zhvA2QXd
         1fr1EoHr6q5P9H33mKfNl6V9/Cs9+yFVog/0UApj0JBJVG4pVjpY22TTn0HEfQEU3nRw
         DFkTNdaWq790Eae/kKjFkIga9YKaD9wzNYQw1x23e+nVd/loUBaE6zMVQ4GJ473F4ntF
         urKA==
X-Gm-Message-State: AOAM532DKcnF64I5X50F3YgejolNoBEA9j/ZZWZCxhWwNg/qOh/oEDA/
        MrkVT2TJcbdpkxCASxno+SPXlEe8rFuhZEFt89T9aQ==
X-Google-Smtp-Source: ABdhPJzjxlGMC3Z5dtOugUnvqGp5PUm36eDXO4XwC+zCsv6WV6IB0+TnX5ciL+7ETNK8DJefYv5a2mxkTufwBOa3B8o=
X-Received: by 2002:a05:651c:906:: with SMTP id e6mr8043153ljq.160.1628298062735;
 Fri, 06 Aug 2021 18:01:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210806231701.106980-1-npache@redhat.com>
In-Reply-To: <20210806231701.106980-1-npache@redhat.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 6 Aug 2021 18:00:51 -0700
Message-ID: <CALvZod6gCof1bhVwdU7vYYKBRCn_HZBFi4BjSYoSK-dyrmswMA@mail.gmail.com>
Subject: Re: [PATCH] vm_swappiness=0 should still try to avoid swapping anon memory
To:     Nico Pache <npache@redhat.com>
Cc:     Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Rafael Aquini <aquini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 6, 2021 at 4:17 PM Nico Pache <npache@redhat.com> wrote:
>
> Since commit b91ac374346b ("mm: vmscan: enforce inactive:active ratio at the
> reclaim root") swappiness can start prematurely swapping anon memory.
> This is due to the assumption that refaulting anon should always allow
> the shrinker to target anon memory. Add a check for vm_swappiness being
> >0 before indiscriminately targeting Anon.

Did you actually observe this behavior?

>
> Signed-off-by: Nico Pache <npache@redhat.com>
> ---
>  mm/vmscan.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 4620df62f0ff..8b932ff72e37 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -2909,8 +2909,8 @@ static void shrink_node(pg_data_t *pgdat, struct scan_control *sc)
>
>                 refaults = lruvec_page_state(target_lruvec,
>                                 WORKINGSET_ACTIVATE_ANON);
> -               if (refaults != target_lruvec->refaults[0] ||
> -                       inactive_is_low(target_lruvec, LRU_INACTIVE_ANON))
> +               if (vm_swappiness && (refaults != target_lruvec->refaults[0] ||
> +                       inactive_is_low(target_lruvec, LRU_INACTIVE_ANON)))

If you are really seeing the said behavior then why will this fix it.
This is just about deactivating active anon LRU. I would rather look
at get_scan_count() to check why swappiness = 0 is still letting the
kernel to scan anon LRU. BTW in cgroup v1, the memcg can overwrite
their swappiness which will be preferred over system vm_swappiness.
Did you set system level swappiness or memcg one?

>                         sc->may_deactivate |= DEACTIVATE_ANON;
>                 else
>                         sc->may_deactivate &= ~DEACTIVATE_ANON;
> --
> 2.31.1
>
