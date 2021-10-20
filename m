Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6F8434919
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 12:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbhJTKmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 06:42:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:50404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229900AbhJTKmR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 06:42:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 64BE7600CC;
        Wed, 20 Oct 2021 10:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634726402;
        bh=wUJFiw8gd3K+1cLBoH5P+5VaoqzxNT0ut8vHk+nwz1Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Oe02BnQ9C7QcW+/pLRPB5CzaI8MP8o6opLdm7r6BBnox9ncxadmFd8R9BW51I5r00
         k4gjbbduPuKXGGg+Pl9HiyLEAKI/QrMKUpx2vol73ls6S8Scp87UVaui+QwzRWdnLh
         JnbVDE0DtlQD08Wqj8PCZHB9MwJAN+zLaGZAH04Lw6KxbvmWJdhHodHRoMlmCjx9Us
         +Mi3R70YArhlvxlgmawCTeP7U5TAoiZiofyU0sNEi6/n/o3cxyzxFXgB2uHu+FFAh6
         +I9YJ2JFY9fjMDsMsjX22Kn8pt79kapeK14QG5rMraqXYuQWJ+wRsZe6HgimWs8aiD
         6vzvWIC+Eks8A==
Date:   Wed, 20 Oct 2021 13:39:55 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Qian Cai <quic_qiancai@quicinc.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] memblock: exclude NOMAP regions from kmemleak
Message-ID: <YW/x+xXQUqxaRU8o@kernel.org>
References: <20211013054756.12177-1-rppt@kernel.org>
 <c30ff0a2-d196-c50d-22f0-bd50696b1205@quicinc.com>
 <YW5bjV128Qk1foIv@kernel.org>
 <YW6t5tBe/IjSYWn3@arm.com>
 <089478ad-3755-b085-d9aa-c68e9792895c@quicinc.com>
 <YW7p3ARYbpxmeLCF@arm.com>
 <8da41896-dc11-8246-54cf-1174f617ac39@quicinc.com>
 <YW8PZ0Q5UeRH4W4R@kernel.org>
 <YW/Hb4sVWGOIxzUk@kernel.org>
 <YW/rsjxNj+m7aL/a@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YW/rsjxNj+m7aL/a@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 20, 2021 at 11:13:06AM +0100, Catalin Marinas wrote:
> On Wed, Oct 20, 2021 at 10:38:23AM +0300, Mike Rapoport wrote:
> > On Tue, Oct 19, 2021 at 09:33:11PM +0300, Mike Rapoport wrote:
> > > On Tue, Oct 19, 2021 at 01:59:22PM -0400, Qian Cai wrote:
> > > > [	0.000000][	T0] Booting Linux on physical CPU 0x0000000000 [0x503f0002]
> > > > [	0.000000][	T0] Linux version 5.15.0-rc6-next-20211019+ (root@admin5) (gcc (Ubuntu 9.3.0-17ubuntu1~20.04) 9.3.0, GNU ld (GNU Binutils for Ubuntu) 2.34) #104 SMP Tue Oct 19 17:36:17 UTC 2021
> > > > [	0.000000][	T0] earlycon: pl11 at MMIO32 0x0000000012600000 (options '')
> > > > [	0.000000][	T0] printk: bootconsole [pl11] enabled
> > > > [	0.000000][	T0] efi: Getting UEFI parameters from /chosen in DT:
> > > > [	0.000000][	T0] efi:   System Table     	: 0x0000009ff7de0018
> > > > [	0.000000][	T0] efi:   MemMap Address   	: 0x0000009fe6dae018
> > > > [	0.000000][	T0] efi:   MemMap Size      	: 0x0000000000000600
> > > > [	0.000000][	T0] efi:   MemMap Desc. Size	: 0x0000000000000030
> > > > [	0.000000][	T0] efi:   MemMap Desc. Version : 0x0000000000000001
> > > > [	0.000000][	T0] efi: EFI v2.70 by American Megatrends
> > > > [	0.000000][	T0] efi: ACPI 2.0=0x9ff5b40000 SMBIOS 3.0=0x9ff686fd98 ESRT=0x9ff1d18298 MEMRESERVE=0x9fe6dacd98  
> > > > [	0.000000][	T0] efi: Processing EFI memory map:
> > > > [	0.000000][	T0] efi:   0x000090000000-0x000091ffffff [Conventional|   |  |  |  |  |  |  |  |  |   |WB|WT|WC|UC]
> > > > [	0.000000][	T0] efi:   0x000092000000-0x0000928fffff [Runtime Data|RUN|  |  |  |  |  |  |  |  |   |WB|WT|WC|UC]
> > > > [	0.000000][	T0] ------------[ cut here ]------------
> > > > [	0.000000][	T0] kernel BUG at mm/kmemleak.c:1140!
> > > > [	0.000000][	T0] Internal error: Oops - BUG: 0 [#1] SMP
> > > > 
> > > > I did not quite figure out where this BUG() was triggered and I did not
> > > 
> > > This is from here:
> > > arch/arm64/include/asm/memory.h:
> > > 
> > > #define PHYS_OFFSET         ({ VM_BUG_ON(memstart_addr & 1); memstart_addr; })
> > > 
> > > kmemleak_free_part_phys() does __va() which uses PHYS_OFFSET and all this
> > > happens before memstart_addr is set.
> > > 
> > > I'll try to see how this can be untangled...
> >  
> > This late in the cycle I can only think of reverting kmemleak wavier from
> > memblock_mark_nomap() and putting it in
> > early_init_dt_alloc_reserved_memory_arch() being the only user setting
> > MEMBLOCK_NOMAP to an allocated chunk rather than marking NOMAP "unusable"
> > memory reported by firmware.
> 
> BTW, would something like this work:
> 
> diff --git a/mm/memblock.c b/mm/memblock.c
> index aa87ff5ae2a4..7e67378a8ddf 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -939,7 +939,7 @@ int __init_memblock memblock_mark_nomap(phys_addr_t base, phys_addr_t size)
>  {
>  	int ret = memblock_setclr_flag(base, size, 1, MEMBLOCK_NOMAP);
>  
> -	if (!ret)
> +	if (!ret && memblock_is_region_reserved(base, size))
>  		kmemleak_free_part_phys(base, size);

Apparently it would for the cases we have now.
But it will fail same way as now if somebody will call memblock_reserve() and then
memblock_mark_nomap() for the same chunk before arm64_memblock_init().

For instance, slight order change in efi-init::reserve_regions() will
trigger the same fault... :(

-- 
Sincerely yours,
Mike.
