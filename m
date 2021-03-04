Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0D2A32D8D3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 18:48:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239485AbhCDRqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 12:46:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236481AbhCDRnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 12:43:32 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21135C06175F
        for <linux-kernel@vger.kernel.org>; Thu,  4 Mar 2021 09:42:52 -0800 (PST)
Received: from zn.tnic (p200300ec2f0f5900f7833063514d8659.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:5900:f783:3063:514d:8659])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1D5CA1EC04BF;
        Thu,  4 Mar 2021 18:42:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1614879769;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yM5O9OT2Se2RIhaKyVbUFCd9i3/WLOj3t1RLUDYv/n4=;
        b=TkA66tKnFDXbGLV3cvK2qZyai3BaO4K3c83XEHLeEnFJVvNrTSxcsUc6t6GYtq2UpKZZXN
        c67X9lDW15AwjDfRY0tY+b8/d7INYlh3kTWFhIzVQORKnAL/8Ix3tw6fZzRNO4cxRgplTM
        X/bv4L+U7atGdlg+8v/VoA5m4xcLLmg=
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 01/21] x86/insn: Rename insn_decode() to insn_decode_from_regs()
Date:   Thu,  4 Mar 2021 18:42:17 +0100
Message-Id: <20210304174237.31945-2-bp@alien8.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210304174237.31945-1-bp@alien8.de>
References: <20210304174237.31945-1-bp@alien8.de>
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
index 1e78f4bd7bf2..557386ce6e3b 100644
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

