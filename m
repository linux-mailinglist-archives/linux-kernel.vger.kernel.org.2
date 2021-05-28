Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15E2B393B87
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 04:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235597AbhE1CpE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 22:45:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbhE1CpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 22:45:04 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35D10C061574
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 19:43:29 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id g24so1691492pji.4
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 19:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WK7OvhFGEkm9+yUjk0yhj08hvOUVzO8BEh+bcJphobk=;
        b=YVjm2iFD/iidjeX+pAgz/60ykJQDrsKhPPU2W4DajsYYUtCikdjC++gYgPHMKw+ha2
         L6jkmHnk/A514N42ePVMmOnSbYqbp7F/nsrqABYE1eU5X1wcty7JvU53CjaDviI4KhVB
         nuZ0XZpInEU6QqKu2jzbeN7Z9A7XfIDvmbFADQYmQGZ3sBpP816cvILTECCoUhYi0a5h
         G1MvSYzeYFIes44hCHSba9PrSAlFtbIkSV1hmJ8Y3t3wDB91NkT78AKZCmbGvk52DYMf
         ATkdNn9tBLkz1kwFIwe1mIKVwP66kQ0EYv+NQqd10pmBKJRXY2jMqvcQI/5VqJWLjSS0
         DyPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WK7OvhFGEkm9+yUjk0yhj08hvOUVzO8BEh+bcJphobk=;
        b=bnH34kM5V7mSIKDVbhLaiomCsCXW8py9Y5Amywd2YpileE7vVvLYxMhnynNiNESnIT
         NxXqDZyvigmlx81ZnFgPcvmEO+Xx5odwW4R+N6RYWt3rqENO90AB7n2o/PQMQJQwX0eH
         8loxwndbN0gFYBlCl/zmpvlykk95M4kNYWfCmh5OWZPbOpndt9mpy178MBbbmy47+QGC
         DgUH4nV/UbaWFgGuzsmvk5KcCWMg0AAxvDtM/ET6e9pLmu13ME4OQKeDvkqUYw1ChXbU
         SjO68GMn3mJGzO3hhYnelZzAHL3yAByPz8LoRD2mPE+8zERwZLSDMnI7cVfayB4xpJo2
         GRYg==
X-Gm-Message-State: AOAM531pR+H3hUhXfPGWixNNTKsgOimIME2Kk9a5xnMYYkFvjEEIJLkY
        BpQ3rCaRsYfkV7ivA2rfjEASfLLCLOqZS+c2yOL46BIhPFCj6Q7S
X-Google-Smtp-Source: ABdhPJzLyme5Cu7erOyOPnEVb3k7CpFuGVYCuJq2UiCSfbZOQyFIm5M+EW929Cl9bzFGapFhADyFhnKJkSsm6edOS0E=
X-Received: by 2002:a17:902:d2c8:b029:fe:cd9a:a6bb with SMTP id
 n8-20020a170902d2c8b02900fecd9aa6bbmr5329743plc.34.1622169808671; Thu, 27 May
 2021 19:43:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210527231225.226987-1-mike.kravetz@oracle.com>
In-Reply-To: <20210527231225.226987-1-mike.kravetz@oracle.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Fri, 28 May 2021 10:42:52 +0800
Message-ID: <CAMZfGtUEuPB8B0Nn3pk-+CRQUrhwOHKhWRjMyFU0AWazT102TA@mail.gmail.com>
Subject: Re: [External] [PATCH] mm: hugetlb: fix dissolve_free_huge_page use
 of tail/head page
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Linux-MM <linux-mm@kvack.org>, lkml <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 28, 2021 at 7:12 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> The routine dissolve_free_huge_page can be passed the tail page of a
> hugetlb page.  The tail page is incorrectly passed on to the routines
> alloc_huge_page_vmemmap and add_hugetlb_page which expect a hugetlb
> head page.
>
> Operating on a tail page instead of head page could result in addressing
> exceptions or vmemmap corruption.
>
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> ---
> The code with this issue is only in mmotm (and next).  Specifically
> mm: hugetlb: alloc the vmemmap pages associated with each HugeTLB page
> Andrew, I assume you will fix in your tree.

Sorry. It's my bad commit. Thanks Mike for fixing this. I suspect this
should be squashed to "mm: hugetlb: alloc the vmemmap pages
associated with each HugeTLB page".

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.

>
>  mm/hugetlb.c            | 4 ++--
>  scripts/rust-version.sh | 0
>  2 files changed, 2 insertions(+), 2 deletions(-)
>  mode change 100644 => 100755 scripts/rust-version.sh
>
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 69a4b551c157..d2461c1f32dd 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1954,7 +1954,7 @@ int dissolve_free_huge_page(struct page *page)
>                  * Attempt to allocate vmemmmap here so that we can take
>                  * appropriate action on failure.
>                  */
> -               rc = alloc_huge_page_vmemmap(h, page);
> +               rc = alloc_huge_page_vmemmap(h, head);
>                 if (!rc) {
>                         /*
>                          * Move PageHWPoison flag from head page to the raw
> @@ -1968,7 +1968,7 @@ int dissolve_free_huge_page(struct page *page)
>                         update_and_free_page(h, head, false);
>                 } else {
>                         spin_lock_irq(&hugetlb_lock);
> -                       add_hugetlb_page(h, page, false);
> +                       add_hugetlb_page(h, head, false);
>                         h->max_huge_pages++;
>                         spin_unlock_irq(&hugetlb_lock);
>                 }
> diff --git a/scripts/rust-version.sh b/scripts/rust-version.sh
> old mode 100644
> new mode 100755
> --
> 2.31.1
>
