Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B999D32D8DE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 18:48:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239800AbhCDRqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 12:46:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238755AbhCDRo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 12:44:58 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9CA1C061762
        for <linux-kernel@vger.kernel.org>; Thu,  4 Mar 2021 09:42:53 -0800 (PST)
Received: from zn.tnic (p200300ec2f0f5900f7833063514d8659.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:5900:f783:3063:514d:8659])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 832141EC0527;
        Thu,  4 Mar 2021 18:42:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1614879772;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aplTV+eFxD8flf1oCPlyMRQkeCaNyonvipSYOkFR2ws=;
        b=a0BA2olZfmgDxftGBmuas0rO475d3EmGso8qVmTnVwJNWrL5qVOYyg87fd18a5UBuloIzB
        avxRYhQQY7Cuv30hl2vOFk7kRPVQuTQkNLF0RXPfP2KIWqaU4mJjM4yuRoX0HFKrns4V8Q
        Ymlv+yjnP3YobSV8HjG97+ehY7dux0c=
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 05/21] x86/insn-eval: Handle return values from the decoder
Date:   Thu,  4 Mar 2021 18:42:21 +0100
Message-Id: <20210304174237.31945-6-bp@alien8.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210304174237.31945-1-bp@alien8.de>
References: <20210304174237.31945-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Now that the different instruction-inspecting functions return a value,
test that and return early from callers if error has been encountered.

While at it, do not call insn_get_modrm() when calling
insn_get_displacement() because latter will make sure to call
insn_get_modrm() if ModRM hasn't been parsed yet.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/lib/insn-eval.c | 34 +++++++++++++++++++++-------------
 1 file changed, 21 insertions(+), 13 deletions(-)

diff --git a/arch/x86/lib/insn-eval.c b/arch/x86/lib/insn-eval.c
index d0ebf9e93e35..1a6c191a38f8 100644
--- a/arch/x86/lib/insn-eval.c
+++ b/arch/x86/lib/insn-eval.c
@@ -928,10 +928,11 @@ static int get_seg_base_limit(struct insn *insn, struct pt_regs *regs,
 static int get_eff_addr_reg(struct insn *insn, struct pt_regs *regs,
 			    int *regoff, long *eff_addr)
 {
-	insn_get_modrm(insn);
+	int ret;
 
-	if (!insn->modrm.nbytes)
-		return -EINVAL;
+	ret = insn_get_modrm(insn);
+	if (ret)
+		return ret;
 
 	if (X86_MODRM_MOD(insn->modrm.value) != 3)
 		return -EINVAL;
@@ -977,14 +978,14 @@ static int get_eff_addr_modrm(struct insn *insn, struct pt_regs *regs,
 			      int *regoff, long *eff_addr)
 {
 	long tmp;
+	int ret;
 
 	if (insn->addr_bytes != 8 && insn->addr_bytes != 4)
 		return -EINVAL;
 
-	insn_get_modrm(insn);
-
-	if (!insn->modrm.nbytes)
-		return -EINVAL;
+	ret = insn_get_modrm(insn);
+	if (ret)
+		return ret;
 
 	if (X86_MODRM_MOD(insn->modrm.value) > 2)
 		return -EINVAL;
@@ -1106,18 +1107,21 @@ static int get_eff_addr_modrm_16(struct insn *insn, struct pt_regs *regs,
  * @base_offset will have a register, as an offset from the base of pt_regs,
  * that can be used to resolve the associated segment.
  *
- * -EINVAL on error.
+ * Negative value on error.
  */
 static int get_eff_addr_sib(struct insn *insn, struct pt_regs *regs,
 			    int *base_offset, long *eff_addr)
 {
 	long base, indx;
 	int indx_offset;
+	int ret;
 
 	if (insn->addr_bytes != 8 && insn->addr_bytes != 4)
 		return -EINVAL;
 
-	insn_get_modrm(insn);
+	ret = insn_get_modrm(insn);
+	if (ret)
+		return ret;
 
 	if (!insn->modrm.nbytes)
 		return -EINVAL;
@@ -1125,7 +1129,9 @@ static int get_eff_addr_sib(struct insn *insn, struct pt_regs *regs,
 	if (X86_MODRM_MOD(insn->modrm.value) > 2)
 		return -EINVAL;
 
-	insn_get_sib(insn);
+	ret = insn_get_sib(insn);
+	if (ret)
+		return ret;
 
 	if (!insn->sib.nbytes)
 		return -EINVAL;
@@ -1194,8 +1200,8 @@ static void __user *get_addr_ref_16(struct insn *insn, struct pt_regs *regs)
 	short eff_addr;
 	long tmp;
 
-	insn_get_modrm(insn);
-	insn_get_displacement(insn);
+	if (insn_get_displacement(insn))
+		goto out;
 
 	if (insn->addr_bytes != 2)
 		goto out;
@@ -1491,7 +1497,9 @@ bool insn_decode_from_regs(struct insn *insn, struct pt_regs *regs,
 	insn->addr_bytes = INSN_CODE_SEG_ADDR_SZ(seg_defs);
 	insn->opnd_bytes = INSN_CODE_SEG_OPND_SZ(seg_defs);
 
-	insn_get_length(insn);
+	if (insn_get_length(insn))
+		return false;
+
 	if (buf_size < insn->length)
 		return false;
 
-- 
2.29.2

