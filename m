Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D2D7308469
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 04:52:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231873AbhA2DvV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 22:51:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231517AbhA2DvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 22:51:01 -0500
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CF60C0613ED
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 19:50:16 -0800 (PST)
Received: by mail-vs1-xe2e.google.com with SMTP id p20so4208280vsq.7
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 19:50:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QXaGYzS0cYK7WboTigRhnstjhNV+KDyvFkcR1YY4X5M=;
        b=HS5Twc4X1YtXRU05Q97oJ4DrvOf8StA/SBXo9mR4bfXvcqPIZsOv9RXlwhkbw69lJS
         0ouJgK/HjaoNoYcyd2Wo9ViJwQMGLo2N8ddOeQPQVgGWe3iwKBXfoyf0EAJ+AjsmJjmD
         zNHBj/XhsGEQe5m1UUfNEIVUrm9gf7Jz0q4mo0WC5n8Z6yGH36i/d5cri81AJAC5+lvQ
         vPVttazNC8g7+ZcMQWcC8O6jaPRLPIFavaKUWXGfI3sRvjksQ1ivwAw9zKDP8nkpQn68
         Mg95a507L1Cs8Nuywkn6rkBirlwlEv+AHto3n4PCO70IaBCUpFkMJHnTo/HZ9n3wxufC
         bBYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QXaGYzS0cYK7WboTigRhnstjhNV+KDyvFkcR1YY4X5M=;
        b=BsPtJSfDox4TCHceKZ8K36V5qymlIUi0tNWVabskhemrkj5955CxOFQZkkkyF1NL+j
         dIxk8uE3PAVhhk23KG2kUZiVjDOdXURFH/udbDlk56Q5U4taSiZkiUgMKsKl4JbYC7so
         ELW2q5jye1RiFVBDU4moi++Yu1nGz9E8LjG/w4lHGRE2Xb8Nh9qtYaL8Tu1MyiZz3j9p
         LOSpfoXORD7kxT2ZgJNttVV84p3Jk8EJqAnU055lYyzsSoENGtEwXQZLTPJZf77vr7yg
         RYBvGZgw93rbRyNUy/faTQ1/hnnbkUnscQfxVrdhpdSxraDjRYJ79CXYp43mnUHAqIhT
         3azA==
X-Gm-Message-State: AOAM530jmDgt2ILEdKWyvu6013YH/+IolKC4XxpVRon+rYiAj46fz2dG
        myOFzmfcDYB08HUJ/5iaySMhOAIQaKKDJmCYxQ8=
X-Google-Smtp-Source: ABdhPJxur3FY3X4RFwf3XUEzzC/DUg0CFdTPYbmbqZOa/dtWuKF3IShJ4hzG3xPrAmlxqKRhqixH3/0ASVgRrHNnAoo=
X-Received: by 2002:a67:fbcf:: with SMTP id o15mr1542804vsr.59.1611892215565;
 Thu, 28 Jan 2021 19:50:15 -0800 (PST)
MIME-Version: 1.0
References: <20210128112028.64831-1-linmiaohe@huawei.com>
In-Reply-To: <20210128112028.64831-1-linmiaohe@huawei.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Fri, 29 Jan 2021 09:20:03 +0530
Message-ID: <CAFqt6zYX5f5Vf_S838XdnjTyLmDsmS+2OS16HpMuzjJjKhS5PQ@mail.gmail.com>
Subject: Re: [PATCH] mm/hugetlb: Fix some comment typos
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Linux-MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 28, 2021 at 4:50 PM Miaohe Lin <linmiaohe@huawei.com> wrote:
>
> Fix typos sasitfy to satisfy, reservtion to reservation, hugegpage to
> hugepage and uniprocesor to uniprocessor in comments.
>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Reviewed-by: Souptick Joarder <jrdr.linux@gmail.com>

> ---
>  include/linux/hugetlb.h | 2 +-
>  mm/hugetlb.c            | 6 +++---
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index ef5b144b8aac..95a5a239c8f2 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -37,7 +37,7 @@ struct hugepage_subpool {
>         struct hstate *hstate;
>         long min_hpages;        /* Minimum huge pages or -1 if no minimum. */
>         long rsv_hpages;        /* Pages reserved against global pool to */
> -                               /* sasitfy minimum size. */
> +                               /* satisfy minimum size. */
>  };
>
>  struct resv_map {
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 53ea65d1c5ab..c42c61c2653e 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1444,7 +1444,7 @@ static void __free_huge_page(struct page *page)
>          * reservation.  If the page was associated with a subpool, there
>          * would have been a page reserved in the subpool before allocation
>          * via hugepage_subpool_get_pages().  Since we are 'restoring' the
> -        * reservtion, do not call hugepage_subpool_put_pages() as this will
> +        * reservation, do not call hugepage_subpool_put_pages() as this will
>          * remove the reserved page from the subpool.
>          */
>         if (!restore_reserve) {
> @@ -3715,7 +3715,7 @@ static unsigned long hugetlb_vm_op_pagesize(struct vm_area_struct *vma)
>  /*
>   * We cannot handle pagefaults against hugetlb pages at all.  They cause
>   * handle_mm_fault() to try to instantiate regular-sized pages in the
> - * hugegpage VMA.  do_page_fault() is supposed to trap this, so BUG is we get
> + * hugepage VMA.  do_page_fault() is supposed to trap this, so BUG is we get
>   * this far.
>   */
>  static vm_fault_t hugetlb_vm_op_fault(struct vm_fault *vmf)
> @@ -4513,7 +4513,7 @@ u32 hugetlb_fault_mutex_hash(struct address_space *mapping, pgoff_t idx)
>  }
>  #else
>  /*
> - * For uniprocesor systems we always use a single mutex, so just
> + * For uniprocessor systems we always use a single mutex, so just
>   * return 0 and avoid the hashing overhead.
>   */
>  u32 hugetlb_fault_mutex_hash(struct address_space *mapping, pgoff_t idx)
> --
> 2.19.1
>
>
