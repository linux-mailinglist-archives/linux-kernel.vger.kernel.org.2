Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE531323B00
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 12:05:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235009AbhBXLFn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 06:05:43 -0500
Received: from mail.skyhub.de ([5.9.137.197]:39610 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234956AbhBXLDV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 06:03:21 -0500
Received: from zn.tnic (p200300ec2f0d180081510bd8ee909965.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:1800:8151:bd8:ee90:9965])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A34CE1EC059E;
        Wed, 24 Feb 2021 12:02:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1614164556;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ekrDVZYJeqI+ZAM/Z+949wNS+Vb/VOkvdg3QUTWa7xc=;
        b=mU5l1NkDY80q78u+KUc1M3Pbq5jNrf7GHqD8ePOp6S5afUFBAHvvSLKanktosoU1BAGdlq
        hV7WRyWnFJ4Se3iWl2WjT+rx/iB2sHGkmnunvotcAfWrjIbm65ZZJLPrdbHSqbnDleOBGO
        B45SUqh7sY6/N8DrEt0+hc+ezl/xKN0=
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 01/21] x86/insn: Rename insn_decode() to insn_decode_from_regs()
Date:   Wed, 24 Feb 2021 12:02:13 +0100
Message-Id: <20210224110233.19715-2-bp@alien8.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210224110233.19715-1-bp@alien8.de>
References: <20210224110233.19715-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Rename insn_decode() to insn_decode_from_regs() to denote that it
receives regs as param and uses registers from there during decoding.
Free the former name for a more generic version of the function.

No functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/include/asm/insn-eval.h | 4 ++--
 arch/x86/kernel/sev-es.c         | 2 +-
 arch/x86/kernel/umip.c           | 2 +-
 arch/x86/lib/insn-eval.c         | 6 +++---
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/insn-eval.h b/arch/x86/include/asm/insn-eval.h
index a0f839aa144d..c755f1a2618b 100644
--- a/arch/x86/include/asm/insn-eval.h
+++ b/arch/x86/include/asm/insn-eval.h
@@ -23,7 +23,7 @@ unsigned long insn_get_seg_base(struct pt_regs *regs, int seg_reg_idx);
 int insn_get_code_seg_params(struct pt_regs *regs);
 int insn_fetch_from_user(struct pt_regs *regs,
 			 unsigned char buf[MAX_INSN_SIZE]);
-bool insn_decode(struct insn *insn, struct pt_regs *regs,
-		 unsigned char buf[MAX_INSN_SIZE], int buf_size);
+bool insn_decode_from_regs(struct insn *insn, struct pt_regs *regs,
+			   unsigned char buf[MAX_INSN_SIZE], int buf_size);
 
 #endif /* _ASM_X86_INSN_EVAL_H */
diff --git a/arch/x86/kernel/sev-es.c b/arch/x86/kernel/sev-es.c
index 84c1821819af..248d14ae5602 100644
--- a/arch/x86/kernel/sev-es.c
+++ b/arch/x86/kernel/sev-es.c
@@ -256,7 +256,7 @@ static enum es_result vc_decode_insn(struct es_em_ctxt *ctxt)
 			return ES_EXCEPTION;
 		}
 
-		if (!insn_decode(&ctxt->insn, ctxt->regs, buffer, res))
+		if (!insn_decode_from_regs(&ctxt->insn, ctxt->regs, buffer, res))
 			return ES_DECODE_FAILED;
 	} else {
 		res = vc_fetch_insn_kernel(ctxt, buffer);
diff --git a/arch/x86/kernel/umip.c b/arch/x86/kernel/umip.c
index f6225bf22c02..8032f5f7eef9 100644
--- a/arch/x86/kernel/umip.c
+++ b/arch/x86/kernel/umip.c
@@ -356,7 +356,7 @@ bool fixup_umip_exception(struct pt_regs *regs)
 	if (!nr_copied)
 		return false;
 
-	if (!insn_decode(&insn, regs, buf, nr_copied))
+	if (!insn_decode_from_regs(&insn, regs, buf, nr_copied))
 		return false;
 
 	umip_inst = identify_insn(&insn);
diff --git a/arch/x86/lib/insn-eval.c b/arch/x86/lib/insn-eval.c
index 4229950a5d78..d0ebf9e93e35 100644
--- a/arch/x86/lib/insn-eval.c
+++ b/arch/x86/lib/insn-eval.c
@@ -1454,7 +1454,7 @@ int insn_fetch_from_user(struct pt_regs *regs, unsigned char buf[MAX_INSN_SIZE])
 }
 
 /**
- * insn_decode() - Decode an instruction
+ * insn_decode_from_regs() - Decode an instruction
  * @insn:	Structure to store decoded instruction
  * @regs:	Structure with register values as seen when entering kernel mode
  * @buf:	Buffer containing the instruction bytes
@@ -1467,8 +1467,8 @@ int insn_fetch_from_user(struct pt_regs *regs, unsigned char buf[MAX_INSN_SIZE])
  *
  * True if instruction was decoded, False otherwise.
  */
-bool insn_decode(struct insn *insn, struct pt_regs *regs,
-		 unsigned char buf[MAX_INSN_SIZE], int buf_size)
+bool insn_decode_from_regs(struct insn *insn, struct pt_regs *regs,
+			   unsigned char buf[MAX_INSN_SIZE], int buf_size)
 {
 	int seg_defs;
 
-- 
2.29.2

