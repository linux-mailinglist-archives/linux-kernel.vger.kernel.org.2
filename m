Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BDB3397BAD
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 23:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234863AbhFAVXW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 17:23:22 -0400
Received: from mail.skyhub.de ([5.9.137.197]:51488 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234831AbhFAVXT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 17:23:19 -0400
Received: from zn.tnic (p200300ec2f111d0093004df6f0d27e9c.dip0.t-ipconnect.de [IPv6:2003:ec:2f11:1d00:9300:4df6:f0d2:7e9c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6ED551EC0288;
        Tue,  1 Jun 2021 23:21:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1622582496;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=r6po77ash8nSd+/o4Au/rz1P1mxTHjT+9nnkvAgn8+E=;
        b=gOd/30Z5BByE+u0vlUXbN52jkEJnKTUBSmsGP2OxydiPFFMWs8t0TthCLECUr9iNFgSv2c
        Fhd02cwuAGPtgSUi7FE/z91xSAQ/Krby7bEmMANlsdFsIHGZytNg+otQJ/KG3PXm4fi56m
        fZl7B7Tg+51iR/FAllP36J5Ib8UnecM=
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Richard Narron <richard@aaazen.com>
Subject: [PATCH] x86/alternative: Optimize single-byte NOPs at an arbitrary position
Date:   Tue,  1 Jun 2021 23:21:25 +0200
Message-Id: <20210601212125.17145-1-bp@alien8.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Up until now the assumption was that an alternative patching site would
have some instructions at the beginning and trailing single-byte NOPs
(0x90) padding. Therefore, the patching machinery would go and optimize
those single-byte NOPs into longer ones.

However, this assumption is broken on 32-bit when code like
hv_do_hypercall() in hyperv_init() would use the ratpoline speculation
killer CALL_NOSPEC. The 32-bit version of that macro would align certain
insns to 16 bytes, leading to the compiler issuing a one or more
single-byte NOPs, depending on the holes it needs to fill for alignment.

That would lead to the warning in optimize_nops() to fire:

  ------------[ cut here ]------------
  Not a NOP at 0xc27fb598
   WARNING: CPU: 0 PID: 0 at arch/x86/kernel/alternative.c:211 optimize_nops.isra.13

due to that function verifying whether all of the following bytes really
are single-byte NOPs.

Therefore, carve out the NOP padding into a separate function and call
it for each NOP range beginning with a single-byte NOP.

Fixes: 23c1ad538f4f ("x86/alternatives: Optimize optimize_nops()")
Reported-by: Richard Narron <richard@aaazen.com>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=213301
Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/kernel/alternative.c | 62 +++++++++++++++++++++++++----------
 1 file changed, 44 insertions(+), 18 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 6974b5174495..7baf13b11952 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -182,42 +182,68 @@ recompute_jump(struct alt_instr *a, u8 *orig_insn, u8 *repl_insn, u8 *insn_buff)
 		n_dspl, (unsigned long)orig_insn + n_dspl + repl_len);
 }
 
+/*
+ * @instr: instruction byte stream
+ * @instrlen: length of the above
+ * @off: offset within @instr where the first NOP has been detected
+ */
+static __always_inline int optimize_nops_range(u8 *instr, u8 instrlen, int off)
+{
+	unsigned long flags;
+	int i = off, nnops;
+
+	while (i < instrlen) {
+		if (instr[i] != 0x90)
+			break;
+
+		i++;
+	}
+
+	nnops = i - off;
+
+	if (nnops <= 1)
+		return nnops;
+
+	local_irq_save(flags);
+	add_nops(instr + off, nnops);
+	local_irq_restore(flags);
+
+	DUMP_BYTES(instr, instrlen, "%px: [%d:%d) optimized NOPs: ",
+		   instr, off, i);
+
+	return nnops;
+}
+
+
 /*
  * "noinline" to cause control flow change and thus invalidate I$ and
  * cause refetch after modification.
  */
 static void __init_or_module noinline optimize_nops(struct alt_instr *a, u8 *instr)
 {
-	unsigned long flags;
 	struct insn insn;
-	int nop, i = 0;
+	int i = 0;
 
 	/*
-	 * Jump over the non-NOP insns, the remaining bytes must be single-byte
-	 * NOPs, optimize them.
+	 * Jump over the non-NOP insns and optimize single-byte NOPs into bigger
+	 * ones.
 	 */
 	for (;;) {
 		if (insn_decode_kernel(&insn, &instr[i]))
 			return;
 
+		/*
+		 * See if this and any potentially following NOPs can be
+		 * optimized.
+		 */
 		if (insn.length == 1 && insn.opcode.bytes[0] == 0x90)
-			break;
-
-		if ((i += insn.length) >= a->instrlen)
-			return;
-	}
+			i += optimize_nops_range(instr, a->instrlen, i);
+		else
+			i += insn.length;
 
-	for (nop = i; i < a->instrlen; i++) {
-		if (WARN_ONCE(instr[i] != 0x90, "Not a NOP at 0x%px\n", &instr[i]))
+		if (i >= a->instrlen)
 			return;
 	}
-
-	local_irq_save(flags);
-	add_nops(instr + nop, i - nop);
-	local_irq_restore(flags);
-
-	DUMP_BYTES(instr, a->instrlen, "%px: [%d:%d) optimized NOPs: ",
-		   instr, nop, a->instrlen);
 }
 
 /*
-- 
2.29.2

