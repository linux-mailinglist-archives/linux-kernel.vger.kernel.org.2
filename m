Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D19CE440804
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Oct 2021 10:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231695AbhJ3ImU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Oct 2021 04:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbhJ3ImT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Oct 2021 04:42:19 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94A28C061570
        for <linux-kernel@vger.kernel.org>; Sat, 30 Oct 2021 01:39:49 -0700 (PDT)
Received: from zn.tnic (p200300ec2f27fc00f1e881fadada7ed4.dip0.t-ipconnect.de [IPv6:2003:ec:2f27:fc00:f1e8:81fa:dada:7ed4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6FAA41EC00F8;
        Sat, 30 Oct 2021 10:39:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1635583187;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=rjQe6IttM36rZ8Dwv63oGei+2vZNCpsH99TfoODDjrE=;
        b=IM0l96t32gTkGN/XNotwYlA0AQwn6W77dpPWSzAcDRYAOgbDCFqV/JTW6JyRfkKJmrWMB3
        qiyLiHXq983MKGK9SWp9phJSg9gvN4aMgs6/UPI47rcHpzn4KCl2XT/rXScKPOjeaLJFah
        OkWQvFPVizZZbAA1pWkqLWCNVwMNZ9A=
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] selftests/x86/iopl: Adjust to the faked iopl CLI/STI usage
Date:   Sat, 30 Oct 2021 10:39:39 +0200
Message-Id: <20211030083939.13073-1-bp@alien8.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Commit in Fixes changed the iopl emulation to not #GP on CLI and STI
because it would break some insane luserspace tools which would toggle
interrupts.

The corresponding selftest would rely on the fact that executing CLI/STI
would trigger a #GP and thus detect it this way but since that #GP is
not happening anymore, the detection is now wrong too.

Extend the test to actually look at the IF flag and whether executing
those insns had any effect on it. The STI detection needs to have the
fact that interrupts were previously disabled, passed in so do that from
the previous CLI test, i.e., STI test needs to follow a previous CLI one
for it to make sense.

Fixes: b968e84b509d ("x86/iopl: Fake iopl(3) CLI/STI usage")
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
---
 tools/testing/selftests/x86/iopl.c | 78 ++++++++++++++++++++++--------
 1 file changed, 58 insertions(+), 20 deletions(-)

diff --git a/tools/testing/selftests/x86/iopl.c b/tools/testing/selftests/x86/iopl.c
index bab2f6e06b63..7e3e09c1abac 100644
--- a/tools/testing/selftests/x86/iopl.c
+++ b/tools/testing/selftests/x86/iopl.c
@@ -85,48 +85,88 @@ static void expect_gp_outb(unsigned short port)
 	printf("[OK]\toutb to 0x%02hx failed\n", port);
 }
 
-static bool try_cli(void)
+#define RET_FAULTED	0
+#define RET_FAIL	1
+#define RET_EMUL	2
+
+static int try_cli(void)
 {
+	unsigned long flags;
+
 	sethandler(SIGSEGV, sigsegv, SA_RESETHAND);
 	if (sigsetjmp(jmpbuf, 1) != 0) {
-		return false;
+		return RET_FAULTED;
 	} else {
-		asm volatile ("cli");
-		return true;
+		asm volatile("cli; pushf; pop %[flags]"
+				: [flags] "=rm" (flags));
+
+		/* X86_FLAGS_IF */
+		if (!(flags & (1 << 9)))
+			return RET_FAIL;
+		else
+			return RET_EMUL;
 	}
 	clearhandler(SIGSEGV);
 }
 
-static bool try_sti(void)
+static int try_sti(bool irqs_off)
 {
+	unsigned long flags;
+
 	sethandler(SIGSEGV, sigsegv, SA_RESETHAND);
 	if (sigsetjmp(jmpbuf, 1) != 0) {
-		return false;
+		return RET_FAULTED;
 	} else {
-		asm volatile ("sti");
-		return true;
+		asm volatile("sti; pushf; pop %[flags]"
+				: [flags] "=rm" (flags));
+
+		/* X86_FLAGS_IF */
+		if (irqs_off && (flags & (1 << 9)))
+			return RET_FAIL;
+		else
+			return RET_EMUL;
 	}
 	clearhandler(SIGSEGV);
 }
 
-static void expect_gp_sti(void)
+static void expect_gp_sti(bool irqs_off)
 {
-	if (try_sti()) {
+	int ret = try_sti(irqs_off);
+
+	switch (ret) {
+	case RET_FAULTED:
+		printf("[OK]\tSTI faulted\n");
+		break;
+	case RET_EMUL:
+		printf("[OK]\tSTI NOPped\n");
+		break;
+	default:
 		printf("[FAIL]\tSTI worked\n");
 		nerrs++;
-	} else {
-		printf("[OK]\tSTI faulted\n");
 	}
 }
 
-static void expect_gp_cli(void)
+/*
+ * Returns whether it managed to disable interrupts.
+ */
+static bool test_cli(void)
 {
-	if (try_cli()) {
+	int ret = try_cli();
+
+	switch (ret) {
+	case RET_FAULTED:
+		printf("[OK]\tCLI faulted\n");
+		break;
+	case RET_EMUL:
+		printf("[OK]\tCLI NOPped\n");
+		break;
+	default:
 		printf("[FAIL]\tCLI worked\n");
 		nerrs++;
-	} else {
-		printf("[OK]\tCLI faulted\n");
+		return true;
 	}
+
+	return false;
 }
 
 int main(void)
@@ -152,8 +192,7 @@ int main(void)
 	}
 
 	/* Make sure that CLI/STI are blocked even with IOPL level 3 */
-	expect_gp_cli();
-	expect_gp_sti();
+	expect_gp_sti(test_cli());
 	expect_ok_outb(0x80);
 
 	/* Establish an I/O bitmap to test the restore */
@@ -204,8 +243,7 @@ int main(void)
 	printf("[RUN]\tparent: write to 0x80 (should fail)\n");
 
 	expect_gp_outb(0x80);
-	expect_gp_cli();
-	expect_gp_sti();
+	expect_gp_sti(test_cli());
 
 	/* Test the capability checks. */
 	printf("\tiopl(3)\n");
-- 
2.29.2

