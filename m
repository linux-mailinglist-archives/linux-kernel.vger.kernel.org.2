Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7441B323B05
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 12:08:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234938AbhBXLG2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 06:06:28 -0500
Received: from mail.skyhub.de ([5.9.137.197]:39656 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234969AbhBXLDV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 06:03:21 -0500
Received: from zn.tnic (p200300ec2f0d180081510bd8ee909965.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:1800:8151:bd8:ee90:9965])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id F36941EC059D;
        Wed, 24 Feb 2021 12:02:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1614164559;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OCcK41xZ76tSLXXQoOKEwr+sxON7KkcCv3qilwNknVE=;
        b=FdFrZZGAi0An7E11XgtWnjTdSFmKijn9bObQk69QK9TpkYZakkepjEYZWjfgwqH97oJiON
        hrj1TMVuXP1KSc1Furxo4fc1wwx8ul/AaPNLdkF+x2zM0YF7uyTg/MQCa+iB4bXsTiDnVk
        pp2rx83Keou8UCllz6fKSBUdacwSgQI=
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 04/21] x86/insn: Add an insn_decode() API
Date:   Wed, 24 Feb 2021 12:02:16 +0100
Message-Id: <20210224110233.19715-5-bp@alien8.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210224110233.19715-1-bp@alien8.de>
References: <20210224110233.19715-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Users of the instruction decoder should use this to decode instruction
bytes. For that, have insn*() helpers return an int value to denote
success/failure. When there's an error fetching the next insn byte and
the insn falls short, return -ENODATA to denote that.

While at it, make insn_get_opcode() more stricter as to whether what has
seen so far is a valid insn and if not.

Copy linux/kconfig.h for the tools-version of the decoder so that it can
use IS_ENABLED().

Also, cast the INSN_MODE_KERN dummy define value to (enum insn_mode)
for tools use of the decoder because perf tool builds with -Werror and
errors out with -Werror=sign-compare otherwise.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/include/asm/insn.h       |  24 ++-
 arch/x86/lib/insn.c               | 241 +++++++++++++++++++++++-------
 tools/arch/x86/include/asm/insn.h |  24 ++-
 tools/arch/x86/lib/insn.c         | 241 +++++++++++++++++++++++-------
 tools/include/linux/kconfig.h     |  73 +++++++++
 5 files changed, 479 insertions(+), 124 deletions(-)
 create mode 100644 tools/include/linux/kconfig.h

