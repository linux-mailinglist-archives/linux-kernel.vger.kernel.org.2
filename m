Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF8F31B539
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 06:28:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbhBOF1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 00:27:06 -0500
Received: from foss.arm.com ([217.140.110.172]:58382 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229486AbhBOF1D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 00:27:03 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C7718101E;
        Sun, 14 Feb 2021 21:26:16 -0800 (PST)
Received: from [192.168.0.130] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4487E3F73B;
        Sun, 14 Feb 2021 21:26:12 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH] arm64: mm: correct the start of physical address in
 linear map
To:     Pavel Tatashin <pasha.tatashin@soleen.com>,
        tyhicks@linux.microsoft.com, jmorris@namei.org,
        catalin.marinas@arm.com, will@kernel.org,
        akpm@linux-foundation.org, rppt@kernel.org, logang@deltatee.com,
        ardb@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20210213012316.1525419-1-pasha.tatashin@soleen.com>
Message-ID: <06b7bfd1-99cd-a9be-e3cc-9fe13f2cf2a6@arm.com>
Date:   Mon, 15 Feb 2021 10:56:15 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210213012316.1525419-1-pasha.tatashin@soleen.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Pavel,

On 2/13/21 6:53 AM, Pavel Tatashin wrote:
> Memory hotplug may fail on systems with CONFIG_RANDOMIZE_BASE because the
> linear map range is not checked correctly.
> 
> The start physical address that linear map covers can be actually at the
> end of the range because of randmomization. Check that and if so reduce it
> to 0.

Looking at the code, this seems possible if memstart_addr which is a signed
value becomes large (after falling below 0) during arm64_memblock_init().

> 
> This can be verified on QEMU with setting kaslr-seed to ~0ul:
> 
> memstart_offset_seed = 0xffff
> START: __pa(_PAGE_OFFSET(vabits_actual)) = ffff9000c0000000
> END:   __pa(PAGE_END - 1) =  1000bfffffff
> 
> Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
> Fixes: 58284a901b42 ("arm64/mm: Validate hotplug range before creating linear mapping")
> ---
>  arch/arm64/mm/mmu.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index ae0c3d023824..6057ecaea897 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -1444,14 +1444,25 @@ static void __remove_pgd_mapping(pgd_t *pgdir, unsigned long start, u64 size)
>  
>  static bool inside_linear_region(u64 start, u64 size)
>  {
> +	u64 start_linear_pa = __pa(_PAGE_OFFSET(vabits_actual));
> +	u64 end_linear_pa = __pa(PAGE_END - 1);
> +
> +	/*
> +	 * Check for a wrap, it is possible because of randomized linear mapping
> +	 * the start physical address is actually bigger than the end physical
> +	 * address. In this case set start to zero because [0, end_linear_pa]
> +	 * range must still be able to cover all addressable physical addresses.
> +	 */

If this is possible only with randomized linear mapping, could you please
add IS_ENABLED(CONFIG_RANDOMIZED_BASE) during the switch over. Wondering
if WARN_ON(start_linear_pa > end_linear_pa) should be added otherwise i.e
when linear mapping randomization is not enabled.

> +	if (start_linear_pa > end_linear_pa)
> +		start_linear_pa = 0;

This looks okay but will double check and give it some more testing.

> +
>  	/*
>  	 * Linear mapping region is the range [PAGE_OFFSET..(PAGE_END - 1)]
>  	 * accommodating both its ends but excluding PAGE_END. Max physical
>  	 * range which can be mapped inside this linear mapping range, must
>  	 * also be derived from its end points.
>  	 */
> -	return start >= __pa(_PAGE_OFFSET(vabits_actual)) &&
> -	       (start + size - 1) <= __pa(PAGE_END - 1);
> +	return start >= start_linear_pa && (start + size - 1) <= end_linear_pa;
>  }
>  
>  int arch_add_memory(int nid, u64 start, u64 size,
> 

- Anshuman
