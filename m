Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69CD43F75BB
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 15:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241148AbhHYNTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 09:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232589AbhHYNTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 09:19:40 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60A36C061757
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 06:18:54 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id j2so9902637pll.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 06:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=4ik/eFnY7+CuzmSUYisgf/KLeW0T92g5imVQVoUtu5U=;
        b=SoU40/GXX37JX5ldvP7VR62In+e75SpTCrmUKETBWribIDwWB8unlY61T9fVRkSqaN
         3Oxj20kczAYSVIZSKQqO5f+aqwM/oUh91yLfVngFCwQpJ9XkGpXRNTW6v1F1PM/EW/gR
         MI9zD+NJ5q891g4Qd5s/9MGEfuZwURR4HeLnAeJaSZmPFF08O5QjpAHHVAomTjIs2C3b
         DYy8nvOwIGPIv5BRtjVNrFOAsT0uKKt0QqhtZpp1frgbAZHjbMAw47OCNvuZrXFPsgf6
         nXsIpbV+i+BdkgrgJTWJGJvi8/oFnmcpV0/GgR6y651VH0pOXxRMwBgC9RuoIM9y22Ix
         Cg5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=4ik/eFnY7+CuzmSUYisgf/KLeW0T92g5imVQVoUtu5U=;
        b=ZSHReO1fVQs9l8z7WlS70aHsPUS38VJbmjBgWPSNdQjJPUPpC8813HdRyC9UpF2ooc
         R7hng4G5tSsSfe6OjPsHXgUiVTCWUtcgEj8m4FTE4v+YtMRZD4kNiLyt3DZMMMWp95xz
         k92D0RBtxXvFGgncXDu5mIHYdFsqpN8+41/GQDoivUAx4CeVunuZQ8dFSWH/HA+FLSHG
         h3W5Zzs5EISJOpFDUjYp8V9HVZrdj37Y36955ebG9kkJBhTlroO/WTAYaDs+dczDOggR
         XxY4w9Rk1Yl6fx/0kRiFhVgMLjjID2fFNMoPb7A6xa8cGVd9j/7YGes1NcCyRX/+ui07
         ViTw==
X-Gm-Message-State: AOAM532JLf+uQtNuVFMaS05zxs9IDqj8DAZwSin3dRjj/BT0IQghlJLi
        cCesrIi8W4cnSKbYElqbRN0=
X-Google-Smtp-Source: ABdhPJyPzbNUVZtiPa+4RWuRZh7fvF6egYCN1AEvgYLKF7aMYWQcoURxf+5sSN8nPf9284E3+rh+ng==
X-Received: by 2002:a17:90a:c88:: with SMTP id v8mr10716479pja.197.1629897533805;
        Wed, 25 Aug 2021 06:18:53 -0700 (PDT)
Received: from owniadeMacBook-Pro.local ([103.97.201.4])
        by smtp.gmail.com with ESMTPSA id p24sm6945858pfh.136.2021.08.25.06.18.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Aug 2021 06:18:53 -0700 (PDT)
Subject: Re: [PATCH 3/4] ARM: Support KFENCE for ARM
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kasan-dev@googlegroups.com
References: <20210825092116.149975-1-wangkefeng.wang@huawei.com>
 <20210825092116.149975-4-wangkefeng.wang@huawei.com>