diff --git a/arch/x86/include/asm/insn.h b/arch/x86/include/asm/insn.h
index 17c130f1ba57..546436b3c215 100644
--- a/arch/x86/include/asm/insn.h
+++ b/arch/x86/include/asm/insn.h
@@ -87,13 +87,23 @@ struct insn {
 #define X86_VEX_M_MAX	0x1f			/* VEX3.M Maximum value */
 
 extern void insn_init(struct insn *insn, const void *kaddr, int buf_len, int x86_64);
-extern void insn_get_prefixes(struct insn *insn);
-extern void insn_get_opcode(struct insn *insn);
-extern void insn_get_modrm(struct insn *insn);
-extern void insn_get_sib(struct insn *insn);
-extern void insn_get_displacement(struct insn *insn);
-extern void insn_get_immediate(struct insn *insn);
-extern void insn_get_length(struct insn *insn);
+extern int insn_get_prefixes(struct insn *insn);
+extern int insn_get_opcode(struct insn *insn);
+extern int insn_get_modrm(struct insn *insn);
+extern int insn_get_sib(struct insn *insn);
+extern int insn_get_displacement(struct insn *insn);
+extern int insn_get_immediate(struct insn *insn);
+extern int insn_get_length(struct insn *insn);
+
+enum insn_mode {
+	INSN_MODE_32,
+	INSN_MODE_64,
+	/* Mode is determined by the current kernel build. */
+	INSN_MODE_KERN,
+	INSN_NUM_MODES,
+};
+
+extern int insn_decode(struct insn *insn, const void *kaddr, int buf_len, enum insn_mode m);
 
 /* Attribute will be determined after getting ModRM (for opcode groups) */
 static inline void insn_get_attribute(struct insn *insn)
diff --git a/arch/x86/lib/insn.c b/arch/x86/lib/insn.c
index 745c704f7c78..07ee5b14ae38 100644
--- a/arch/x86/lib/insn.c
+++ b/arch/x86/lib/insn.c
@@ -13,6 +13,9 @@
 #include <asm/inat.h> /*__ignore_sync_check__ */
 #include <asm/insn.h> /* __ignore_sync_check__ */
 
+#include <linux/errno.h>
+#include <linux/kconfig.h>
+
 #include <asm/emulate_prefix.h> /* __ignore_sync_check__ */
 
 /* Verify next sizeof(t) bytes can be on the same instruction */
@@ -80,12 +83,15 @@ static int __insn_get_emulate_prefix(struct insn *insn,
 	return 1;
 
 err_out:
-	return 0;
+	return -ENODATA;
 }
 
 static void insn_get_emulate_prefix(struct insn *insn)
 {
-	if (__insn_get_emulate_prefix(insn, xen_prefix, sizeof(xen_prefix)))
+	int ret;
+
+	ret = __insn_get_emulate_prefix(insn, xen_prefix, sizeof(xen_prefix));
+	if (ret > 0)
 		return;
 
 	__insn_get_emulate_prefix(insn, kvm_prefix, sizeof(kvm_prefix));
@@ -98,8 +104,12 @@ static void insn_get_emulate_prefix(struct insn *insn)
  * Populates the @insn->prefixes bitmap, and updates @insn->next_byte
  * to point to the (first) opcode.  No effect if @insn->prefixes.got
  * is already set.
+ *
+ * * Returns:
+ * 0:  on success
+ * < 0: on error
  */
-void insn_get_prefixes(struct insn *insn)
+int insn_get_prefixes(struct insn *insn)
 {
 	struct insn_field *prefixes = &insn->prefixes;
 	insn_attr_t attr;
@@ -107,7 +117,7 @@ void insn_get_prefixes(struct insn *insn)
 	int i, nb;
 
 	if (prefixes->got)
-		return;
+		return 0;
 
 	insn_get_emulate_prefix(insn);
 
@@ -218,8 +228,10 @@ void insn_get_prefixes(struct insn *insn)
 
 	prefixes->got = 1;
 
+	return 0;
+
 err_out:
-	return;
+	return -ENODATA;
 }
 
 /**
@@ -231,16 +243,25 @@ void insn_get_prefixes(struct insn *insn)
  * If necessary, first collects any preceding (prefix) bytes.
  * Sets @insn->opcode.value = opcode1.  No effect if @insn->opcode.got
  * is already 1.
+ *
+ * Returns:
+ * 0:  on success
+ * < 0: on error
  */
-void insn_get_opcode(struct insn *insn)
+int insn_get_opcode(struct insn *insn)
 {
 	struct insn_field *opcode = &insn->opcode;
+	int pfx_id, ret;
 	insn_byte_t op;
-	int pfx_id;
+
 	if (opcode->got)
-		return;
-	if (!insn->prefixes.got)
-		insn_get_prefixes(insn);
+		return 0;
+
+	if (!insn->prefixes.got) {
+		ret = insn_get_prefixes(insn);
+		if (ret)
+			return ret;
+	}
 
 	/* Get first opcode */
 	op = get_next(insn_byte_t, insn);
@@ -255,9 +276,13 @@ void insn_get_opcode(struct insn *insn)
 		insn->attr = inat_get_avx_attribute(op, m, p);
 		if ((inat_must_evex(insn->attr) && !insn_is_evex(insn)) ||
 		    (!inat_accept_vex(insn->attr) &&
-		     !inat_is_group(insn->attr)))
-			insn->attr = 0;	/* This instruction is bad */
-		goto end;	/* VEX has only 1 byte for opcode */
+		     !inat_is_group(insn->attr))) {
+			/* This instruction is bad */
+			insn->attr = 0;
+			return 1;
+		}
+		/* VEX has only 1 byte for opcode */
+		goto end;
 	}
 
 	insn->attr = inat_get_opcode_attribute(op);
@@ -268,13 +293,18 @@ void insn_get_opcode(struct insn *insn)
 		pfx_id = insn_last_prefix_id(insn);
 		insn->attr = inat_get_escape_attribute(op, pfx_id, insn->attr);
 	}
-	if (inat_must_vex(insn->attr))
-		insn->attr = 0;	/* This instruction is bad */
+
+	if (inat_must_vex(insn->attr)) {
+		/* This instruction is bad */
+		insn->attr = 0;
+		return 1;
+	}
 end:
 	opcode->got = 1;
+	return 0;
 
 err_out:
-	return;
+	return -ENODATA;
 }
 
 /**
@@ -284,15 +314,25 @@ void insn_get_opcode(struct insn *insn)
  * Populates @insn->modrm and updates @insn->next_byte to point past the
  * ModRM byte, if any.  If necessary, first collects the preceding bytes
  * (prefixes and opcode(s)).  No effect if @insn->modrm.got is already 1.
+ *
+ * Returns:
+ * 0:  on success
+ * < 0: on error
  */
