Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3983D43BEC1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 03:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236708AbhJ0BIi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 21:08:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231388AbhJ0BIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 21:08:36 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 652A3C061570
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 18:06:11 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id m17so3539657edc.12
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 18:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NPnUcmJPzNpCJmNXKCtVtKSaoCA98/bc9kV85ZHfaes=;
        b=XJ09VHpESCkBAhdldJec7DvCtjMADGQMfzgfBYZ6uWOzxyrYhRV4eYoragSCgUmwW3
         UVw347B0XFDFJeqI9wax7oGzTZOnUmzCS9sqJs4nEFGHGu73wU1iz4m0NBtl8z6GvR8L
         EZyVkrkQF0Bc05pCR6vIgfXvEAb0L0Kbd+sYSOd1JZZw9zYH3mSvhb0BZ13F9kLqefs2
         AbhfA5okotf6IIxHb+cVjxMpzL7b9XlI8+0bsU0fHHUrO/ETNcA6eT0i76nbqqb+sDe6
         rDBnAQHWzW1XCGfxn96IR5Fqwv7z+1/oMCVeHx84y2MTNRMEpVrgrBn48dWZEckvqxRr
         FeDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NPnUcmJPzNpCJmNXKCtVtKSaoCA98/bc9kV85ZHfaes=;
        b=3Wistwz6mkLGF4fqEIKPO1Xr+mB4w8kvljpTOXdxPw2/ZXL4EpVhhV1E7bu89x8dRW
         NCJH5TKTpkWLQ2PNFWioFhO/D2FqTJ7ETal8+p980RzBk6lyECMDAxYEPWAGyaneRNXT
         qSwZuvaQpkIx+n0RU4GQ57Cy0xZuJ8jncGIbBD067aNa8cTA0Xr5fVA379VWBLwkdPnu
         f4rRKC4F4VOkiUCVdJkpNVPIJZyPWuaUUGGOpX7fPNq4r/4djXcMpF4OixnhNjzF89xg
         s+/8vL9y87c2NsUAbva64+Yp+DguQ8+d5XvTwYKIocl/MNOcRqXv6jbrH/3yL58i+BAs
         1fgQ==
X-Gm-Message-State: AOAM531KtoVqpiO+q7yFJWo9+BtWhrX/akFE+Ur4YHm7b1JrP4qd2Nyg
        70+CGRCQ8SfZpzTeDVflUGia0aqgqWo3XzPWKRA=
X-Google-Smtp-Source: ABdhPJyYlUgv07QHHv4dW6RoVdU5DdRP0hixAlGaLsxi29olLji1br9tTKT9PkJBOidiy1eJChMuh3+ofIUcO6nKFX8=
X-Received: by 2002:a17:907:3f83:: with SMTP id hr3mr34792062ejc.555.1635296770056;
 Tue, 26 Oct 2021 18:06:10 -0700 (PDT)
MIME-Version: 1.0
References: <20211025230503.2650970-1-naoya.horiguchi@linux.dev> <20211025231120.GA2651146@u2004>
In-Reply-To: <20211025231120.GA2651146@u2004>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 26 Oct 2021 18:05:58 -0700
Message-ID: <CAHbLzkr=h3U9tVS=Xz0wQMypMAK2SXrhuY-WazJVAkbCDxfh6g@mail.gmail.com>
Subject: Re: [PATCH 3/4] mm/hwpoison: remove MF_MSG_BUDDY_2ND and MF_MSG_POISONED_HUGE
To:     Naoya Horiguchi <nao.horiguchi@gmail.com>
Cc:     Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        Ding Hui <dinghui@sangfor.com.cn>,
        Tony Luck <tony.luck@intel.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Peter Xu <peterx@redhat.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 25, 2021 at 4:14 PM Naoya Horiguchi <nao.horiguchi@gmail.com> wrote:
>
> (I failed to send patch 3/4 and 4/4 due to the ratelimit of linux.dev,
> so I switched mail server...)
>
> From: Naoya Horiguchi <naoya.horiguchi@nec.com>
>
> These action_page_types are no longer used, so remove them.
>
> Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>

Acked-by: Yang Shi <shy828301@gmail.com>

