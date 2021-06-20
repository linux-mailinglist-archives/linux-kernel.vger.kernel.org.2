Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB1A3ADE1D
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jun 2021 13:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbhFTLTn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Jun 2021 07:19:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbhFTLTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jun 2021 07:19:40 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B4A6C061574
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jun 2021 04:17:25 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id t7so14903645edd.5
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jun 2021 04:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ox6b74Fvc6eYbkVfNLZ3KvjE6zQLqybhjoI+fLMMAAM=;
        b=WXYG6Cdf6By2iyUeWDdpOD47jL5uFwBbosTEKrmlnmXvDpzsAuoyBww2pRA2Nf2Ygd
         DD4A5L3vWj87qldAax3ct/cAmp7164hOVOcjWuNyybt/M5PYq+bH7Uw8xsxzqm4JclDK
         LIto+UwOj0HHXP1hgJKyxLfliaNccUpEscCUVWs3myw6twqAl1PUNRlS4mwtL8VPvH2i
         /jG/shwVDIPB0cqHPRLgk+7J9ddYULS67W9JTNIBBiYBCKekjzWaq4G6xn3gTi7x3oZi
         4TI3M6kZhzIxXd31Git2Xl8h73DWG2h8bolP5AxjIovmioxJN4HIDmt/HBr1mTifgnT4
         w+GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ox6b74Fvc6eYbkVfNLZ3KvjE6zQLqybhjoI+fLMMAAM=;
        b=Zk8j8MwlZbbsROV3t8eJusRHs9EmiWs2jocb4Dm1Af4JlafC4sxtSjKlajgoy+Sgei
         Ef37R9IDlSJV9DkSp8EJATTJJoTeyA4YN9eYoHQyuTubRjOMd8axB2G20r50fNoSv6n0
         OIrhy4ZwAxnW2MXg8bLRtDGlDNvc6+fTHiraZ1ffTIbFg7fLuIQpYwt5xKeTwMT5Ehjj
         Ar5p3l5+9K4w/b1KDAQcAVGbyjArR4as+lJQVUZ89VpLlp9c+UR5zbw8yhSoxxOqyGhC
         7H12MdBesPjV6NdH+huYG1Y0sf1ukUDB94cGaLoOiH7IjjdRp+T7EbRQ5IMmwPm9Mqr5
         1f3Q==
X-Gm-Message-State: AOAM533IhfuFX1DIbm1c4YqQyV28jrZRSLxx9tcP7UzPW3+fLUlzx7lV
        HPRp5I7JswO8IgtdmVfAUYID8wv2C7ebfMfnK7E=
X-Google-Smtp-Source: ABdhPJww9MCpsYchtIGF8m60gxIne2Q2KYFvGjYAO6vwCGhLCbJsxWFd2YH44uCprI1gDhfoSaxdRwpOLzbrVk0RxPA=
X-Received: by 2002:a50:fd83:: with SMTP id o3mr12106286edt.95.1624187843896;
 Sun, 20 Jun 2021 04:17:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210617093032.103097-1-dja@axtens.net> <20210617093032.103097-4-dja@axtens.net>
In-Reply-To: <20210617093032.103097-4-dja@axtens.net>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Sun, 20 Jun 2021 14:17:04 +0300
Message-ID: <CA+fCnZeJerhmLg_5F_FdVptJC+QqoVa5+pAhqU+nSH1itmhAcQ@mail.gmail.com>
Subject: Re: [PATCH v15 3/4] mm: define default MAX_PTRS_PER_* in include/pgtable.h
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
> Commit c65e774fb3f6 ("x86/mm: Make PGDIR_SHIFT and PTRS_PER_P4D variable")
> made PTRS_PER_P4D variable on x86 and introduced MAX_PTRS_PER_P4D as a
> constant for cases which need a compile-time constant (e.g. fixed-size
> arrays).
>
> powerpc likewise has boot-time selectable MMU features which can cause
> other mm "constants" to vary. For KASAN, we have some static
> PTE/PMD/PUD/P4D arrays so we need compile-time maximums for all these
> constants. Extend the MAX_PTRS_PER_ idiom, and place default definitions
> in include/pgtable.h. These define MAX_PTRS_PER_x to be PTRS_PER_x unless
> an architecture has defined MAX_PTRS_PER_x in its arch headers.
>
> Clean up pgtable-nop4d.h and s390's MAX_PTRS_PER_P4D definitions while
> we're at it: both can just pick up the default now.
>
> Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> Reviewed-by: Marco Elver <elver@google.com>
> Signed-off-by: Daniel Axtens <dja@axtens.net>
>
> ---
>
> s390 was compile tested only.
> ---
>  arch/s390/include/asm/pgtable.h     |  2 --
>  include/asm-generic/pgtable-nop4d.h |  1 -
>  include/linux/pgtable.h             | 22 ++++++++++++++++++++++
>  3 files changed, 22 insertions(+), 3 deletions(-)
>
> diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
> index 7c66ae5d7e32..cf05954ce013 100644
> --- a/arch/s390/include/asm/pgtable.h
> +++ b/arch/s390/include/asm/pgtable.h
> @@ -342,8 +342,6 @@ static inline int is_module_addr(void *addr)
>  #define PTRS_PER_P4D   _CRST_ENTRIES
>  #define PTRS_PER_PGD   _CRST_ENTRIES
>
> -#define MAX_PTRS_PER_P4D       PTRS_PER_P4D
> -
>  /*
>   * Segment table and region3 table entry encoding
>   * (R = read-only, I = invalid, y = young bit):
> diff --git a/include/asm-generic/pgtable-nop4d.h b/include/asm-generic/pgtable-nop4d.h
> index ce2cbb3c380f..2f6b1befb129 100644
> --- a/include/asm-generic/pgtable-nop4d.h
> +++ b/include/asm-generic/pgtable-nop4d.h
> @@ -9,7 +9,6 @@
>  typedef struct { pgd_t pgd; } p4d_t;
>
>  #define P4D_SHIFT              PGDIR_SHIFT
> -#define MAX_PTRS_PER_P4D       1
>  #define PTRS_PER_P4D           1
>  #define P4D_SIZE               (1UL << P4D_SHIFT)
>  #define P4D_MASK               (~(P4D_SIZE-1))
> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index 9e6f71265f72..69700e3e615f 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -1625,4 +1625,26 @@ typedef unsigned int pgtbl_mod_mask;
>  #define pte_leaf_size(x) PAGE_SIZE
>  #endif
>
> +/*
> + * Some architectures have MMUs that are configurable or selectable at boot
> + * time. These lead to variable PTRS_PER_x. For statically allocated arrays it
> + * helps to have a static maximum value.
> + */
> +
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
> +
> +#ifndef MAX_PTRS_PER_P4D
> +#define MAX_PTRS_PER_P4D PTRS_PER_P4D
> +#endif
> +
>  #endif /* _LINUX_PGTABLE_H */
> --
> 2.30.2
>

Acked-by: Andrey Konovalov <andreyknvl@gmail.com>
