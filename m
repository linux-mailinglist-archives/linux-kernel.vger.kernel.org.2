Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0E1C3EC856
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Aug 2021 11:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236957AbhHOJ1V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Aug 2021 05:27:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:33330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231194AbhHOJ1U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Aug 2021 05:27:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D6DDF6103A;
        Sun, 15 Aug 2021 09:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629019610;
        bh=trUOhcObmX84g8zVOeV0ixAL+vgOcmd4ivtys7gco1s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R1/r42SDz5CKltxjesnI9RS2eUH1qqsAtkx86DEdIbS9bfj1OD3ZvNXv9FQb9u3dn
         VaXYQMqY0fDPad+uHr4YCKwE/5e9Rf7+keC1SlSSmF/+g8rfph/tJi9Aj9AjhD7zml
         42xRUl+An9WqFwOhL0rUfyChSCid8cJIDLCV0tr7PZcP0l0mZmFwgEW8p+ICxWPsrQ
         IvE4BqaMsfegoCHNISFqeyYvAe6cV45Lxypb0Hj/161UKMhvl9WbZAVjCHkAlKO/Tf
         6E0tUN+pnzv9jI0jrLQ9/Zkj1fwMoeo1SRTAw6PogAcY6WYxUn0UXECpihvhMKk3h2
         dk12dh2sVhMVQ==
Date:   Sun, 15 Aug 2021 12:26:43 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Vineet Gupta <vgupta@kernel.org>
Cc:     linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH v2 00/19] ARC mm updates: support 3/4 levels and
 asm-generic/pgalloc
Message-ID: <YRjd01Tr3IuEE7wj@kernel.org>
References: <20210812233753.104217-1-vgupta@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210812233753.104217-1-vgupta@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 12, 2021 at 04:37:34PM -0700, Vineet Gupta wrote:
> Hi,
> 
> Big pile of ARC mm changes to prepare for 3 or 4 levels of paging (from
> current 2) needed for new hardware page walked MMUv6 (in aRCv3 ISA based
> cores).
> 
> Most of these changes are incremental cleanups to make way for 14/18 and
> 15/18 which actually imeplement the new levels (in existing ARCv2 port)
> and worth a critical eye.
> 
> CC'ing some of you guys dealing with page tables for a while :-)
> to spot any obvious gotchas.

There are a couple of small nits here and there, but overall

Acked-by: Mike Rapoport <rppt@linux.ibm.com>

> Thx,
> -Vineet
> 
> Changes since v1 [1]
>  - Switched ARC to asm-generic/pgalloc.h  (so struct page based pgtable_t)      [Mike Rapoport]
>  - Dropped {pud,pmd}_alloc_one/{pud,pmd}_free provided by asm-generic/pgalloc.h [Mike Rapoport]
>  - Negative diffstat now due to above
>  - Added BUILD_BUG_ON() to arch/arc/mm/init.c for sanity of table sizes
>  - Consolidated 2 patches related to ARC_USE_SCRATCH_REG			   [Mike Rapoport]
>  - Reworked how mmu is re-enabled in entry code                                 [Jose Abreu]
> 
> [1] http://lists.infradead.org/pipermail/linux-snps-arc/2021-August/005326.html
> 
> Vineet Gupta (19):
>   ARC: mm: use SCRATCH_DATA0 register for caching pgdir in ARCv2 only
>   ARC: mm: remove tlb paranoid code
>   ARC: mm: move mmu/cache externs out to setup.h
>   ARC: mm: Fixes to allow STRICT_MM_TYPECHECKS
>   ARC: mm: Enable STRICT_MM_TYPECHECKS
>   ARC: ioremap: use more commonly used PAGE_KERNEL based uncached flag
>   ARC: mm: pmd_populate* to use the canonical set_pmd (and drop pmd_set)
>   ARC: mm: switch pgtable_t back to struct page *
>   ARC: mm: switch to asm-generic/pgalloc.h
>   ARC: mm: non-functional code cleanup ahead of 3 levels
>   ARC: mm: move MMU specific bits out of ASID allocator
>   ARC: mm: move MMU specific bits out of entry code ...
>   ARC: mm: disintegrate mmu.h (arcv2 bits out)
>   ARC: mm: disintegrate pgtable.h into levels and flags
>   ARC: mm: hack to allow 2 level build with 4 level code
>   ARC: mm: support 3 levels of page tables
>   ARC: mm: support 4 levels of page tables
>   ARC: mm: vmalloc sync from kernel to user table to update PMD ...
>   ARC: mm: introduce _PAGE_TABLE to explicitly link pgd,pud,pmd entries
> 
>  arch/arc/Kconfig                          |   7 +-
>  arch/arc/include/asm/cache.h              |   4 -
>  arch/arc/include/asm/entry-compact.h      |   8 -
>  arch/arc/include/asm/mmu-arcv2.h          | 103 +++++++
>  arch/arc/include/asm/mmu.h                |  73 +----
>  arch/arc/include/asm/mmu_context.h        |  28 +-
>  arch/arc/include/asm/page.h               |  74 +++--
>  arch/arc/include/asm/pgalloc.h            |  81 ++----
>  arch/arc/include/asm/pgtable-bits-arcv2.h | 151 +++++++++++
>  arch/arc/include/asm/pgtable-levels.h     | 179 ++++++++++++
>  arch/arc/include/asm/pgtable.h            | 315 +---------------------
>  arch/arc/include/asm/processor.h          |   2 +-
>  arch/arc/include/asm/setup.h              |  12 +-
>  arch/arc/kernel/entry-arcv2.S             |   1 +
>  arch/arc/kernel/entry.S                   |   7 +-
>  arch/arc/mm/fault.c                       |  20 +-
>  arch/arc/mm/init.c                        |   5 +
>  arch/arc/mm/ioremap.c                     |   3 +-
>  arch/arc/mm/tlb.c                         |  68 +----
>  arch/arc/mm/tlbex.S                       |  78 ++----
>  20 files changed, 591 insertions(+), 628 deletions(-)
>  create mode 100644 arch/arc/include/asm/mmu-arcv2.h
>  create mode 100644 arch/arc/include/asm/pgtable-bits-arcv2.h
>  create mode 100644 arch/arc/include/asm/pgtable-levels.h
> 
> -- 
> 2.25.1
> 

-- 
Sincerely yours,
Mike.
