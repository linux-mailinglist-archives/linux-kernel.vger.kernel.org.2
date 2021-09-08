Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1B3D403E43
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 19:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352442AbhIHRS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 13:18:58 -0400
Received: from terminus.zytor.com ([198.137.202.136]:59317 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230217AbhIHRS5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 13:18:57 -0400
Received: from tazenda.hos.anvin.org ([IPv6:2601:646:8600:3c70:7285:c2ff:fefb:fd4])
        (authenticated bits=0)
        by mail.zytor.com (8.16.1/8.15.2) with ESMTPSA id 188HHQGV4133488
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 8 Sep 2021 10:17:37 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 188HHQGV4133488
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2021083001; t=1631121457;
        bh=+c97iHdGu2Ow8GnHPTGKXxAd8Rj1up2lNHoffmQQRHg=;
        h=From:To:Cc:Subject:Date:From;
        b=Kh9NjNB5WYTcSaV/cpFT7ZNRJfYHo2m1z2AoLCJbHfiLWZAAfAhwJKeghyIbXSpwC
         JvPjrrUkNc7q6BUd3YNLgCSU8dmQWuVnTpL4sRDf+2FWbf1ENHdFRCQWRwc16d5Jz2
         Fn+YcDF1MnaJKL7qbzdTbhJTyOzY26zL2cxDK4U+r/xFwzC0OAdHAF2Tour8NKSR1k
         U04KjQ8Nunc6gep2LLU5N/nDOB2AwziuwgvbqmtoD5G1Mupn/yOwpKu+C67PM/1sAi
         qKqj7Y2a8sbXVyXKZMt/JoqCoBLe/XpELqOC5g5CWjlKyRgz5QYjelrgLaWF21yS78
         kPlsWN1jplZoQ==
From:   "H. Peter Anvin (Intel)" <hpa@zytor.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "H. Peter Anvin (Intel)" <hpa@zytor.com>
Subject: [PATCH] x86/asm: pessimize the pre-initialization case in static_cpu_has()
Date:   Wed,  8 Sep 2021 10:17:16 -0700
Message-Id: <20210908171716.3340120-1-hpa@zytor.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gcc will sometimes manifest the address of boot_cpu_data in a register
as part of constant propagation. When multiple static_cpu_has() are
used this may foul the mainline code with a register load which will
only be used on the fallback path, which is unused after
initialization.

Explicitly force gcc to use immediate (rip-relative) addressing for
the fallback path, thus removing any possible register use from
static_cpu_has().

Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
---
 arch/x86/include/asm/cpufeature.h | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/cpufeature.h b/arch/x86/include/asm/cpufeature.h
index 16a51e7288d5..ff18906b60d8 100644
--- a/arch/x86/include/asm/cpufeature.h
+++ b/arch/x86/include/asm/cpufeature.h
@@ -173,20 +173,25 @@ extern void clear_cpu_cap(struct cpuinfo_x86 *c, unsigned int bit);
  * means that the boot_cpu_has() variant is already fast enough for the
  * majority of cases and you should stick to using it as it is generally
  * only two instructions: a RIP-relative MOV and a TEST.
+ *
+ * Do not use an "m" constraint for [cap_byte] here: gcc doesn't know
+ * that this is only used on a fallback path and will sometimes cause
+ * it to manifest the address of boot_cpu_data in a register, fouling
+ * the mainline (post-initialization) code.
  */
 static __always_inline bool _static_cpu_has(u16 bit)
 {
 	asm_volatile_goto(
 		ALTERNATIVE_TERNARY("jmp 6f", %P[feature], "", "jmp %l[t_no]")
-		".section .altinstr_aux,\"ax\"\n"
+		".pushsection .altinstr_aux,\"ax\"\n"
 		"6:\n"
-		" testb %[bitnum],%[cap_byte]\n"
+		" testb %[bitnum],%P[cap_byte]\n"
 		" jnz %l[t_yes]\n"
 		" jmp %l[t_no]\n"
-		".previous\n"
+		".popsection\n"
 		 : : [feature]  "i" (bit),
 		     [bitnum]   "i" (1 << (bit & 7)),
-		     [cap_byte] "m" (((const char *)boot_cpu_data.x86_capability)[bit >> 3])
+		     [cap_byte] "i" (&((const char *)boot_cpu_data.x86_capability)[bit >> 3])
 		 : : t_yes, t_no);
 t_yes:
 	return true;
-- 
2.31.1

