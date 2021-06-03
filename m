Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6D75399CCC
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 10:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbhFCInW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 04:43:22 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:28333 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229620AbhFCInV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 04:43:21 -0400
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4FwfWh2xqMzBC5j;
        Thu,  3 Jun 2021 10:41:36 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 2aIBgItm49pb; Thu,  3 Jun 2021 10:41:36 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4FwfWh223WzBC5Z;
        Thu,  3 Jun 2021 10:41:36 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 3BC018B848;
        Thu,  3 Jun 2021 10:41:36 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id ScWqzpR0GDFX; Thu,  3 Jun 2021 10:41:36 +0200 (CEST)
Received: from po15610vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id DD36D8B767;
        Thu,  3 Jun 2021 10:41:35 +0200 (CEST)
Received: by po15610vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id ADBBA64BD2; Thu,  3 Jun 2021 08:41:35 +0000 (UTC)
Message-Id: <cover.1622708530.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v2 00/12] powerpc: Optimise KUAP on book3s/32
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Thu,  3 Jun 2021 08:41:35 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is a rework of KUAP on book3s/32.

On book3s32, KUAP is heavier than on other platform because it can't
be opened globaly at once, it must be done for each 256Mb segment.

Instead of opening access to all necessary segments via a heavy logic,
only open access to the segment matching the start of the range.

99.999% of the time, the range doesn't cross segment limit so
it is not worth checking and handling that corner case at the
first place. If that happens, take a fault and do the additional
segments opening in the fault handler. See patch 9 for details.

This series also adds the capability to disable KUAP and KUEP at boot
time via the "nosmap" and "nosmep" kernel parameters as PPC64 does.

Last 2 patches are cleanup of generic KUAP code once book3s/32 has
been simplified.

Changes in v2:
- Incorporated the conversion to C of switch_mmu_context()
- Converted initial KUAP/KUEP setup to C
- Added capability to disable KUAP and KUEP at boottime
- Enable KUAP and KUEP by default 

Christophe Leroy (12):
  powerpc/32s: Move setup_{kuep/kuap}() into {kuep/kuap}.c
  powerpc/32s: Refactor update of user segment registers
  powerpc/32s: move CTX_TO_VSID() into mmu-hash.h
  powerpc/32s: Convert switch_mmu_context() to C
  powerpc/32s: Simplify calculation of segment register content
  powerpc/32s: Initialise KUAP and KUEP in C
  powerpc/32s: Allow disabling KUEP at boot time
  powerpc/32s: Allow disabling KUAP at boot time
  powerpc/32s: Rework Kernel Userspace Access Protection
  powerpc/32s: Activate KUAP and KUEP by default
  powerpc/kuap: Remove KUAP_CURRENT_XXX
  powerpc/kuap: Remove to/from/size parameters of prevent_user_access()

 arch/powerpc/include/asm/book3s/32/kup.h      | 199 ++++++++++++------
 arch/powerpc/include/asm/book3s/32/mmu-hash.h |  41 ++++
 arch/powerpc/include/asm/book3s/64/kup.h      |   3 +-
 arch/powerpc/include/asm/kup.h                |  28 +--
 arch/powerpc/include/asm/nohash/32/kup-8xx.h  |   3 +-
 arch/powerpc/include/asm/processor.h          |  10 +-
 arch/powerpc/kernel/asm-offsets.c             |   5 -
 arch/powerpc/kernel/head_book3s_32.S          |  64 ------
 arch/powerpc/kernel/process.c                 |   3 +
 arch/powerpc/kernel/smp.c                     |   4 +
 arch/powerpc/kvm/book3s_32_mmu_host.c         |   3 -
 arch/powerpc/mm/book3s32/Makefile             |   1 +
 arch/powerpc/mm/book3s32/kuap.c               |  30 +++
 arch/powerpc/mm/book3s32/kuep.c               |  42 +---
 arch/powerpc/mm/book3s32/mmu.c                |  20 --
 arch/powerpc/mm/book3s32/mmu_context.c        |  48 +++--
 arch/powerpc/platforms/Kconfig.cputype        |   4 +-
 17 files changed, 276 insertions(+), 232 deletions(-)
 create mode 100644 arch/powerpc/mm/book3s32/kuap.c

-- 
2.25.0

