Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E939938DC62
	for <lists+linux-kernel@lfdr.de>; Sun, 23 May 2021 20:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231865AbhEWSPk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 May 2021 14:15:40 -0400
Received: from smtp.dei.uc.pt ([193.137.203.234]:41096 "EHLO smtp2.dei.uc.pt"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231821AbhEWSPj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 May 2021 14:15:39 -0400
X-Greylist: delayed 538 seconds by postgrey-1.27 at vger.kernel.org; Sun, 23 May 2021 14:15:38 EDT
Received: from localhost.localdomain (bl28-69-28.dsl.telepac.pt [37.189.69.28] (may be forged))
        (user=sneves@dei.uc.pt mech=LOGIN bits=0)
        by smtp2.dei.uc.pt (8.15.2/8.14.4) with ESMTPSA id 14NI4X41068721
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 23 May 2021 19:04:45 +0100
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.dei.uc.pt 14NI4X41068721
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dei.uc.pt;
        s=default; t=1621793086;
        bh=GUU3hb//nR6Qc7QutKFp1lrj9VWyHdSWs4XH0jxcF/g=;
        h=From:To:Cc:Subject:Date:From;
        b=Y1YCgVk2xb26zFXajgrKogN+lq0dc7mmdVjhhGww9AJWh7QDyYH6JGx6di+z7DD0P
         f63zROm6npHP8aAlBFxKnYVJwv7cPphsx4PJUsQO9/ZpO3mhVmz761Z+v97D4CaDuW
         O8uEO3qmLV9ez/N6SVb2BgSFD3QpjKsd37j+1/EE=
From:   Samuel Neves <sneves@dei.uc.pt>
To:     x86@kernel.org, ak@linux.intel.com, linux-kernel@vger.kernel.org
Cc:     Samuel Neves <sneves@dei.uc.pt>
Subject: [PATCH] x86/usercopy: speed up 64-bit __clear_user() with stos{b,q}
Date:   Sun, 23 May 2021 19:04:23 +0100
Message-Id: <20210523180423.108087-1-sneves@dei.uc.pt>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-FCTUC-DEI-SIC-MailScanner-Information: Please contact helpdesk@dei.uc.pt for more information
X-FCTUC-DEI-SIC-MailScanner-ID: 14NI4X41068721
X-FCTUC-DEI-SIC-MailScanner: Found to be clean
X-FCTUC-DEI-SIC-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
        score=-59.7, required 3.252, autolearn=not spam, ALL_TRUSTED -10.00,
        BAYES_00 -0.10, DKIM_SIGNED 0.10, L_SMTP_AUTH -50.00,
        T_DKIM_INVALID 0.30)
X-FCTUC-DEI-SIC-MailScanner-From: sneves@dei.uc.pt
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current 64-bit implementation of __clear_user consists of a simple loop
writing an 8-byte register per iteration. On typical x86_64 chips, this will
result in a rate of ~8 bytes per cycle.

On those same typical chips, much better is often possible, ranging from 16
to 32 to 64 bytes per cycle. Here we want to avoid bringing vector
instructions for this, but we can still achieve something close to those fill
rates using `rep stos{b,q}`. This is actually how it is already done in
usercopy_32.c.

This patch does precisely this. But because `rep stosb` can be slower for
short fills, I've retained the old loop for sizes below 256 bytes. This is a
somewhat arbitrary threshold; some documents say that `rep stosb` should be
faster after 128 bytes, whereas glibc puts the threshold at 2048 bytes (but
there it is competing against vector instructions). My measurements on
various (but not an exhaustive variety of) machines suggest this is a
reasonable threshold, but I could be mistaken.

It should also be mentioned that the existent code contains a bug. In the loop

    "0: movq $0,(%[dst])\n"
    "   addq   $8,%[dst]\n"
    "   decl %%ecx ; jnz   0b\n"

The `decl %%ecx` instruction truncates the register containing `size/8` to
32 bits, which means that calling __clear_user on a buffer longer than 32 GiB
would leave part of it unzeroed.

This change is noticeable from userspace. That is in fact how I spotted it; in
a hashing benchmark that read from /dev/zero, around 10-15% of the CPU time
was spent in __clear_user. After this patch, on a Skylake CPU, these are the
before/after figures:

