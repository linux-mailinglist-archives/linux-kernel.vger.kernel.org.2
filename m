Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C36843159EA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 00:17:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234872AbhBIXN4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 18:13:56 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:10509 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233354AbhBITve (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 14:51:34 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4DZtHq1pzDz9v022;
        Tue,  9 Feb 2021 20:29:27 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id BSGrLhm21DSi; Tue,  9 Feb 2021 20:29:27 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4DZtHq0tBCz9v021;
        Tue,  9 Feb 2021 20:29:27 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 10A358B7EA;
        Tue,  9 Feb 2021 20:29:27 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id SfL1QxCWtiXO; Tue,  9 Feb 2021 20:29:27 +0100 (CET)
Received: from po16121vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id D386D8B764;
        Tue,  9 Feb 2021 20:29:26 +0100 (CET)
Received: by po16121vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 91BAC67382; Tue,  9 Feb 2021 19:29:26 +0000 (UTC)
Message-Id: <cover.1612898425.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v6 0/2] powerpc/32: Implement C syscall entry/exit (complement)
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com,
        msuchanek@suse.de
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue,  9 Feb 2021 19:29:26 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series implements C syscall entry/exit for PPC32. It reuses
the work already done for PPC64.

This series is based on today's next-test (f538b53fd47a) where main patchs from v5 are merged in.

The first patch is important for performance.

v6:
- Forced scv param to 0 on syscall_exit_prepare(), and added is_not_scv bool.
- Reworked the last patch to avoid code duplication.

Christophe Leroy (2):
  powerpc/syscall: Do not check unsupported scv vector on PPC32
  powerpc/32: Handle bookE debugging in C in syscall entry/exit

 arch/powerpc/include/asm/interrupt.h | 12 +++++++
 arch/powerpc/include/asm/ptrace.h    |  5 +++
 arch/powerpc/include/asm/reg_booke.h |  3 ++
 arch/powerpc/kernel/entry_32.S       |  7 ----
 arch/powerpc/kernel/head_32.h        | 15 ---------
 arch/powerpc/kernel/head_booke.h     | 19 -----------
 arch/powerpc/kernel/interrupt.c      | 50 ++++++++++++++++++----------
 7 files changed, 52 insertions(+), 59 deletions(-)

-- 
2.25.0

