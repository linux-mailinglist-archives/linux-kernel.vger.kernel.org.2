Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB9D340723B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 21:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233490AbhIJUBG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 16:01:06 -0400
Received: from terminus.zytor.com ([198.137.202.136]:56529 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232584AbhIJUAt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 16:00:49 -0400
Received: from tazenda.hos.anvin.org ([IPv6:2601:646:8600:3c70:7285:c2ff:fefb:fd4])
        (authenticated bits=0)
        by mail.zytor.com (8.16.1/8.15.2) with ESMTPSA id 18AJxIMh517265
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 10 Sep 2021 12:59:28 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 18AJxIMh517265
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2021083001; t=1631303968;
        bh=bV65ZcfF9kTXnHGSJPjzxAbKUtfMfSyoK78WNVAh7WM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q8EFWGYnjqRot6D6cP9SSTssqDCLMD9FkIFGPGUa+suug5HhYFdQjWDj0tTIlhMqA
         9YTjEFKBHQF14VfpjE/ZK2hDD9orO9vzGr1FtVqNRwpXCd7MoLMXWhHug9r9DQXxQa
         1GkeoBr1PPSK1B9JgjzWDPirz62YjohC7aS3uEFusdxr1pethbwGSE05awiDgrDOpz
         FVDnPIpg22aGzqE3ykHi6r5a6rpl/bZ3jSa7ku0S23ZjX0dTnJiwA8yBJxX/RydSrc
         SysSu16PCrcpZQJk+TkcKfFn+ht4pkqy947SCi437pH9qy75P124V7lnj06a4+x4lW
         ERcz0omTohsTA==
From:   "H. Peter Anvin (Intel)" <hpa@zytor.com>
To:     Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>
Cc:     x86 mailing list <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v3 2/2] x86/asm: avoid adding register pressure for the init case in static_cpu_has()
Date:   Fri, 10 Sep 2021 12:59:10 -0700
Message-Id: <20210910195910.2542662-4-hpa@zytor.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210910195910.2542662-1-hpa@zytor.com>
References: <20210908171716.3340120-1-hpa@zytor.com>
 <20210910195910.2542662-1-hpa@zytor.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "H. Peter Anvin" <hpa@zytor.com>

gcc will sometimes manifest the address of boot_cpu_data in a register
as part of constant propagation. When multiple static_cpu_has() are
used this may foul the mainline code with a register load which will
only be used on the fallback path, which is unused after
initialization.

Explicitly force gcc to use immediate (rip-relative) addressing for
the fallback path, thus removing any possible register use from
static_cpu_has().

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

