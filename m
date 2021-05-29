Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD5B394E87
	for <lists+linux-kernel@lfdr.de>; Sun, 30 May 2021 01:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbhE2XoS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 May 2021 19:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbhE2XoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 May 2021 19:44:16 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30915C061760
        for <linux-kernel@vger.kernel.org>; Sat, 29 May 2021 16:42:38 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id b15-20020a17090a550fb029015dad75163dso4595654pji.0
        for <linux-kernel@vger.kernel.org>; Sat, 29 May 2021 16:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:subject:in-reply-to:cc:to:message-id:mime-version
         :content-transfer-encoding;
        bh=tgVyKHeK8MLlOo9tbOhuEHC7TCcOVMTTHGz7sFUvf8I=;
        b=XibzmkyPQneOiMaxr9WCUu+/mxvk8aUjvWXFPHv4PSjVK3JDLgkiwo9j2ziQ82Knfb
         mJcFiS8i6p+strYzSxNlMKyaFiAWp0vhthq+bwDNOzGsrmiz8TIJM0O4gxNG7/jzu7PM
         r8U2iPTm5lEo0EUVkQpT+/VuuK4F1rog4xLk+o7nFfe8oCBE9Oy/toNhpvkyXlsjmu1o
         wP+JSmMtO+PsDP4e72rYUIwuTqIuYGcIy8IBZM7p2jFvSJVoCEmiOZuupP+2x6OCDOZ5
         WuG5HEGE5H5oY6z23kSIjprv6S6ZWkJjK8Di5nFDkr9O8ewOSMNrWaucjFbtSxm5xfr9
         gHcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:in-reply-to:cc:to:message-id
         :mime-version:content-transfer-encoding;
        bh=tgVyKHeK8MLlOo9tbOhuEHC7TCcOVMTTHGz7sFUvf8I=;
        b=IJE7dgbH+bxdk7PV4n3OhJedYBTGtzz06/evp9khY3OJqCLBHcP87Iot6YwE4mdyvx
         y/TZVzXjd6NLUGQJaLNIJh1cqEvqZ2hyvGRMvxjadXG96YWa2ulsRaKANVuH8e1LRUuZ
         toJ/CriGq+3S4arLxVUBRyFd6WkdfwgTu8bcTIDz9bfnk3ZGe58xm73Hos64lb6OY+RD
         5hoYfJshOPLTFr+d/ML0y8lJzl+8RdB3lfCVFf0FjMGj/jdS7MlWKPy5F6qhAros+EfY
         iv4cyRXfi6+JUQn8CrfmJTsJzHcOBuF+FQKF+aernQgpaz1r9AsAkw4SBVP8Xt/Kkfnh
         cpgg==
X-Gm-Message-State: AOAM532uXwJCRBq7GqwLahNgYXvTKZFBZYykvLuDifwpJ4EsqjRhIllc
        cYFJqgXOgoYFdVpJtiDPfnlKkQ==
X-Google-Smtp-Source: ABdhPJwu0FekTwBon4KdCYGCBJyPRXlOLy0Ljddqtr3M4Lg5F5zcV/zboSbJBsRXFyipPt+88WkxIQ==
X-Received: by 2002:a17:90a:b796:: with SMTP id m22mr11854271pjr.146.1622331757490;
        Sat, 29 May 2021 16:42:37 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id b16sm7720890pju.35.2021.05.29.16.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 May 2021 16:42:37 -0700 (PDT)
Date:   Sat, 29 May 2021 16:42:37 -0700 (PDT)
X-Google-Original-Date: Sat, 29 May 2021 16:41:42 PDT (-0700)
From:   palmerdabbelt@google.com
X-Google-Original-From: palmer@dabbelt.com
Subject:     Re: [PATCH V4 2/2] riscv: Use use_asid_allocator flush TLB
In-Reply-To: <20210527070903.GA32653@lst.de>
CC:     guoren@kernel.org, Anup Patel <Anup.Patel@wdc.com>,
        Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-sunxi@lists.linux.dev,
        guoren@linux.alibaba.com
