Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C365D426DC8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 17:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243476AbhJHPox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 11:44:53 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:50989 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243416AbhJHPok (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 11:44:40 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4HQsqF0xZYz9sSw;
        Fri,  8 Oct 2021 17:41:13 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id eGuufPcYlGU2; Fri,  8 Oct 2021 17:41:13 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4HQspy5z3Jz9sST;
        Fri,  8 Oct 2021 17:40:58 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B6F108B763;
        Fri,  8 Oct 2021 17:40:58 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id hbVUUyJtnRLP; Fri,  8 Oct 2021 17:40:58 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.202.75])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 0B18D8B79F;
        Fri,  8 Oct 2021 17:40:56 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.16.1/8.16.1) with ESMTPS id 198Femrh1129639
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Fri, 8 Oct 2021 17:40:48 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.16.1/8.16.1/Submit) id 198FekTG1129638;
        Fri, 8 Oct 2021 17:40:46 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 00/16] powerpc: Add KUAP support for BOOKE and 40x
Date:   Fri,  8 Oct 2021 17:40:28 +0200
Message-Id: <cover.1633707305.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On booke/40x we don't have segments like book3s/32.
On booke/40x we don't have access protection groups like 8xx.

Use the PID register to provide user access protection.
Kernel address space can be accessed with any PID.
User address space has to be accessed with the PID of the user.
User PID is always not null.

Everytime the kernel is entered, set PID register to 0 and
restore PID register when returning to user.

Everytime kernel needs to access user data, PID is restored
for the access.

In TLB miss handlers, check the PID and bail out to data storage
exception when PID is 0 and accessed address is in user space.

Note that also forbids execution of user text by kernel except
when user access is unlocked. But this shouldn't be a problem
as the kernel is not supposed to ever run user text.

This series has:
- Two first patches have already been submitted and are not directly related to KUAP but would conflict otherwise
- Following patches aim at refactoring the KUAP interface to reduce redundant platform specific code.
- Then comes patches 9 and 10 that add generic support frame for booke type processors
- Followed by the assembly modification for each of the 4 booke family types 
- Last patch removes CONFIG_PPC_HAVE_KUAP now that all powerpc platforms have KUAP.

Changes in v2:
- Rebased on top of today's merge (trivial conflict with d93f9e23744b ("powerpc/32s: Fix kuap_kernel_restore()"))
- Fix missing check in bad_kuap_fault() which led to KUAP fault on platforms where KUAP was disabled (CI g5_defconfig)
- New patch to fix PPC_KUAP_DEBUG dependency

Christophe Leroy (16):
  powerpc/32s: Do kuep_lock() and kuep_unlock() in assembly
  powerpc/32s: Save content of sr0 to avoid 'mfsr'
  powerpc/kuap: Add a generic intermediate layer
  powerpc/kuap: Check KUAP activation in generic functions
  powerpc/kuap: Remove __kuap_assert_locked()
  powerpc/kuap: Add kuap_lock()
  powerpc/nohash: Move setup_kuap out of 8xx.c
  powerpc/config: Add CONFIG_BOOKE_OR_40x
  powerpc/kuap: Prepare for supporting KUAP on BOOK3E/64
  powerpc/kuap: Make PPC_KUAP_DEBUG depend on PPC_KUAP only
  powerpc: Add KUAP support for BOOKE and 40x
  powerpc/kuap: Wire-up KUAP on 44x
  powerpc/kuap: Wire-up KUAP on 40x
  powerpc/kuap: Wire-up KUAP on 85xx in 32 bits mode.
  powerpc/kuap: Wire-up KUAP on book3e/64
  powerpc: Remove CONFIG_PPC_HAVE_KUAP

 arch/powerpc/include/asm/book3s/32/kup.h      | 103 ++++-----------
 arch/powerpc/include/asm/book3s/32/mmu-hash.h |  78 +++++++++++-
 arch/powerpc/include/asm/book3s/64/kup.h      |  56 ++++-----
 arch/powerpc/include/asm/hw_irq.h             |   8 +-
 arch/powerpc/include/asm/interrupt.h          |  13 +-
 arch/powerpc/include/asm/irq.h                |   2 +-
 arch/powerpc/include/asm/kup.h                | 117 +++++++++++++++---
 arch/powerpc/include/asm/nohash/32/kup-8xx.h  |  50 ++------
 arch/powerpc/include/asm/nohash/kup-booke.h   | 110 ++++++++++++++++
 arch/powerpc/include/asm/processor.h          |   4 +
 arch/powerpc/include/asm/ptrace.h             |   2 +-
 arch/powerpc/include/asm/reg.h                |   4 +-
 arch/powerpc/kernel/asm-offsets.c             |   2 +-
 arch/powerpc/kernel/entry_32.S                |  34 ++++-
 arch/powerpc/kernel/head_32.h                 |   6 +
 arch/powerpc/kernel/head_40x.S                |   8 ++
 arch/powerpc/kernel/head_44x.S                |  16 +++
 arch/powerpc/kernel/head_fsl_booke.S          |  12 ++
 arch/powerpc/kernel/interrupt.c               |   3 +-
 arch/powerpc/kernel/irq.c                     |   2 +-
 arch/powerpc/kernel/kgdb.c                    |   4 +-
 arch/powerpc/kernel/process.c                 |   9 +-
 arch/powerpc/kernel/setup.h                   |   2 +-
 arch/powerpc/kernel/setup_32.c                |   2 +-
 arch/powerpc/kernel/time.c                    |   2 +-
 arch/powerpc/mm/book3s32/kuap.c               |   5 +-
 arch/powerpc/mm/book3s32/kuep.c               |  21 +++-
 arch/powerpc/mm/book3s32/mmu_context.c        |  15 ++-
 arch/powerpc/mm/mmu_context.c                 |   9 ++
 arch/powerpc/mm/nohash/8xx.c                  |  21 ----
 arch/powerpc/mm/nohash/Makefile               |   2 +-
 arch/powerpc/mm/nohash/kup.c                  |  31 +++++
 arch/powerpc/mm/nohash/mmu_context.c          |   6 +-
 arch/powerpc/mm/nohash/tlb_low_64e.S          |  40 +++++-
 arch/powerpc/platforms/Kconfig.cputype        |  14 +--
 35 files changed, 575 insertions(+), 238 deletions(-)
 create mode 100644 arch/powerpc/include/asm/nohash/kup-booke.h
 create mode 100644 arch/powerpc/mm/nohash/kup.c

-- 
2.31.1

