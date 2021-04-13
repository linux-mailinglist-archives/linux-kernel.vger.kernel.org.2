Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EA6C35E43F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 18:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346873AbhDMQkf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 12:40:35 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:52375 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346857AbhDMQkc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 12:40:32 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4FKWYP6gssz9vBmM;
        Tue, 13 Apr 2021 18:40:09 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id hjERo5K_HDNb; Tue, 13 Apr 2021 18:40:09 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4FKWYP5nYqz9vBmL;
        Tue, 13 Apr 2021 18:40:09 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 6C4E98B7AA;
        Tue, 13 Apr 2021 18:40:11 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id LG92FNJ7a5cc; Tue, 13 Apr 2021 18:40:11 +0200 (CEST)
Received: from po16121vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 1F9B18B75F;
        Tue, 13 Apr 2021 18:40:11 +0200 (CEST)
Received: by po16121vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id D7F6A67A15; Tue, 13 Apr 2021 16:40:10 +0000 (UTC)
Message-Id: <dca10b8ff2414ac580dc2726a608fc982ca0b022.1618331980.git.christophe.leroy@csgroup.eu>
In-Reply-To: <857ceb23b6a614aea2522e770b067593d5f9e906.1618331980.git.christophe.leroy@csgroup.eu>
References: <857ceb23b6a614aea2522e770b067593d5f9e906.1618331980.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v2 4/4] powerpc: Move copy_from_kernel_nofault_inst()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, jniethe5@gmail.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue, 13 Apr 2021 16:40:10 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When probe_kernel_read_inst() was created, there was no good place to
put it, so a file called lib/inst.c was dedicated for it.

Since then, probe_kernel_read_inst() has been renamed
copy_from_kernel_nofault_inst(). And mm/maccess.h didn't exist at that
time. Today, mm/maccess.h is related to copy_from_kernel_nofault().

Move copy_from_kernel_nofault_inst() into mm/maccess.c

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
v2: Remove inst.o from Makefile
---
 arch/powerpc/lib/Makefile |  2 +-
 arch/powerpc/lib/inst.c   | 26 --------------------------
 arch/powerpc/mm/maccess.c | 21 +++++++++++++++++++++
 3 files changed, 22 insertions(+), 27 deletions(-)
 delete mode 100644 arch/powerpc/lib/inst.c

diff --git a/arch/powerpc/lib/Makefile b/arch/powerpc/lib/Makefile
index d4efc182662a..f2c690ee75d1 100644
--- a/arch/powerpc/lib/Makefile
+++ b/arch/powerpc/lib/Makefile
@@ -16,7 +16,7 @@ CFLAGS_code-patching.o += -DDISABLE_BRANCH_PROFILING
 CFLAGS_feature-fixups.o += -DDISABLE_BRANCH_PROFILING
 endif
 
-obj-y += alloc.o code-patching.o feature-fixups.o pmem.o inst.o test_code-patching.o
+obj-y += alloc.o code-patching.o feature-fixups.o pmem.o test_code-patching.o
 
 ifndef CONFIG_KASAN
 obj-y	+=	string.o memcmp_$(BITS).o
diff --git a/arch/powerpc/lib/inst.c b/arch/powerpc/lib/inst.c
deleted file mode 100644
index ec7f6bae8b3c..000000000000
--- a/arch/powerpc/lib/inst.c
+++ /dev/null
@@ -1,26 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- *  Copyright 2020, IBM Corporation.
- */
-
-#include <linux/uaccess.h>
-#include <asm/disassemble.h>
-#include <asm/inst.h>
-#include <asm/ppc-opcode.h>
-
-int copy_from_kernel_nofault_inst(struct ppc_inst *inst, struct ppc_inst *src)
-{
-	unsigned int val, suffix;
-	int err;
-
-	err = copy_from_kernel_nofault(&val, src, sizeof(val));
-	if (err)
-		return err;
-	if (IS_ENABLED(CONFIG_PPC64) && get_op(val) == OP_PREFIX) {
-		err = copy_from_kernel_nofault(&suffix, (void *)src + 4, 4);
-		*inst = ppc_inst_prefix(val, suffix);
-	} else {
-		*inst = ppc_inst(val);
-	}
-	return err;
-}
diff --git a/arch/powerpc/mm/maccess.c b/arch/powerpc/mm/maccess.c
index fa9a7a718fc6..e75e74c52a8a 100644
--- a/arch/powerpc/mm/maccess.c
+++ b/arch/powerpc/mm/maccess.c
@@ -3,7 +3,28 @@
 #include <linux/uaccess.h>
 #include <linux/kernel.h>
 
+#include <asm/disassemble.h>
+#include <asm/inst.h>
+#include <asm/ppc-opcode.h>
+
 bool copy_from_kernel_nofault_allowed(const void *unsafe_src, size_t size)
 {
 	return is_kernel_addr((unsigned long)unsafe_src);
 }
+
+int copy_from_kernel_nofault_inst(struct ppc_inst *inst, struct ppc_inst *src)
+{
+	unsigned int val, suffix;
+	int err;
+
+	err = copy_from_kernel_nofault(&val, src, sizeof(val));
+	if (err)
+		return err;
+	if (IS_ENABLED(CONFIG_PPC64) && get_op(val) == OP_PREFIX) {
+		err = copy_from_kernel_nofault(&suffix, (void *)src + 4, 4);
+		*inst = ppc_inst_prefix(val, suffix);
+	} else {
+		*inst = ppc_inst(val);
+	}
+	return err;
+}
-- 
2.25.0

