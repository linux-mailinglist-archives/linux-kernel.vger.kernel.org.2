Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3E6F34B96A
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Mar 2021 22:14:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbhC0VNs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Mar 2021 17:13:48 -0400
Received: from mx-out.tlen.pl ([193.222.135.158]:21542 "EHLO mx-out.tlen.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230015AbhC0VNf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Mar 2021 17:13:35 -0400
Received: (wp-smtpd smtp.tlen.pl 40850 invoked from network); 27 Mar 2021 22:13:32 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=o2.pl; s=1024a;
          t=1616879612; bh=6XmFuodXSwp/ahPWGzc07JUgMKXhdAiUWCGT3utXIz8=;
          h=From:To:Cc:Subject;
          b=VcwuxU4kkulEtKXK9k3zTge4AI8VbDODz8TlZ0g7+2ovjTU3RJ0kax9w7LR2dcbu3
           Sl+ismmdQSWH+PmN8H2O8Jl6BPgMq0S+6x5eQseOO2GBL0CDFxT8/+f3U0czl8z2gI
           8w81T/DS0AramsgYkEfYYB9mx3oRebDQxklJ4jgA=
Received: from aclp172.neoplus.adsl.tpnet.pl (HELO localhost.localdomain) (mat.jonczyk@o2.pl@[83.10.117.172])
          (envelope-sender <mat.jonczyk@o2.pl>)
          by smtp.tlen.pl (WP-SMTPD) with SMTP
          for <linux-kernel@vger.kernel.org>; 27 Mar 2021 22:13:32 +0100
From:   =?UTF-8?q?Mateusz=20Jo=C5=84czyk?= <mat.jonczyk@o2.pl>
To:     linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Mateusz=20Jo=C5=84czyk?= <mat.jonczyk@o2.pl>
Subject: Re: Testers wanted: Atom netbooks with x86_64 disabled by BIOS
Date:   Sat, 27 Mar 2021 22:13:22 +0100
Message-Id: <20210327211322.121708-1-mat.jonczyk@o2.pl>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210327203218.119372-1-mat.jonczyk@o2.pl>
References: <20210327203218.119372-1-mat.jonczyk@o2.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-WP-DKIM-Status: good (id: o2.pl)                                      
X-WP-MailID: 4154caa4a390fb312713de6c19cca6ab
X-WP-AV: skaner antywirusowy Poczty o2
X-WP-SPAM: NO 0000000 [kbOE]                               
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W dniu 27.03.2021 o 21:32, Mateusz Jończyk pisze:
> Hello,
>
> There are some netbooks with Intel Atom processors that have 64-bit
> support disabled by BIOS. Theoretically, the processor supports 64-bit
> operation, but BIOS allows only 32-bit code to run.
>
> I wonder whether the 64-bit mode is really disabled in the CPU or only
> hidden in the CPUID flags. If the latter, the computer could be made to
> run a 64-bit kernel.
>
> Similarly, there are some Pentium M processors that support PAE
> (Physical Address Extensions), but do not show this in CPUID. They could
> be made to run distributions that require PAE with the "forcepae" kernel
> command line parameter.
>
> I would like to ask people with such netbooks to try to run a 64-bit kernel
> with this patch applied.
>
> When a patched 64-bit kernel is run in `qemu-system-i386`, the virtual
> machine restarts instantly. Without this patch in such a case a 64-bit
> kernel hangs indefinitely (inside .Lno_longmode in head_64.S).

I have made two mistakes:
- I left commented out code,
- I have commented out lines with '#'. The code compiled though.

Attaching corrected patch, please excuse me.

Greetings,
Mateusz

Signed-off-by: Mateusz Jończyk <mat.jonczyk@o2.pl>

---
 arch/x86/boot/compressed/head_64.S | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index e94874f4bbc1..a9f0415da7c2 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -111,8 +111,6 @@ SYM_FUNC_START(startup_32)
 	leal	rva(boot_stack_end)(%ebp), %esp
 
 	call	verify_cpu
-	testl	%eax, %eax
-	jnz	.Lno_longmode
 
 /*
  * Compute the delta between where we were compiled to run at
-- 
2.25.1

