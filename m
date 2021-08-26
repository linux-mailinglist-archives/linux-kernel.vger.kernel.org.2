Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 366A03F808D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 04:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237894AbhHZChk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 22:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237872AbhHZChj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 22:37:39 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF7C9C061757
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 19:36:52 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id r13so1010785pff.7
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 19:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=5cq0XFEhowwKe5TCIMBI1biKXS+xMvevaDEBrI2bw/w=;
        b=gKpcE35rQaNULX+xymwzBfAmgqkgo6dIo9I2lJ11q8X8T6SlNhxbVh2oBMUKAQwaOx
         d6lfyfUBzSPkW9OgEBcfL0wFhSXI9mjeI1jfMNW1qfZodYqOTBrzXiafOZ66bH4TnDvT
         7feKAjAngDorRxAYPl82Q+uYktCnYV4oFwi7wkIaNYjNn7OSESeIbGypPRUju6ao3w4M
         dLXwSx6ejKCIDTAJJFPmSqoS7U18irZlBZE6cv3lWMMgYkKldTIXUbDppK+saCuhMwsp
         DIxIjM4mJNjGdd8ranG+KUe0+nO3hsSE5OMLy//dK0FcT32wD3NluJsj3W6RsjAVFabq
         31nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=5cq0XFEhowwKe5TCIMBI1biKXS+xMvevaDEBrI2bw/w=;
        b=BDpcy0YkPqG9OhnjmfMnG4mbUG4i+bULjBc7wkCV0rXMcE83UqiOXO5ZTj1hcZ+Fi8
         oHqnEob5zzVnXpZdkxBtw5WEt5Ck8yD0+Fe7G1m7dY4+FlB9mDa8HFBHnbnc0NryfM9J
         tRzZLzXJuQCpDcNgChtVBTVb58TH98Fe/G36Rx+/dzrWoJmAoxoInykza9fPrnDPCZca
         q5fM6Y8cRdLJiH7o2wO7zKlSC7JBJywMabwmM+XKW93gmX6t+rCmyyBTqLQD/SttlSki
         0fclWQz7YHAkjlOWr5iIWvuINZnA5sCFoLX2QVty80Kr1rFh5InoMh5SC2/sVFWNGI+a
         6B/Q==
X-Gm-Message-State: AOAM533QeRFWz0LbElDrdi0cdv6+yij2sayD4qH7J8e8Cy4/Xu4UDNek
        qeXTgepWpOrzJF593Jvqi5c=
X-Google-Smtp-Source: ABdhPJzbqwdT8TICVT7I8YZw/O1jEMal+3Gw8zY0CKVRabrsT1+gLeX4J+gXhk1bVScpTyYUNGcZnw==
X-Received: by 2002:a65:608f:: with SMTP id t15mr1244831pgu.452.1629945412458;
        Wed, 25 Aug 2021 19:36:52 -0700 (PDT)
Received: from localhost (193-116-119-33.tpgi.com.au. [193.116.119.33])
        by smtp.gmail.com with ESMTPSA id i11sm1335608pgo.25.2021.08.25.19.36.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Aug 2021 19:36:52 -0700 (PDT)
Date:   Thu, 26 Aug 2021 12:36:46 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 1/2] mm: move ioremap_page_range to vmalloc.c
To:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Peter Zijlstra <peterz@infradead.org>
References: <20210824091259.1324527-1-hch@lst.de>
        <20210824091259.1324527-2-hch@lst.de>
