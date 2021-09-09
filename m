Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49A58405F3E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 00:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344293AbhIIWKA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 18:10:00 -0400
Received: from terminus.zytor.com ([198.137.202.136]:33889 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343850AbhIIWJ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 18:09:58 -0400
Received: from tazenda.hos.anvin.org ([IPv6:2601:646:8600:3c70:7285:c2ff:fefb:fd4])
        (authenticated bits=0)
        by mail.zytor.com (8.16.1/8.15.2) with ESMTPSA id 189M8Rx3240627
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 9 Sep 2021 15:08:40 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 189M8Rx3240627
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2021083001; t=1631225321;
        bh=pZndsSVfn7uTOG7pzXGi+jsIJmC1XgD7p0ciVR6KQKM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BFFKidtPE2+SrIVxKxdiLxrgNP5eVCkd7io0nBvIWG+mPXV3FqE8LsuE7qCJ3H7Xc
         yRQgSDZC2NqK2c/sVId2D12J4l8T2gcShCIXl3AOz0V6csNEqasJolsFcIGroEkJ7x
         IzRrbkSkRCrJsr+hNvSXH4sD/yQS1i6f+PzJBZFodu1do/DBr1NuB5/10qqn147NpU
         UUauxAhBN9gka70rCS1gaoD+aGrZnJGgDDdtoCHVZ/Ja2/D4XhpTfsmkOEUT+XhJuS
         9vjF39P1zxiE/b0r4orcIo2Aj2dkjhL9eTYiXScSGEyghB3NW2FovP0CRsck4hFMtO
         ehImQWJHWuQ3A==
From:   "H. Peter Anvin (Intel)" <hpa@zytor.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        x86@kernel.org, "H. Peter Anvin (Intel)" <hpa@zytor.com>
Subject: [PATCH v2 2/2] x86/asm: pessimize the pre-initialization case in static_cpu_has()
Date:   Thu,  9 Sep 2021 15:08:18 -0700
Message-Id: <20210909220818.417312-3-hpa@zytor.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210909220818.417312-1-hpa@zytor.com>
References: <20210908171716.3340120-1-hpa@zytor.com>
 <20210909220818.417312-1-hpa@zytor.com>
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

Explicitly force gcc to use immediate (rip-relative on x86-64)
addressing for the fallback path, thus removing any possible register
use from static_cpu_has().

While making changes, modernize the code to use
.pushsection...popsection instead of .section...previous.

Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
---
 arch/x86/include/asm/cpufeature.h | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/cpufeature.h b/arch/x86/include/asm/cpufeature.h
index 16a51e7288d5..1261842d006c 100644
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
+		" testb %[bitnum]," _ASM_RIP(%P[cap_byte]) "\n"
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

