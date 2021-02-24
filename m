Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14730323B15
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 12:12:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235093AbhBXLLy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 06:11:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234949AbhBXLEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 06:04:07 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A00C06178C
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 03:02:46 -0800 (PST)
Received: from zn.tnic (p200300ec2f0d180081510bd8ee909965.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:1800:8151:bd8:ee90:9965])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 194F41EC05B0;
        Wed, 24 Feb 2021 12:02:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1614164565;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y/oXYQntpQK73FEjvYCUnR5K5I6+/KmmfAaTMijdZ9c=;
        b=cdoyUCCQG+gF2qnHV50wUoDXgglvtQonC0VFP7VuWk0FvAyIfnSgdg46KD3dg1FRxuAfnY
        HOPjjPRK6KE/OyXF91l6Me6R5095RwvAnGUduQFH1mRcwf3pNHIy0MGgrf68LGS8hYuPC/
        ooEMSyUvWmKpyxLG+s/sVPpCK9OfVeg=
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 12/21] x86/sev-es: Split vc_decode_insn()
Date:   Wed, 24 Feb 2021 12:02:24 +0100
Message-Id: <20210224110233.19715-13-bp@alien8.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210224110233.19715-1-bp@alien8.de>
References: <20210224110233.19715-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Split it into two helpers - a user- and a kernel-mode one for
readability. Yes, the original function body is not that convoluted but
splitting it makes following through that code trivial than having to
pay attention to each little difference when in user or in kernel mode.

No functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/kernel/sev-es.c | 59 ++++++++++++++++++++++++++--------------
 1 file changed, 38 insertions(+), 21 deletions(-)

diff --git a/arch/x86/kernel/sev-es.c b/arch/x86/kernel/sev-es.c
index 248d14ae5602..6513e94d53f2 100644
--- a/arch/x86/kernel/sev-es.c
+++ b/arch/x86/kernel/sev-es.c
@@ -241,41 +241,58 @@ static int vc_fetch_insn_kernel(struct es_em_ctxt *ctxt,
 	return copy_from_kernel_nofault(buffer, (unsigned char *)ctxt->regs->ip, MAX_INSN_SIZE);
 }
 
-static enum es_result vc_decode_insn(struct es_em_ctxt *ctxt)
+static enum es_result __vc_decode_user_insn(struct es_em_ctxt *ctxt)
 {
 	char buffer[MAX_INSN_SIZE];
 	enum es_result ret;
 	int res;
 
-	if (user_mode(ctxt->regs)) {
-		res = insn_fetch_from_user(ctxt->regs, buffer);
-		if (!res) {
-			ctxt->fi.vector     = X86_TRAP_PF;
-			ctxt->fi.error_code = X86_PF_INSTR | X86_PF_USER;
-			ctxt->fi.cr2        = ctxt->regs->ip;
-			return ES_EXCEPTION;
-		}
+	res = insn_fetch_from_user(ctxt->regs, buffer);
+	if (!res) {
+		ctxt->fi.vector     = X86_TRAP_PF;
+		ctxt->fi.error_code = X86_PF_INSTR | X86_PF_USER;
+		ctxt->fi.cr2        = ctxt->regs->ip;
+		return ES_EXCEPTION;
+	}
 
-		if (!insn_decode_from_regs(&ctxt->insn, ctxt->regs, buffer, res))
-			return ES_DECODE_FAILED;
-	} else {
-		res = vc_fetch_insn_kernel(ctxt, buffer);
-		if (res) {
-			ctxt->fi.vector     = X86_TRAP_PF;
-			ctxt->fi.error_code = X86_PF_INSTR;
-			ctxt->fi.cr2        = ctxt->regs->ip;
-			return ES_EXCEPTION;
-		}
+	if (!insn_decode_from_regs(&ctxt->insn, ctxt->regs, buffer, res))
+		return ES_DECODE_FAILED;
+
+	ret = ctxt->insn.immediate.got ? ES_OK : ES_DECODE_FAILED;
+
+	return ret;
+}
 
-		insn_init(&ctxt->insn, buffer, MAX_INSN_SIZE - res, 1);
-		insn_get_length(&ctxt->insn);
+static enum es_result __vc_decode_kern_insn(struct es_em_ctxt *ctxt)
+{
+	char buffer[MAX_INSN_SIZE];
+	enum es_result ret;
+	int res;
+
+	res = vc_fetch_insn_kernel(ctxt, buffer);
+	if (res) {
+		ctxt->fi.vector     = X86_TRAP_PF;
+		ctxt->fi.error_code = X86_PF_INSTR;
+		ctxt->fi.cr2        = ctxt->regs->ip;
+		return ES_EXCEPTION;
 	}
 
+	insn_init(&ctxt->insn, buffer, MAX_INSN_SIZE - res, 1);
+	insn_get_length(&ctxt->insn);
+
 	ret = ctxt->insn.immediate.got ? ES_OK : ES_DECODE_FAILED;
 
 	return ret;
 }
 
+static enum es_result vc_decode_insn(struct es_em_ctxt *ctxt)
+{
+	if (user_mode(ctxt->regs))
+		return __vc_decode_user_insn(ctxt);
+	else
+		return __vc_decode_kern_insn(ctxt);
+}
+
 static enum es_result vc_write_mem(struct es_em_ctxt *ctxt,
 				   char *dst, char *buf, size_t size)
 {
-- 
2.29.2

