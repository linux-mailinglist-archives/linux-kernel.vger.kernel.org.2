Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF2A458AB4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 09:49:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239023AbhKVIwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 03:52:37 -0500
Received: from pegase2.c-s.fr ([93.17.235.10]:49365 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238925AbhKVIwc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 03:52:32 -0500
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4HyLXk2FlWz9sSp;
        Mon, 22 Nov 2021 09:48:54 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id qoLcZdD2JWwe; Mon, 22 Nov 2021 09:48:54 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4HyLXc1KF0z9sSn;
        Mon, 22 Nov 2021 09:48:48 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 17A948B776;
        Mon, 22 Nov 2021 09:48:48 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id yLdfSD87LI3b; Mon, 22 Nov 2021 09:48:47 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [172.25.230.108])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id AFE978B77C;
        Mon, 22 Nov 2021 09:48:47 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 1AM8mcwQ631708
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Mon, 22 Nov 2021 09:48:38 +0100
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 1AM8mbml631700;
        Mon, 22 Nov 2021 09:48:37 +0100
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, alex@ghiti.fr
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-mm@kvack.org
Subject: [PATCH 0/8] Convert powerpc to default topdown mmap layout
Date:   Mon, 22 Nov 2021 09:48:20 +0100
Message-Id: <cover.1637570556.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1637570905; l=2539; s=20211009; h=from:subject:message-id; bh=BYMlT8t1rQmLJHB6M/rmi2Dhxo6sTBfS7n0H0F9IIs0=; b=sM1kxSuEvtE1c8++Tb4yJCAeefYfWUmMUwSUMkYK3TwR+ime9qoN4wEXWdeyeV2aJMfUeLAsATyu mHwFN+AMDa/KoznYAZXi6+EVieRUlxYmyJmsosWivRsw0FiMciUs
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series converts powerpc to default topdown mmap layout.

powerpc provides its own arch_get_unmapped_area() only when
slices are needed, which is only for book3s/64. First part of
the series moves slices into book3s/64 specific directories
and cleans up other subarchitectures.

Then a small modification is done to core mm to allow
powerpc to still provide its own arch_randomize_brk()

Last part converts to default topdown mmap layout.

Christophe Leroy (8):
  powerpc/mm: Make slice specific to book3s/64
  powerpc/mm: Remove CONFIG_PPC_MM_SLICES
  powerpc/mm: Remove asm/slice.h
  powerpc/mm: Move vma_mmu_pagesize() and hugetlb_get_unmapped_area() to
    slice.c
  powerpc/mm: Call radix__arch_get_unmapped_area() from
    arch_get_unmapped_area()
  mm: Allow arch specific arch_randomize_brk() with
    CONFIG_ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT
  powerpc/mm: Convert to default topdown mmap layout
  powerpc/mm: Properly randomise mmap with slices

 arch/Kconfig                                  |   1 -
 arch/powerpc/Kconfig                          |   1 +
 arch/powerpc/include/asm/book3s/64/hash.h     |   5 +-
 arch/powerpc/include/asm/book3s/64/mmu-hash.h |   1 +
 arch/powerpc/include/asm/book3s/64/slice.h    |  18 ++
 arch/powerpc/include/asm/hugetlb.h            |   2 +-
 arch/powerpc/include/asm/paca.h               |   5 -
 arch/powerpc/include/asm/page.h               |   1 -
 arch/powerpc/include/asm/processor.h          |   2 -
 arch/powerpc/include/asm/slice.h              |  46 ----
 arch/powerpc/kernel/paca.c                    |   5 -
 arch/powerpc/mm/Makefile                      |   3 +-
 arch/powerpc/mm/book3s64/Makefile             |   2 +-
 arch/powerpc/mm/book3s64/hash_utils.c         |  14 --
 arch/powerpc/mm/{ => book3s64}/slice.c        | 144 ++++++++++-
 arch/powerpc/mm/hugetlbpage.c                 |  28 ---
 arch/powerpc/mm/mmap.c                        | 228 ------------------
 arch/powerpc/mm/nohash/mmu_context.c          |   2 -
 arch/powerpc/mm/nohash/tlb.c                  |   4 -
 arch/powerpc/platforms/Kconfig.cputype        |   4 -
 fs/binfmt_elf.c                               |   3 +-
 include/linux/elf-randomize.h                 |   3 +-
 mm/util.c                                     |   2 +
 23 files changed, 165 insertions(+), 359 deletions(-)
 delete mode 100644 arch/powerpc/include/asm/slice.h
 rename arch/powerpc/mm/{ => book3s64}/slice.c (84%)
 delete mode 100644 arch/powerpc/mm/mmap.c

-- 
2.33.1

