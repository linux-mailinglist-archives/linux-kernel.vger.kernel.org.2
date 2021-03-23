Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98241346623
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 18:19:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbhCWRS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 13:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbhCWRSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 13:18:02 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 470FCC061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 10:18:02 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a7so28367897ejs.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 10:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sIksllOwwOhhczn6psOt0I0GoHXhkwJmcDYhamv8gKE=;
        b=vSZ2XfjPA7Q0x7nDslI0TUHCfgjE8OzQMOyiNBobfPbkI7lBvvFArrtxoeDIweJhPl
         8JHZOJTEfIN6cYo/3ONtzOz9XyV/C/Vyrb/R6bUfDuZWuDjZWUOsg+XY8wQfiHn8anFp
         NM496MAMALYcNbbsrGFVgyFgWqCos84G/R0MK46SuowtveMtrjpGirzN8vpR9zQIVz/l
         ej7DRfCobng5+6YzAzAgL1CJOA3zSyREUFYJ/+gUv/Yyr2wZgUmeVGLPyJuWTN/V3T1A
         NrnV3ziZIMZSj47PoXTFhNY0ghO/BugGK9eIjMuUeDl5riC1yWLStB+wjJtX01YDeeRk
         dkUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sIksllOwwOhhczn6psOt0I0GoHXhkwJmcDYhamv8gKE=;
        b=N5HWRa6lhgAAQKLzZul5Gw8i07D7+550xVZkb+JJESYHxRW9MkOrHsJW+8I1j8hevS
         Ngpf6JIomAiIDPqvzazhRa9lFOGfxOHZ2E//tWXSxYWdpGQV8Zv8RnCOlzxTZBOmMus9
         ZZgyHu9aeglA99Fe62g/8h1Pl2QKrtTPuBHc5hji/oy+2Ml6bG3eF4ctkHpE8yTAuTGh
         FX7jOCKvQ2ljcgmq752VYA3vhgw7GCscbeu1P2hyWOyc7MOJTRnYgpCjAv5085onlWrY
         WY0ymF2yXY6OPPENny4kUwfPvettAPlYq7P4d+EDckqQnKExETII3Y+d65kwDNj42+VC
         1Wjg==
X-Gm-Message-State: AOAM531+7wwGyn0LhL/mqyRWzs1aCt8x4QQ9HNcXUi2dozvGlR7M5pQi
        9BzTxm6kEFjzBWchNsIARdIz/NEfidXesxFIfkQ=
X-Google-Smtp-Source: ABdhPJwU2t5vL8Vrp8UxhxH5Rh72ecVZHaOXV1n09OFWS/tmbQifotHY4rvMhWKy6CC87aCytJUDsCpsRi6eSvqyKx0=
X-Received: by 2002:a17:906:a51:: with SMTP id x17mr5954970ejf.25.1616519881066;
 Tue, 23 Mar 2021 10:18:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210323135405.65059-1-linmiaohe@huawei.com> <20210323135405.65059-6-linmiaohe@huawei.com>
In-Reply-To: <20210323135405.65059-6-linmiaohe@huawei.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 23 Mar 2021 10:17:48 -0700
Message-ID: <CAHbLzkoSsPWSdyZQBR03NbU8i3AG_DTL4P-efYULvuYmWzyYbg@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] mm/migrate.c: fix potential deadlock in NUMA
 balancing shared exec THP case
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jerome Glisse <jglisse@redhat.com>,
        Rafael Aquini <aquini@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Alistair Popple <apopple@nvidia.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 23, 2021 at 6:55 AM Miaohe Lin <linmiaohe@huawei.com> wrote:
>
> Since commit c77c5cbafe54 ("mm: migrate: skip shared exec THP for NUMA
> balancing"), the NUMA balancing would skip shared exec transhuge page.
> But this enhancement is not suitable for transhuge page. Because it's
> required that page_mapcount() must be 1 due to no migration pte dance
> is done here. On the other hand, the shared exec transhuge page will
> leave the migrate_misplaced_page() with pte entry untouched and page
> locked. Thus pagefault for NUMA will be triggered again and deadlock
> occurs when we start waiting for the page lock held by ourselves.

Thanks for catching this. By relooking the code I think the other
important reason for removing this is
migrate_misplaced_transhuge_page() actually can't see shared exec file
THP at all since page_lock_anon_vma_read() is called before and if
page is not anonymous page it will just restore the PMD without
migrating anything.

The pages for private mapped file vma may be anonymous pages due to
COW but they can't be THP so it won't trigger THP numa fault at all. I
think this is why no bug was reported. I overlooked this in the first
place.

Your fix is correct, and please add the above justification to your commit log.

Reviewed-by: Yang Shi <shy828301@gmail.com>

>
> Fixes: c77c5cbafe54 ("mm: migrate: skip shared exec THP for NUMA balancing")
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  mm/migrate.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 5357a8527ca2..68bfa1625898 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -2192,9 +2192,6 @@ int migrate_misplaced_transhuge_page(struct mm_struct *mm,
>         int page_lru = page_is_file_lru(page);
>         unsigned long start = address & HPAGE_PMD_MASK;
>
> -       if (is_shared_exec_page(vma, page))
> -               goto out;
> -
>         new_page = alloc_pages_node(node,
>                 (GFP_TRANSHUGE_LIGHT | __GFP_THISNODE),
>                 HPAGE_PMD_ORDER);
> @@ -2306,7 +2303,6 @@ int migrate_misplaced_transhuge_page(struct mm_struct *mm,
>
>  out_unlock:
>         unlock_page(page);
> -out:
>         put_page(page);
>         return 0;
>  }
> --
> 2.19.1
>