$ dd if=/dev/zero of=/dev/null bs=1024k status=progress
94402248704 bytes (94 GB, 88 GiB) copied, 6 s, 15.7 GB/s

$ dd if=/dev/zero of=/dev/null bs=1024k status=progress
446476320768 bytes (446 GB, 416 GiB) copied, 15 s, 29.8 GB/s

The difference decreases when reading in smaller increments, but I have
observed no slowdowns.

Signed-off-by: Samuel Neves <sneves@dei.uc.pt>
---
 arch/x86/lib/usercopy_64.c | 59 +++++++++++++++++++++++++-------------
 1 file changed, 39 insertions(+), 20 deletions(-)

diff --git a/arch/x86/lib/usercopy_64.c b/arch/x86/lib/usercopy_64.c
index 508c81e97..af0f3089a 100644
--- a/arch/x86/lib/usercopy_64.c
+++ b/arch/x86/lib/usercopy_64.c
@@ -9,6 +9,7 @@
 #include <linux/export.h>
 #include <linux/uaccess.h>
 #include <linux/highmem.h>
+#include <asm/alternative.h>
 
 /*
  * Zero Userspace
@@ -16,33 +17,51 @@
 
 unsigned long __clear_user(void __user *addr, unsigned long size)
 {
-	long __d0;
+	long __d0, __d1;
 	might_fault();
 	/* no memory constraint because it doesn't change any memory gcc knows
 	   about */
 	stac();
 	asm volatile(
-		"	testq  %[size8],%[size8]\n"
-		"	jz     4f\n"
-		"	.align 16\n"
-		"0:	movq $0,(%[dst])\n"
-		"	addq   $8,%[dst]\n"
-		"	decl %%ecx ; jnz   0b\n"
-		"4:	movq  %[size1],%%rcx\n"
-		"	testl %%ecx,%%ecx\n"
-		"	jz     2f\n"
-		"1:	movb   $0,(%[dst])\n"
-		"	incq   %[dst]\n"
-		"	decl %%ecx ; jnz  1b\n"
-		"2:\n"
+		"	cmp    $256, %[size]\n"
+		"	jae    3f\n"  /* size >= 256 */
+		"	mov    %k[size], %k[aux]\n"
+		"	and    $7, %k[aux]\n"
+		"	shr    $3, %[size]\n"
+		"	jz     1f\n"  /* size < 8 */
+		".align 16\n"
+		"0:	movq   %%rax,(%[dst])\n"
+		"	add    $8,%[dst]\n"
+		"	dec    %[size]; jnz 0b\n"
+		"1:	mov    %k[aux],%k[size]\n"
+		"	test   %k[aux], %k[aux]\n"
+		"	jz     6f\n"
+		"2:	movb   %%al,(%[dst])\n"
+		"	inc    %[dst]\n"
+		"	dec    %k[size]; jnz 2b\n"
+		"	jmp	   6f\n"
+		"3:	\n"
+		ALTERNATIVE(
+			"mov   %k[size], %k[aux]\n"
+			"shr   $3, %[size]\n"
+			"and   $7, %k[aux]\n"
+			"4:    rep stosq\n"
+			"mov   %k[aux], %k[size]\n",
+			"",
+			X86_FEATURE_ERMS
+		)
+		"5: rep stosb\n"
+		"6:	\n"
 		".section .fixup,\"ax\"\n"
-		"3:	lea 0(%[size1],%[size8],8),%[size8]\n"
-		"	jmp 2b\n"
+		"7:	lea 0(%[aux],%[size],8),%[size]\n"
+		"	jmp    6b\n"
 		".previous\n"
-		_ASM_EXTABLE_UA(0b, 3b)
-		_ASM_EXTABLE_UA(1b, 2b)
-		: [size8] "=&c"(size), [dst] "=&D" (__d0)
-		: [size1] "r"(size & 7), "[size8]" (size / 8), "[dst]"(addr));
+		_ASM_EXTABLE_UA(0b, 7b)
+		_ASM_EXTABLE_UA(2b, 6b)
+		_ASM_EXTABLE_UA(4b, 7b)
+		_ASM_EXTABLE_UA(5b, 6b)
+		: [size] "=&c"(size), [dst] "=&D" (__d0), [aux] "=&r"(__d1)
+		: "[size]" (size), "[dst]"(addr), "a"(0));
 	clac();
 	return size;
 }
-- 
2.31.1

