Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 486893E8751
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 02:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235866AbhHKAnk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 20:43:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:38700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232410AbhHKAni (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 20:43:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E99A06056C;
        Wed, 11 Aug 2021 00:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628642596;
        bh=dhUncP/4+yqpzI3mayz8xRr13F3WjLadA+iK0UX3tsc=;
        h=From:To:Cc:Subject:Date:From;
        b=FcOe5AdnPi+ivIsFrXpVskA7CT3OaYgFY5uwIoLAnmXpOiqmJZJnHEH/dgzhzIiFA
         daQatxU1WOJoqbIL+k2/lxbO+HEt4fYjku5bG5xZZqQZ+JXaqsEVhyCDfEOQXiu6Lw
         vl3/QTj3whmwV/eTM64Bl7RuxmKYZ+OVENOqIHvCbDqJsc30kBjiwLfAzaaiV/wCKu
         34kQTz/ugSPNSV8ljWdTuXUx1gU83pfFnhE55F7dDYV0Nt62JXvnEReo3bEmJgm0sE
         4xrZoVBsn8BoefU+dLOQ77RqwcILcZ1W4JmyNvj5gI7r6J+KuPyXtn7gDaxTnW1aEt
         oTpe7tKHWmUrg==
From:   Vineet Gupta <vgupta@kernel.org>
To:     linux-snps-arc@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Mike Rapoport <rppt@kernel.org>,
        Vineet Gupta <vgupta@kernel.org>
Subject: [PATCH 00/18] ARC mm updates to support 3 or 4 levels of paging
Date:   Tue, 10 Aug 2021 17:42:40 -0700
Message-Id: <20210811004258.138075-1-vgupta@kernel.org>
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

Vineet Gupta (18):
  ARC: mm: simplify mmu scratch register assingment to mmu needs
  ARC: mm: remove tlb paranoid code
  ARC: mm: move mmu/cache externs out to setup.h
  ARC: mm: remove pgd_offset_fast
  ARC: mm: Fixes to allow STRICT_MM_TYPECHECKS
  ARC: mm: Enable STRICT_MM_TYPECHECKS
  ARC: ioremap: use more commonly used PAGE_KERNEL based uncached flag
  ARC: mm: pmd_populate* to use the canonical set_pmd (and drop pmd_set)
  ARC: mm: non-functional code cleanup ahead of 3 levels
  ARC: mm: move MMU specific bits out of ASID allocator
  ARC: mm: move MMU specific bits out of entry code
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
 arch/arc/include/asm/mmu-arcv2.h          |  94 +++++++
 arch/arc/include/asm/mmu.h                |  73 +----
 arch/arc/include/asm/mmu_context.h        |  29 +-
 arch/arc/include/asm/page.h               |  72 +++--
 arch/arc/include/asm/pgalloc.h            |  70 ++++-
 arch/arc/include/asm/pgtable-bits-arcv2.h | 151 +++++++++++
 arch/arc/include/asm/pgtable-levels.h     | 179 ++++++++++++
 arch/arc/include/asm/pgtable.h            | 315 +---------------------
 arch/arc/include/asm/processor.h          |   2 +-
 arch/arc/include/asm/setup.h              |  12 +-
 arch/arc/kernel/entry.S                   |   6 -
 arch/arc/mm/fault.c                       |  20 +-
 arch/arc/mm/ioremap.c                     |   3 +-
 arch/arc/mm/tlb.c                         |  71 ++---
 arch/arc/mm/tlbex.S                       |  80 ++----
 18 files changed, 617 insertions(+), 579 deletions(-)
 create mode 100644 arch/arc/include/asm/mmu-arcv2.h
 create mode 100644 arch/arc/include/asm/pgtable-bits-arcv2.h
 create mode 100644 arch/arc/include/asm/pgtable-levels.h

-- 
2.25.1

