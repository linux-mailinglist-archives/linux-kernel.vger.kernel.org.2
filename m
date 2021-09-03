Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E19CF3FFEE3
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 13:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349228AbhICLUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 07:20:04 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:51003 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349177AbhICLTt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 07:19:49 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4H1FfT5B4fz9sTt;
        Fri,  3 Sep 2021 13:18:41 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id FuMy-xG9P-QH; Fri,  3 Sep 2021 13:18:41 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4H1FfS4GTvz9sTN;
        Fri,  3 Sep 2021 13:18:40 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 7DBF08B8E3;
        Fri,  3 Sep 2021 13:18:40 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id i5Sf6cF5lbMz; Fri,  3 Sep 2021 13:18:40 +0200 (CEST)
Received: from po18078vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 4F9AC8B764;
        Fri,  3 Sep 2021 13:18:40 +0200 (CEST)
Received: by po18078vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 205DB63D74; Fri,  3 Sep 2021 11:18:40 +0000 (UTC)
Message-Id: <7dd5ead4bbca749e2da089ff6fe2b1878d6bf40e.1630667612.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1630667612.git.christophe.leroy@csgroup.eu>
References: <cover.1630667612.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [RFC PATCH v1 05/11] powerpc/machdep: Move sys_ctrler_t definition
 into pmac.h
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Fri,  3 Sep 2021 11:18:40 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sys_ctrler_t definitions are tied to pmac. Move it in pmac.h

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/machdep.h     | 15 ---------------
 arch/powerpc/platforms/powermac/pmac.h | 12 ++++++++++++
 2 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/include/asm/machdep.h b/arch/powerpc/include/asm/machdep.h
index a50aed6170c3..9f31281095ab 100644
--- a/arch/powerpc/include/asm/machdep.h
+++ b/arch/powerpc/include/asm/machdep.h
@@ -230,21 +230,6 @@ extern struct machdep_calls *machine_id;
 		machine_id == &mach_##name; \
 	})
 
-#ifdef CONFIG_PPC_PMAC
-/*
- * Power macintoshes have either a CUDA, PMU or SMU controlling
- * system reset, power, NVRAM, RTC.
- */
-typedef enum sys_ctrler_kind {
-	SYS_CTRLER_UNKNOWN = 0,
-	SYS_CTRLER_CUDA = 1,
-	SYS_CTRLER_PMU = 2,
-	SYS_CTRLER_SMU = 3,
-} sys_ctrler_t;
-extern sys_ctrler_t sys_ctrler;
-
-#endif /* CONFIG_PPC_PMAC */
-
 static inline void log_error(char *buf, unsigned int err_type, int fatal)
 {
 	if (ppc_md.log_error)
diff --git a/arch/powerpc/platforms/powermac/pmac.h b/arch/powerpc/platforms/powermac/pmac.h
index 0d715db434dc..34496e078e0f 100644
--- a/arch/powerpc/platforms/powermac/pmac.h
+++ b/arch/powerpc/platforms/powermac/pmac.h
@@ -5,6 +5,18 @@
 #include <linux/pci.h>
 #include <linux/irq.h>
 
+/*
+ * Power macintoshes have either a CUDA, PMU or SMU controlling
+ * system reset, power, NVRAM, RTC.
+ */
+typedef enum sys_ctrler_kind {
+	SYS_CTRLER_UNKNOWN = 0,
+	SYS_CTRLER_CUDA = 1,
+	SYS_CTRLER_PMU = 2,
+	SYS_CTRLER_SMU = 3,
+} sys_ctrler_t;
+extern sys_ctrler_t sys_ctrler;
+
 /*
  * Declaration for the various functions exported by the
  * pmac_* files. Mostly for use by pmac_setup
-- 
2.25.0

