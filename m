Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 593C7323B11
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 12:12:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235062AbhBXLKM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 06:10:12 -0500
Received: from mail.skyhub.de ([5.9.137.197]:39790 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234911AbhBXLD2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 06:03:28 -0500
Received: from zn.tnic (p200300ec2f0d180081510bd8ee909965.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:1800:8151:bd8:ee90:9965])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D28201EC05B8;
        Wed, 24 Feb 2021 12:02:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1614164565;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SbXcvQtQlk37sTwBYKWjYuAsoKYQUBpZHjGeHDDyaHo=;
        b=DfP0rgjls9jJeAaVCgeienL2aWCLAxTcifvcClIS8txzUlaUq4A26ZOJv+lAp/Xk5VPvhV
        5oT0l4JemZjUpVbRVjgtxq4fj/tTUO7b75HTsd79P1EeOEV4DCMjn/bYJL/cZaxJk8HRa+
        Lmb0wVBzm18StN+q2b7G5t6NnAxphFk=
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 13/21] x86/sev-es: Convert to insn_decode()
Date:   Wed, 24 Feb 2021 12:02:25 +0100
Message-Id: <20210224110233.19715-14-bp@alien8.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210224110233.19715-1-bp@alien8.de>
References: <20210224110233.19715-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Simplify code, no functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/kernel/sev-es.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kernel/sev-es.c b/arch/x86/kernel/sev-es.c
index 6513e94d53f2..d2880a305772 100644
--- a/arch/x86/kernel/sev-es.c
+++ b/arch/x86/kernel/sev-es.c
@@ -244,7 +244,6 @@ static int vc_fetch_insn_kernel(struct es_em_ctxt *ctxt,
 static enum es_result __vc_decode_user_insn(struct es_em_ctxt *ctxt)
 {
 	char buffer[MAX_INSN_SIZE];
-	enum es_result ret;
 	int res;
 
 	res = insn_fetch_from_user(ctxt->regs, buffer);
@@ -258,16 +257,16 @@ static enum es_result __vc_decode_user_insn(struct es_em_ctxt *ctxt)
 	if (!insn_decode_from_regs(&ctxt->insn, ctxt->regs, buffer, res))
 		return ES_DECODE_FAILED;
 
-	ret = ctxt->insn.immediate.got ? ES_OK : ES_DECODE_FAILED;
-
-	return ret;
+	if (ctxt->insn.immediate.got)
+		return ES_OK;
+	else
+		return ES_DECODE_FAILED;
 }
 
 static enum es_result __vc_decode_kern_insn(struct es_em_ctxt *ctxt)
 {
 	char buffer[MAX_INSN_SIZE];
-	enum es_result ret;
-	int res;
+	int res, ret;
 
 	res = vc_fetch_insn_kernel(ctxt, buffer);
 	if (res) {
@@ -277,12 +276,11 @@ static enum es_result __vc_decode_kern_insn(struct es_em_ctxt *ctxt)
 		return ES_EXCEPTION;
 	}
 
-	insn_init(&ctxt->insn, buffer, MAX_INSN_SIZE - res, 1);
-	insn_get_length(&ctxt->insn);
-
-	ret = ctxt->insn.immediate.got ? ES_OK : ES_DECODE_FAILED;
-
-	return ret;
+	ret = insn_decode(&ctxt->insn, buffer, MAX_INSN_SIZE, INSN_MODE_64);
+	if (ret < 0)
+		return ES_DECODE_FAILED;
+	else
+		return ES_OK;
 }
 
 static enum es_result vc_decode_insn(struct es_em_ctxt *ctxt)
-- 
2.29.2

