Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F5CF352A35
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 13:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234999AbhDBL1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 07:27:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:36262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229599AbhDBL1C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 07:27:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 32EB4610CF;
        Fri,  2 Apr 2021 11:27:00 +0000 (UTC)
Date:   Fri, 2 Apr 2021 12:26:57 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Zack Rusin <zackr@vmware.com>
Cc:     linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64/mm: Fix mapping_dirty_helpers with arm64
Message-ID: <20210402112657.GB29774@arm.com>
References: <20210331182344.47987-1-zackr@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210331182344.47987-1-zackr@vmware.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 31, 2021 at 02:23:44PM -0400, Zack Rusin wrote:
> The pagetable walk callbacks in mm/mapping_dirty_helpers.c depend
> on a set of helpers from which pud_dirty(pud) was missing. I'm
> assuming mapping_dirty_helpers weren't used on ARM64 before
> because the missing pud_dirty is causing a compilation error.
> 
> The drivers/gpu/drm/vmwgfx code uses mapping_dirty_helpers and
> has been ported to ARM64 but it depends on this code getting in
> first in order to compile/work.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Zack Rusin <zackr@vmware.com>
> ---
>  arch/arm64/include/asm/pgtable.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index 47027796c2f9..ecd80f87a996 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -451,6 +451,7 @@ static inline pmd_t pmd_mkdevmap(pmd_t pmd)
>  #define pfn_pmd(pfn,prot)	__pmd(__phys_to_pmd_val((phys_addr_t)(pfn) << PAGE_SHIFT) | pgprot_val(prot))
>  #define mk_pmd(page,prot)	pfn_pmd(page_to_pfn(page),prot)
>  
> +#define pud_dirty(pud)		pte_dirty(pud_pte(pud))
>  #define pud_young(pud)		pte_young(pud_pte(pud))
>  #define pud_mkyoung(pud)	pte_pud(pte_mkyoung(pud_pte(pud)))
>  #define pud_write(pud)		pte_write(pud_pte(pud))

I think pud_dirty() should only be defined if
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD which is not the case on
arm64. Well, the pud_young/mkyoung/write should probably also be removed
until we have pud pages on arm64.

The wp_clean_pud_entry() function bails out early since
pud_trans_unstable() returns 0 on arm64. So we either bracket this
function by some #ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD or we
make some generic definitions for pud_* accessors when we don't have
this config.

-- 
Catalin
