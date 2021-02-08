Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C67BD313905
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 17:14:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233237AbhBHQO1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 11:14:27 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:42304 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232072AbhBHPLG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 10:11:06 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4DZ8bB2BKTz9vBnB;
        Mon,  8 Feb 2021 16:10:14 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id lr6rAJO9bx12; Mon,  8 Feb 2021 16:10:14 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4DZ8bB1NFPz9vBn7;
        Mon,  8 Feb 2021 16:10:14 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 979238B7B3;
        Mon,  8 Feb 2021 16:10:19 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 9b4hOr69BAZV; Mon,  8 Feb 2021 16:10:19 +0100 (CET)
Received: from po16121vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.230.103])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 6E4358B7B2;
        Mon,  8 Feb 2021 16:10:19 +0100 (CET)
Received: by po16121vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 4551A6733E; Mon,  8 Feb 2021 15:10:19 +0000 (UTC)
Message-Id: <cover.1612796617.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v5 00/22] powerpc/32: Implement C syscall entry/exit
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com,
        msuchanek@suse.de
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Mon,  8 Feb 2021 15:10:19 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series implements C syscall entry/exit for PPC32. It reuses
the work already done for PPC64.

This series is based on today's merge-test (b6f72fc05389e3fc694bf5a5fa1bbd33f61879e0)

In terms on performance we have the following number of cycles on an
8xx running null_syscall benchmark:
- mainline: 296 cycles
- after patch 4: 283 cycles
- after patch 16: 304 cycles
- after patch 17: 348 cycles
- at the end of the series: 320 cycles

So in summary, we have a degradation of performance of 8% on null_syscall.

I think it is not a big degradation, it is worth it.

v4 was the first mature version.

v5:
- Comments from Nick
- Converted booke DBCR0 handling in C
- Removed convertion of KUAP restore in C (will be done as part of interrupt entry/exit porting to C)
- Added a few more changes in preparatory patches to prepare for interrupt entry/exit in C which will follow

Christophe Leroy (22):
  powerpc/32s: Add missing call to kuep_lock on syscall entry
  powerpc/32: Always enable data translation on syscall entry
  powerpc/32: On syscall entry, enable instruction translation at the
    same time as data
  powerpc/32: Reorder instructions to avoid using CTR in syscall entry
  powerpc/irq: Add helper to set regs->softe
  powerpc/irq: Rework helpers that manipulate MSR[EE/RI]
  powerpc/irq: Add stub irq_soft_mask_return() for PPC32
  powerpc/syscall: Rename syscall_64.c into interrupt.c
  powerpc/syscall: Make interrupt.c buildable on PPC32
  powerpc/syscall: Use is_compat_task()
  powerpc/syscall: Save r3 in regs->orig_r3
  powerpc/syscall: Change condition to check MSR_RI
  powerpc/32: Always save non volatile GPRs at syscall entry
  powerpc/syscall: implement system call entry/exit logic in C for PPC32
  powerpc/32: Remove verification of MSR_PR on syscall in the ASM entry
  powerpc/syscall: Avoid stack frame in likely part of
    system_call_exception()
  powerpc/syscall: Do not check unsupported scv vector on PPC32
  powerpc/syscall: Remove FULL_REGS verification in
    system_call_exception
  powerpc/syscall: Optimise checks in beginning of
    system_call_exception()
  powerpc/syscall: Avoid storing 'current' in another pointer
  powerpc/32: Remove the counter in global_dbcr0
  powerpc/32: Handle bookE debugging in C in syscall entry/exit

 arch/powerpc/include/asm/hw_irq.h             |  91 +++--
 arch/powerpc/include/asm/ptrace.h             |   5 +
 arch/powerpc/include/asm/reg.h                |   1 +
 arch/powerpc/include/asm/reg_booke.h          |   3 +
 arch/powerpc/kernel/Makefile                  |   4 +-
 arch/powerpc/kernel/entry_32.S                | 321 ++----------------
 arch/powerpc/kernel/entry_64.S                |   2 -
 arch/powerpc/kernel/head_32.h                 |  96 +-----
 arch/powerpc/kernel/head_booke.h              |  51 +--
 .../kernel/{syscall_64.c => interrupt.c}      | 120 +++++--
 arch/powerpc/kernel/syscalls/syscall.tbl      |  20 +-
 11 files changed, 218 insertions(+), 496 deletions(-)
 rename arch/powerpc/kernel/{syscall_64.c => interrupt.c} (80%)

-- 
2.25.0