From:   ownia <ownia.linux@gmail.com>
Message-ID: <51b02ecd-0f3d-99b0-c943-1d4da26174d0@gmail.com>
Date:   Wed, 25 Aug 2021 21:18:49 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210825092116.149975-4-wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021/8/25 17:21, Kefeng Wang wrote:
> Add architecture specific implementation details for KFENCE and enable
> KFENCE on ARM. In particular, this implements the required interface in
>  <asm/kfence.h>.
>
> KFENCE requires that attributes for pages from its memory pool can
> individually be set. Therefore, force the kfence pool to be mapped
> at page granularity.
>
> Testing this patch using the testcases in kfence_test.c and all passed
> with or without ARM_LPAE.
>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  arch/arm/Kconfig              |  1 +
>  arch/arm/include/asm/kfence.h | 52 +++++++++++++++++++++++++++++++++++
>  arch/arm/mm/fault.c           |  9 ++++--
>  3 files changed, 60 insertions(+), 2 deletions(-)
>  create mode 100644 arch/arm/include/asm/kfence.h
>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 7a8059ff6bb0..3798f82a0c0d 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -73,6 +73,7 @@ config ARM
>  	select HAVE_ARCH_AUDITSYSCALL if AEABI && !OABI_COMPAT
>  	select HAVE_ARCH_BITREVERSE if (CPU_32v7M || CPU_32v7) && !CPU_32v6
>  	select HAVE_ARCH_JUMP_LABEL if !XIP_KERNEL && !CPU_ENDIAN_BE32 && MMU
> +	select HAVE_ARCH_KFENCE if MMU
>  	select HAVE_ARCH_KGDB if !CPU_ENDIAN_BE32 && MMU
>  	select HAVE_ARCH_KASAN if MMU && !XIP_KERNEL
>  	select HAVE_ARCH_MMAP_RND_BITS if MMU
> diff --git a/arch/arm/include/asm/kfence.h b/arch/arm/include/asm/kfence.h
> new file mode 100644
> index 000000000000..eae7a12ab2a9
> --- /dev/null
> +++ b/arch/arm/include/asm/kfence.h
> @@ -0,0 +1,52 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef __ASM_ARM_KFENCE_H
> +#define __ASM_ARM_KFENCE_H
> +
> +#include <linux/kfence.h>
> +#include <asm/set_memory.h>
> +#include <asm/pgalloc.h>
> +
> +static inline int split_pmd_page(pmd_t *pmd, unsigned long addr)
> +{
> +	int i;
> +	unsigned long pfn = PFN_DOWN(__pa((addr & PMD_MASK)));
> +	pte_t *pte = pte_alloc_one_kernel(&init_mm);
> +
> +	if (!pte)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < PTRS_PER_PTE; i++)
> +		set_pte_ext(pte + i, pfn_pte(pfn + i, PAGE_KERNEL), 0);
> +	pmd_populate_kernel(&init_mm, pmd, pte);
> +
> +	flush_tlb_kernel_range(addr, addr + PMD_SIZE);
> +	return 0;
> +}
> +
> +static inline bool arch_kfence_init_pool(void)
> +{
> +	unsigned long addr;
> +	pmd_t *pmd;
> +
> +	for (addr = (unsigned long)__kfence_pool; is_kfence_address((void *)addr);
> +	     addr += PAGE_SIZE) {
> +		pmd = pmd_off_k(addr);
> +
> +		if (pmd_leaf(*pmd)) {
> +			if (split_pmd_page(pmd, addr))
> +				return false;
> +		}
> +	}
> +
> +	return true;
> +}
> +
> +static inline bool kfence_protect_page(unsigned long addr, bool protect)
> +{
> +	set_memory_valid(addr, 1, !protect);
> +
> +	return true;
> +}
> +
> +#endif /* __ASM_ARM_KFENCE_H */
> diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
> index f7ab6dabe89f..9fa221ffa1b9 100644
> --- a/arch/arm/mm/fault.c
> +++ b/arch/arm/mm/fault.c
> @@ -17,6 +17,7 @@
>  #include <linux/sched/debug.h>
>  #include <linux/highmem.h>
>  #include <linux/perf_event.h>
> +#include <linux/kfence.h>
>  
>  #include <asm/system_misc.h>
>  #include <asm/system_info.h>
> @@ -131,10 +132,14 @@ __do_kernel_fault(struct mm_struct *mm, unsigned long addr, unsigned int fsr,
>  	/*
>  	 * No handler, we'll have to terminate things with extreme prejudice.
>  	 */
> -	if (addr < PAGE_SIZE)
> +	if (addr < PAGE_SIZE) {
>  		msg = "NULL pointer dereference";
> -	else
> +	} else {
> +		if (kfence_handle_page_fault(addr, is_write_fault(fsr), regs))
> +			return;
> +
>  		msg = "paging request";
> +	}


I think here should do some fixup to follow upstream mainline code.


>  
>  	die_kernel_fault(msg, mm, addr, fsr, regs);
>  }