-void insn_get_modrm(struct insn *insn)
+int insn_get_modrm(struct insn *insn)
 {
 	struct insn_field *modrm = &insn->modrm;
 	insn_byte_t pfx_id, mod;
+	int ret;
+
 	if (modrm->got)
-		return;
-	if (!insn->opcode.got)
-		insn_get_opcode(insn);
+		return 0;
+
+	if (!insn->opcode.got) {
+		ret = insn_get_opcode(insn);
+		if (ret)
+			return ret;
+	}
 
 	if (inat_has_modrm(insn->attr)) {
 		mod = get_next(insn_byte_t, insn);
@@ -302,17 +342,22 @@ void insn_get_modrm(struct insn *insn)
 			pfx_id = insn_last_prefix_id(insn);
 			insn->attr = inat_get_group_attribute(mod, pfx_id,
 							      insn->attr);
-			if (insn_is_avx(insn) && !inat_accept_vex(insn->attr))
-				insn->attr = 0;	/* This is bad */
+			if (insn_is_avx(insn) && !inat_accept_vex(insn->attr)) {
+				/* Bad insn */
+				insn->attr = 0;
+				return 1;
+			}
 		}
 	}
 
 	if (insn->x86_64 && inat_is_force64(insn->attr))
 		insn->opnd_bytes = 8;
+
 	modrm->got = 1;
+	return 0;
 
 err_out:
-	return;
+	return -ENODATA;
 }
 
 
