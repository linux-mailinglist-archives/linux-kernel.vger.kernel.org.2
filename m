Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D3D8445582
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 15:41:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231700AbhKDOnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 10:43:47 -0400
Received: from mail.skyhub.de ([5.9.137.197]:49286 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231402AbhKDOnb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 10:43:31 -0400
Received: from zn.tnic (p200300ec2f0f2b00bdd517953c60a78f.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:2b00:bdd5:1795:3c60:a78f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1E38F1EC0587;
        Thu,  4 Nov 2021 15:40:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1636036853;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+VcBvBeMaXnwlIMk+3o/pwLv3UEWJJA53DeSvk4bEPw=;
        b=G4SozZNqnGhw2nV7YHQ8KTccfzWcBgUxpHJvV9SwP8l1ODYcpMLSxL9K4U3NNJQva8Cnss
        LCGffMGteD/E7G3lTFiQNk7AflMWwkWiP/sFtj71EAp2TfR9zN68EooJ3LPPAA0BekHqm7
        tCoHh2yaf+2UXKnyg0SWIUDw0uju+pY=
From:   Borislav Petkov <bp@alien8.de>
To:     Tony Luck <tony.luck@intel.com>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v0 10/12] x86/mce: Move the tainting outside of the noinstr region
Date:   Thu,  4 Nov 2021 15:40:33 +0100
Message-Id: <20211104144035.20107-11-bp@alien8.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211104144035.20107-1-bp@alien8.de>
References: <20211104144035.20107-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

add_taint() is yet another external facility which the #MC handler
calls. Move that tainting call into the instrumentation-allowed part of
the handler.

Fixes

  vmlinux.o: warning: objtool: do_machine_check()+0x617: call to add_taint() leaves .noinstr.text section

While at it, drop noinstr tracking around mce_log().

Fixes

  vmlinux.o: warning: objtool: do_machine_check()+0x690: call to mce_log() leaves .noinstr.text section

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/kernel/cpu/mce/core.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index e31df79f87c7..961f80a4bd6f 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1175,13 +1175,14 @@ static noinstr bool mce_check_crashing_cpu(void)
 	return false;
 }
 
-static void __mc_scan_banks(struct mce *m, struct pt_regs *regs, struct mce *final,
-			    unsigned long *toclear, unsigned long *valid_banks,
-			    int no_way_out, int *worst)
+static __always_inline int
+__mc_scan_banks(struct mce *m, struct pt_regs *regs, struct mce *final,
+		unsigned long *toclear, unsigned long *valid_banks, int no_way_out,
+		int *worst)
 {
 	struct mce_bank *mce_banks = this_cpu_ptr(mce_banks_array);
 	struct mca_config *cfg = &mca_cfg;
-	int severity, i;
+	int severity, i, taint = 0;
 
 	for (i = 0; i < this_cpu_read(mce_num_banks); i++) {
 		__clear_bit(i, toclear);
@@ -1208,7 +1209,7 @@ static void __mc_scan_banks(struct mce *m, struct pt_regs *regs, struct mce *fin
 			continue;
 
 		/* Set taint even when machine check was not enabled. */
-		add_taint(TAINT_MACHINE_CHECK, LOCKDEP_NOW_UNRELIABLE);
+		taint++;
 
 		severity = mce_severity(m, regs, cfg->tolerant, NULL, true);
 
@@ -1231,7 +1232,9 @@ static void __mc_scan_banks(struct mce *m, struct pt_regs *regs, struct mce *fin
 		/* assuming valid severity level != 0 */
 		m->severity = severity;
 
+		instrumentation_begin();
 		mce_log(m);
+		instrumentation_end();
 
 		if (severity > *worst) {
 			*final = *m;
@@ -1241,6 +1244,8 @@ static void __mc_scan_banks(struct mce *m, struct pt_regs *regs, struct mce *fin
 
 	/* mce_clear_state will clear *final, save locally for use later */
 	*m = *final;
+
+	return taint;
 }
 
 static void kill_me_now(struct callback_head *ch)
@@ -1349,7 +1354,7 @@ static noinstr void unexpected_machine_check(struct pt_regs *regs)
  */
 noinstr void do_machine_check(struct pt_regs *regs)
 {
-	int worst = 0, order, no_way_out, kill_current_task, lmce;
+	int worst = 0, order, no_way_out, kill_current_task, lmce, taint = 0;
 	DECLARE_BITMAP(valid_banks, MAX_NR_BANKS) = { 0 };
 	DECLARE_BITMAP(toclear, MAX_NR_BANKS) = { 0 };
 	struct mca_config *cfg = &mca_cfg;
@@ -1428,7 +1433,7 @@ noinstr void do_machine_check(struct pt_regs *regs)
 		order = mce_start(&no_way_out);
 	}
 
-	__mc_scan_banks(&m, regs, final, toclear, valid_banks, no_way_out, &worst);
+	taint = __mc_scan_banks(&m, regs, final, toclear, valid_banks, no_way_out, &worst);
 
 	if (!no_way_out)
 		mce_clear_state(toclear);
@@ -1460,11 +1465,14 @@ noinstr void do_machine_check(struct pt_regs *regs)
 		}
 	}
 
+	instrumentation_begin();
+
+	if (taint)
+		add_taint(TAINT_MACHINE_CHECK, LOCKDEP_NOW_UNRELIABLE);
+
 	if (worst != MCE_AR_SEVERITY && !kill_current_task)
 		goto out;
 
-	instrumentation_begin();
-
 	/* Fault was in user mode and we need to take some action */
 	if ((m.cs & 3) == 3) {
 		/* If this triggers there is no way to recover. Die hard. */
@@ -1494,9 +1502,9 @@ noinstr void do_machine_check(struct pt_regs *regs)
 			queue_task_work(&m, msg, kill_me_never);
 	}
 
+out:
 	instrumentation_end();
 
-out:
 	mce_wrmsrl(MSR_IA32_MCG_STATUS, 0);
 }
 EXPORT_SYMBOL_GPL(do_machine_check);
-- 
2.29.2

