Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B9D23ADE20
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jun 2021 13:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbhFTLUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Jun 2021 07:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbhFTLUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jun 2021 07:20:32 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 338CBC061574
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jun 2021 04:18:19 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id hz1so1127978ejc.1
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jun 2021 04:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QziFBff9GiMT4Os8umf/EiLjglEeNn/Ybki8x4poeu0=;
        b=PUPR7UCLEc58GXQJRHHhcsalboiBUKhgIE37jx1X1YWBZACe0Brp+YmMs43CnCPuk0
         us8/fLV6tuKG8vV0wrRUK3vn0vXtCMCHxecWzLCL1D4hN8dijyv/IHdQBvbpmZKUy47O
         R8kuM3qxft9OQVL9Dy3fs1+G1UrlmaLws7fcflaiVAY9pLiLsILpNtw/t7qpKmhYHg49
         Ifmnzs+CNNZsUpJlD8v3fA8QEvt3towamggAmaQHQ3kpn5+jClmKsv+38uoXEloU00zh
         jSGl0ayd9jQFJVe9TPf0sAmzWf/gm2n7NiYPpUgFMnI/10QTa+ZBwKcYmXez/NCSG6z+
         r6Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QziFBff9GiMT4Os8umf/EiLjglEeNn/Ybki8x4poeu0=;
        b=tyKJKAJAAwa8AeEcohdyOWeMnlbfK2ApfX9WucXn9cCspfQZwwm71fRhtSHOIFCjkh
         w4HERTHVthAPRe+lFaFQCzojkpZ3/76lyFoUJGIrR3UUomBYYjnCa6KIBSLcICWcRIi0
         GOw/9ghePGMXrhOKn/GTUT859/3pH//z0RLdjsMj/JNILkrq59QguEl5vO/aIzZ+Z5Fb
         V26DGtUHJd0v3VhyHFwmTCsvE+K6+lqumN5Ub7OnybYaESa12PuPTUSTTLgRvJXdRbrZ
         UbH3En6Jx8dcuTR/eOBSJVdQE1entzYhw2EBB2fDyrhW/OcBIHHKqgiXZlxTXLYHOknf
         N7NQ==
X-Gm-Message-State: AOAM533R/dvciYj4DtVHA/onjpzsJGZS7jZM8K9VfN8q6cc7xCECVO4L
        ZMvCBPcf+iI6gBMgYxt64JlqqiWUsAkPEt1elj0=
X-Google-Smtp-Source: ABdhPJz/S/MSqo/80qI6QRv0Bhi2f8HKVBKRu6I41epUdGXpKkIFJ4CV/4mirJli5A5XQPAh/IdIMWx6bo4q/0vs1BY=
X-Received: by 2002:a17:906:6b90:: with SMTP id l16mr11511853ejr.439.1624187897865;
 Sun, 20 Jun 2021 04:18:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210617093032.103097-1-dja@axtens.net> <20210617093032.103097-5-dja@axtens.net>
In-Reply-To: <20210617093032.103097-5-dja@axtens.net>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Sun, 20 Jun 2021 14:17:57 +0300
Message-ID: <CA+fCnZejE20i=R4=J1TCkoqhukT1G-vnADP_byxpoRULfOvC-A@mail.gmail.com>
Subject: Re: [PATCH v15 4/4] kasan: use MAX_PTRS_PER_* for early shadow tables
To:     Daniel Axtens <dja@axtens.net>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Marco Elver <elver@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev@lists.ozlabs.org, christophe.leroy@csgroup.eu,
        aneesh.kumar@linux.ibm.com, bsingharora@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 17, 2021 at 12:30 PM Daniel Axtens <dja@axtens.net> wrote:
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
> Reviewed-by: Marco Elver <elver@google.com>
> Signed-off-by: Daniel Axtens <dja@axtens.net>
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

Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>