To:     Christoph Hellwig <hch@lst.de>
Message-ID: <mhng-cfb5a043-4b59-4698-b732-5cf5ceb49114@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 May 2021 00:09:03 PDT (-0700), Christoph Hellwig wrote:
> On Wed, May 26, 2021 at 05:49:21AM +0000, guoren@kernel.org wrote:
>> From: Guo Ren <guoren@linux.alibaba.com>
>>
>> Use static_branch_unlikely(&use_asid_allocator) to keep the origin
>> tlb flush style, so it's no effect on the existing machine. Here
>> are the optimized functions:
>>  - flush_tlb_mm
>>  - flush_tlb_page
>>  - flush_tlb_range
>>
>> All above are based on the below new implement functions:
>>  - __sbi_tlb_flush_range_asid
>>  - local_flush_tlb_range_asid
>>
>> These functions are based on ASID instead of previous non-ASID
>> tlb_flush implementation which invalidates more useful tlb
>> entries.
>
> I still think the commit message is incomplete and rather misleading.
> Here is what I'd come up with from reading the patch:
>
> ---------
> Subject: add ASID-based tlbflushing methods
>
> Implement optimized version of the tlb flushing routines for systems
> using ASIDs.  These are behind the use_asid_allocator static branch to
> not affect existing systems not using ASIDs.
> ---------

That seems much better, thanks.

