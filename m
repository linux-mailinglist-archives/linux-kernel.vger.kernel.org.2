Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E74FF3237BC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 08:13:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232473AbhBXHNN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 02:13:13 -0500
Received: from foss.arm.com ([217.140.110.172]:43288 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230019AbhBXHMz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 02:12:55 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 85CD71FB;
        Tue, 23 Feb 2021 23:12:06 -0800 (PST)
Received: from [10.163.64.181] (unknown [10.163.64.181])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 35D053F73D;
        Tue, 23 Feb 2021 23:12:01 -0800 (PST)
Subject: Re: [PATCH v3 1/1] arm64: mm: correct the inside linear map range
 during hotplug check
To:     Pavel Tatashin <pasha.tatashin@soleen.com>,
        tyhicks@linux.microsoft.com, jmorris@namei.org,
        catalin.marinas@arm.com, will@kernel.org,
        akpm@linux-foundation.org, rppt@kernel.org, logang@deltatee.com,
        ardb@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, mhocko@suse.com, linux-mm@kvack.org
References: <20210216150351.129018-1-pasha.tatashin@soleen.com>
 <20210216150351.129018-2-pasha.tatashin@soleen.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <605fb3ad-7208-6d27-f055-cb642be8804b@arm.com>
Date:   Wed, 24 Feb 2021 12:42:31 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210216150351.129018-2-pasha.tatashin@soleen.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/16/21 8:33 PM, Pavel Tatashin wrote:
> Memory hotplug may fail on systems with CONFIG_RANDOMIZE_BASE because the
> linear map range is not checked correctly.
> 
> The start physical address that linear map covers can be actually at the
> end of the range because of randomization. Check that and if so reduce it
> to 0.
> 
> This can be verified on QEMU with setting kaslr-seed to ~0ul:
> 
> memstart_offset_seed = 0xffff
> START: __pa(_PAGE_OFFSET(vabits_actual)) = ffff9000c0000000
> END:   __pa(PAGE_END - 1) =  1000bfffffff

This would have tripped the check in mhp_get_pluggable_range()
with errors something like here, which is expected.

Hotplug memory [0x680000000-0x688000000] exceeds maximum addressable range [0x0-0x0]
Hotplug memory [0x6c0000000-0x6c8000000] exceeds maximum addressable range [0x0-0x0]
Hotplug memory [0x700000000-0x708000000] exceeds maximum addressable range [0x0-0x0]
Hotplug memory [0x780000000-0x788000000] exceeds maximum addressable range [0x0-0x0]
Hotplug memory [0x7c0000000-0x7c8000000] exceeds maximum addressable range [0x0-0x0]

> 
> Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
> Fixes: 58284a901b42 ("arm64/mm: Validate hotplug range before creating linear mapping")
> Tested-by: Tyler Hicks <tyhicks@linux.microsoft.com>
> ---
>  arch/arm64/mm/mmu.c | 21 +++++++++++++++++++--
>  1 file changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index ef7698c4e2f0..0d9c115e427f 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -1447,6 +1447,22 @@ static void __remove_pgd_mapping(pgd_t *pgdir, unsigned long start, u64 size)
>  struct range arch_get_mappable_range(void)
>  {
>  	struct range mhp_range;
> +	u64 start_linear_pa = __pa(_PAGE_OFFSET(vabits_actual));
> +	u64 end_linear_pa = __pa(PAGE_END - 1);
> +
> +	if (IS_ENABLED(CONFIG_RANDOMIZE_BASE)) {
> +		/*
> +		 * Check for a wrap, it is possible because of randomized linear
> +		 * mapping the start physical address is actually bigger than
> +		 * the end physical address. In this case set start to zero
> +		 * because [0, end_linear_pa] range must still be able to cover
> +		 * all addressable physical addresses.
> +		 */
> +		if (start_linear_pa > end_linear_pa)
> +			start_linear_pa = 0;
> +	}
> +
> +	WARN_ON(start_linear_pa > end_linear_pa);
>  
>  	/*
>  	 * Linear mapping region is the range [PAGE_OFFSET..(PAGE_END - 1)]
> @@ -1454,8 +1470,9 @@ struct range arch_get_mappable_range(void)
>  	 * range which can be mapped inside this linear mapping range, must
>  	 * also be derived from its end points.
>  	 */
> -	mhp_range.start = __pa(_PAGE_OFFSET(vabits_actual));
> -	mhp_range.end =  __pa(PAGE_END - 1);
> +	mhp_range.start = start_linear_pa;
> +	mhp_range.end =  end_linear_pa;
> +
>  	return mhp_range;
>  }

LGTM.

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
