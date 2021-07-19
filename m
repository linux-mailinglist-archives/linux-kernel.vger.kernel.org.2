Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48A403CCD29
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 06:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231350AbhGSEmj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 00:42:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbhGSEmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 00:42:38 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69334C061762
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jul 2021 21:39:38 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id h6-20020a17090a6486b029017613554465so1516495pjj.4
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jul 2021 21:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yDGF8o8BehqvGXFf3uJaMh578EYZzuyWfmjx8aoS3pw=;
        b=XJ7M/RfxAi8kYWi/QfdEGMfuJS3jI030zsEyAP4Z1FcpSuAKdzuko4haaChz3aq5Ct
         uUBRCSkJrT2/ktdpGwooj/58HbJsBmAzJolJuESHxtay/UI8jPzwZfmercuV15ezNhD2
         Tp5aPWTdxcNT2dcWgIqxzAqnaWD8gydUvVbBZaZd5ddRhLaumEBNDl78s8CIu5o9mHeR
         z+pa6ZDydRYoB9JoAu0WLhusnN3uvDjBQNpa6xkZ8/2wv91Ey2Kgl4Uq6jk2GlbFjbOm
         3XG2yjkaJI5MNvvn6xh7Ex1WCj9//6g9av92W0qraDqoxbqPfYMIQoa4YJ5QW+Spwctn
         bNnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yDGF8o8BehqvGXFf3uJaMh578EYZzuyWfmjx8aoS3pw=;
        b=tLTt4BM8lUuj2eQy9YwLxXceJ3uObyi3s1l4zzahYYOC/IpA7pZoJJ6/pMpFpveRnr
         UgAzMHm4D7lGXGddXmSPOO1z4JCCXssKqNk8TnEbEAGgYgkcq9ZxABGx5Itviz1sP949
         clVdluBF2gBSKAGsrNe+3c9AKE9sUhTs4qAywIBfV19I+HgEPrmEWaRxNbhjaMi5NWhd
         JqSrZK2DkSh1BFiMOnxgrGlNmZS4ZNbkh7Yt/rhKgSJrrDl3f7L+sfb9qZ5tTykk1V2O
         +SFSC/TWVecQG+S4gjEWP6c2IFum7FGjg1wBpH07YW3z31CBn3aAt7sJharcLLjzWlfn
         LywA==
X-Gm-Message-State: AOAM533RY+oWtuOyZjJD4Ccjy8lZcLvu14ed+cyK8tN4Oi26CCr5CU12
        GTtn8nqgvH25kMdtmU+FhnA=
X-Google-Smtp-Source: ABdhPJy2xXIXfwovXw3tLCc8rvN6Prm1wCkHSrxZvbfxoLTukNEcsoNFyDE8XHrxHTAFBM/RY5EDSQ==
X-Received: by 2002:a17:90a:28f:: with SMTP id w15mr22785727pja.70.1626669577993;
        Sun, 18 Jul 2021 21:39:37 -0700 (PDT)
Received: from localhost (g142.61-125-55.ppp.wakwak.ne.jp. [61.125.55.142])
        by smtp.gmail.com with ESMTPSA id y2sm235363pfe.146.2021.07.18.21.39.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jul 2021 21:39:37 -0700 (PDT)
Date:   Mon, 19 Jul 2021 13:39:35 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        openrisc@lists.librecores.org
Subject: Re: [PATCH] openrisc: rename or32 code & comments to or1k
Message-ID: <YPUCB7dSCHWrYHBl@antec>
References: <20210716022338.19342-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210716022338.19342-1-rdunlap@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 15, 2021 at 07:23:38PM -0700, Randy Dunlap wrote:
> From Documentation/openrisc/todo.rst, rename "or32" in the
> source code to "or1k" since this is the name that has been
> settled on.

Hello, the kernel test robot found a build failure with this.

Will you send the update for that?

> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Jonas Bonn <jonas@southpole.se>
> Cc: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
> Cc: Stafford Horne <shorne@gmail.com>
> Cc: openrisc@lists.librecores.org
> ---
>  arch/openrisc/include/asm/pgtable.h     |    6 +++---
>  arch/openrisc/include/asm/thread_info.h |    2 +-
>  arch/openrisc/kernel/entry.S            |    4 ++--
>  arch/openrisc/kernel/head.S             |    6 +++---
>  arch/openrisc/kernel/setup.c            |    4 ++--
>  arch/openrisc/lib/Makefile              |    2 +-
>  arch/openrisc/mm/fault.c                |    2 +-
>  7 files changed, 13 insertions(+), 13 deletions(-)
> 
> --- linux-next-20210715.orig/arch/openrisc/include/asm/pgtable.h
> +++ linux-next-20210715/arch/openrisc/include/asm/pgtable.h
> @@ -12,7 +12,7 @@
>   * et al.
>   */
>  
> -/* or32 pgtable.h - macros and functions to manipulate page tables
> +/* or1k pgtable.h - macros and functions to manipulate page tables
>   *
>   * Based on:
>   * include/asm-cris/pgtable.h
> @@ -29,14 +29,14 @@
>  
>  /*
>   * The Linux memory management assumes a three-level page table setup. On
> - * or32, we use that, but "fold" the mid level into the top-level page
> + * or1k, we use that, but "fold" the mid level into the top-level page
>   * table. Since the MMU TLB is software loaded through an interrupt, it
>   * supports any page table structure, so we could have used a three-level
>   * setup, but for the amounts of memory we normally use, a two-level is
>   * probably more efficient.
>   *
>   * This file contains the functions and defines necessary to modify and use
> - * the or32 page table tree.
> + * the or1k page table tree.
>   */
>  
>  extern void paging_init(void);
> --- linux-next-20210715.orig/arch/openrisc/include/asm/thread_info.h
> +++ linux-next-20210715/arch/openrisc/include/asm/thread_info.h
> @@ -25,7 +25,7 @@
>  
>  /* THREAD_SIZE is the size of the task_struct/kernel_stack combo.
>   * normally, the stack is found by doing something like p + THREAD_SIZE
> - * in or32, a page is 8192 bytes, which seems like a sane size
> + * in or1k, a page is 8192 bytes, which seems like a sane size
>   */
>  
>  #define THREAD_SIZE_ORDER 0
> --- linux-next-20210715.orig/arch/openrisc/lib/Makefile
> +++ linux-next-20210715/arch/openrisc/lib/Makefile
> @@ -1,6 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  #
> -# Makefile for or32 specific library files..
> +# Makefile for or1k specific library files..
>  #
>  
>  obj-y	:= delay.o string.o memset.o memcpy.o
> --- linux-next-20210715.orig/arch/openrisc/mm/fault.c
> +++ linux-next-20210715/arch/openrisc/mm/fault.c
> @@ -28,7 +28,7 @@ unsigned long pte_misses;	/* updated by
>  unsigned long pte_errors;	/* updated by do_page_fault() */
>  
>  /* __PHX__ :: - check the vmalloc_fault in do_page_fault()
> - *            - also look into include/asm-or32/mmu_context.h
> + *            - also look into include/asm/mmu_context.h
>   */
>  volatile pgd_t *current_pgd[NR_CPUS];
>  
> --- linux-next-20210715.orig/arch/openrisc/kernel/entry.S
> +++ linux-next-20210715/arch/openrisc/kernel/entry.S
> @@ -326,7 +326,7 @@ EXCEPTION_ENTRY(_data_page_fault_handler
>  1:	l.ori   r6,r0,0x0                  // !write access
>  2:
>  
> -	/* call fault.c handler in or32/mm/fault.c */
> +	/* call fault.c handler in openrisc/mm/fault.c */
>  	l.jal   do_page_fault
>  	 l.nop
>  	l.j     _ret_from_exception
> @@ -348,7 +348,7 @@ EXCEPTION_ENTRY(_insn_page_fault_handler
>  	/* r4 set be EXCEPTION_HANDLE */   // effective address of fault
>  	l.ori	r6,r0,0x0		   // !write access
>  
> -	/* call fault.c handler in or32/mm/fault.c */
> +	/* call fault.c handler in openrisc/mm/fault.c */
>  	l.jal   do_page_fault
>  	 l.nop
>  	l.j     _ret_from_exception
> --- linux-next-20210715.orig/arch/openrisc/kernel/head.S
> +++ linux-next-20210715/arch/openrisc/kernel/head.S
> @@ -599,7 +599,7 @@ flush_tlb:
>  	l.jal	_flush_tlb
>  	 l.nop
>  
> -/* The MMU needs to be enabled before or32_early_setup is called */
> +/* The MMU needs to be enabled before or1k_early_setup is called */
>  
>  enable_mmu:
>  	/*
> @@ -641,9 +641,9 @@ enable_mmu:
>  	/* magic number mismatch, set fdt pointer to null */
>  	l.or	r25,r0,r0
>  _fdt_found:
> -	/* pass fdt pointer to or32_early_setup in r3 */
> +	/* pass fdt pointer to or1k_early_setup in r3 */
>  	l.or	r3,r0,r25
> -	LOAD_SYMBOL_2_GPR(r24, or32_early_setup)
> +	LOAD_SYMBOL_2_GPR(r24, or1k_early_setup)
>  	l.jalr r24
>  	 l.nop
>  
> --- linux-next-20210715.orig/arch/openrisc/kernel/setup.c
> +++ linux-next-20210715/arch/openrisc/kernel/setup.c
> @@ -209,7 +209,7 @@ void __init setup_cpuinfo(void)
>  }
>  
>  /**
> - * or32_early_setup
> + * or1k_early_setup
>   *
>   * Handles the pointer to the device tree that this kernel is to use
>   * for establishing the available platform devices.
> @@ -217,7 +217,7 @@ void __init setup_cpuinfo(void)
>   * Falls back on built-in device tree in case null pointer is passed.
>   */
>  
> -void __init or32_early_setup(void *fdt)
> +void __init or1k_early_setup(void *fdt)
>  {
>  	if (fdt)
>  		pr_info("FDT at %p\n", fdt);
