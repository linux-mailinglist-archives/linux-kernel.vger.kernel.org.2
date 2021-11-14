Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8892744F81B
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Nov 2021 14:31:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235999AbhKNNeN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Nov 2021 08:34:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbhKNNdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Nov 2021 08:33:53 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7223C061766
        for <linux-kernel@vger.kernel.org>; Sun, 14 Nov 2021 05:30:59 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1636896658;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=vTcvmJMjAZmVBK5QPKP6yMljmGS3I3iKbHkut/+98HM=;
        b=JT45iI4VZqoB/+bkK3xq5D/f28cTJFj0yMyd8RNtjo2l36+KffqFta3qXn2atR9H7bSzeQ
        ymCv/TWY+ceZ+WbY2eqMM5cB3RtmioZT/h1TtfFrhfNWfVgjDey+I81E/GqyFVkx3vsLhc
        BVCgW4x6+lYG7JE+gxDEObHlfNfinbIGWC5kVJnmzMlezh3aYATJ/qfz49h4kOpHQXyH6I
        1+YHPDwhzQ3QMCjvYYe7NOfdWDCD9DTusVKyC7IkyPDdt3G+kM7QA9F3T+CLdqXM4q79BT
        sU8RVfQqmKo0ThnuztmQl2wKqDctjfOZp9+Gvz/nNgMTRqAEtXJehOCKw5pc0Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1636896658;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=vTcvmJMjAZmVBK5QPKP6yMljmGS3I3iKbHkut/+98HM=;
        b=bVoCspH3WUN82qEICoSdBhR2X0p9tAD/Qb4arkW85xPihk1vOulPGMUh2ruoDbJk+sH/U7
        llbokdbZpIzblGDA==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] locking/urgent for v5.16-rc1
References: <163689642456.3249160.13397023971040961440.tglx@xen13>
Message-ID: <163689642600.3249160.14155489699842458627.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Date:   Sun, 14 Nov 2021 14:30:58 +0100 (CET)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest locking/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-urgent-2=
021-11-14

up to:  2105a92748e8: static_call,x86: Robustify trampoline patching

A single fix for static calls to make the trampoline patching more robust
by placing explicit signature bytes after the call trampoline to prevent
patching random other jumps like the CFI jump table entries.

Thanks,

	tglx

------------------>
Peter Zijlstra (1):
      static_call,x86: Robustify trampoline patching


 arch/x86/include/asm/static_call.h |  1 +
 arch/x86/kernel/static_call.c      | 14 ++++++++++----
 tools/objtool/check.c              |  3 +++
 3 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/static_call.h b/arch/x86/include/asm/static=
_call.h
index cbb67b6030f9..39ebe0511869 100644
--- a/arch/x86/include/asm/static_call.h
+++ b/arch/x86/include/asm/static_call.h
@@ -27,6 +27,7 @@
 	    ".globl " STATIC_CALL_TRAMP_STR(name) "		\n"	\
 	    STATIC_CALL_TRAMP_STR(name) ":			\n"	\
 	    insns "						\n"	\
+	    ".byte 0x53, 0x43, 0x54				\n"	\
 	    ".type " STATIC_CALL_TRAMP_STR(name) ", @function	\n"	\
 	    ".size " STATIC_CALL_TRAMP_STR(name) ", . - " STATIC_CALL_TRAMP_STR(nam=
e) " \n" \
 	    ".popsection					\n")
diff --git a/arch/x86/kernel/static_call.c b/arch/x86/kernel/static_call.c
index ea028e736831..9c407a33a774 100644
--- a/arch/x86/kernel/static_call.c
+++ b/arch/x86/kernel/static_call.c
@@ -56,10 +56,15 @@ static void __ref __static_call_transform(void *insn, enu=
m insn_type type, void
 	text_poke_bp(insn, code, size, emulate);
 }
=20
-static void __static_call_validate(void *insn, bool tail)
+static void __static_call_validate(void *insn, bool tail, bool tramp)
 {
 	u8 opcode =3D *(u8 *)insn;
=20
+	if (tramp && memcmp(insn+5, "SCT", 3)) {
+		pr_err("trampoline signature fail");
+		BUG();
+	}
+
 	if (tail) {
 		if (opcode =3D=3D JMP32_INSN_OPCODE ||
 		    opcode =3D=3D RET_INSN_OPCODE)
@@ -74,7 +79,8 @@ static void __static_call_validate(void *insn, bool tail)
 	/*
 	 * If we ever trigger this, our text is corrupt, we'll probably not live lo=
ng.
 	 */
-	WARN_ONCE(1, "unexpected static_call insn opcode 0x%x at %pS\n", opcode, in=
sn);
+	pr_err("unexpected static_call insn opcode 0x%x at %pS\n", opcode, insn);
+	BUG();
 }
=20
 static inline enum insn_type __sc_insn(bool null, bool tail)
@@ -97,12 +103,12 @@ void arch_static_call_transform(void *site, void *tramp,=
 void *func, bool tail)
 	mutex_lock(&text_mutex);
=20
 	if (tramp) {
-		__static_call_validate(tramp, true);
+		__static_call_validate(tramp, true, true);
 		__static_call_transform(tramp, __sc_insn(!func, true), func);
 	}
=20
 	if (IS_ENABLED(CONFIG_HAVE_STATIC_CALL_INLINE) && site) {
-		__static_call_validate(site, tail);
+		__static_call_validate(site, tail, false);
 		__static_call_transform(site, __sc_insn(!func, tail), func);
 	}
=20
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index add39902166d..21735829b860 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -3310,6 +3310,9 @@ static bool ignore_unreachable_insn(struct objtool_file=
 *file, struct instructio
 	if (!insn->func)
 		return false;
=20
+	if (insn->func->static_call_tramp)
+		return true;
+
 	/*
 	 * CONFIG_UBSAN_TRAP inserts a UD2 when it sees
 	 * __builtin_unreachable().  The BUG() macro has an unreachable() after

