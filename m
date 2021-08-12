Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 321E63EADA7
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 01:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237973AbhHLXiY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 19:38:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:48626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229703AbhHLXiX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 19:38:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F2F436103E;
        Thu, 12 Aug 2021 23:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628811477;
        bh=cjVChcfrvuXbPh5LIL6KQzVZ8QD79IVN7HLo5LoUmIQ=;
        h=From:To:Cc:Subject:Date:From;
        b=FDVpodf9ZzkWEE3mkU6g0FyvggmUWx5aTtCy28S8sNtDcQqYeQtz6YY6mD72MORYG
         MvAK+xPkEqL343KbpeOF1z+QV3r4XQgoIDmJF/elSbcbqYE36d0edUIbsQYGlJaY8O
         wd1gNUbJ5b4XrWGOr11MhN/SJy3H6MthI5n/a68rk+ctWTmPfO1jNRTJQjdLa1sAPi
         RY5tjU44RbYFk1Ss60IhzVSITiAslJd0GBzbJeWbvtsMXIMgk1Plis5hmrjl8eFO0F
         32pW60PwJfv/lVPQIDXjw8f+NjXmG3V19HJ2BKtJ23mTrGKBSsPaFVzeIfK/fXMBFR
         tQoAbPzU66q+w==
From:   Vineet Gupta <vgupta@kernel.org>
To:     linux-snps-arc@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Mike Rapoport <rppt@kernel.org>,
        Vineet Gupta <vgupta@kernel.org>
Subject: [PATCH v2 00/19] ARC mm updates: support 3/4 levels and asm-generic/pgalloc
Date:   Thu, 12 Aug 2021 16:37:34 -0700
Message-Id: <20210812233753.104217-1-vgupta@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Big pile of ARC mm changes to prepare for 3 or 4 levels of paging (from
current 2) needed for new hardware page walked MMUv6 (in aRCv3 ISA based
cores).

Most of these changes are incremental cleanups to make way for 14/18 and
15/18 which actually imeplement the new levels (in existing ARCv2 port)
and worth a critical eye.

CC'ing some of you guys dealing with page tables for a while :-)
to spot any obvious gotchas.

Thx,
-Vineet

Changes since v1 [1]
 - Switched ARC to asm-generic/pgalloc.h  (so struct page based pgtable_t)      [Mike Rapoport]
 - Dropped {pud,pmd}_alloc_one/{pud,pmd}_free provided by asm-generic/pgalloc.h [Mike Rapoport]
 - Negative diffstat now due to above
 - Added BUILD_BUG_ON() to arch/arc/mm/init.c for sanity of table sizes
 - Consolidated 2 patches related to ARC_USE_SCRATCH_REG			   [Mike Rapoport]
 - Reworked how mmu is re-enabled in entry code                                 [Jose Abreu]

[1] http://lists.infradead.org/pipermail/linux-snps-arc/2021-August/005326.html

Vineet Gupta (19):
  ARC: mm: use SCRATCH_DATA0 register for caching pgdir in ARCv2 only
  ARC: mm: remove tlb paranoid code
  ARC: mm: move mmu/cache externs out to setup.h
  ARC: mm: Fixes to allow STRICT_MM_TYPECHECKS
  ARC: mm: Enable STRICT_MM_TYPECHECKS
  ARC: ioremap: use more commonly used PAGE_KERNEL based uncached flag
  ARC: mm: pmd_populate* to use the canonical set_pmd (and drop pmd_set)
  ARC: mm: switch pgtable_t back to struct page *
  ARC: mm: switch to asm-generic/pgalloc.h
  ARC: mm: non-functional code cleanup ahead of 3 levels
  ARC: mm: move MMU specific bits out of ASID allocator
  ARC: mm: move MMU specific bits out of entry code ...
  ARC: mm: disintegrate mmu.h (arcv2 bits out)
  ARC: mm: disintegrate pgtable.h into levels and flags
  ARC: mm: hack to allow 2 level build with 4 level code
  ARC: mm: support 3 levels of page tables
  ARC: mm: support 4 levels of page tables
  ARC: mm: vmalloc sync from kernel to user table to update PMD ...
  ARC: mm: introduce _PAGE_TABLE to explicitly link pgd,pud,pmd entries

 arch/arc/Kconfig                          |   7 +-
 arch/arc/include/asm/cache.h              |   4 -
 arch/arc/include/asm/entry-compact.h      |   8 -
 arch/arc/include/asm/mmu-arcv2.h          | 103 +++++++
 arch/arc/include/asm/mmu.h                |  73 +----
 arch/arc/include/asm/mmu_context.h        |  28 +-
 arch/arc/include/asm/page.h               |  74 +++--
 arch/arc/include/asm/pgalloc.h            |  81 ++----
 arch/arc/include/asm/pgtable-bits-arcv2.h | 151 +++++++++++
 arch/arc/include/asm/pgtable-levels.h     | 179 ++++++++++++
 arch/arc/include/asm/pgtable.h            | 315 +---------------------
 arch/arc/include/asm/processor.h          |   2 +-
 arch/arc/include/asm/setup.h              |  12 +-
 arch/arc/kernel/entry-arcv2.S             |   1 +
 arch/arc/kernel/entry.S                   |   7 +-
 arch/arc/mm/fault.c                       |  20 +-
 arch/arc/mm/init.c                        |   5 +
 arch/arc/mm/ioremap.c                     |   3 +-
 arch/arc/mm/tlb.c                         |  68 +----
 arch/arc/mm/tlbex.S                       |  78 ++----
 20 files changed, 591 insertions(+), 628 deletions(-)
 create mode 100644 arch/arc/include/asm/mmu-arcv2.h
 create mode 100644 arch/arc/include/asm/pgtable-bits-arcv2.h
 create mode 100644 arch/arc/include/asm/pgtable-levels.h

-- 
2.25.1