@@ -326,11 +371,16 @@ void insn_get_modrm(struct insn *insn)
 int insn_rip_relative(struct insn *insn)
 {
 	struct insn_field *modrm = &insn->modrm;
+	int ret;
 
 	if (!insn->x86_64)
 		return 0;
-	if (!modrm->got)
-		insn_get_modrm(insn);
+
+	if (!modrm->got) {
+		ret = insn_get_modrm(insn);
+		if (ret)
+			return ret;
+	}
 	/*
 	 * For rip-relative instructions, the mod field (top 2 bits)
 	 * is zero and the r/m field (bottom 3 bits) is 0x5.
@@ -344,15 +394,25 @@ int insn_rip_relative(struct insn *insn)
  *
  * If necessary, first collects the instruction up to and including the
  * ModRM byte.
+ *
+ * Returns:
+ * 0: if decoding succeeded
+ * < 0: otherwise.
  */
-void insn_get_sib(struct insn *insn)
+int insn_get_sib(struct insn *insn)
 {
 	insn_byte_t modrm;
+	int ret;
 
 	if (insn->sib.got)
-		return;
-	if (!insn->modrm.got)
-		insn_get_modrm(insn);
+		return 0;
+
+	if (!insn->modrm.got) {
+		ret = insn_get_modrm(insn);
+		if (ret)
+			return ret;
+	}
+
 	if (insn->modrm.nbytes) {
 		modrm = (insn_byte_t)insn->modrm.value;
 		if (insn->addr_bytes != 2 &&
@@ -363,8 +423,10 @@ void insn_get_sib(struct insn *insn)
 	}
 	insn->sib.got = 1;
 
+	return 0;
+
 err_out:
-	return;
+	return -ENODATA;
 }
 
 
@@ -375,15 +437,25 @@ void insn_get_sib(struct insn *insn)
  * If necessary, first collects the instruction up to and including the
  * SIB byte.
  * Displacement value is sign-expanded.
+ *
+ * * Returns:
+ * 0: if decoding succeeded
+ * < 0: otherwise.
  */
-void insn_get_displacement(struct insn *insn)
+int insn_get_displacement(struct insn *insn)
 {
 	insn_byte_t mod, rm, base;
+	int ret;
 
 	if (insn->displacement.got)
-		return;
-	if (!insn->sib.got)
-		insn_get_sib(insn);
+		return 0;
+
+	if (!insn->sib.got) {
+		ret = insn_get_sib(insn);
+		if (ret)
+			return ret;
+	}
+
 	if (insn->modrm.nbytes) {
 		/*
 		 * Interpreting the modrm byte:
@@ -426,12 +498,13 @@ void insn_get_displacement(struct insn *insn)
 	}
 out:
 	insn->displacement.got = 1;
+	return 0;
 
 err_out:
-	return;
+	return -ENODATA;
 }
 
-/* Decode moffset16/32/64. Return 0 if failed */
+/* Decode moffset16/32/64. Return a negative value if failed. */
 static int __get_moffset(struct insn *insn)
 {
 	switch (insn->addr_bytes) {
@@ -457,10 +530,10 @@ static int __get_moffset(struct insn *insn)
 	return 1;
 
 err_out:
-	return 0;
+	return -ENODATA;
 }
 
-/* Decode imm v32(Iz). Return 0 if failed */
+/* Decode imm v32(Iz). Return a negative value if failed. */
 static int __get_immv32(struct insn *insn)
 {
 	switch (insn->opnd_bytes) {
@@ -480,10 +553,10 @@ static int __get_immv32(struct insn *insn)
 	return 1;
 
 err_out:
-	return 0;
+	return -ENODATA;
 }
 
-/* Decode imm v64(Iv/Ov), Return 0 if failed */
+/* Decode imm v64(Iv/Ov). Return a negative value if failed. */
 static int __get_immv(struct insn *insn)
 {
 	switch (insn->opnd_bytes) {
@@ -507,11 +580,12 @@ static int __get_immv(struct insn *insn)
 	insn->immediate1.got = insn->immediate2.got = 1;
 
 	return 1;
+
 err_out:
-	return 0;
+	return -ENODATA;
 }
 
-/* Decode ptr16:16/32(Ap) */
+/* Decode ptr16:16/32(Ap). Return a negative value if failed. */
 static int __get_immptr(struct insn *insn)
 {
 	switch (insn->opnd_bytes) {
@@ -534,25 +608,36 @@ static int __get_immptr(struct insn *insn)
 	insn->immediate1.got = insn->immediate2.got = 1;
 
 	return 1;
+
 err_out:
-	return 0;
+	return -ENODATA;
 }
 
 /**
- * insn_get_immediate() - Get the immediates of instruction
+ * insn_get_immediate() - Get the immediate in an instruction
  * @insn:	&struct insn containing instruction
  *
  * If necessary, first collects the instruction up to and including the
  * displacement bytes.
  * Basically, most of immediates are sign-expanded. Unsigned-value can be
- * get by bit masking with ((1 << (nbytes * 8)) - 1)
+ * computed by bit masking with ((1 << (nbytes * 8)) - 1)
+ *
+ * Returns:
+ * 0:  on success
+ * < 0: on error
  */
-void insn_get_immediate(struct insn *insn)
+int insn_get_immediate(struct insn *insn)
 {
+	int ret;
+
 	if (insn->immediate.got)
-		return;
-	if (!insn->displacement.got)
-		insn_get_displacement(insn);
+		return 0;
+
+	if (!insn->displacement.got) {
+		ret = insn_get_displacement(insn);
+		if (ret)
+			return ret;
+	}
 
 	if (inat_has_moffset(insn->attr)) {
 		if (!__get_moffset(insn))
@@ -605,9 +690,10 @@ void insn_get_immediate(struct insn *insn)
 	}
 done:
 	insn->immediate.got = 1;
+	return 0;
 
 err_out:
-	return;
+	return -ENODATA;
 }
 
 /**
@@ -616,13 +702,58 @@ void insn_get_immediate(struct insn *insn)
  *
  * If necessary, first collects the instruction up to and including the
  * immediates bytes.
- */
-void insn_get_length(struct insn *insn)
+ *
+ * Returns:
+ *  - 0 on success
+ *  - < 0 on error
+*/
+int insn_get_length(struct insn *insn)
 {
+	int ret;
+
 	if (insn->length)
-		return;
-	if (!insn->immediate.got)
-		insn_get_immediate(insn);
+		return 0;
+
+	if (!insn->immediate.got) {
+		ret = insn_get_immediate(insn);
+		if (ret)
+			return ret;
+	}
+
 	insn->length = (unsigned char)((unsigned long)insn->next_byte
 				     - (unsigned long)insn->kaddr);
+
+	return 0;
+}
+
+/**
+ * insn_decode() - Decode an x86 instruction
+ * @insn:	&struct insn to be initialized
+ * @kaddr:	address (in kernel memory) of instruction (or copy thereof)
+ * @buf_len:	length of the insn buffer at @kaddr
+ * @m:		insn mode, see enum insn_mode
+ *
+ * Returns:
+ * 0: if decoding succeeded
+ * < 0: otherwise.
+ */
+int insn_decode(struct insn *insn, const void *kaddr, int buf_len, enum insn_mode m)
+{
+	int ret;
+
+/* #define INSN_MODE_KERN	-1 __ignore_sync_check__ mode is only valid in the kernel */
+
+	if (m == INSN_MODE_KERN)
+		insn_init(insn, kaddr, buf_len, IS_ENABLED(CONFIG_X86_64));
+	else
+		insn_init(insn, kaddr, buf_len, m == INSN_MODE_64);
+
+	ret = insn_get_length(insn);
+	if (ret)
+		return ret;
+
+	if (insn_complete(insn))
+		return 0;
+
+	return -EINVAL;
 }
diff --git a/tools/arch/x86/include/asm/insn.h b/tools/arch/x86/include/asm/insn.h
index 33d41982a5dd..621ab64a6d27 100644
--- a/tools/arch/x86/include/asm/insn.h
+++ b/tools/arch/x86/include/asm/insn.h
@@ -87,13 +87,23 @@ struct insn {
 #define X86_VEX_M_MAX	0x1f			/* VEX3.M Maximum value */
 
 extern void insn_init(struct insn *insn, const void *kaddr, int buf_len, int x86_64);
-extern void insn_get_prefixes(struct insn *insn);
-extern void insn_get_opcode(struct insn *insn);
-extern void insn_get_modrm(struct insn *insn);
-extern void insn_get_sib(struct insn *insn);
-extern void insn_get_displacement(struct insn *insn);
-extern void insn_get_immediate(struct insn *insn);
-extern void insn_get_length(struct insn *insn);
+extern int insn_get_prefixes(struct insn *insn);
+extern int insn_get_opcode(struct insn *insn);
+extern int insn_get_modrm(struct insn *insn);
+extern int insn_get_sib(struct insn *insn);
+extern int insn_get_displacement(struct insn *insn);
+extern int insn_get_immediate(struct insn *insn);
+extern int insn_get_length(struct insn *insn);
+
+enum insn_mode {
+	INSN_MODE_32,
+	INSN_MODE_64,
+	/* Mode is determined by the current kernel build. */
+	INSN_MODE_KERN,
+	INSN_NUM_MODES,
+};
+
+extern int insn_decode(struct insn *insn, const void *kaddr, int buf_len, enum insn_mode m);
 
 /* Attribute will be determined after getting ModRM (for opcode groups) */
 static inline void insn_get_attribute(struct insn *insn)
diff --git a/tools/arch/x86/lib/insn.c b/tools/arch/x86/lib/insn.c
index dedcfd67f90c..6c9c1648eef3 100644
--- a/tools/arch/x86/lib/insn.c
+++ b/tools/arch/x86/lib/insn.c
@@ -13,6 +13,9 @@
 #include "../include/asm/inat.h" /* __ignore_sync_check__ */
 #include "../include/asm/insn.h" /* __ignore_sync_check__ */
 
+#include <linux/errno.h>
+#include <linux/kconfig.h>
+
 #include "../include/asm/emulate_prefix.h" /* __ignore_sync_check__ */
 
 /* Verify next sizeof(t) bytes can be on the same instruction */
@@ -80,12 +83,15 @@ static int __insn_get_emulate_prefix(struct insn *insn,
 	return 1;
 
 err_out:
-	return 0;
+	return -ENODATA;
 }
 
 static void insn_get_emulate_prefix(struct insn *insn)
 {
-	if (__insn_get_emulate_prefix(insn, xen_prefix, sizeof(xen_prefix)))
+	int ret;
+
+	ret = __insn_get_emulate_prefix(insn, xen_prefix, sizeof(xen_prefix));
+	if (ret > 0)
 		return;
 
 	__insn_get_emulate_prefix(insn, kvm_prefix, sizeof(kvm_prefix));
@@ -98,8 +104,12 @@ static void insn_get_emulate_prefix(struct insn *insn)
  * Populates the @insn->prefixes bitmap, and updates @insn->next_byte
  * to point to the (first) opcode.  No effect if @insn->prefixes.got
  * is already set.
+ *
+ * * Returns:
+ * 0:  on success
+ * < 0: on error
  */
-void insn_get_prefixes(struct insn *insn)
+int insn_get_prefixes(struct insn *insn)
 {
 	struct insn_field *prefixes = &insn->prefixes;
 	insn_attr_t attr;
@@ -107,7 +117,7 @@ void insn_get_prefixes(struct insn *insn)
 	int i, nb;
 
 	if (prefixes->got)
-		return;
+		return 0;
 
 	insn_get_emulate_prefix(insn);
 
@@ -218,8 +228,10 @@ void insn_get_prefixes(struct insn *insn)
 
 	prefixes->got = 1;
 
+	return 0;
+
 err_out:
-	return;
+	return -ENODATA;
 }
 
 /**
@@ -231,16 +243,25 @@ void insn_get_prefixes(struct insn *insn)
  * If necessary, first collects any preceding (prefix) bytes.
  * Sets @insn->opcode.value = opcode1.  No effect if @insn->opcode.got
  * is already 1.
+ *
+ * Returns:
+ * 0:  on success
+ * < 0: on error
  */
-void insn_get_opcode(struct insn *insn)
+int insn_get_opcode(struct insn *insn)
 {
 	struct insn_field *opcode = &insn->opcode;
+	int pfx_id, ret;
 	insn_byte_t op;
-	int pfx_id;
+
 	if (opcode->got)
-		return;
-	if (!insn->prefixes.got)
-		insn_get_prefixes(insn);
+		return 0;
+
+	if (!insn->prefixes.got) {
+		ret = insn_get_prefixes(insn);
+		if (ret)
+			return ret;
+	}
 
 	/* Get first opcode */
 	op = get_next(insn_byte_t, insn);
@@ -255,9 +276,13 @@ void insn_get_opcode(struct insn *insn)
 		insn->attr = inat_get_avx_attribute(op, m, p);
 		if ((inat_must_evex(insn->attr) && !insn_is_evex(insn)) ||
 		    (!inat_accept_vex(insn->attr) &&
-		     !inat_is_group(insn->attr)))
-			insn->attr = 0;	/* This instruction is bad */
-		goto end;	/* VEX has only 1 byte for opcode */
+		     !inat_is_group(insn->attr))) {
+			/* This instruction is bad */
+			insn->attr = 0;
+			return 1;
+		}
+		/* VEX has only 1 byte for opcode */
+		goto end;
 	}
 
 	insn->attr = inat_get_opcode_attribute(op);
@@ -268,13 +293,18 @@ void insn_get_opcode(struct insn *insn)
 		pfx_id = insn_last_prefix_id(insn);
 		insn->attr = inat_get_escape_attribute(op, pfx_id, insn->attr);
 	}
-	if (inat_must_vex(insn->attr))
-		insn->attr = 0;	/* This instruction is bad */
+
+	if (inat_must_vex(insn->attr)) {
+		/* This instruction is bad */
+		insn->attr = 0;
+		return 1;
+	}
 end:
 	opcode->got = 1;
+	return 0;
 
 err_out:
-	return;
+	return -ENODATA;
 }
 
 /**
@@ -284,15 +314,25 @@ void insn_get_opcode(struct insn *insn)
  * Populates @insn->modrm and updates @insn->next_byte to point past the
  * ModRM byte, if any.  If necessary, first collects the preceding bytes
  * (prefixes and opcode(s)).  No effect if @insn->modrm.got is already 1.
+ *
+ * Returns:
+ * 0:  on success
+ * < 0: on error
  */
-void insn_get_modrm(struct insn *insn)
+int insn_get_modrm(struct insn *insn)
 {
 	struct insn_field *modrm = &insn->modrm;
 	insn_byte_t pfx_id, mod;
+	int ret;
+
 	if (modrm->got)
-		return;
-	if (!insn->opcode.got)
-		insn_get_opcode(insn);
+		return 0;
+
+	if (!insn->opcode.got) {
+		ret = insn_get_opcode(insn);
+		if (ret)
+			return ret;
+	}
 
 	if (inat_has_modrm(insn->attr)) {
 		mod = get_next(insn_byte_t, insn);
@@ -302,17 +342,22 @@ void insn_get_modrm(struct insn *insn)
 			pfx_id = insn_last_prefix_id(insn);
 			insn->attr = inat_get_group_attribute(mod, pfx_id,
 							      insn->attr);
-			if (insn_is_avx(insn) && !inat_accept_vex(insn->attr))
-				insn->attr = 0;	/* This is bad */
+			if (insn_is_avx(insn) && !inat_accept_vex(insn->attr)) {
+				/* Bad insn */
+				insn->attr = 0;
+				return 1;
+			}
 		}
 	}
 
 	if (insn->x86_64 && inat_is_force64(insn->attr))
 		insn->opnd_bytes = 8;
+
 	modrm->got = 1;
+	return 0;
 
 err_out:
-	return;
+	return -ENODATA;
 }
 
 
@@ -326,11 +371,16 @@ void insn_get_modrm(struct insn *insn)
 int insn_rip_relative(struct insn *insn)
 {
 	struct insn_field *modrm = &insn->modrm;
+	int ret;
 
 	if (!insn->x86_64)
 		return 0;
-	if (!modrm->got)
-		insn_get_modrm(insn);
+
+	if (!modrm->got) {
+		ret = insn_get_modrm(insn);
+		if (ret)
+			return ret;
+	}
 	/*
 	 * For rip-relative instructions, the mod field (top 2 bits)
 	 * is zero and the r/m field (bottom 3 bits) is 0x5.
@@ -344,15 +394,25 @@ int insn_rip_relative(struct insn *insn)
  *
  * If necessary, first collects the instruction up to and including the
  * ModRM byte.
+ *
+ * Returns:
+ * 0: if decoding succeeded
+ * < 0: otherwise.
  */
-void insn_get_sib(struct insn *insn)
+int insn_get_sib(struct insn *insn)
 {
 	insn_byte_t modrm;
+	int ret;
 
 	if (insn->sib.got)
-		return;
-	if (!insn->modrm.got)
-		insn_get_modrm(insn);
+		return 0;
+
+	if (!insn->modrm.got) {
+		ret = insn_get_modrm(insn);
+		if (ret)
+			return ret;
+	}
+
 	if (insn->modrm.nbytes) {
 		modrm = (insn_byte_t)insn->modrm.value;
 		if (insn->addr_bytes != 2 &&
@@ -363,8 +423,10 @@ void insn_get_sib(struct insn *insn)
 	}
 	insn->sib.got = 1;
 
+	return 0;
+
 err_out:
-	return;
+	return -ENODATA;
 }
 
 
@@ -375,15 +437,25 @@ void insn_get_sib(struct insn *insn)
  * If necessary, first collects the instruction up to and including the
  * SIB byte.
  * Displacement value is sign-expanded.
+ *
+ * * Returns:
+ * 0: if decoding succeeded
+ * < 0: otherwise.
  */
-void insn_get_displacement(struct insn *insn)
+int insn_get_displacement(struct insn *insn)
 {
 	insn_byte_t mod, rm, base;
+	int ret;
 
 	if (insn->displacement.got)
-		return;
-	if (!insn->sib.got)
-		insn_get_sib(insn);
+		return 0;
+
+	if (!insn->sib.got) {
+		ret = insn_get_sib(insn);
+		if (ret)
+			return ret;
+	}
+
 	if (insn->modrm.nbytes) {
 		/*
 		 * Interpreting the modrm byte:
@@ -426,12 +498,13 @@ void insn_get_displacement(struct insn *insn)
 	}
 out:
 	insn->displacement.got = 1;
+	return 0;
 
 err_out:
-	return;
+	return -ENODATA;
 }
 
-/* Decode moffset16/32/64. Return 0 if failed */
+/* Decode moffset16/32/64. Return a negative value if failed. */
 static int __get_moffset(struct insn *insn)
 {
 	switch (insn->addr_bytes) {
@@ -457,10 +530,10 @@ static int __get_moffset(struct insn *insn)
 	return 1;
 
 err_out:
-	return 0;
+	return -ENODATA;
 }
 
-/* Decode imm v32(Iz). Return 0 if failed */
+/* Decode imm v32(Iz). Return a negative value if failed. */
 static int __get_immv32(struct insn *insn)
 {
 	switch (insn->opnd_bytes) {
@@ -480,10 +553,10 @@ static int __get_immv32(struct insn *insn)
 	return 1;
 
 err_out:
-	return 0;
+	return -ENODATA;
 }
 
-/* Decode imm v64(Iv/Ov), Return 0 if failed */
+/* Decode imm v64(Iv/Ov). Return a negative value if failed. */
 static int __get_immv(struct insn *insn)
 {
 	switch (insn->opnd_bytes) {
@@ -507,11 +580,12 @@ static int __get_immv(struct insn *insn)
 	insn->immediate1.got = insn->immediate2.got = 1;
 
 	return 1;
+
 err_out:
-	return 0;
+	return -ENODATA;
 }
 
-/* Decode ptr16:16/32(Ap) */
+/* Decode ptr16:16/32(Ap). Return a negative value if failed. */
 static int __get_immptr(struct insn *insn)
 {
 	switch (insn->opnd_bytes) {
@@ -534,25 +608,36 @@ static int __get_immptr(struct insn *insn)
 	insn->immediate1.got = insn->immediate2.got = 1;
 
 	return 1;
+
 err_out:
-	return 0;
+	return -ENODATA;
 }
 
 /**
- * insn_get_immediate() - Get the immediates of instruction
+ * insn_get_immediate() - Get the immediate in an instruction
  * @insn:	&struct insn containing instruction
  *
  * If necessary, first collects the instruction up to and including the
  * displacement bytes.
  * Basically, most of immediates are sign-expanded. Unsigned-value can be
- * get by bit masking with ((1 << (nbytes * 8)) - 1)
+ * computed by bit masking with ((1 << (nbytes * 8)) - 1)
+ *
+ * Returns:
+ * 0:  on success
+ * < 0: on error
  */
-void insn_get_immediate(struct insn *insn)
+int insn_get_immediate(struct insn *insn)
 {
+	int ret;
+
 	if (insn->immediate.got)
-		return;
-	if (!insn->displacement.got)
-		insn_get_displacement(insn);
+		return 0;
+
+	if (!insn->displacement.got) {
+		ret = insn_get_displacement(insn);
+		if (ret)
+			return ret;
+	}
 
 	if (inat_has_moffset(insn->attr)) {
 		if (!__get_moffset(insn))
@@ -605,9 +690,10 @@ void insn_get_immediate(struct insn *insn)
 	}
 done:
 	insn->immediate.got = 1;
+	return 0;
 
 err_out:
-	return;
+	return -ENODATA;
 }
 
 /**
@@ -616,13 +702,58 @@ void insn_get_immediate(struct insn *insn)
  *
  * If necessary, first collects the instruction up to and including the
  * immediates bytes.
- */
-void insn_get_length(struct insn *insn)
+ *
+ * Returns:
+ *  - 0 on success
+ *  - < 0 on error
+*/
+int insn_get_length(struct insn *insn)
 {
+	int ret;
+
 	if (insn->length)
-		return;
-	if (!insn->immediate.got)
-		insn_get_immediate(insn);
+		return 0;
+
+	if (!insn->immediate.got) {
+		ret = insn_get_immediate(insn);
+		if (ret)
+			return ret;
+	}
+
 	insn->length = (unsigned char)((unsigned long)insn->next_byte
 				     - (unsigned long)insn->kaddr);
+
+	return 0;
+}
+
+/**
+ * insn_decode() - Decode an x86 instruction
+ * @insn:	&struct insn to be initialized
+ * @kaddr:	address (in kernel memory) of instruction (or copy thereof)
+ * @buf_len:	length of the insn buffer at @kaddr
+ * @m:		insn mode, see enum insn_mode
+ *
+ * Returns:
+ * 0: if decoding succeeded
+ * < 0: otherwise.
+ */
+int insn_decode(struct insn *insn, const void *kaddr, int buf_len, enum insn_mode m)
+{
+	int ret;
+
+#define INSN_MODE_KERN	(enum insn_mode)-1 /* __ignore_sync_check__ mode is only valid in the kernel */
+
+	if (m == INSN_MODE_KERN)
+		insn_init(insn, kaddr, buf_len, IS_ENABLED(CONFIG_X86_64));
+	else
+		insn_init(insn, kaddr, buf_len, m == INSN_MODE_64);
+
+	ret = insn_get_length(insn);
+	if (ret)
+		return ret;
+
+	if (insn_complete(insn))
+		return 0;
+
+	return -EINVAL;
 }
diff --git a/tools/include/linux/kconfig.h b/tools/include/linux/kconfig.h
new file mode 100644
index 000000000000..1555a0c4f345
--- /dev/null
+++ b/tools/include/linux/kconfig.h
@@ -0,0 +1,73 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _TOOLS_LINUX_KCONFIG_H
+#define _TOOLS_LINUX_KCONFIG_H
+
+/* CONFIG_CC_VERSION_TEXT (Do not delete this comment. See help in Kconfig) */
+
+#ifdef CONFIG_CPU_BIG_ENDIAN
+#define __BIG_ENDIAN 4321
+#else
+#define __LITTLE_ENDIAN 1234
+#endif
+
+#define __ARG_PLACEHOLDER_1 0,
+#define __take_second_arg(__ignored, val, ...) val
+
+/*
+ * The use of "&&" / "||" is limited in certain expressions.
+ * The following enable to calculate "and" / "or" with macro expansion only.
+ */
+#define __and(x, y)			___and(x, y)
+#define ___and(x, y)			____and(__ARG_PLACEHOLDER_##x, y)
+#define ____and(arg1_or_junk, y)	__take_second_arg(arg1_or_junk y, 0)
+
+#define __or(x, y)			___or(x, y)
+#define ___or(x, y)			____or(__ARG_PLACEHOLDER_##x, y)
+#define ____or(arg1_or_junk, y)		__take_second_arg(arg1_or_junk 1, y)
+
+/*
+ * Helper macros to use CONFIG_ options in C/CPP expressions. Note that
+ * these only work with boolean and tristate options.
+ */
+
+/*
+ * Getting something that works in C and CPP for an arg that may or may
+ * not be defined is tricky.  Here, if we have "#define CONFIG_BOOGER 1"
+ * we match on the placeholder define, insert the "0," for arg1 and generate
+ * the triplet (0, 1, 0).  Then the last step cherry picks the 2nd arg (a one).
+ * When CONFIG_BOOGER is not defined, we generate a (... 1, 0) pair, and when
+ * the last step cherry picks the 2nd arg, we get a zero.
+ */
+#define __is_defined(x)			___is_defined(x)
+#define ___is_defined(val)		____is_defined(__ARG_PLACEHOLDER_##val)
+#define ____is_defined(arg1_or_junk)	__take_second_arg(arg1_or_junk 1, 0)
+
+/*
+ * IS_BUILTIN(CONFIG_FOO) evaluates to 1 if CONFIG_FOO is set to 'y', 0
+ * otherwise. For boolean options, this is equivalent to
+ * IS_ENABLED(CONFIG_FOO).
+ */
+#define IS_BUILTIN(option) __is_defined(option)
+
+/*
+ * IS_MODULE(CONFIG_FOO) evaluates to 1 if CONFIG_FOO is set to 'm', 0
+ * otherwise.
+ */
+#define IS_MODULE(option) __is_defined(option##_MODULE)
+
+/*
+ * IS_REACHABLE(CONFIG_FOO) evaluates to 1 if the currently compiled
+ * code can call a function defined in code compiled based on CONFIG_FOO.
+ * This is similar to IS_ENABLED(), but returns false when invoked from
+ * built-in code when CONFIG_FOO is set to 'm'.
+ */
+#define IS_REACHABLE(option) __or(IS_BUILTIN(option), \
+				__and(IS_MODULE(option), __is_defined(MODULE)))
+
+/*
+ * IS_ENABLED(CONFIG_FOO) evaluates to 1 if CONFIG_FOO is set to 'y' or 'm',
+ * 0 otherwise.
+ */
+#define IS_ENABLED(option) __or(IS_BUILTIN(option), IS_MODULE(option))
+
+#endif /* _TOOLS_LINUX_KCONFIG_H */
-- 
2.29.2

