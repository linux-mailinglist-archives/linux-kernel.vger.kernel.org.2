Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20F6844E4A3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 11:33:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234958AbhKLKfv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 05:35:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234675AbhKLKfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 05:35:50 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAF77C061766
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 02:32:59 -0800 (PST)
Received: from zn.tnic (p200300ec2f10ce005b16e04e289251c2.dip0.t-ipconnect.de [IPv6:2003:ec:2f10:ce00:5b16:e04e:2892:51c2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2A7051EC0554;
        Fri, 12 Nov 2021 11:32:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1636713178;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TP4zsIn4OL4QXFvxgHDCXWW5SKm2B+L24GmNzhK8bV0=;
        b=LN/S6E9JRPqPE/z+jhFlGR9oc2kBTF25YWD1tWWKV6s8RZhaoBYMG3SdmLVj/lvyj6Cal1
        W88rGc+y9NAkqi1IxhnoAgUiRcneJ99g7/vZDjZQJhn+t5TYjE2y0w+FEHYugeNI9ZA1o3
        o5kw2CVHjjF0scUueqW1wjwUsFzTyhw=
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/6] x86/cpu: Allow feature bit names from /proc/cpuinfo in clearcpuid=
Date:   Fri, 12 Nov 2021 11:32:41 +0100
Message-Id: <20211112103246.7555-2-bp@alien8.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211112103246.7555-1-bp@alien8.de>
References: <20211112103246.7555-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Having to give the X86_FEATURE array indices in order to disable a
feature bit for testing is not really user-friendly. So accept the
feature bit names too.

Some feature bits don't have names so there the array indices are still
accepted, of course.

Clearing CPUID flags is not something which should be done in production
so taint the kernel too.

An exemplary cmdline would then be something like:

clearcpuid=de,440,smca,succory,bmi1,3dnow ("succory" is wrong on
purpose).

and it says:

[    0.000000] Clearing CPUID bits: de 13:24 smca bmi1 3dnow

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 .../admin-guide/kernel-parameters.txt         | 11 ++--
 arch/x86/kernel/cpu/common.c                  | 51 ++++++++++++++-----
 2 files changed, 47 insertions(+), 15 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 0905d2cdb2d5..dadb09d30212 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -622,12 +622,17 @@
 			Defaults to zero when built as a module and to
 			10 seconds when built into the kernel.
 
-	clearcpuid=BITNUM[,BITNUM...] [X86]
+	clearcpuid=X[,X...] [X86]
 			Disable CPUID feature X for the kernel. See
 			arch/x86/include/asm/cpufeatures.h for the valid bit
-			numbers. Note the Linux specific bits are not necessarily
-			stable over kernel options, but the vendor specific
+			numbers X. Note the Linux-specific bits are not necessarily
+			stable over kernel options, but the vendor-specific
 			ones should be.
+			X can also be a string as appearing in the flags: line
+			in /proc/cpuinfo which does not have the above
+			instability issue. However, not all features have names
+			in /proc/cpuinfo.
+			Note that using this option will taint your kernel.
 			Also note that user programs calling CPUID directly
 			or using the feature without checking anything
 			will still see it. This just prevents it from
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 0083464de5e3..0d1cf5c65b0c 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1237,8 +1237,8 @@ static void detect_nopl(void)
 static void __init cpu_parse_early_param(void)
 {
 	char arg[128];
-	char *argptr = arg;
-	int arglen, res, bit;
+	char *argptr = arg, *opt;
+	int arglen, taint = 0;
 
 #ifdef CONFIG_X86_32
 	if (cmdline_find_option_bool(boot_command_line, "no387"))
@@ -1266,21 +1266,48 @@ static void __init cpu_parse_early_param(void)
 		return;
 
 	pr_info("Clearing CPUID bits:");
-	do {
-		res = get_option(&argptr, &bit);
-		if (res == 0 || res == 3)
-			break;
 
-		/* If the argument was too long, the last bit may be cut off */
-		if (res == 1 && arglen >= sizeof(arg))
-			break;
+	while (argptr) {
+		unsigned int bit;
 
-		if (bit >= 0 && bit < NCAPINTS * 32) {
-			pr_cont(" " X86_CAP_FMT, x86_cap_flag(bit));
+		opt = strsep(&argptr, ",");
+
+		/*
+		 * Handle naked numbers first for feature flags which don't
+		 * have names.
+		 */
+		if (!kstrtouint(opt, 10, &bit)) {
+			if (bit < NCAPINTS * 32) {
+				pr_cont(" " X86_CAP_FMT, x86_cap_flag(bit));
+				setup_clear_cpu_cap(bit);
+				taint++;
+			}
+			/*
+			 * The assumption is that there are no feature names with only
+			 * numbers in the name thus go to the next argument.
+			 */
+			continue;
+		}
+
+#ifdef CONFIG_X86_FEATURE_NAMES
+		for (bit = 0; bit < 32 * NCAPINTS; bit++) {
+			if (!x86_cap_flag(bit))
+				continue;
+
+			if (strcmp(x86_cap_flag(bit), opt))
+				continue;
+
+			pr_cont(" %s", opt);
 			setup_clear_cpu_cap(bit);
+			taint++;
+			break;
 		}
-	} while (res == 2);
+#endif
+	}
 	pr_cont("\n");
+
+	if (taint)
+		add_taint(TAINT_CPU_OUT_OF_SPEC, LOCKDEP_STILL_OK);
 }
 
 /*
-- 
2.29.2

