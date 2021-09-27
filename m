Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B347C418E64
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 06:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232594AbhI0Ejx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 00:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbhI0Eju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 00:39:50 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC4BEC061570;
        Sun, 26 Sep 2021 21:38:12 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id x7so49127644edd.6;
        Sun, 26 Sep 2021 21:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=83Uhs6ZL7h4cnl4M9YaZp+1cwFpz7hwB6M99EqA8Pek=;
        b=Wt/NNiCekc3wV4M98bGP4We81eFo45oWPb9JUhIjjHarMxCZFloPFPqM3DGq5qR2Xz
         DiH9zbth9nKe+0QEEfefJ/kMmqbGgvB+Sit1HZTEZ2STfJBRbzi9Gtgrar94Ub83TfcL
         OtESJn/asGAfl6CM5gNlX6ZvpceDUYsE0fcNIqqbxtAKsmmcNJSHNbqdOIHkYj2iDWD6
         qROIZ3bonVnvPWKldxMTuI3J/GjNVUAu6DQj+pYPZYX18QD8Z2BY5wAvEvF9jHAxzf9/
         RAGiDk3jrMST55boE5BE+by7r07xBkm0EcWwIJWr0GRPHv3xPfUT9H9x2x6mlh6i3vdR
         J//A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=83Uhs6ZL7h4cnl4M9YaZp+1cwFpz7hwB6M99EqA8Pek=;
        b=5BVkkWqOJD1apY8MVJTRVETX0PhnYH+BTnyxKnMWs+naSy0kHhVxCu7Vq9aGy7POfc
         hL+6Q9mYlaOZwT2E/uajz9gfG03OodYOqnByH+FBlk7Z6pO6c1EZm28NLyuT7eGixizz
         9dKxZTMI7tXfaXN6xdhqKsPvs0MggJ6VcySQrCQ5JDbSyMiND63x9yXT2ezxvdroo4vw
         qA7T1JmBLNEaaN3GFdawfQjCEXXD7pwliZcZeEe2t8BHfIEM8YYbbibaxvfwy0Z/NEun
         B61fJqMKbnWSLb6sve1z2idOTvRYrVpnmGicPpCrW4PAunWN9/9HJPuubYSQKyhO82Ty
         MTGw==
X-Gm-Message-State: AOAM533zWcWFmMgzfbRlIcikfHJeA18HbZ+blcN7gcS6lGaEbuQYxl/S
        VD7szq2f43JW5A5GKrSUFnIaf7DILsccn2pKhMAkF+RT
X-Google-Smtp-Source: ABdhPJy5YQteHdDUUQsfgrI8dnM7kpupflvC9srOtrZxF9O4v+93VplTgdbMJbiiGuPOl+oXENK/QY6x2Fnt98C7qIk=
X-Received: by 2002:a05:6402:c96:: with SMTP id cm22mr21115283edb.314.1632717491292;
 Sun, 26 Sep 2021 21:38:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210926031339.40043-1-songmuchun@bytedance.com> <20210926031339.40043-6-songmuchun@bytedance.com>
In-Reply-To: <20210926031339.40043-6-songmuchun@bytedance.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Mon, 27 Sep 2021 17:38:00 +1300
Message-ID: <CAGsJ_4yFbLzHoLA=7QCOvPev1w=mn4sX61+TZNn8uKkDmA9X6A@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] mm: sparsemem: move vmemmap related to HugeTLB to CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        David Hildenbrand <david@redhat.com>,
        Chen Huang <chenhuang5@huawei.com>,
        "Bodeddula, Balasubramaniam" <bodeddub@amazon.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Matthew Wilcox <willy@infradead.org>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        fam.zheng@bytedance.com, Muchun Song <smuchun@gmail.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 26, 2021 at 4:15 PM Muchun Song <songmuchun@bytedance.com> wrote:
>
> The vmemmap_remap_free/alloc are relevant to HugeTLB, so move those
> functiongs to the scope of CONFIG_HUGETLB_PAGE_FREE_VMEMMAP.
>
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Reviewed-by: Barry Song <song.bao.hua@hisilicon.com>

> ---
>  include/linux/mm.h  | 2 ++
>  mm/sparse-vmemmap.c | 2 ++
>  2 files changed, 4 insertions(+)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 00bb2d938df4..a706e7ffda94 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -3182,10 +3182,12 @@ static inline void print_vma_addr(char *prefix, unsigned long rip)
>  }
>  #endif
>
> +#ifdef CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
>  int vmemmap_remap_free(unsigned long start, unsigned long end,
>                        unsigned long reuse);
>  int vmemmap_remap_alloc(unsigned long start, unsigned long end,
>                         unsigned long reuse, gfp_t gfp_mask);
> +#endif
>
>  void *sparse_buffer_alloc(unsigned long size);
>  struct page * __populate_section_memmap(unsigned long pfn,
> diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
> index d486a7a48512..3c7dd41c3164 100644
> --- a/mm/sparse-vmemmap.c
> +++ b/mm/sparse-vmemmap.c
> @@ -34,6 +34,7 @@
>  #include <asm/pgalloc.h>
>  #include <asm/tlbflush.h>
>
> +#ifdef CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
>  /**
>   * struct vmemmap_remap_walk - walk vmemmap page table
>   *
> @@ -423,6 +424,7 @@ int vmemmap_remap_alloc(unsigned long start, unsigned long end,
>
>         return 0;
>  }
> +#endif /* CONFIG_HUGETLB_PAGE_FREE_VMEMMAP */
>
>  /*
>   * Allocate a block of memory to be used to back the virtual memory map
> --
> 2.11.0
>