>> +static inline void local_flush_tlb_range_asid(unsigned long start,
>> +				unsigned long size, unsigned long asid)
>> +{
>> +	unsigned long tmp, end = ALIGN(start + size, PAGE_SIZE);
>> +
>> +	for (tmp = start & PAGE_MASK; tmp < end; tmp += PAGE_SIZE) {
>> +		__asm__ __volatile__ ("sfence.vma %0, %1"
>> +				:
>> +				: "r" (tmp), "r" (asid)
>> +				: "memory");
>> +		tmp += PAGE_SIZE;
>> +	}
>
> This double increments tmp.
>
> Also the non-ASID code switches to a global flush once flushing more
> than a single page.  It might be worth documenting the tradeoff in the
> code.

For some reason I thought we'd written this down in the commentary of 
teh ISA manual as the suggested huersitic here, but I can't find it so 
maybe I'm wrong.  If it's actually there it would be good to point that 
out, otherwise some documentation seems fine as it'll probably become a 
tunable at some point anyway.

>> +static void __sbi_tlb_flush_range_asid(struct cpumask *cmask,
>> +				       unsigned long start,
>> +				       unsigned long size,
>> +				       unsigned long asid)
>> +{
>
> I don't think the calling conventions here are optimal.  I'd pass
> the mm_struct as the first argument, as we can derive both the cpumask
> and asid from it instead of doing that in the callers.
>
> But more importantly I think the static branch check can be moved deeper
> into the code to avoid a lot of duplication.  What do you think of this
> version?
>
> diff --git a/arch/riscv/include/asm/mmu_context.h b/arch/riscv/include/asm/mmu_context.h
> index b0659413a080..7030837adc1a 100644
> --- a/arch/riscv/include/asm/mmu_context.h
> +++ b/arch/riscv/include/asm/mmu_context.h
> @@ -33,6 +33,8 @@ static inline int init_new_context(struct task_struct *tsk,
>  	return 0;
>  }
>
> +DECLARE_STATIC_KEY_FALSE(use_asid_allocator);
> +
>  #include <asm-generic/mmu_context.h>
>
>  #endif /* _ASM_RISCV_MMU_CONTEXT_H */
> diff --git a/arch/riscv/mm/context.c b/arch/riscv/mm/context.c
> index 68aa312fc352..45c1b04b105d 100644
> --- a/arch/riscv/mm/context.c
> +++ b/arch/riscv/mm/context.c
> @@ -18,7 +18,7 @@
>
>  #ifdef CONFIG_MMU
>
> -static DEFINE_STATIC_KEY_FALSE(use_asid_allocator);
> +DEFINE_STATIC_KEY_FALSE(use_asid_allocator);
>
>  static unsigned long asid_bits;
>  static unsigned long num_asids;
> diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
> index 720b443c4528..d8afbb1269d5 100644
> --- a/arch/riscv/mm/tlbflush.c
> +++ b/arch/riscv/mm/tlbflush.c
> @@ -4,6 +4,33 @@
>  #include <linux/smp.h>
>  #include <linux/sched.h>
>  #include <asm/sbi.h>
> +#include <asm/mmu_context.h>
> +
> +static inline void local_flush_tlb_all_asid(unsigned long asid)
> +{
> +	__asm__ __volatile__ ("sfence.vma x0, %0"
> +			:
> +			: "r" (asid)
> +			: "memory");
> +}
> +
> +static inline void local_flush_tlb_page_asid(unsigned long addr,
> +		unsigned long asid)
> +{
> +	__asm__ __volatile__ ("sfence.vma %0, %1"
> +			:
> +			: "r" (addr), "r" (asid)
> +			: "memory");
> +}
> +
> +static inline void local_flush_tlb_range_asid(unsigned long start,
> +				unsigned long size, unsigned long asid)
> +{
> +	unsigned long addr, end = ALIGN(start + size, PAGE_SIZE);
> +
> +	for (addr = start & PAGE_MASK; addr < end; addr += PAGE_SIZE)
> +		local_flush_tlb_page_asid(addr, asid);
> +}
>
>  void flush_tlb_all(void)
>  {
> @@ -12,28 +39,43 @@ void flush_tlb_all(void)
>
>  /*
>   * This function must not be called with cmask being null.
> - * Kernel may panic if cmask is NULL.
>   */
> -static void __sbi_tlb_flush_range(struct cpumask *cmask, unsigned long start,
> +static void __sbi_tlb_flush_range(struct mm_struct *mm, unsigned long start,
>  				  unsigned long size)
>  {
> +	struct cpumask *cmask = mm_cpumask(mm);
>  	struct cpumask hmask;
>  	unsigned int cpuid;
> +	bool broadcast;
>
>  	if (cpumask_empty(cmask))
>  		return;
>
>  	cpuid = get_cpu();
> +	/* check if the tlbflush needs to be sent to other CPUs */
> +	broadcast = cpumask_any_but(cmask, cpuid) < nr_cpu_ids;
> +	if (static_branch_unlikely(&use_asid_allocator)) {
> +		unsigned long asid = atomic_long_read(&mm->context.id);
>
> -	if (cpumask_any_but(cmask, cpuid) >= nr_cpu_ids) {
> -		/* local cpu is the only cpu present in cpumask */
> -		if (size <= PAGE_SIZE)
> +		if (broadcast) {
> +			riscv_cpuid_to_hartid_mask(cmask, &hmask);
> +			sbi_remote_sfence_vma_asid(cpumask_bits(&hmask),
> +						   start, size, asid);
> +		} else if (size != -1) {
> +			local_flush_tlb_range_asid(start, size, asid);
> +		} else {
> +			local_flush_tlb_all_asid(asid);
> +		}
> +	} else {
> +		if (broadcast) {
> +			riscv_cpuid_to_hartid_mask(cmask, &hmask);
> +			sbi_remote_sfence_vma(cpumask_bits(&hmask),
> +					      start, size);
> +		} else if (size <= PAGE_SIZE) {
>  			local_flush_tlb_page(start);
> -		else
> +		} else {
>  			local_flush_tlb_all();
> -	} else {
> -		riscv_cpuid_to_hartid_mask(cmask, &hmask);
> -		sbi_remote_sfence_vma(cpumask_bits(&hmask), start, size);
> +		}
>  	}
>
>  	put_cpu();
> @@ -41,16 +83,16 @@ static void __sbi_tlb_flush_range(struct cpumask *cmask, unsigned long start,
>
>  void flush_tlb_mm(struct mm_struct *mm)
>  {
> -	__sbi_tlb_flush_range(mm_cpumask(mm), 0, -1);
> +	__sbi_tlb_flush_range(mm, 0, -1);
>  }
>
>  void flush_tlb_page(struct vm_area_struct *vma, unsigned long addr)
>  {
> -	__sbi_tlb_flush_range(mm_cpumask(vma->vm_mm), addr, PAGE_SIZE);
> +	__sbi_tlb_flush_range(vma->vm_mm, addr, PAGE_SIZE);
>  }
>
>  void flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
>  		     unsigned long end)
>  {
> -	__sbi_tlb_flush_range(mm_cpumask(vma->vm_mm), start, end - start);
> +	__sbi_tlb_flush_range(vma->vm_mm, start, end - start);
>  }

LGTM.  I took the first one as IMO they're really distnict issues, LMK 
if you want to re-spin this one or if I should just take what's here.
