Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80CFB323763
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 07:36:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232203AbhBXGfN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 01:35:13 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:57662 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230165AbhBXGfL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 01:35:11 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4DlmNZ11TJz9typF;
        Wed, 24 Feb 2021 07:34:22 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id UrfR2TZ5sEw8; Wed, 24 Feb 2021 07:34:22 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4DlmNY6lfZz9tyhP;
        Wed, 24 Feb 2021 07:34:21 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E205B8B833;
        Wed, 24 Feb 2021 07:34:22 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id ljQKO2k2kZk9; Wed, 24 Feb 2021 07:34:22 +0100 (CET)
Received: from localhost.localdomain (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A85EB8B766;
        Wed, 24 Feb 2021 07:34:22 +0100 (CET)
Received: by localhost.localdomain (Postfix, from userid 0)
        id 70B6E673C1; Wed, 24 Feb 2021 06:34:22 +0000 (UTC)
Message-Id: <53f3a1f719441761000c41154602bf097d4350b5.1614148356.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH] powerpc/syscall: Force inlining of
 __prep_irq_for_enabled_exit()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Wed, 24 Feb 2021 06:34:22 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As reported by kernel test robot, a randconfig with high amount of
debuging options can lead to build failure for undefined reference
to replay_soft_interrupts() on ppc32.

This is due to gcc not seeing that __prep_irq_for_enabled_exit()
always returns true on ppc32 because it doesn't inline it for
some reason.

Force inlining of __prep_irq_for_enabled_exit() to fix the build.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Fixes: 344bb20b159d ("powerpc/syscall: Make interrupt.c buildable on PPC32")
---
 arch/powerpc/kernel/interrupt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/interrupt.c b/arch/powerpc/kernel/interrupt.c
index 398cd86b6ada..2ef3c4051bb9 100644
--- a/arch/powerpc/kernel/interrupt.c
+++ b/arch/powerpc/kernel/interrupt.c
@@ -149,7 +149,7 @@ notrace long system_call_exception(long r3, long r4, long r5,
  * enabled when the interrupt handler returns (indicating a process-context /
  * synchronous interrupt) then irqs_enabled should be true.
  */
-static notrace inline bool __prep_irq_for_enabled_exit(bool clear_ri)
+static notrace __always_inline bool __prep_irq_for_enabled_exit(bool clear_ri)
 {
 	/* This must be done with RI=1 because tracing may touch vmaps */
 	trace_hardirqs_on();
-- 
2.25.0

