Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D3863AAD17
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 09:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbhFQHLa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 03:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbhFQHL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 03:11:29 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A31E6C061574
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 00:09:21 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id q10so5457541oij.5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 00:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y899QIQlOQvFqET/XGorOZ+F3vK0QdxZBrZzg45qzIs=;
        b=FQtZTwK4cC4uXfrgpUfeUmm6Siw4e/WbKHpMQAsnI2GuJrbWnfKGVx55CrlKwNW3Yv
         id9W++OpGmqczrcKmov1LTEXRpsdyADCcXpBqkD3ebXNrue27Wv5udaUtl2dl2J7AQit
         2ZDLx7SobVYkJb2Bwi7poyskkgAhFTaR7gPp/EyyS7kgrsdZcS/qwY/6LfDvnh3iCN2V
         WwCHMNNX9KIRmVZ3KOoIMKnbAUnz92UztTDXuBlQJ2gQoGCeCIK4IFzAku3R+7L7K/l4
         m78ITtrlX333pwjx/YWYG2DdGtLJayvmEFV1IjtZ3EiO1Qem80PZN8VEq3YzlCZaW7KP
         bOCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y899QIQlOQvFqET/XGorOZ+F3vK0QdxZBrZzg45qzIs=;
        b=cI2941yp6w2zYV07Umvo40BqLkUOZJBOb+ddYiM5v8/5BSRBhcP27SQsV4FC8i3nJ3
         bvQJdzX0MxeX9tPUCprmV1ojyuKyBlO28hdN3zwKg5fjESFFqMp18mVAq49Nai0891r7
         ymiwn9UzXXgWD9UeOmLsbgMW9EuOpphz21skm4XsKzmcfjL4ko5ak3tUPkPFqdDsAONd
         xl2Zql3t1rQDg8/ttKSTObEY7T/Vu1k2Ln18s1h+9lh1tZqCNXdstmN9+Nwqk9FejgBN
         i+KGaPf5DEM4s0SVnIYU5xGwprscODO4IbN2n6EwFnOZxCeO0bayan6Jje8C799LfPji
         n/0A==
X-Gm-Message-State: AOAM533sLp3nq+Qt8CMY6bnEikevGiItSVo+HSWkwKCpFd3iIxR/ljPm
        wKnAMoNh14dHEV/dt/XpcaKZOyyKDLEn7f3ogRj3eQ==
X-Google-Smtp-Source: ABdhPJztoH0C1/zvKob2TwWK9o3BZ++QjbgLwppAe2djLU6M4cBSQ1jJwElkp2Tz9gErUtDFo+xgFIsfw23ZT5VTMGA=
X-Received: by 2002:a05:6808:bd5:: with SMTP id o21mr2275661oik.172.1623913760824;
 Thu, 17 Jun 2021 00:09:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210617063956.94061-1-dja@axtens.net> <20210617063956.94061-5-dja@axtens.net>
In-Reply-To: <20210617063956.94061-5-dja@axtens.net>
From:   Marco Elver <elver@google.com>
Date:   Thu, 17 Jun 2021 09:09:09 +0200
Message-ID: <CANpmjNOoeZqRnqpPGZqiro-ptaV=qKf5dnRYmVcZkRMPq7spig@mail.gmail.com>
Subject: Re: [PATCH v14 4/4] kasan: use MAX_PTRS_PER_* for early shadow tables
To:     Daniel Axtens <dja@axtens.net>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        linuxppc-dev@lists.ozlabs.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        aneesh.kumar@linux.ibm.com, Balbir Singh <bsingharora@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Jun 2021 at 08:40, Daniel Axtens <dja@axtens.net> wrote:
>
> powerpc has a variable number of PTRS_PER_*, set at runtime based
> on the MMU that the kernel is booted under.
>
> This means the PTRS_PER_* are no longer constants, and therefore
> breaks the build. Switch to using MAX_PTRS_PER_*, which are constant.
>
> Suggested-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> Suggested-by: Balbir Singh <bsingharora@gmail.com>
> Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> Reviewed-by: Balbir Singh <bsingharora@gmail.com>
> Signed-off-by: Daniel Axtens <dja@axtens.net>

Reviewed-by: Marco Elver <elver@google.com>


> ---
>  include/linux/kasan.h | 6 +++---
>  mm/kasan/init.c       | 6 +++---
>  2 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> index 768d7d342757..5310e217bd74 100644
> --- a/include/linux/kasan.h
> +++ b/include/linux/kasan.h
> @@ -41,9 +41,9 @@ struct kunit_kasan_expectation {
>  #endif
>
>  extern unsigned char kasan_early_shadow_page[PAGE_SIZE];
> -extern pte_t kasan_early_shadow_pte[PTRS_PER_PTE + PTE_HWTABLE_PTRS];
> -extern pmd_t kasan_early_shadow_pmd[PTRS_PER_PMD];
> -extern pud_t kasan_early_shadow_pud[PTRS_PER_PUD];
> +extern pte_t kasan_early_shadow_pte[MAX_PTRS_PER_PTE + PTE_HWTABLE_PTRS];
> +extern pmd_t kasan_early_shadow_pmd[MAX_PTRS_PER_PMD];
> +extern pud_t kasan_early_shadow_pud[MAX_PTRS_PER_PUD];
>  extern p4d_t kasan_early_shadow_p4d[MAX_PTRS_PER_P4D];
>
>  int kasan_populate_early_shadow(const void *shadow_start,
> diff --git a/mm/kasan/init.c b/mm/kasan/init.c
> index 348f31d15a97..cc64ed6858c6 100644
> --- a/mm/kasan/init.c
> +++ b/mm/kasan/init.c
> @@ -41,7 +41,7 @@ static inline bool kasan_p4d_table(pgd_t pgd)
>  }
>  #endif
>  #if CONFIG_PGTABLE_LEVELS > 3
> -pud_t kasan_early_shadow_pud[PTRS_PER_PUD] __page_aligned_bss;
> +pud_t kasan_early_shadow_pud[MAX_PTRS_PER_PUD] __page_aligned_bss;
>  static inline bool kasan_pud_table(p4d_t p4d)
>  {
>         return p4d_page(p4d) == virt_to_page(lm_alias(kasan_early_shadow_pud));
> @@ -53,7 +53,7 @@ static inline bool kasan_pud_table(p4d_t p4d)
>  }
>  #endif
>  #if CONFIG_PGTABLE_LEVELS > 2
> -pmd_t kasan_early_shadow_pmd[PTRS_PER_PMD] __page_aligned_bss;
> +pmd_t kasan_early_shadow_pmd[MAX_PTRS_PER_PMD] __page_aligned_bss;
>  static inline bool kasan_pmd_table(pud_t pud)
>  {
>         return pud_page(pud) == virt_to_page(lm_alias(kasan_early_shadow_pmd));
> @@ -64,7 +64,7 @@ static inline bool kasan_pmd_table(pud_t pud)
>         return false;
>  }
>  #endif
> -pte_t kasan_early_shadow_pte[PTRS_PER_PTE + PTE_HWTABLE_PTRS]
> +pte_t kasan_early_shadow_pte[MAX_PTRS_PER_PTE + PTE_HWTABLE_PTRS]
>         __page_aligned_bss;
>
>  static inline bool kasan_pte_table(pmd_t pmd)
> --
> 2.30.2
>
