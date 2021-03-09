Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B54E1332B78
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 17:07:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232053AbhCIQHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 11:07:05 -0500
Received: from mx2.suse.de ([195.135.220.15]:33364 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230495AbhCIQGd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 11:06:33 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1615305992; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yE5Leq5IeRX/BGMbx+e0U1ktiHL+YFJD+F5kGmaHXd0=;
        b=EwCIEbawx8JZXbWyvRDdft0L71brX1Fx+d/eZYuwgZItIq6G5aTUcSr2UVJrwlCkGFKXrm
        pYZ0uFkIF6aGMVsjGli9Q1bZ51U3C5zgCu/XaNKv4ki1lj4IDx6a5FOxErE/kI43Yk5vp9
        k+ZEUtvPFtuaXGTylCOasP4UGg38aPA=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 21C7AAF0C;
        Tue,  9 Mar 2021 16:06:32 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     xen-devel@lists.xenproject.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v6 14/12] x86/alternative: don't open code ALTERNATIVE_TERNARY() in _static_cpu_has()
Date:   Tue,  9 Mar 2021 17:06:21 +0100
Message-Id: <20210309160621.29290-2-jgross@suse.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210309160621.29290-1-jgross@suse.com>
References: <20210309134813.23912-1-jgross@suse.com>
 <20210309160621.29290-1-jgross@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

_static_cpu_has() contains a completely open coded version of
ALTERNATIVE_TERNARY(). Replace that with the macro instead.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/include/asm/cpufeature.h | 41 +++++++------------------------
 1 file changed, 9 insertions(+), 32 deletions(-)

diff --git a/arch/x86/include/asm/cpufeature.h b/arch/x86/include/asm/cpufeature.h
index 1728d4ce5730..16a51e7288d5 100644
--- a/arch/x86/include/asm/cpufeature.h
+++ b/arch/x86/include/asm/cpufeature.h
@@ -8,6 +8,7 @@
 
 #include <asm/asm.h>
 #include <linux/bitops.h>
+#include <asm/alternative.h>
 
 enum cpuid_leafs
 {
@@ -175,39 +176,15 @@ extern void clear_cpu_cap(struct cpuinfo_x86 *c, unsigned int bit);
  */
 static __always_inline bool _static_cpu_has(u16 bit)
 {
-	asm_volatile_goto("1: jmp 6f\n"
-		 "2:\n"
-		 ".skip -(((5f-4f) - (2b-1b)) > 0) * "
-			 "((5f-4f) - (2b-1b)),0x90\n"
-		 "3:\n"
-		 ".section .altinstructions,\"a\"\n"
-		 " .long 1b - .\n"		/* src offset */
-		 " .long 4f - .\n"		/* repl offset */
-		 " .word %P[always]\n"		/* always replace */
-		 " .byte 3b - 1b\n"		/* src len */
-		 " .byte 5f - 4f\n"		/* repl len */
-		 " .byte 3b - 2b\n"		/* pad len */
-		 ".previous\n"
-		 ".section .altinstr_replacement,\"ax\"\n"
-		 "4: jmp %l[t_no]\n"
-		 "5:\n"
-		 ".previous\n"
-		 ".section .altinstructions,\"a\"\n"
-		 " .long 1b - .\n"		/* src offset */
-		 " .long 0\n"			/* no replacement */
-		 " .word %P[feature]\n"		/* feature bit */
-		 " .byte 3b - 1b\n"		/* src len */
-		 " .byte 0\n"			/* repl len */
-		 " .byte 0\n"			/* pad len */
-		 ".previous\n"
-		 ".section .altinstr_aux,\"ax\"\n"
-		 "6:\n"
-		 " testb %[bitnum],%[cap_byte]\n"
-		 " jnz %l[t_yes]\n"
-		 " jmp %l[t_no]\n"
-		 ".previous\n"
+	asm_volatile_goto(
+		ALTERNATIVE_TERNARY("jmp 6f", %P[feature], "", "jmp %l[t_no]")
+		".section .altinstr_aux,\"ax\"\n"
+		"6:\n"
+		" testb %[bitnum],%[cap_byte]\n"
+		" jnz %l[t_yes]\n"
+		" jmp %l[t_no]\n"
+		".previous\n"
 		 : : [feature]  "i" (bit),
-		     [always]   "i" (X86_FEATURE_ALWAYS),
 		     [bitnum]   "i" (1 << (bit & 7)),
 		     [cap_byte] "m" (((const char *)boot_cpu_data.x86_capability)[bit >> 3])
 		 : : t_yes, t_no);
-- 
2.26.2

