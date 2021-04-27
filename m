Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCA4936CDD5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 23:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239271AbhD0VXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 17:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238817AbhD0VXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 17:23:46 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2678BC061574
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 14:23:01 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id u21so91522365ejo.13
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 14:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hnD8S3GSKseiEg2y//OaeV3NCBwwk6P677uvsqZialc=;
        b=C375EiuxQe+q6YfYFPhoQmMqYCj0G5EsXD4JzemmRV3XdpXM/vpTm6ZS6y5rHissSA
         iZp9GCyeIC1zV7co6V0yzuWx7vaFVSUE/CBcTT2Dd/lWkN5r3NHA9eF59bIYO51n2tBQ
         TEubXGgqSVg16ljLAZx2cnQnm8RdU3uRb60UVtuiwmSqgWbtiK43g/YtCbeAz8mbglvQ
         +QX+6u3cXPZbcXgTEcK30JP7KUxIsbQXh2QB85CGY5D4htFPacKXQ1V99XkZYG/TmqFu
         E/Gm4/Wek1jfQ06PsK7XfuxlbyqlmQTu1/QWK5YMnjwVjY+KpWKP7Kwm/0jLcYnvgh0y
         WCfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hnD8S3GSKseiEg2y//OaeV3NCBwwk6P677uvsqZialc=;
        b=tVOx9T5Hjn/y92HaUSWDawS0FZZdXUjGyUchicWRYY2M4lC18Bmw7iIjrqbcS9DRpX
         tiM00p20cnuToAAuodHvgDI/V5dhuTL2yYs9/I2MibUSpOyRn3QgUm/UevRrhNeqKKFt
         RcK1zHoei7KMKQMsQ3YbGHRW1csjjZx7yLNLrceQOkwjiiq4ToXCL85khEpYgchViBLP
         65b1ckNj3GbTWUWFGPsKKBNQvC4IFBOXuUujB9rovkKL8zNSoBf0azcIcjoE+vlgy5sE
         u2FcM8rjGUmaVZkP2sUjc2nfS/U6H16eN7InbcjSL6M0TI0FZqGI3cWYb2pbSK/POsjC
         6eYg==
X-Gm-Message-State: AOAM532vkJBf6Qu2kC52uD0aj8NxpXyBBbjG5pm34pYhz6Q5+NyCo+Ml
        zkbn+zJrAFZSjBnd46aflYk6OYozR7NuIe4k0EI=
X-Google-Smtp-Source: ABdhPJxOqPpxFTf/VZYgX9bWGZGoHkiXHtK+vERnLmAHPlIgknmxoJe0lLWFF9bCfQQePgWAiNcWT1T0l8W2vx4FdHw=
X-Received: by 2002:a17:906:ece4:: with SMTP id qt4mr25719376ejb.514.1619558579904;
 Tue, 27 Apr 2021 14:22:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210427133214.2270207-1-linmiaohe@huawei.com> <20210427133214.2270207-6-linmiaohe@huawei.com>
In-Reply-To: <20210427133214.2270207-6-linmiaohe@huawei.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 27 Apr 2021 14:22:48 -0700
Message-ID: <CAHbLzkrYqKw+iF_+sDccyBEAsRySTPKyhd01p9f6KV0FLLAbnQ@mail.gmail.com>
Subject: Re: [PATCH 5/5] mm/huge_memory.c: don't discard hugepage if other
 processes are mapping it
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>,
        william.kucharski@oracle.com, Matthew Wilcox <willy@infradead.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        aneesh.kumar@linux.ibm.com, Ralph Campbell <rcampbell@nvidia.com>,
        Song Liu <songliubraving@fb.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Rik van Riel <riel@surriel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Minchan Kim <minchan@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 27, 2021 at 6:32 AM Miaohe Lin <linmiaohe@huawei.com> wrote:
>
> If other processes are mapping any other subpages of the hugepage, i.e. in
> pte-mapped thp case, page_mapcount() will return 1 incorrectly. Then we
> would discard the page while other processes are still mapping it. Fix it
> by using total_mapcount() which can tell whether other processes are still
> mapping it.

Seems correct to me. It is possible that the THP is PTE-mapped by the
other processes.

Reviewed-by: Yang Shi <shy828301@gmail.com>

>
> Fixes: b8d3c4c3009d ("mm/huge_memory.c: don't split THP page when MADV_FREE syscall is called")
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  mm/huge_memory.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index f652be6ecca3..d14fecb8cd00 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -1604,7 +1604,7 @@ bool madvise_free_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
>          * If other processes are mapping this page, we couldn't discard
>          * the page unless they all do MADV_FREE so let's skip the page.
>          */
> -       if (page_mapcount(page) != 1)
> +       if (total_mapcount(page) != 1)
>                 goto out;
>
>         if (!trylock_page(page))
> --
> 2.23.0
>
>
