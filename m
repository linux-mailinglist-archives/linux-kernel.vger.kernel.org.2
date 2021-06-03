Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBA6B399A5F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 08:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbhFCGBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 02:01:51 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:41847 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbhFCGBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 02:01:49 -0400
Received: (Authenticated sender: alex@ghiti.fr)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 5E52EFF803;
        Thu,  3 Jun 2021 05:59:59 +0000 (UTC)
Subject: Re: [PATCH v2] riscv: Map the kernel with correct permissions the
 first time
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jisheng Zhang <jszhang@kernel.org>,
        Zong Li <zong.li@sifive.com>, Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210526134110.217073-1-alex@ghiti.fr>
 <YK89yVQirCLdodxG@infradead.org>
From:   Alex Ghiti <alex@ghiti.fr>
Message-ID: <acf00719-c41a-21de-b54a-a2be003a5698@ghiti.fr>
Date:   Thu, 3 Jun 2021 07:59:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <YK89yVQirCLdodxG@infradead.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 27/05/2021 à 08:35, Christoph Hellwig a écrit :
> On Wed, May 26, 2021 at 03:41:10PM +0200, Alexandre Ghiti wrote:
>>   #ifdef CONFIG_64BIT
>> +#define is_kernel_mapping(x)	((x) >= kernel_virt_addr && (x) < (kernel_virt_addr + load_sz))
>> +#define is_linear_mapping(x)	((x) >= PAGE_OFFSET && (x) < kernel_virt_addr)
>> +
> 
> Overly long lines.  Independ of that complex macros are generally much
> more readable if they are written more function-like, that is the name
> and paramtes are kept on a line of their own:
> 
> #define is_kernel_mapping(x) \
> 	((x) >= kernel_virt_addr && (x) < (kernel_virt_addr + load_sz))
> 
> But what is the reason to not make them type-safe inline functions
> anyway?
> 
>>   #define __va_to_pa_nodebug(x)	({						\
>>   	unsigned long _x = x;							\
>> -	(_x < kernel_virt_addr) ?						\
>> +	is_linear_mapping(_x) ?							\
>>   		linear_mapping_va_to_pa(_x) : kernel_mapping_va_to_pa(_x);	\
>>   	})
> 
> ... especially for something complex like this.

Turning those macros into inline functions gave me a hard time because 
of the XIP fixups that use macros to redefine symbols that should be 
accessed in RAM instead of flash before the MMU is enabled, I couldn't 
manage to get rid of header circular dependencies.

But, I think I finally found a solution to eliminate the need for those 
fixups. So for the moment, I'll send a v3 that fixes all your comments 
but this one and then I will work on this solution.

Thanks again for your comments,

Alex

