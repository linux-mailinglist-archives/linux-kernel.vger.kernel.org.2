Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD53A3891AC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 16:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354452AbhESOpa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 10:45:30 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:58839 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1354511AbhESOo5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 10:44:57 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4FlbG812B3z9sWS;
        Wed, 19 May 2021 16:43:28 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id qorOCowr6Gbv; Wed, 19 May 2021 16:43:28 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4FlbG775dWz9sWQ;
        Wed, 19 May 2021 16:43:27 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id D33C18B7F5;
        Wed, 19 May 2021 16:43:27 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id t4ptb7JajGFM; Wed, 19 May 2021 16:43:27 +0200 (CEST)
Received: from po15610vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 9F7358B7E0;
        Wed, 19 May 2021 16:43:27 +0200 (CEST)
Received: by po15610vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 6B49E64C3A; Wed, 19 May 2021 14:43:27 +0000 (UTC)
Message-Id: <cover.1621435024.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v1 00/12] Cleanup use of 'struct ppc_inst'
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        naveen.n.rao@linux.vnet.ibm.com, jniethe5@gmail.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Wed, 19 May 2021 14:43:27 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is a cleanup of the use of 'struct ppc_inst'.

A confusion is made between internal representation of powerpc
instructions with 'struct ppc_inst' and in-memory code which is
and will always be an array of 'unsigned int'.

This series cleans it up.

First patch is fixing detection of missing '__user' flag by sparse
when using get_user_instr().

Last part of the series does some source code cleanup in
optprobes, it is put at the ends of this series because of
clashes with the 'struct ppc_inst' cleanups.

Christophe Leroy (12):
  powerpc/inst: Fix sparse detection on get_user_instr()
  powerpc/inst: Reduce casts in get_user_instr()
  powerpc/inst: Improve readability of get_user_instr() and friends
  powerpc/inst: Avoid pointer dereferencing in ppc_inst_equal()
  powerpc: Do not dereference code as 'struct ppc_inst' (uprobe,
    code-patching, feature-fixups)
  powerpc/lib/code-patching: Make instr_is_branch_to_addr() static
  powerpc/lib/code-patching: Don't use struct 'ppc_inst' for runnable
    code in tests.
  powerpc: Don't use 'struct ppc_inst' to reference instruction location
  powerpc/inst: Refactor PPC32 and PPC64 versions
  powerpc/optprobes: Minimise casts
  powerpc/optprobes: Compact code source a bit.
  powerpc/optprobes: use PPC_RAW_ macros

 arch/powerpc/include/asm/code-patching.h  |  23 ++-
 arch/powerpc/include/asm/inst.h           |  95 +++++--------
 arch/powerpc/include/asm/ppc-opcode.h     |  11 +-
 arch/powerpc/include/asm/uprobes.h        |   4 +-
 arch/powerpc/kernel/crash_dump.c          |   4 +-
 arch/powerpc/kernel/epapr_paravirt.c      |   4 +-
 arch/powerpc/kernel/jump_label.c          |   2 +-
 arch/powerpc/kernel/kgdb.c                |   6 +-
 arch/powerpc/kernel/kprobes.c             |  17 ++-
 arch/powerpc/kernel/mce_power.c           |   2 +-
 arch/powerpc/kernel/optprobes.c           | 124 +++++-----------
 arch/powerpc/kernel/setup_32.c            |   2 +-
 arch/powerpc/kernel/trace/ftrace.c        |  26 ++--
 arch/powerpc/kernel/uprobes.c             |   6 +-
 arch/powerpc/lib/code-patching.c          | 165 ++++++++++++----------
 arch/powerpc/lib/feature-fixups.c         |  98 ++++++-------
 arch/powerpc/perf/core-book3s.c           |   4 +-
 arch/powerpc/platforms/86xx/mpc86xx_smp.c |   2 +-
 arch/powerpc/platforms/powermac/smp.c     |   4 +-
 arch/powerpc/xmon/xmon.c                  |  10 +-
 20 files changed, 274 insertions(+), 335 deletions(-)

-- 
2.25.0

