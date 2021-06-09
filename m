Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D23073A0C44
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 08:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236708AbhFIGTy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 02:19:54 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3912 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236699AbhFIGTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 02:19:53 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4G0Gzd5XMgz6wqy;
        Wed,  9 Jun 2021 14:14:53 +0800 (CST)
Received: from dggpemm500009.china.huawei.com (7.185.36.225) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 9 Jun 2021 14:17:56 +0800
Received: from [10.174.179.24] (10.174.179.24) by
 dggpemm500009.china.huawei.com (7.185.36.225) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 9 Jun 2021 14:17:55 +0800
Subject: Re: [PATCH -next] riscv: Enable KFENCE for riscv64
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>
References: <20210529080340.2987212-1-liushixin2@huawei.com>
CC:     <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <kasan-dev@googlegroups.com>
From:   Liu Shixin <liushixin2@huawei.com>
Message-ID: <0a3ee489-47db-47f5-6192-794457fc74f8@huawei.com>
Date:   Wed, 9 Jun 2021 14:17:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20210529080340.2987212-1-liushixin2@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.24]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500009.china.huawei.com (7.185.36.225)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, everybody,

I perfected the patch based on the previous advice. How about this version?


Thanks,


On 2021/5/29 16:03, Liu Shixin wrote:
> Add architecture specific implementation details for KFENCE and enable
> KFENCE for the riscv64 architecture. In particular, this implements the
> required interface in <asm/kfence.h>.
>
> KFENCE requires that attributes for pages from its memory pool can
> individually be set. Therefore, force the kfence pool to be mapped at
> page granularity.
>
> Testing this patch using the testcases in kfence_test.c and all passed.
>
> Signed-off-by: Liu Shixin <liushixin2@huawei.com>
> ---
> 1. Add helper function split_pmd_page() which is used to split a pmd to ptes. 
> 2. Add the judgment on the result of pte_alloc_one_kernel().
>
>  arch/riscv/Kconfig              |  1 +
>  arch/riscv/include/asm/kfence.h | 63 +++++++++++++++++++++++++++++++++
>  arch/riscv/mm/fault.c           | 11 +++++-
>  3 files changed, 74 insertions(+), 1 deletion(-)
>  create mode 100644 arch/riscv/include/asm/kfence.h
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 4982130064ef..2f4903a7730f 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -65,6 +65,7 @@ config RISCV
>  	select HAVE_ARCH_JUMP_LABEL_RELATIVE
>  	select HAVE_ARCH_KASAN if MMU && 64BIT
>  	select HAVE_ARCH_KASAN_VMALLOC if MMU && 64BIT
> +	select HAVE_ARCH_KFENCE if MMU && 64BIT
>  	select HAVE_ARCH_KGDB
>  	select HAVE_ARCH_KGDB_QXFER_PKT
>  	select HAVE_ARCH_MMAP_RND_BITS if MMU
> diff --git a/arch/riscv/include/asm/kfence.h b/arch/riscv/include/asm/kfence.h
> new file mode 100644
> index 000000000000..d887a54042aa
> --- /dev/null
> +++ b/arch/riscv/include/asm/kfence.h
> @@ -0,0 +1,63 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef _ASM_RISCV_KFENCE_H
> +#define _ASM_RISCV_KFENCE_H
> +
> +#include <linux/kfence.h>
> +#include <linux/pfn.h>
> +#include <asm-generic/pgalloc.h>
> +#include <asm/pgtable.h>
> +
> +static inline int split_pmd_page(unsigned long addr)
> +{
> +	int i;
> +	unsigned long pfn = PFN_DOWN(__pa((addr & PMD_MASK)));
> +	pmd_t *pmd = pmd_off_k(addr);
> +	pte_t *pte = pte_alloc_one_kernel(&init_mm);
> +
> +	if (!pte)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < PTRS_PER_PTE; i++)
> +		set_pte(pte + i, pfn_pte(pfn + i, PAGE_KERNEL));
> +	set_pmd(pmd, pfn_pmd(PFN_DOWN(__pa(pte)), PAGE_TABLE));
> +
> +	flush_tlb_kernel_range(addr, addr + PMD_SIZE);
> +	return 0;
> +}
> +
> +static inline bool arch_kfence_init_pool(void)
> +{
> +	int ret;
> +	unsigned long addr;
> +	pmd_t *pmd;
> +
> +	for (addr = (unsigned long)__kfence_pool; is_kfence_address((void *)addr);
> +	     addr += PAGE_SIZE) {
> +		pmd = pmd_off_k(addr);
> +
> +		if (pmd_leaf(*pmd)) {
> +			ret = split_pmd_page(addr);
> +			if (ret)
> +				return false;
> +		}
> +	}
> +
> +	return true;
> +}
> +
> +static inline bool kfence_protect_page(unsigned long addr, bool protect)
> +{
> +	pte_t *pte = virt_to_kpte(addr);
> +
> +	if (protect)
> +		set_pte(pte, __pte(pte_val(*pte) & ~_PAGE_PRESENT));
> +	else
> +		set_pte(pte, __pte(pte_val(*pte) | _PAGE_PRESENT));
> +
> +	flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
> +
> +	return true;
> +}
> +
> +#endif /* _ASM_RISCV_KFENCE_H */
> diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
> index 096463cc6fff..aa08dd2f8fae 100644
> --- a/arch/riscv/mm/fault.c
> +++ b/arch/riscv/mm/fault.c
> @@ -14,6 +14,7 @@
>  #include <linux/signal.h>
>  #include <linux/uaccess.h>
>  #include <linux/kprobes.h>
> +#include <linux/kfence.h>
>  
>  #include <asm/ptrace.h>
>  #include <asm/tlbflush.h>
> @@ -45,7 +46,15 @@ static inline void no_context(struct pt_regs *regs, unsigned long addr)
>  	 * Oops. The kernel tried to access some bad page. We'll have to
>  	 * terminate things with extreme prejudice.
>  	 */
> -	msg = (addr < PAGE_SIZE) ? "NULL pointer dereference" : "paging request";
> +	if (addr < PAGE_SIZE)
> +		msg = "NULL pointer dereference";
> +	else {
> +		if (kfence_handle_page_fault(addr, regs->cause == EXC_STORE_PAGE_FAULT, regs))
> +			return;
> +
> +		msg = "paging request";
> +	}
> +
>  	die_kernel_fault(msg, addr, regs);
>  }
>  

