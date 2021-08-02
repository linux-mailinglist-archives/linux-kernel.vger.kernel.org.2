Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1D683DD58B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 14:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233679AbhHBMUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 08:20:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:34934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233631AbhHBMUD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 08:20:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1B12660FC2;
        Mon,  2 Aug 2021 12:19:50 +0000 (UTC)
Date:   Mon, 2 Aug 2021 13:19:48 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Oleksandr Tyshchenko <olekstysh@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Will Deacon <will@kernel.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Joey Gouly <joey.gouly@arm.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Juergen Gross <jgross@suse.com>, Julien Grall <julien@xen.org>,
        Wei Chen <Wei.Chen@arm.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Mike Rapoport <rppt@kernel.org>
Subject: Re: [RFC PATCH 1/2] arm64: mm: Make virt_addr_valid to check for
 pfn_valid again
Message-ID: <20210802121947.GF18685@arm.com>
References: <1627490656-1267-1-git-send-email-olekstysh@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1627490656-1267-1-git-send-email-olekstysh@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding Mike and Anshuman,

On Wed, Jul 28, 2021 at 07:44:15PM +0300, Oleksandr Tyshchenko wrote:
> From: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
> 
> The problem is that Arm's implementation of virt_addr_valid()
> leads to memblock_is_map_memory() check, which will fail for
> ZONE_DEVICE based addresses. But, the pfn_valid() check in turn
> is able to cope with ZONE_DEVICE based memory.
> 
> You can find a good explanation of that problem at:
> https://lore.kernel.org/lkml/1614921898-4099-2-git-send-email-anshuman.khandual@arm.com
> 
> Signed-off-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
> ---
> I am not quite sure whether it is a "correct" place and
> the change itself, I just partially restored a behaviour before:
> https://lore.kernel.org/lkml/20210511100550.28178-4-rppt@kernel.org
> So, the target of this patch is to get a feedback how to resolve
> this properly if, of course, this really needs to be resolved
> (I might miss important bits here).
> 
> It is worth mentioning that patch doesn't fix the current code base
> (if I am not mistaken, no one calls virt_addr_valid() on Arm64 for
> ZONE_DEVICE based addresses at the moment, so it seems that nothing
> is broken), the fix is intended for the subsequent patch in this
> series that will try to enable Xen's "unpopulated-alloc" usage
> on Arm (it was enabled on x86 so far).
> Please see:
> [RFC PATCH 2/2] xen/unpopulated-alloc: Query hypervisor to provide
> unallocated space
> 
> The subsequent patch will enable the code where virt_addr_valid()
> is used in drivers/xen/unpopulated-alloc.c:fill_list() to check that
> a virtual address returned by memremap_pages() is valid.

I wonder what the point of calling virt_addr_valid() in fill_list() is?
If memremap_pages() succeeded, the pages were mapped at the returned
vaddr, there's no need for an additional virt_addr_valid() check.

> ---
>  arch/arm64/include/asm/memory.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
> index 824a365..1a35a44 100644
> --- a/arch/arm64/include/asm/memory.h
> +++ b/arch/arm64/include/asm/memory.h
> @@ -351,7 +351,7 @@ static inline void *phys_to_virt(phys_addr_t x)
>  
>  #define virt_addr_valid(addr)	({					\
>  	__typeof__(addr) __addr = __tag_reset(addr);			\
> -	__is_lm_address(__addr) && pfn_is_map_memory(virt_to_pfn(__addr));	\
> +	__is_lm_address(__addr) && pfn_valid(virt_to_pfn(__addr));	\
>  })

pfn_valid() only guarantees the presence of a struct page but not
necessarily that the virtual address is accessible (valid). So this
change would break the NOMAP ranges case.

-- 
Catalin
