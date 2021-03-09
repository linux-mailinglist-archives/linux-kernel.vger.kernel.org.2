Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0E6E3324FA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 13:11:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231923AbhCIMLL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 07:11:11 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:4945 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231324AbhCIMKK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 07:10:10 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4DvvD02yMlz9tyjK;
        Tue,  9 Mar 2021 13:10:08 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id AgaypGjUG2IV; Tue,  9 Mar 2021 13:10:08 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4DvvD025K6z9tyjG;
        Tue,  9 Mar 2021 13:10:08 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A29E18B801;
        Tue,  9 Mar 2021 13:10:09 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 8FAdydQXcIL6; Tue,  9 Mar 2021 13:10:09 +0100 (CET)
Received: from po16121vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 579878B800;
        Tue,  9 Mar 2021 13:10:09 +0100 (CET)
Received: by po16121vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 352B167555; Tue,  9 Mar 2021 12:10:09 +0000 (UTC)
Message-Id: <5cfe7db13867ab74c94e9a8fa4af0c724b9fe993.1615291474.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1615291471.git.christophe.leroy@csgroup.eu>
References: <cover.1615291471.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v2 42/43] powerpc/8xx: Create C version of kuap
 save/restore/check helpers
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue,  9 Mar 2021 12:10:09 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation of porting PPC32 to C syscall entry/exit,
create C version of kuap_save_and_lock() and kuap_user_restore() and
kuap_kernel_restore() and kuap_check() and kuap_get_and_check() on 8xx.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/nohash/32/kup-8xx.h | 31 ++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/powerpc/include/asm/nohash/32/kup-8xx.h b/arch/powerpc/include/asm/nohash/32/kup-8xx.h
index 17a4a616436f..c74f5704bc47 100644
--- a/arch/powerpc/include/asm/nohash/32/kup-8xx.h
+++ b/arch/powerpc/include/asm/nohash/32/kup-8xx.h
@@ -34,6 +34,37 @@
 
 #include <asm/reg.h>
 
+static inline void kuap_save_and_lock(struct pt_regs *regs)
+{
+	regs->kuap = mfspr(SPRN_MD_AP);
+	mtspr(SPRN_MD_AP, MD_APG_KUAP);
+}
+
+static inline void kuap_user_restore(struct pt_regs *regs)
+{
+}
+
+static inline void kuap_kernel_restore(struct pt_regs *regs, unsigned long kuap)
+{
+	mtspr(SPRN_MD_AP, regs->kuap);
+}
+
+static inline unsigned long kuap_get_and_check(void)
+{
+	unsigned long kuap = mfspr(SPRN_MD_AP);
+
+	if (IS_ENABLED(CONFIG_PPC_KUAP_DEBUG))
+		WARN_ON_ONCE(kuap >> 16 != MD_APG_KUAP >> 16);
+
+	return kuap;
+}
+
+static inline void kuap_check(void)
+{
+	if (IS_ENABLED(CONFIG_PPC_KUAP_DEBUG))
+		kuap_get_and_check();
+}
+
 static inline void allow_user_access(void __user *to, const void __user *from,
 				     unsigned long size, unsigned long dir)
 {
-- 
2.25.0

