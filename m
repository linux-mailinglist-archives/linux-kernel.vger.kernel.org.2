Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1408731AD78
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Feb 2021 18:55:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbhBMRxM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Feb 2021 12:53:12 -0500
Received: from linux.microsoft.com ([13.77.154.182]:47760 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbhBMRwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Feb 2021 12:52:49 -0500
Received: from sequoia (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id 5DE3220B6C40;
        Sat, 13 Feb 2021 09:52:08 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5DE3220B6C40
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1613238729;
        bh=rpYdOjpj1FhPRVoMVuBcX3/kmdKDHEmtzDLETHUirhk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f0x9yRh1W4Z03Eavj5Wvr2Rz9XmndNKoeVjCcJOMKOOLl/qHAe8p9YiEySEkp6R4B
         bEyLMGpqhIaQoHRq3KvJd0H6oTHjkWYVOHMU5AhCku2e+2PEsemmPE3ugrw4QREGMQ
         8jOrWE1lDvRvb0ApTGZd1zbpimF91L+3sUnaGAy8=
Date:   Sat, 13 Feb 2021 11:51:51 -0600
From:   Tyler Hicks <tyhicks@linux.microsoft.com>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     jmorris@namei.org, catalin.marinas@arm.com, will@kernel.org,
        akpm@linux-foundation.org, anshuman.khandual@arm.com,
        rppt@kernel.org, logang@deltatee.com, ardb@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: mm: correct the start of physical address in
 linear map
Message-ID: <20210213175151.GA4646@sequoia>
References: <20210213012316.1525419-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210213012316.1525419-1-pasha.tatashin@soleen.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-02-12 20:23:16, Pavel Tatashin wrote:
> Memory hotplug may fail on systems with CONFIG_RANDOMIZE_BASE because the
> linear map range is not checked correctly.
> 
> The start physical address that linear map covers can be actually at the
> end of the range because of randmomization. Check that and if so reduce it
> to 0.
> 
> This can be verified on QEMU with setting kaslr-seed to ~0ul:
> 
> memstart_offset_seed = 0xffff
> START: __pa(_PAGE_OFFSET(vabits_actual)) = ffff9000c0000000
> END:   __pa(PAGE_END - 1) =  1000bfffffff
> 
> Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
> Fixes: 58284a901b42 ("arm64/mm: Validate hotplug range before creating linear mapping")

Tested-by: Tyler Hicks <tyhicks@linux.microsoft.com>

This fixes a memory hot plugging bug that I was seeing on 5.10, with the
introduction of 58284a901b42.

One comment below...

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
> +	if (start_linear_pa > end_linear_pa)
> +		start_linear_pa = 0;

We're ignoring the portion from the linear mapping's start PA to the
point of wraparound. Could the start and end of the hot plugged memory
fall within this range and, as a result, the hot plug operation be
incorrectly blocked?

Tyler

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
> -- 
> 2.25.1
> 
