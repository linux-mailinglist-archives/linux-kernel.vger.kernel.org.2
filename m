Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2073844557E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 15:41:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231587AbhKDOni (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 10:43:38 -0400
Received: from mail.skyhub.de ([5.9.137.197]:49286 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231346AbhKDOn2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 10:43:28 -0400
Received: from zn.tnic (p200300ec2f0f2b00bdd517953c60a78f.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:2b00:bdd5:1795:3c60:a78f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C1BA81EC058A;
        Thu,  4 Nov 2021 15:40:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1636036849;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ewJd6xUYrozLS7QDg82Vu0ji7kfTYjcPyLl/RHif8YU=;
        b=Ec0JDhz73aix/2+MvBAdfDU/K41YBDHhwPR7P11KtNtWLkkiDgDf+Q0U7B6kh+eBl9b+Ju
        IcLYcTwYyd2WLCq6YDtR2H0TyEdzr6gkzsoyTCqMsK35B2Ct8yZJZCmPwMQlfd8YOsBMAr
        iG+Ec9u3Jz0cD/4mQNH9GGWCCKvIdBQ=
From:   Borislav Petkov <bp@alien8.de>
To:     Tony Luck <tony.luck@intel.com>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v0 06/12] x86/mce: Prevent severity computation from being instrumented
Date:   Thu,  4 Nov 2021 15:40:29 +0100
Message-Id: <20211104144035.20107-7-bp@alien8.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211104144035.20107-1-bp@alien8.de>
References: <20211104144035.20107-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Mark all the MCE severity computation logic noinstr and allow
instrumentation when it "calls out".

Fixes

  vmlinux.o: warning: objtool: do_machine_check()+0xc5d: call to mce_severity() leaves .noinstr.text section

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/kernel/cpu/mce/severity.c | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/severity.c b/arch/x86/kernel/cpu/mce/severity.c
index 00e97ebbd94a..03543765e9bf 100644
--- a/arch/x86/kernel/cpu/mce/severity.c
+++ b/arch/x86/kernel/cpu/mce/severity.c
@@ -263,24 +263,35 @@ static bool is_copy_from_user(struct pt_regs *regs)
  * distinguish an exception taken in user from from one
  * taken in the kernel.
  */
-static int error_context(struct mce *m, struct pt_regs *regs)
+static noinstr int error_context(struct mce *m, struct pt_regs *regs)
 {
+	int fixup_type;
+	bool copy_user;
+
 	if ((m->cs & 3) == 3)
 		return IN_USER;
+
 	if (!mc_recoverable(m->mcgstatus))
 		return IN_KERNEL;
 
-	switch (ex_get_fixup_type(m->ip)) {
+	instrumentation_begin();
+	fixup_type = ex_get_fixup_type(m->ip);
+	copy_user  = is_copy_from_user(regs);
+	instrumentation_end();
+
+	switch (fixup_type) {
 	case EX_TYPE_UACCESS:
 	case EX_TYPE_COPY:
-		if (!regs || !is_copy_from_user(regs))
+		if (!regs || !copy_user)
 			return IN_KERNEL;
 		m->kflags |= MCE_IN_KERNEL_COPYIN;
 		fallthrough;
+
 	case EX_TYPE_FAULT_MCE_SAFE:
 	case EX_TYPE_DEFAULT_MCE_SAFE:
 		m->kflags |= MCE_IN_KERNEL_RECOV;
 		return IN_KERNEL_RECOV;
+
 	default:
 		return IN_KERNEL;
 	}
@@ -315,8 +326,8 @@ static int mce_severity_amd_smca(struct mce *m, enum context err_ctx)
  * See AMD Error Scope Hierarchy table in a newer BKDG. For example
  * 49125_15h_Models_30h-3Fh_BKDG.pdf, section "RAS Features"
  */
-static int mce_severity_amd(struct mce *m, struct pt_regs *regs, int tolerant,
-			    char **msg, bool is_excp)
+static noinstr int mce_severity_amd(struct mce *m, struct pt_regs *regs, int tolerant,
+				    char **msg, bool is_excp)
 {
 	enum context ctx = error_context(m, regs);
 
@@ -368,8 +379,8 @@ static int mce_severity_amd(struct mce *m, struct pt_regs *regs, int tolerant,
 	return MCE_KEEP_SEVERITY;
 }
 
-static int mce_severity_intel(struct mce *m, struct pt_regs *regs,
-			      int tolerant, char **msg, bool is_excp)
+static noinstr int mce_severity_intel(struct mce *m, struct pt_regs *regs,
+				      int tolerant, char **msg, bool is_excp)
 {
 	enum exception excp = (is_excp ? EXCP_CONTEXT : NO_EXCP);
 	enum context ctx = error_context(m, regs);
@@ -405,8 +416,8 @@ static int mce_severity_intel(struct mce *m, struct pt_regs *regs,
 	}
 }
 
-int mce_severity(struct mce *m, struct pt_regs *regs, int tolerant, char **msg,
-		 bool is_excp)
+int noinstr mce_severity(struct mce *m, struct pt_regs *regs, int tolerant, char **msg,
+			 bool is_excp)
 {
 	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||
 	    boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)
-- 
2.29.2

