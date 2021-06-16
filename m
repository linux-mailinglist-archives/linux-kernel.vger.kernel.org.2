Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAC8A3A9590
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 11:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231524AbhFPJKU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 05:10:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231335AbhFPJKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 05:10:19 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19493C061574
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 02:08:08 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id 7-20020a9d0d070000b0290439abcef697so1830979oti.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 02:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9xuYq+64b5WvG58VNmoINL8JRqUZnuNk7CS6Gt/jkYU=;
        b=lrYME9Lw0bw5jobMrw7bAtz5zFCN5SIDCWMMy0Oc0iZ4OQM2eXD+jUDkK8nxuts6FA
         AhN/U0QDTrC0uUDtjo1hykQLrvJkugVmxGdE72uPfu38L59Vca6oh8jJDg379Nm1VdPR
         BzRHVGfCTzwQOlq/xhXSpQZnXcZudbpjg5IaGbYAvlAHcTdf2ih3PJfBvYEgRNK84Y2H
         I/DxrlyGKIeYhJzsGfXq7badWjr+bCqgO65DdKZr2ECnoKxf1dwN8m/0M9CO1nbAQWFn
         /YKrA4l8MnlqJCjqDpx5yYF5+t1yzzfOu4Q0KLNh8EbBwjwhE3pVEW40Zj98ScS7lun2
         ozsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9xuYq+64b5WvG58VNmoINL8JRqUZnuNk7CS6Gt/jkYU=;
        b=mE3vJK7NMn34pKso1AnLtC32jTj7uuor5++iTJCWa2VYQ5Lo+nqg7fBjxoXjOdQ4W5
         T81gviPowv+JcKc0K+pioUrizHhHEU8Ib5gT92jhzqLwfr6rKJrBe809z5uAoOJz1h/x
         hTFlTeytX5vAWTo8nRriwiSlAMUJqa8/AzDatJditb+Q2XORsRAPRZsX+KDHnlTJdLXr
         GBzNjXDM9qys4Ap5Q45QIT5ORZDnP2HcZSi256JOiDibnnj5iHDIt4fnJlK2eilsYiAx
         jhJvgzm2+zRYqLURdzUNjOUDQogHO3QhTnaluo0QT5LRVS6sMM4IDVUSSirRQejrT0ip
         SrGw==
X-Gm-Message-State: AOAM530p8UM7LC5TILAL/VHPPNE/FvUvXkxQTEO0WQjweypHDSuwtK/l
        vddTnxOPr7lOI2zJST7Uyh6yqQUD+ceCBTG3oS5v6g==
X-Google-Smtp-Source: ABdhPJyDEOnGc9wAnOoqktHhJZmmNWHzwtwqb4yeXvjQLG8ilX6jnwU0HCYru7+LM5x6jxSUH5lcOFoSo2gOnUPfKv0=
X-Received: by 2002:a05:6830:1bcb:: with SMTP id v11mr3239145ota.251.1623834487248;
 Wed, 16 Jun 2021 02:08:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210616080244.51236-1-dja@axtens.net> <20210616080244.51236-4-dja@axtens.net>
In-Reply-To: <20210616080244.51236-4-dja@axtens.net>
From:   Marco Elver <elver@google.com>
Date:   Wed, 16 Jun 2021 11:07:55 +0200
Message-ID: <CANpmjNN2-nkqaQ8J3nU5QJ4KGkX2mwiNTeTCNPGQYdbb1v2OaA@mail.gmail.com>
Subject: Re: [PATCH v13 3/3] kasan: define and use MAX_PTRS_PER_* for early
 shadow tables
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

On Wed, 16 Jun 2021 at 10:03, Daniel Axtens <dja@axtens.net> wrote:
[...]
> diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> index 768d7d342757..fd65f477ac92 100644
> --- a/include/linux/kasan.h
> +++ b/include/linux/kasan.h
> @@ -40,10 +40,22 @@ struct kunit_kasan_expectation {
>  #define PTE_HWTABLE_PTRS 0
>  #endif
>
> +#ifndef MAX_PTRS_PER_PTE
> +#define MAX_PTRS_PER_PTE PTRS_PER_PTE
> +#endif
> +
> +#ifndef MAX_PTRS_PER_PMD
> +#define MAX_PTRS_PER_PMD PTRS_PER_PMD
> +#endif
> +
> +#ifndef MAX_PTRS_PER_PUD
> +#define MAX_PTRS_PER_PUD PTRS_PER_PUD
> +#endif

This is introducing new global constants in a <linux/..> header. It
feels like this should be in <linux/pgtable.h> together with a
comment. Because <linux/kasan.h> is actually included in
<linux/slab.h>, most of the kernel will get these new definitions.
That in itself is fine, but it feels wrong that the KASAN header
introduces these.

Thoughts?

Sorry for only realizing this now.

Thanks,
-- Marco

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
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/20210616080244.51236-4-dja%40axtens.net.