> ---
>  include/linux/mm.h      | 2 --
>  include/ras/ras_event.h | 2 --
>  mm/memory-failure.c     | 2 --
>  3 files changed, 6 deletions(-)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index a3229f609856..71d886470d71 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -3246,7 +3246,6 @@ enum mf_action_page_type {
>         MF_MSG_KERNEL_HIGH_ORDER,
>         MF_MSG_SLAB,
>         MF_MSG_DIFFERENT_COMPOUND,
> -       MF_MSG_POISONED_HUGE,
>         MF_MSG_HUGE,
>         MF_MSG_FREE_HUGE,
>         MF_MSG_NON_PMD_HUGE,
> @@ -3261,7 +3260,6 @@ enum mf_action_page_type {
>         MF_MSG_CLEAN_LRU,
>         MF_MSG_TRUNCATED_LRU,
>         MF_MSG_BUDDY,
> -       MF_MSG_BUDDY_2ND,
>         MF_MSG_DAX,
>         MF_MSG_UNSPLIT_THP,
>         MF_MSG_UNKNOWN,
> diff --git a/include/ras/ras_event.h b/include/ras/ras_event.h
> index 0bdbc0d17d2f..d0337a41141c 100644
> --- a/include/ras/ras_event.h
> +++ b/include/ras/ras_event.h
> @@ -358,7 +358,6 @@ TRACE_EVENT(aer_event,
>         EM ( MF_MSG_KERNEL_HIGH_ORDER, "high-order kernel page" )       \
>         EM ( MF_MSG_SLAB, "kernel slab page" )                          \
>         EM ( MF_MSG_DIFFERENT_COMPOUND, "different compound page after locking" ) \
> -       EM ( MF_MSG_POISONED_HUGE, "huge page already hardware poisoned" )      \
>         EM ( MF_MSG_HUGE, "huge page" )                                 \
>         EM ( MF_MSG_FREE_HUGE, "free huge page" )                       \
>         EM ( MF_MSG_NON_PMD_HUGE, "non-pmd-sized huge page" )           \
> @@ -373,7 +372,6 @@ TRACE_EVENT(aer_event,
>         EM ( MF_MSG_CLEAN_LRU, "clean LRU page" )                       \
>         EM ( MF_MSG_TRUNCATED_LRU, "already truncated LRU page" )       \
>         EM ( MF_MSG_BUDDY, "free buddy page" )                          \
> -       EM ( MF_MSG_BUDDY_2ND, "free buddy page (2nd try)" )            \
>         EM ( MF_MSG_DAX, "dax page" )                                   \
>         EM ( MF_MSG_UNSPLIT_THP, "unsplit thp" )                        \
>         EMe ( MF_MSG_UNKNOWN, "unknown page" )
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index a47b741ca04b..09f079987928 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -723,7 +723,6 @@ static const char * const action_page_types[] = {
>         [MF_MSG_KERNEL_HIGH_ORDER]      = "high-order kernel page",
>         [MF_MSG_SLAB]                   = "kernel slab page",
>         [MF_MSG_DIFFERENT_COMPOUND]     = "different compound page after locking",
> -       [MF_MSG_POISONED_HUGE]          = "huge page already hardware poisoned",
>         [MF_MSG_HUGE]                   = "huge page",
>         [MF_MSG_FREE_HUGE]              = "free huge page",
>         [MF_MSG_NON_PMD_HUGE]           = "non-pmd-sized huge page",
> @@ -738,7 +737,6 @@ static const char * const action_page_types[] = {
>         [MF_MSG_CLEAN_LRU]              = "clean LRU page",
>         [MF_MSG_TRUNCATED_LRU]          = "already truncated LRU page",
>         [MF_MSG_BUDDY]                  = "free buddy page",
> -       [MF_MSG_BUDDY_2ND]              = "free buddy page (2nd try)",
>         [MF_MSG_DAX]                    = "dax page",
>         [MF_MSG_UNSPLIT_THP]            = "unsplit thp",
>         [MF_MSG_UNKNOWN]                = "unknown page",
> --
> 2.25.1
>
>
>
>
>
>
>
>
>
>
>
>
> From: Naoya Horiguchi <nao.horiguchi@gmail.com>
> To:
> Cc:
> Bcc: nao.horiguchi@gmail.com
> Subject:
> Reply-To:
>
