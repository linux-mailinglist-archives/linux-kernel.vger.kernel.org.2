Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C95445E02C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 19:02:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238856AbhKYSEy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 13:04:54 -0500
Received: from pegase2.c-s.fr ([93.17.235.10]:50819 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238512AbhKYSCw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 13:02:52 -0500
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4J0QTr2C9Zz9sSc;
        Thu, 25 Nov 2021 18:53:36 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id OCU5f0EQOYcY; Thu, 25 Nov 2021 18:53:36 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4J0QTm6tl9z9sSs;
        Thu, 25 Nov 2021 18:53:32 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id DB0FB8B78D;
        Thu, 25 Nov 2021 18:53:32 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id m_M4jOlQWhbp; Thu, 25 Nov 2021 18:53:32 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.203.227])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 205898B77E;
        Thu, 25 Nov 2021 18:53:32 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 1APHrJc2385511
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Thu, 25 Nov 2021 18:53:19 +0100
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 1APHrEbD385509;
        Thu, 25 Nov 2021 18:53:14 +0100
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, alex@ghiti.fr
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-mm@kvack.org
Subject: [PATCH v2 rebased 0/9] Convert powerpc to default topdown mmap layout
Date:   Thu, 25 Nov 2021 18:52:49 +0100
Message-Id: <cover.1637862579.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1637862776; l=2870; s=20211009; h=from:subject:message-id; bh=7bwl2JTsVET3ON+eXly75sHul/r8R8DKYECszZMJh2w=; b=s0Ryj9w3bsj0m2oYIutnWRtp67buMgF4l4oIB4I4OYmBi7PlZgDsMXO+TC4fu3p11O0aOs6JMzmP z2vKN9kyD+8HlKx0Kkw6XVzgmEPxe4TM0GyswQBOdNlA4k1/ggJT
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Same as v2 but rebased on top of Nic's v4 series "powerpc: Make hash MMU code build configurable"

This series converts powerpc to default topdown mmap layout.

powerpc provides its own arch_get_unmapped_area() only when
slices are needed, which is only for book3s/64. First part of
the series moves slices into book3s/64 specific directories
and cleans up other subarchitectures.

Then a small modification is done to core mm to allow
powerpc to still provide its own arch_randomize_brk()

Last part converts to default topdown mmap layout.

Changes in v2:
- Moved patch 4 before patch 2
- Make generic arch_randomize_brk() __weak
- Added patch 9

Christophe Leroy (9):
  powerpc/mm: Make slice specific to book3s/64
  powerpc/mm: Move vma_mmu_pagesize() and hugetlb_get_unmapped_area() to
    slice.c
  powerpc/mm: Remove CONFIG_PPC_MM_SLICES
  powerpc/mm: Remove asm/slice.h
  powerpc/mm: Call radix__arch_get_unmapped_area() from
    arch_get_unmapped_area()
  mm: Allow arch specific arch_randomize_brk() with
    CONFIG_ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT
  powerpc/mm: Convert to default topdown mmap layout
  powerpc/mm: Properly randomise mmap with slices
  powerpc: Simplify and move arch_randomize_brk()

 arch/powerpc/Kconfig                          |   2 +-
 arch/powerpc/include/asm/book3s/64/hash.h     |   7 +-
 arch/powerpc/include/asm/book3s/64/hugetlb.h  |   4 -
 arch/powerpc/include/asm/book3s/64/mmu-hash.h |   1 +
 arch/powerpc/include/asm/book3s/64/slice.h    |  18 ++
 arch/powerpc/include/asm/hugetlb.h            |   2 +-
 arch/powerpc/include/asm/paca.h               |   7 -
 arch/powerpc/include/asm/page.h               |   1 -
 arch/powerpc/include/asm/processor.h          |   2 -
 arch/powerpc/include/asm/slice.h              |  46 ----
 arch/powerpc/kernel/paca.c                    |   5 -
 arch/powerpc/kernel/process.c                 |  41 ----
 arch/powerpc/mm/Makefile                      |   3 +-
 arch/powerpc/mm/book3s64/Makefile             |   2 +-
 arch/powerpc/mm/book3s64/hash_utils.c         |  33 +--
 arch/powerpc/mm/book3s64/radix_hugetlbpage.c  |  55 -----
 arch/powerpc/mm/{ => book3s64}/slice.c        | 200 ++++++++++++++-
 arch/powerpc/mm/hugetlbpage.c                 |  28 ---
 arch/powerpc/mm/mmap.c                        | 228 ------------------
 arch/powerpc/mm/nohash/mmu_context.c          |   9 -
 arch/powerpc/mm/nohash/tlb.c                  |   4 -
 arch/powerpc/platforms/Kconfig.cputype        |   4 -
 include/linux/sizes.h                         |   2 +
 mm/util.c                                     |   2 +-
 24 files changed, 237 insertions(+), 469 deletions(-)
 delete mode 100644 arch/powerpc/include/asm/slice.h
 rename arch/powerpc/mm/{ => book3s64}/slice.c (80%)
 delete mode 100644 arch/powerpc/mm/mmap.c

-- 
2.33.1

