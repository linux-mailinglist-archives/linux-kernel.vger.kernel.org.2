Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 162C3331F16
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 07:20:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbhCIGTd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 01:19:33 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:57500 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229480AbhCIGTd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 01:19:33 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4DvlRQ4ptCz9v0dM;
        Tue,  9 Mar 2021 07:19:30 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id pjmTOPqa6zt6; Tue,  9 Mar 2021 07:19:30 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4DvlRQ40nmz9v0dJ;
        Tue,  9 Mar 2021 07:19:30 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 816318B773;
        Tue,  9 Mar 2021 07:19:31 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id hxiPNV4Vfjbe; Tue,  9 Mar 2021 07:19:31 +0100 (CET)
Received: from po16121vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 43E098B7CE;
        Tue,  9 Mar 2021 07:19:31 +0100 (CET)
Received: by po16121vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id ED32167551; Tue,  9 Mar 2021 06:19:30 +0000 (UTC)
Message-Id: <a7aa198a88bcd33c6e35e99f70f86c7b7f2f9440.1615270757.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH] powerpc/vdso32: Add missing _restgpr_31_x to fix build
 failure
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        segher@kernel.crashing.org
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue,  9 Mar 2021 06:19:30 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With some defconfig including CONFIG_CC_OPTIMIZE_FOR_SIZE,
(for instance mvme5100_defconfig and ps3_defconfig), gcc 5
generates a call to _restgpr_31_x.

Until recently it went unnoticed, but
commit 42ed6d56ade2 ("powerpc/vdso: Block R_PPC_REL24 relocations")
made it rise to the surface.

Provide that function (copied from lib/crtsavres.S) in
gettimeofday.S

Fixes: ab037dd87a2f ("powerpc/vdso: Switch VDSO to generic C implementation.")
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
I don't know if there is a way to tell GCC not to emit that call, because at the end we get more instructions than needed.
---
 arch/powerpc/kernel/vdso32/gettimeofday.S | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/powerpc/kernel/vdso32/gettimeofday.S b/arch/powerpc/kernel/vdso32/gettimeofday.S
index a6e29f880e0e..d21d08140a5e 100644
--- a/arch/powerpc/kernel/vdso32/gettimeofday.S
+++ b/arch/powerpc/kernel/vdso32/gettimeofday.S
@@ -65,3 +65,14 @@ V_FUNCTION_END(__kernel_clock_getres)
 V_FUNCTION_BEGIN(__kernel_time)
 	cvdso_call_time __c_kernel_time
 V_FUNCTION_END(__kernel_time)
+
+/* Routines for restoring integer registers, called by the compiler.  */
+/* Called with r11 pointing to the stack header word of the caller of the */
+/* function, just beyond the end of the integer restore area.  */
+_GLOBAL(_restgpr_31_x)
+_GLOBAL(_rest32gpr_31_x)
+	lwz	r0,4(r11)
+	lwz	r31,-4(r11)
+	mtlr	r0
+	mr	r1,r11
+	blr
-- 
2.25.0