In-Reply-To: <20210824091259.1324527-2-hch@lst.de>
MIME-Version: 1.0
Message-Id: <1629945172.9i2oy8ddvl.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Christoph Hellwig's message of August 24, 2021 7:12 pm:
> This keeps it together with the implementation, and to remove the
> vmap_range wrapper.
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  include/linux/vmalloc.h |  3 ---
>  mm/Makefile             |  3 ++-
>  mm/ioremap.c            | 25 -------------------------
>  mm/vmalloc.c            | 22 +++++++++++++++++-----
>  4 files changed, 19 insertions(+), 34 deletions(-)
>=20
> diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
> index 2644425b6dce..671d402c3778 100644
> --- a/include/linux/vmalloc.h
> +++ b/include/linux/vmalloc.h
> @@ -225,9 +225,6 @@ static inline bool is_vm_area_hugepages(const void *a=
ddr)
>  }
> =20
>  #ifdef CONFIG_MMU
> -int vmap_range(unsigned long addr, unsigned long end,
> -			phys_addr_t phys_addr, pgprot_t prot,
> -			unsigned int max_page_shift);
>  void vunmap_range(unsigned long addr, unsigned long end);
>  static inline void set_vm_flush_reset_perms(void *addr)
>  {
> diff --git a/mm/Makefile b/mm/Makefile
> index e3436741d539..0e0a5a6fe127 100644
> --- a/mm/Makefile
> +++ b/mm/Makefile
> @@ -38,7 +38,7 @@ mmu-y			:=3D nommu.o
>  mmu-$(CONFIG_MMU)	:=3D highmem.o memory.o mincore.o \
>  			   mlock.o mmap.o mmu_gather.o mprotect.o mremap.o \
>  			   msync.o page_vma_mapped.o pagewalk.o \
> -			   pgtable-generic.o rmap.o vmalloc.o ioremap.o
> +			   pgtable-generic.o rmap.o vmalloc.o
> =20
> =20
>  ifdef CONFIG_CROSS_MEMORY_ATTACH
> @@ -128,3 +128,4 @@ obj-$(CONFIG_PTDUMP_CORE) +=3D ptdump.o
>  obj-$(CONFIG_PAGE_REPORTING) +=3D page_reporting.o
>  obj-$(CONFIG_IO_MAPPING) +=3D io-mapping.o
>  obj-$(CONFIG_HAVE_BOOTMEM_INFO_NODE) +=3D bootmem_info.o
> +obj-$(CONFIG_GENERIC_IOREMAP) +=3D ioremap.o

Nice cleanup.

> diff --git a/mm/ioremap.c b/mm/ioremap.c
> index 8ee0136f8cb0..5fe598ecd9b7 100644
> --- a/mm/ioremap.c
> +++ b/mm/ioremap.c
> @@ -8,33 +8,9 @@
>   */
>  #include <linux/vmalloc.h>
>  #include <linux/mm.h>
> -#include <linux/sched.h>
>  #include <linux/io.h>
>  #include <linux/export.h>
> -#include <asm/cacheflush.h>
> =20
> -#include "pgalloc-track.h"
> -
> -#ifdef CONFIG_HAVE_ARCH_HUGE_VMAP
> -static unsigned int __ro_after_init iomap_max_page_shift =3D BITS_PER_LO=
NG - 1;
> -
> -static int __init set_nohugeiomap(char *str)
> -{
> -	iomap_max_page_shift =3D PAGE_SHIFT;
> -	return 0;
> -}
> -early_param("nohugeiomap", set_nohugeiomap);
> -#else /* CONFIG_HAVE_ARCH_HUGE_VMAP */
> -static const unsigned int iomap_max_page_shift =3D PAGE_SHIFT;
> -#endif	/* CONFIG_HAVE_ARCH_HUGE_VMAP */
> -
> -int ioremap_page_range(unsigned long addr,
> -		       unsigned long end, phys_addr_t phys_addr, pgprot_t prot)
> -{
> -	return vmap_range(addr, end, phys_addr, prot, iomap_max_page_shift);
> -}
> -
> -#ifdef CONFIG_GENERIC_IOREMAP
>  void __iomem *ioremap_prot(phys_addr_t addr, size_t size, unsigned long =
prot)
>  {
>  	unsigned long offset, vaddr;
> @@ -71,4 +47,3 @@ void iounmap(volatile void __iomem *addr)
>  	vunmap((void *)((unsigned long)addr & PAGE_MASK));
>  }
>  EXPORT_SYMBOL(iounmap);
> -#endif /* CONFIG_GENERIC_IOREMAP */
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index d5cd52805149..e44983fb2d15 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -44,6 +44,19 @@
>  #include "internal.h"
>  #include "pgalloc-track.h"
> =20
> +#ifdef CONFIG_HAVE_ARCH_HUGE_VMAP
> +static unsigned int __ro_after_init ioremap_max_page_shift =3D BITS_PER_=
LONG - 1;
> +
> +static int __init set_nohugeiomap(char *str)
> +{
> +	ioremap_max_page_shift =3D PAGE_SHIFT;
> +	return 0;
> +}
> +early_param("nohugeiomap", set_nohugeiomap);
> +#else /* CONFIG_HAVE_ARCH_HUGE_VMAP */
> +static const unsigned int ioremap_max_page_shift =3D PAGE_SHIFT;
> +#endif	/* CONFIG_HAVE_ARCH_HUGE_VMAP */
> +
>  #ifdef CONFIG_HAVE_ARCH_HUGE_VMALLOC
>  static bool __ro_after_init vmap_allow_huge =3D true;
> =20
> @@ -298,15 +311,14 @@ static int vmap_range_noflush(unsigned long addr, u=
nsigned long end,
>  	return err;
>  }
> =20
> -int vmap_range(unsigned long addr, unsigned long end,
> -			phys_addr_t phys_addr, pgprot_t prot,
> -			unsigned int max_page_shift)
> +int ioremap_page_range(unsigned long addr, unsigned long end,
> +		phys_addr_t phys_addr, pgprot_t prot)
>  {
>  	int err;
> =20
> -	err =3D vmap_range_noflush(addr, end, phys_addr, prot, max_page_shift);
> +	err =3D vmap_range_noflush(addr, end, phys_addr, prot,
> +				 ioremap_max_page_shift);
>  	flush_cache_vmap(addr, end);
> -
>  	return err;
>  }

I guess this is fine. I wanted to have an API that can be used to remap=20
memory without struct page and that is not MMIO but since you removed=20
the caller it could come back if other things make use of it.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

Thanks,
Nick
