Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F5C136CDA7
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 23:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239021AbhD0VEU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 17:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238960AbhD0VED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 17:04:03 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D487C061574
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 14:03:18 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id r12so91433114ejr.5
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 14:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IVCjFm7QV+VqFMh+TVJiLEQ0dbasaVs/3/fcUDprAlc=;
        b=Wggutq2xOVkODR7nsL4N1fYAFB5PApJOT8TpfgWcuPoYVGAp/LREhg+ynfMGRcz7id
         tSIlWmNaxBhuLorY6ZRJz+qrRbY5mCWnrUmk3dmn79YolSfHOZ7hyzqU1Dg9r1JVr9zu
         yNrw5eZ54MCLPoPtMxIZgHbefwNvfxqyTaECD/rqBCUm/Roeg7AmzviKns10Ey5xt32P
         sxYRT6GkVC/qiEn1ZSHGgTL2XGvYGK+l+nvIi6rdmroPlHGzO8AeLF2Myik2dICBGab2
         OxOSzPx1JGsf38bOUki0yDv/hMMDNpV30+QkaR5/6AVX4spO+xpXH6ETL2OtnuLtGkH3
         gx/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IVCjFm7QV+VqFMh+TVJiLEQ0dbasaVs/3/fcUDprAlc=;
        b=nndXeSYGaNuZl09tANMyDfvGXqlklSE6FdAUF6cXbvKN6YJNUzCR1Kz+xErsuopx/I
         NqwaKt7I5hciaarscTZMKhP1CUJxNQLgXUm5PikKix7hrDJgalRc/e9kaNvtILwsAxy9
         IYCETwsoa3K6NF14s5QKQvUeCXiiBVEj/6Fm0pSCtgFK9jiE7byrUxVoMiPBssFog320
         SCmbG6d+BIe4DlatuqLz/vHwFrwrgKJO9VJqflQldaqv/u2wPS2di/mx7N92Nlw7YC2p
         pxr4Dio/hTdVEdHTV2Q5QUQzcZ45T65wWuHyeGML23mAXXsrlslrejjrjm5E0mxHbScE
         gIYQ==
X-Gm-Message-State: AOAM533bLl9xkoW40MmW3LARHPfHyn89ApXZ9grKO1hmVAXBJpEyAuUI
        alisRC+dmzlkNkv42fzoYDMOzRzMbqVe67+IiFA=
X-Google-Smtp-Source: ABdhPJx/00l72TILd6o0PsEVlLXRNJLrr6CnjbrSc7BkiSs2DiNtINQRuM84mhfwDOc0OQuy1zfxbp2YRN0+PyIbBRU=
X-Received: by 2002:a17:906:4881:: with SMTP id v1mr24404083ejq.383.1619557396934;
 Tue, 27 Apr 2021 14:03:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210427133214.2270207-1-linmiaohe@huawei.com> <20210427133214.2270207-4-linmiaohe@huawei.com>
In-Reply-To: <20210427133214.2270207-4-linmiaohe@huawei.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 27 Apr 2021 14:03:05 -0700
Message-ID: <CAHbLzkrBAtTM8aE_pM4ASQ6cGyfPcs7_7HPJLCd9T24VyqU5wQ@mail.gmail.com>
Subject: Re: [PATCH 3/5] mm/huge_memory.c: add missing read-only THP checking
 in transparent_hugepage_enabled()
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
> Since commit 99cb0dbd47a1 ("mm,thp: add read-only THP support for
> (non-shmem) FS"), read-only THP file mapping is supported. But it
> forgot to add checking for it in transparent_hugepage_enabled().
>
> Fixes: 99cb0dbd47a1 ("mm,thp: add read-only THP support for (non-shmem) FS")
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  mm/huge_memory.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 76ca1eb2a223..aa22a0ae9894 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -74,6 +74,9 @@ bool transparent_hugepage_enabled(struct vm_area_struct *vma)
>                 return __transparent_hugepage_enabled(vma);
>         if (vma_is_shmem(vma))
>                 return shmem_huge_enabled(vma);
> +       if (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) && vma->vm_file &&
> +           (vma->vm_flags & VM_DENYWRITE))
> +               return true;

I don't think this change is correct. This function is used to
indicate if allocating THP is eligible for the VMAs or not showed by
smap. And currently readonly FS THP is collapsed by khugepaged only.

So, you need check if the vma is suitable for khugepaged. Take a look
at what hugepage_vma_check() does.

And, the new patch
(https://lore.kernel.org/linux-mm/20210406000930.3455850-1-cfijalkovich@google.com/)
relax the constraints for readonly FS THP, it might be already in -mm
tree, so you need adopt the new condition as well.

>
>         return false;
>  }

> --
> 2.23.0
>
>
