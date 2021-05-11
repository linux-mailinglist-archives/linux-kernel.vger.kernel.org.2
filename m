Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7EAF37B2B9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 01:40:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbhEKXlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 19:41:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:57936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230075AbhEKXlK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 19:41:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CEB36616ED;
        Tue, 11 May 2021 23:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1620776402;
        bh=StGQ4zZ+sG3aVDQn1MpkpljgXREKqD6fxuaBEDSUudw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hLUpIpjSxwdX1nAVP+N0LVLY1lMcui+/l5k4s7PPY993iDcrCDJiORv58ridgFjWj
         wF7Xs+ficCdWvf9n3xE8QH0AX1CndZ8jg99pk6I8kkslLGbrhvNIDIvE8Ao0cNHD9I
         umVQBDkgO0C86yyC8U/o7/4epynrz7QOojArhONg=
Date:   Tue, 11 May 2021 16:40:01 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v4 4/4] arm64: drop pfn_valid_within() and simplify
 pfn_valid()
Message-Id: <20210511164001.7e905659fdbb8a5e190d303a@linux-foundation.org>
In-Reply-To: <20210511100550.28178-5-rppt@kernel.org>
References: <20210511100550.28178-1-rppt@kernel.org>
        <20210511100550.28178-5-rppt@kernel.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 May 2021 13:05:50 +0300 Mike Rapoport <rppt@kernel.org> wrote:

> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> The arm64's version of pfn_valid() differs from the generic because of two
> reasons:
> 
> * Parts of the memory map are freed during boot. This makes it necessary to
>   verify that there is actual physical memory that corresponds to a pfn
>   which is done by querying memblock.
> 
> * There are NOMAP memory regions. These regions are not mapped in the
>   linear map and until the previous commit the struct pages representing
>   these areas had default values.
> 
> As the consequence of absence of the special treatment of NOMAP regions in
> the memory map it was necessary to use memblock_is_map_memory() in
> pfn_valid() and to have pfn_valid_within() aliased to pfn_valid() so that
> generic mm functionality would not treat a NOMAP page as a normal page.
> 
> Since the NOMAP regions are now marked as PageReserved(), pfn walkers and
> the rest of core mm will treat them as unusable memory and thus
> pfn_valid_within() is no longer required at all and can be disabled by
> removing CONFIG_HOLES_IN_ZONE on arm64.
> 
> pfn_valid() can be slightly simplified by replacing
> memblock_is_map_memory() with memblock_is_memory().
> 
> ...
>
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -1052,9 +1052,6 @@ config NEED_PER_CPU_EMBED_FIRST_CHUNK
>  	def_bool y
>  	depends on NUMA
>  
> -config HOLES_IN_ZONE
> -	def_bool y
> -
>  source "kernel/Kconfig.hz"
>  
>  config ARCH_SPARSEMEM_ENABLE

https://lkml.kernel.org/r/20210417075946.181402-1-wangkefeng.wang@huawei.com
already did this, so I simply dropped that hunk?  And I don't think the
changelog needs updating for this?


> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 798f74f501d5..fb07218da2c0 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -251,7 +251,7 @@ int pfn_valid(unsigned long pfn)
>  	if (!early_section(ms))
>  		return pfn_section_valid(ms, pfn);
>  
> -	return memblock_is_map_memory(addr);
> +	return memblock_is_memory(addr);
>  }
>  EXPORT_SYMBOL(pfn_valid);

