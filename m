Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E1AF3C6A9F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 08:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234036AbhGMGeg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 02:34:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233374AbhGMGef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 02:34:35 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC8EDC0613DD
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 23:31:44 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id b5-20020a17090a9905b029016fc06f6c5bso1454429pjp.5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 23:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Br8GUMFwUFegAxc9iJgZv/zXdT69t+A8Nufo1mD356g=;
        b=wao4cd/9u7fGjc9e560agRWg1B6OIVuJAjPDiC+lxPCIpySqZTqxcr06BmkQybfSzq
         /Ba9X9CZj6XIk/M0ss/En+B+/fdfvNHTkLLNnYgS3Qxs5NffHPD1zv0iznXcvws6QMwN
         S+smVHifljhWEjCtAZaMFKoAX229UwDDuGY9oK1VG3L0/Gp3A5bZOYO6MV8anSC0OsoX
         cCpz763mUTgY77HSUce4aHqMKac0ndLgrMI1BaGmHscBR4PSONgZQAphsPDRNzvl/+Lt
         MWNgwZr61GMQQJoCOdqSppSfXhApCd3vMz5EpX+PjPpOIuW2UqGbAs4ochiAjJ5G1vZl
         TIkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Br8GUMFwUFegAxc9iJgZv/zXdT69t+A8Nufo1mD356g=;
        b=H7Y1+TEH9a45AVYQsU6Kn3xeHncALY/6Rpsx6w6f0ZaHX/5ZshuWwqBj2gw0Mtty+G
         7Apr44UPhqB5xTIFue1xsuUFBaa3d/nt4L5pJVhtd1rJBi4VvbbnAEt8tBm2cheDp8G5
         Igi/DZJSZP8bnSRrgT41XKRoxnrX/RUpQfbNG/g/HNExzLNHHj+r//k3xmuF92/ohMSU
         n8iwld9CACDDGxSpEMWxvRYJIsBvwEOP7vdAHapD6z+gy/ne4jVeCEZhV1th1Jeh6RB6
         qbVr2RFukjkEb23fCF3Qp9M7dlA6lrEjqjtCWUPEFLftixSkVvufR8QxPFjUX75YchJ+
         jwWg==
X-Gm-Message-State: AOAM531i1741ygMTsmx0VnF6049wxzcikz5qPWer7EjR9wAwYt6gQCq0
        C9gR+bVD+DOsD22oBbzn5+A7RF4Faxb7Y1N9aBVz2w==
X-Google-Smtp-Source: ABdhPJz32PTvCL1DociLEj1FUp3UFQ1G2/2HInEOm1k/PEel8a/8ZFZgPD7P75Xp2i9SCuakpZAIXjALI1b/rQEnYhc=
X-Received: by 2002:a17:90a:5204:: with SMTP id v4mr17743612pjh.147.1626157904440;
 Mon, 12 Jul 2021 23:31:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210710002441.167759-1-mike.kravetz@oracle.com> <20210710002441.167759-2-mike.kravetz@oracle.com>
In-Reply-To: <20210710002441.167759-2-mike.kravetz@oracle.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Tue, 13 Jul 2021 14:31:08 +0800
Message-ID: <CAMZfGtU0LzeVE-mXY7-mEAWZcu-q7K_Lp+HL4+VuDDOnxFkkNQ@mail.gmail.com>
Subject: Re: [External] [PATCH 1/3] hugetlb: simplify prep_compound_gigantic_page
 ref count racing code
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Mina Almasry <almasrymina@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 10, 2021 at 8:25 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> Code in prep_compound_gigantic_page waits for a rcu grace period if it
> notices a temporarily inflated ref count on a tail page.  This was due
> to the identified potential race with speculative page cache references
> which could only last for a rcu grace period.  This is overly complicated
> as this situation is VERY unlikely to ever happen.  Instead, just quickly
> return an error.

Right. The race is very very small. IMHO, that does not complicate
the code is the right thing to do.

>
> Also, only print a warning in prep_compound_gigantic_page instead of
> multiple callers.
>
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> ---
>  mm/hugetlb.c | 15 +++++----------
>  1 file changed, 5 insertions(+), 10 deletions(-)
>
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 924553aa8f78..e59ebba63da7 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1657,16 +1657,12 @@ static bool prep_compound_gigantic_page(struct page *page, unsigned int order)
>                  * cache adding could take a ref on a 'to be' tail page.
>                  * We need to respect any increased ref count, and only set
>                  * the ref count to zero if count is currently 1.  If count
> -                * is not 1, we call synchronize_rcu in the hope that a rcu
> -                * grace period will cause ref count to drop and then retry.
> -                * If count is still inflated on retry we return an error and
> -                * must discard the pages.
> +                * is not 1, we return an error and caller must discard the
> +                * pages.

Shall we add more details about why we discard the pages?

Thanks.

>                  */
>                 if (!page_ref_freeze(p, 1)) {
> -                       pr_info("HugeTLB unexpected inflated ref count on freshly allocated page\n");
> -                       synchronize_rcu();
> -                       if (!page_ref_freeze(p, 1))
> -                               goto out_error;
> +                       pr_warn("HugeTLB page can not be used due to unexpected inflated ref count\n");
> +                       goto out_error;
>                 }
>                 set_page_count(p, 0);
>                 set_compound_head(p, page);
> @@ -1830,7 +1826,6 @@ static struct page *alloc_fresh_huge_page(struct hstate *h,
>                                 retry = true;
>                                 goto retry;
>                         }
> -                       pr_warn("HugeTLB page can not be used due to unexpected inflated ref count\n");
>                         return NULL;
>                 }
>         }
> @@ -2828,8 +2823,8 @@ static void __init gather_bootmem_prealloc(void)
>                         prep_new_huge_page(h, page, page_to_nid(page));
>                         put_page(page); /* add to the hugepage allocator */
>                 } else {
> +                       /* VERY unlikely inflated ref count on a tail page */
>                         free_gigantic_page(page, huge_page_order(h));
> -                       pr_warn("HugeTLB page can not be used due to unexpected inflated ref count\n");
>                 }
>
>                 /*
> --
> 2.31.1
>
