Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CDB434B95A
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Mar 2021 21:40:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbhC0UkA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Mar 2021 16:40:00 -0400
Received: from mx-out.tlen.pl ([193.222.135.145]:59884 "EHLO mx-out.tlen.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230002AbhC0Ujp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Mar 2021 16:39:45 -0400
X-Greylist: delayed 396 seconds by postgrey-1.27 at vger.kernel.org; Sat, 27 Mar 2021 16:39:45 EDT
Received: (wp-smtpd smtp.tlen.pl 4720 invoked from network); 27 Mar 2021 21:33:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=o2.pl; s=1024a;
          t=1616877184; bh=JuabIowwXjMlE1i/TVQ4jxLohpJBzzcBMU6nptsqkFo=;
          h=From:To:Cc:Subject;
          b=EXIWs+Q80PxXhQyGfJFZQsLp+Q5aidrONoqtDorKudjRNEN3mdKAzKHnfXkhlH/r6
           nbLgSdWMlThdiGg/mfh6qq5vU1DMc2UCxHRr+xo6qapccS1UxXHKzy2l/ZHVq4Uq+e
           crbGCwZjiruaz0jcMWSNbNz8oNPTV8Ar0Z+ZJFwI=
Received: from aclp172.neoplus.adsl.tpnet.pl (HELO localhost.localdomain) (mat.jonczyk@o2.pl@[83.10.117.172])
          (envelope-sender <mat.jonczyk@o2.pl>)
          by smtp.tlen.pl (WP-SMTPD) with SMTP
          for <linux-kernel@vger.kernel.org>; 27 Mar 2021 21:33:03 +0100
From:   =?UTF-8?q?Mateusz=20Jo=C5=84czyk?= <mat.jonczyk@o2.pl>
To:     linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Mateusz=20Jo=C5=84czyk?= <mat.jonczyk@o2.pl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org
Subject: Testers wanted: Atom netbooks with x86_64 disabled by BIOS
Date:   Sat, 27 Mar 2021 21:32:18 +0100
Message-Id: <20210327203218.119372-1-mat.jonczyk@o2.pl>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-WP-MailID: c87522c42fe7c5357912513f254d7fc5
X-WP-AV: skaner antywirusowy Poczty o2
X-WP-SPAM: NO 0000000 [gQPk]                               
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

There are some netbooks with Intel Atom processors that have 64-bit
support disabled by BIOS. Theoretically, the processor supports 64-bit
operation, but BIOS allows only 32-bit code to run.

I wonder whether the 64-bit mode is really disabled in the CPU or only
hidden in the CPUID flags. If the latter, the computer could be made to
run a 64-bit kernel.

Similarly, there are some Pentium M processors that support PAE
(Physical Address Extensions), but do not show this in CPUID. They could
be made to run distributions that require PAE with the "forcepae" kernel
command line parameter.

I would like to ask people with such netbooks to try to run a 64-bit kernel
with this patch applied.

When a patched 64-bit kernel is run in `qemu-system-i386`, the virtual
machine restarts instantly. Without this patch in such a case a 64-bit
kernel hangs indefinitely (inside .Lno_longmode in head_64.S).


CC: Thomas Gleixner <tglx@linutronix.de>
CC: Ingo Molnar <mingo@redhat.com>
CC: Borislav Petkov <bp@alien8.de>
CC: <x86@kernel.org>

Signed-off-by: Mateusz Jończyk <mat.jonczyk@o2.pl>

---
 arch/x86/boot/compressed/head_64.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index e94874f4bbc1..23c376d0b221 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -112,7 +112,7 @@ SYM_FUNC_START(startup_32)
 
 	call	verify_cpu
 	testl	%eax, %eax
-	jnz	.Lno_longmode
+	#jnz	.Lno_longmode
 
 /*
  * Compute the delta between where we were compiled to run at
-- 
2.25.1