> 
>> +static inline bool is_va_kernel_lm_alias_text(uintptr_t va)
>> +{
>> +	return (va >= (uintptr_t)lm_alias(_start) && va < (uintptr_t)lm_alias(__init_text_begin));
> 
> Overly long line as well.  And useless braces.
> 
>> +static inline bool is_va_kernel_init_text(uintptr_t va)
>> +{
>> +	return (va >= (uintptr_t)__init_text_begin && va < (uintptr_t)__init_data_begin);
>> +}
> 
> Same here.
> 
>> +#ifdef CONFIG_STRICT_KERNEL_RWX
>> +static __init pgprot_t pgprot_from_va(uintptr_t va)
>> +{
>> +#ifdef CONFIG_64BIT
>> +	if (is_va_kernel_text(va) || is_va_kernel_init_text(va))
>> +		return PAGE_KERNEL_READ_EXEC;
>> +
>> +	/*
>> +	 * We must mark only text as read-only as init text will get freed later
>> +	 * and rodata section is marked readonly in mark_rodata_ro.
>> +	 */
>> +	if (is_va_kernel_lm_alias_text(va))
>> +		return PAGE_KERNEL_READ;
>> +
>> +	return PAGE_KERNEL;
>> +#else
>> +	if (is_va_kernel_text(va))
>> +		return PAGE_KERNEL_READ_EXEC;
>> +
>> +	if (is_va_kernel_init_text(va))
>> +		return PAGE_KERNEL_EXEC;
>> +
>> +	return PAGE_KERNEL;
>> +#endif /* CONFIG_64BIT */
>> +}
> 
> If the entire function is different for config symbols please just
> split it into two separate functions.  But to make the difference more
> clear IS_ENABLED might fit better here:
> 
> static __init pgprot_t pgprot_from_va(uintptr_t va)
> {
> 	if (is_va_kernel_text(va))
> 		return PAGE_KERNEL_READ_EXEC;
> 	if (is_va_kernel_init_text(va))
> 		return IS_ENABLED(CONFIG_64BIT) ?
> 			PAGE_KERNEL_READ_EXEC : PAGE_KERNEL_EXEC;
> 	if (IS_ENABLED(CONFIG_64BIT) && is_va_kernel_lm_alias_text(va))
> 		return PAGE_KERNEL_READ;
> 	return PAGE_KERNEL;
> }
> 
> Preferable with comments explaining the 32-bit vs 64-bit difference.
> 
>> +void mark_rodata_ro(void)
>> +{
>> +	unsigned long rodata_start = (unsigned long)__start_rodata;
>> +	unsigned long data_start = (unsigned long)_data;
>> +	unsigned long __maybe_unused lm_rodata_start = (unsigned long)lm_alias(__start_rodata);
>> +	unsigned long __maybe_unused lm_data_start = (unsigned long)lm_alias(_data);
>> +
>> +	set_memory_ro(rodata_start, (data_start - rodata_start) >> PAGE_SHIFT);
>> +#ifdef CONFIG_64BIT
>> +	set_memory_ro(lm_rodata_start, (lm_data_start - lm_rodata_start) >> PAGE_SHIFT);
>> +#endif
> 
> Lots of unreadable overly lone lines.  Why not add a helper and do
> something like:
> 
> static void set_kernel_memory_ro(char *startp, char *endp)
> {
>          unsigned long start = (unsigned long)startp;
> 	unsigned long end = (unsigned long)endp;
> 
> 	set_memory_ro(start, (start - end) >> PAGE_SHIFT);
> }
> 
>          set_kernel_memory_ro(_start_rodata, _data);
> 	if (IS_ENABLED(CONFIG_64BIT))
> 		set_kernel_memory_ro(lm_alias(__start_rodata), lm_alias(_data));
> 
> 
>> +static __init pgprot_t pgprot_from_va(uintptr_t va)
>> +{
>> +#ifdef CONFIG_64BIT
>> +	if (is_kernel_mapping(va))
>> +		return PAGE_KERNEL_EXEC;
>> +
>> +	if (is_linear_mapping(va))
>> +		return PAGE_KERNEL;
>> +
>> +	return PAGE_KERNEL;
>> +#else
>> +	return PAGE_KERNEL_EXEC;
>> +#endif /* CONFIG_64BIT */
>> +}
>> +#endif /* CONFIG_STRICT_KERNEL_RWX */
>> +
> 
> Same comment as for the other version.  This could become:
> 
> static __init pgprot_t pgprot_from_va(uintptr_t va)
> {
> 	if (IS_ENABLED(CONFIG_64BIT) && !is_kernel_mapping(va))
> 		return PAGE_KERNEL;
> 	return PAGE_KERNEL_EXEC;
> }
> 
>> -static void __init create_kernel_page_table(pgd_t *pgdir, uintptr_t map_size)
>> +static void __init create_kernel_page_table(pgd_t *pgdir, uintptr_t map_size, bool early)
> 
> Overly long line.
> 
>>   	for (va = kernel_virt_addr; va < end_va; va += map_size)
>>   		create_pgd_mapping(pgdir, va,
>>   				   load_pa + (va - kernel_virt_addr),
>> -				   map_size, PAGE_KERNEL_EXEC);
>> +				   map_size, early ? PAGE_KERNEL_EXEC : pgprot_from_va(va));
> 
> Same here.  But why not pass in a "pgprot_t ram_pgprot" instead of the
> bool, which would be self-documenting.
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
> 
