Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09A1A3F1291
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 06:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbhHSEda (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 00:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbhHSEda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 00:33:30 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AEDDC061764
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 21:32:54 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id w5so9963094ejq.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 21:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ubfeGC8hBPINfgsfaFwyzQgBXCaEyQzf4aYBEpJp0fQ=;
        b=NNJy5EjqV0GKZWIhLKsPiB6DiVCBQLgu7nz8x77PoU04kkF/SmVxJSREKDeIlcAqyL
         TxPJNLQsYJ9ZDfW2soWi4nkJrJV7Y7hWwzevQxXkthOqdwcDLLPwX9qNuzdN0hiYVNrR
         dJPdrw7RxyMBT4iblu03kcx2QwRdwXUqN27MuI81HyfPuDlo7wXGE1SK82vU97xRc5RZ
         RKcuG5XJ4vuddClsldU1kaiFcKWVe08YyWgzsumSIUuLZoALiUldE1YcfnJ1D9kdmide
         bK68IWWzcJHGYdGx4KpWPfOyzFjBReEHslTKfO4fUIfMsM6gOt9ylI6h7Oyqc80JTGut
         1B5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ubfeGC8hBPINfgsfaFwyzQgBXCaEyQzf4aYBEpJp0fQ=;
        b=bCT9gvUeQRCeYF4auMXXuWKcaJEU7UKhUiUiebEXDY+PCZSy3rnI5zA+T5DLeuu1CT
         PRf+Rp4dnvD1SblJFElnxWYQiXiwYNOLo7ksiuR5C+8sDA/nmschQK32SpjG1KI9SDiE
         +YsWRPbnvxQWeemS0LLjSk4lysMqbq+/Vi5TDmTAmTgb8RaCx3RuDI/dTLpTlkSMyPrg
         mPS8BXKQde4N1cqqo93hHtN6QOCWmFkcIwFr6KgITG133QjDMzWX/dX6zYd0pkOjRVaw
         RVEJETHGQue15CH3Qg9PUU22VQshjtn0HM7ighFYYYB3Ex7JeaBxPxb5JDGwii17KSrR
         807g==
X-Gm-Message-State: AOAM530NckEqCRACjHaSPMubYbaWK7VA6/nRj2VwLfL9pxwb83HDrZkA
        fBmGOtNNJS39z+Vu9wY5bzx2gkvpmHVThmlkpxQ=
X-Google-Smtp-Source: ABdhPJymj0dcg1F2fDDKY1nPj9Zmh8COCKlBzdv9aIe0cQAu25nNsfWAI7ne8MKbt4B4lLMgyZthya6Xf95Kw2h490I=
X-Received: by 2002:a17:906:1f82:: with SMTP id t2mr13378982ejr.499.1629347572753;
 Wed, 18 Aug 2021 21:32:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210819001958.2365157-1-naoya.horiguchi@linux.dev>
In-Reply-To: <20210819001958.2365157-1-naoya.horiguchi@linux.dev>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 18 Aug 2021 21:32:41 -0700
Message-ID: <CAHbLzkpAEZRTmnOnjVHYHGJ7ApjdC8eDh53DAnTHsG185QGOfQ@mail.gmail.com>
Subject: Re: [PATCH v2] mm/hwpoison: Retry with shake_page() for unhandlable pages
To:     Naoya Horiguchi <naoya.horiguchi@linux.dev>
Cc:     Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tony Luck <tony.luck@intel.com>,
        Oscar Salvador <osalvador@suse.de>,
        Muchun Song <songmuchun@bytedance.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 18, 2021 at 5:20 PM Naoya Horiguchi
<naoya.horiguchi@linux.dev> wrote:
>
> From: Naoya Horiguchi <naoya.horiguchi@nec.com>
>
> HWPoisonHandlable() sometimes returns false for typical user pages
> due to races with average memory events like transfers over LRU lists.
> This causes failures in hwpoison handling.
>
> There's retry code for such a case but does not work because the retry
> loop reaches the retry limit too quickly before the page settles down to
> handlable state. Let get_any_page() call shake_page() to fix it.
>
> Fixes: 25182f05ffed ("mm,hwpoison: fix race with hugetlb page allocation")
> Reported-by: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
> Cc: stable@vger.kernel.org # 5.13
> ---
> ChangeLog v2:
> - get_any_page() return -EIO when retry limit reached (by Yang Shi)

Thanks for taking this. The fix looks good to me. Reviewed-by: Yang
Shi <shy828301@gmail.com>

> ---
>  mm/memory-failure.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git v5.14-rc6/mm/memory-failure.c v5.14-rc6_patched/mm/memory-failure.c
> index eefd823deb67..470400cc7513 100644
> --- v5.14-rc6/mm/memory-failure.c
> +++ v5.14-rc6_patched/mm/memory-failure.c
> @@ -1146,7 +1146,7 @@ static int __get_hwpoison_page(struct page *page)
>          * unexpected races caused by taking a page refcount.
>          */
>         if (!HWPoisonHandlable(head))
> -               return 0;
> +               return -EBUSY;
>
>         if (PageTransHuge(head)) {
>                 /*
> @@ -1199,9 +1199,15 @@ static int get_any_page(struct page *p, unsigned long flags)
>                         }
>                         goto out;
>                 } else if (ret == -EBUSY) {
> -                       /* We raced with freeing huge page to buddy, retry. */
> -                       if (pass++ < 3)
> +                       /*
> +                        * We raced with (possibly temporary) unhandlable
> +                        * page, retry.
> +                        */
> +                       if (pass++ < 3) {
> +                               shake_page(p, 1);
>                                 goto try_again;
> +                       }
> +                       ret = -EIO;
>                         goto out;
>                 }
>         }
> --
> 2.25.1
>
>
