Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7901139CBEC
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 02:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbhFFAeg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Jun 2021 20:34:36 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33054 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbhFFAeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jun 2021 20:34:24 -0400
Message-Id: <20210606001324.242471028@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1622939554;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=xkh/61yaweGJv//rxoeyrYOro4J8cUKqRuHHst9k0B4=;
        b=VuTKKeT3q4oSomlUxI21AHKZ5T9JLOReIAvjtHakbGTqHpqrO6BkRJAY3gHmOUIMa5xknk
        vzfEu7CTck8i9gO6BNYCgyi/2P492jir9A5Wgie2FrxKcE0fPoKR90OYXBwyeNp4N/vVq8
        zr8zVvovIkKenJ1KRCsu6D4AptqeDD8XbOS6kOsgWXOfQ5Wj/Oc7h2ewgcRIQFU4JINL80
        laKa73tnblJnME+Py2apNfLHs6WW0zhbWmdGTLDLNQl4JLFiTW36lFwV8GPglkiRHJi3x7
        P7Y2XopPjTzGdHMKw+P3PhyKciCnx9iE0f+qsB75eof028urWYaozeLhTHAJcg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1622939554;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=xkh/61yaweGJv//rxoeyrYOro4J8cUKqRuHHst9k0B4=;
        b=qCRp/Y3NxXJhyqZeueKvx6E0cqdCG0aIqjzs9N2FToIzbn414d0NwlSfkrCFFsqRI4QBBX
        9zgEmSeuN2AG0sAg==
Date:   Sun, 06 Jun 2021 01:47:55 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [patch V2 13/14] x86/fpu: Rename xstate copy functions which are
 related to UABI
References: <20210605234742.712464974@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename them to reflect that these functions deal with user space format
XSAVE buffers.

Suggested-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: New patch
---
 arch/x86/include/asm/fpu/xstate.h |    6 +++---
 arch/x86/kernel/fpu/regset.c      |    4 ++--
 arch/x86/kernel/fpu/signal.c      |    2 +-
 arch/x86/kernel/fpu/xstate.c      |    7 ++++---
 4 files changed, 10 insertions(+), 9 deletions(-)

--- a/arch/x86/include/asm/fpu/xstate.h
+++ b/arch/x86/include/asm/fpu/xstate.h
@@ -105,9 +105,9 @@ const void *get_xsave_field_ptr(int xfea
 int using_compacted_format(void);
 int xfeature_size(int xfeature_nr);
 struct membuf;
-void copy_xstate_to_kernel(struct membuf to, struct xregs_state *xsave);
-int copy_kernel_to_xstate(struct xregs_state *xsave, const void *kbuf);
-int copy_user_to_xstate(struct xregs_state *xsave, const void __user *ubuf);
+void copy_uabi_xstate_to_kernel(struct membuf to, struct xregs_state *xsave);
+int copy_uabi_from_kernel_to_xstate(struct xregs_state *xsave, const void *kbuf);
+int copy_uabi_from_user_to_xstate(struct xregs_state *xsave, const void __user *ubuf);
 void copy_supervisor_to_kernel(struct xregs_state *xsave);
 void copy_dynamic_supervisor_to_kernel(struct xregs_state *xstate, u64 mask);
 void copy_kernel_to_dynamic_supervisor(struct xregs_state *xstate, u64 mask);
--- a/arch/x86/kernel/fpu/regset.c
+++ b/arch/x86/kernel/fpu/regset.c
@@ -89,7 +89,7 @@ int xstateregs_get(struct task_struct *t
 	fpu__prepare_read(fpu);
 
 	if (using_compacted_format()) {
-		copy_xstate_to_kernel(to, xsave);
+		copy_uabi_xstate_to_kernel(to, xsave);
 		return 0;
 	} else {
 		fpstate_sanitize_xstate(fpu);
@@ -135,7 +135,7 @@ int xstateregs_set(struct task_struct *t
 	}
 
 	fpu__prepare_write(fpu);
-	ret = copy_kernel_to_xstate(&fpu->state.xsave, kbuf ?: tmpbuf);
+	ret = copy_uabi_from_kernel_to_xstate(&fpu->state.xsave, kbuf ?: tmpbuf);
 
 out:
 	vfree(tmpbuf);
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -426,7 +426,7 @@ static int __fpu__restore_sig(void __use
 	if (use_xsave() && !fx_only) {
 		u64 init_bv = xfeatures_mask_user() & ~user_xfeatures;
 
-		ret = copy_user_to_xstate(&fpu->state.xsave, buf_fx);
+		ret = copy_uabi_from_user_to_xstate(&fpu->state.xsave, buf_fx);
 		if (ret)
 			goto err_out;
 
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -1072,7 +1072,7 @@ static void copy_part(struct membuf *to,
  * It supports partial copy but pos always starts from zero. This is called
  * from xstateregs_get() and there we check the CPU has XSAVES.
  */
-void copy_xstate_to_kernel(struct membuf to, struct xregs_state *xsave)
+void copy_uabi_xstate_to_kernel(struct membuf to, struct xregs_state *xsave)
 {
 	struct xstate_header header;
 	const unsigned off_mxcsr = offsetof(struct fxregs_state, mxcsr);
@@ -1128,7 +1128,7 @@ void copy_xstate_to_kernel(struct membuf
  * Convert from a ptrace standard-format kernel buffer to kernel XSAVES format
  * and copy to the target thread. This is called from xstateregs_set().
  */
-int copy_kernel_to_xstate(struct xregs_state *xsave, const void *kbuf)
+int copy_uabi_from_kernel_to_xstate(struct xregs_state *xsave, const void *kbuf)
 {
 	unsigned int offset, size;
 	int i;
@@ -1183,7 +1183,8 @@ int copy_kernel_to_xstate(struct xregs_s
  * XSAVES format and copy to the target thread. This is called from the
  * sigreturn() and rt_sigreturn() system calls.
  */
-int copy_user_to_xstate(struct xregs_state *xsave, const void __user *ubuf)
+int copy_uabi_from_user_to_xstate(struct xregs_state *xsave,
+				  const void __user *ubuf)
 {
 	unsigned int offset, size;
 	int i;

