Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9DDE32F0A9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 18:05:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231426AbhCERFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 12:05:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231327AbhCEREj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 12:04:39 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E0E9C061574
        for <linux-kernel@vger.kernel.org>; Fri,  5 Mar 2021 09:04:39 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id x29so1792769pgk.6
        for <linux-kernel@vger.kernel.org>; Fri, 05 Mar 2021 09:04:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VCvImFx+wjxWiBbU2aABnmv0wEUTxntHCJc3sPTuzt0=;
        b=dXaqm+VxNg2RViHBaZ0HAsG7Ly1wCaEY1w/LvaKxbzoEWPkTUmsgeCynvu6OmZIeoy
         gNawnUoFWo84SIk7OsyslEzNAMqD9mTawzcbJcZUIibf+9FOhJ2RN7XwByJhlaFrJaaf
         VnRMSyLVTkrBlB3qRagyt263D71B8YXt7MAMiTTfTetWqMEbLqdsv5meS2q1KmsjTidz
         UCZcOWy16Uo7UB2JcmkQkFUA5d4BU5fhQWBN2LnyOgtXl9kPfg3a10BGFQt2wQBYwQbO
         gZyToCRDOjSZz+ZWolm3WfPAi0aFwfti1SHI1WehYDHKour6MlASvLR9WUc6XaH7e4H2
         Yasg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VCvImFx+wjxWiBbU2aABnmv0wEUTxntHCJc3sPTuzt0=;
        b=CDMSQb6h2s1btprzF216XnCQhOjYyi9us9WxhNPgMUU2HyTFMdcBv+fIwUNtODFasQ
         YFywf1ElCJkl2RyLZXMsYEgKDOs5G2WEzpkRFQmCVDt5Z9lTUyebqydbf6djMc76igoF
         DXCo2QJp9WcR/WCmgHACLZlvfzcv2oTSehogHqIO3r30ui6RbgmSS32+9oV8FIsIOR53
         F8mXXDEm85Us7x9thDkfWbggdtyImuDSlp8EXOyCTAwjdbVuNaQEuyy6iW4okQTLx7EE
         FSpJpSJYiCbowqIUYGka/ll730OQQwixKTJPxrD0P5lk/9R3+q93MFZ4SOcL5RbhToBo
         B6qA==
X-Gm-Message-State: AOAM531smfTjhQE19e/IYCYxZ3lTq3KC7RVi3xMKcNisDKLhjNGaXPzq
        Pk4Gy6D/T7/Oz3X87BQ6m//34Th4ehSlBJlYCnZmvQ==
X-Google-Smtp-Source: ABdhPJxAX3ppZx/J43oBs600LSSxe6ehgcl1hfWycwnFOzRGOHGJWpPGSwRgxxf0J1SX3/CfsvapDRc/SDafh54WYOw=
X-Received: by 2002:a62:38c8:0:b029:1ef:21ba:aba3 with SMTP id
 f191-20020a6238c80000b02901ef21baaba3mr8126629pfa.24.1614963878391; Fri, 05
 Mar 2021 09:04:38 -0800 (PST)
MIME-Version: 1.0
References: <1aa83e48627978de8068d5e3314185f3a0d7a849.1614302398.git.andreyknvl@google.com>
In-Reply-To: <1aa83e48627978de8068d5e3314185f3a0d7a849.1614302398.git.andreyknvl@google.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Fri, 5 Mar 2021 18:04:27 +0100
Message-ID: <CAAeHK+wyh=vpw=Gbi+NqZ0A1z-0a8pQS8q0OkOfLc9o=zhMEUA@mail.gmail.com>
Subject: Re: [PATCH] kasan, mm: fix crash with HW_TAGS and DEBUG_PAGEALLOC
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 26, 2021 at 2:25 AM Andrey Konovalov <andreyknvl@google.com> wrote:
>
> Currently, kasan_free_nondeferred_pages()->kasan_free_pages() is called
> after debug_pagealloc_unmap_pages(). This causes a crash when
> debug_pagealloc is enabled, as HW_TAGS KASAN can't set tags on an
> unmapped page.
>
> This patch puts kasan_free_nondeferred_pages() before
> debug_pagealloc_unmap_pages().
>
> Besides fixing the crash, this also makes the annotation order consistent
> with debug_pagealloc_map_pages() preceding kasan_alloc_pages().
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> ---
>  mm/page_alloc.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index c89e7b107514..54bc237fd319 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1311,10 +1311,14 @@ static __always_inline bool free_pages_prepare(struct page *page,
>          */
>         arch_free_page(page, order);
>
> -       debug_pagealloc_unmap_pages(page, 1 << order);
> -
> +       /*
> +        * With hardware tag-based KASAN, memory tags must be set
> +        * before unmapping the page with debug_pagealloc.
> +        */
>         kasan_free_nondeferred_pages(page, order, fpi_flags);

Looking at this again, I think we need to move kasan_() callback above
arch_free_page(), as that can also make the page unavailable. I'll
send v2.
