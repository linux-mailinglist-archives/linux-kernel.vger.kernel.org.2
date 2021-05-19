Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 198D0389887
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 23:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbhESVXp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 17:23:45 -0400
Received: from terminus.zytor.com ([198.137.202.136]:52011 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229448AbhESVXm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 17:23:42 -0400
Received: from tazenda.hos.anvin.org ([IPv6:2601:646:8602:8be0:7285:c2ff:fefb:fd4])
        (authenticated bits=0)
        by mail.zytor.com (8.16.1/8.15.2) with ESMTPSA id 14JLM1Ea4187848
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 19 May 2021 14:22:10 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 14JLM1Ea4187848
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2021042801; t=1621459330;
        bh=33Yokt1dzuDHwHzUr9sb9/in/l76kiXG+5MekBOVROM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aAbGbYwYncQHSq/YcL8DuVItAau0TIbiIUhPlB2DutOii+n1kRc9jQLu1YhAs6o8W
         8T35fE773TsQzrDSxhdCNFEqXbg51F6+M2WbonSqeBvrqS21UZMXedkKSwDKcDY/09
         m+Wuy91M/5DEurzoNP/tJyvtjDViEPEw+OnqJcV5WLwJjF8HaJLalkzACv8Of/6e85
         dM0PljcX7qwcGQ5FI/dPPuIzeVnwMmAfULbi2ojdX5he+0qMJu1J/xiTdJ4oAOEIDI
         ZJq+8KiJvgTr2iz7dY4sRdCqvUh1LYtLQ0kTiXaqDYgCmf+K2kTEcwovAZMRcwKxlh
         LyBvDFJtH7lkg==
From:   "H. Peter Anvin" <hpa@zytor.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 2/8] x86/irqvector: add NR_EXTERNAL_VECTORS and NR_SYSTEM_VECTORS
Date:   Wed, 19 May 2021 14:21:48 -0700
Message-Id: <20210519212154.511983-3-hpa@zytor.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210519212154.511983-1-hpa@zytor.com>
References: <20210519212154.511983-1-hpa@zytor.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "H. Peter Anvin (Intel)" <hpa@zytor.com>

Add defines for the number of external vectors and number of system
vectors instead of requiring the use of (FIRST_SYSTEM_VECTOR -
FIRST_EXTERNAL_VECTOR) and (NR_VECTORS - FIRST_SYSTEM_VECTOR)
respectively.

Acked-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
---
 arch/x86/include/asm/idtentry.h          | 4 ++--
 arch/x86/include/asm/irq_vectors.h       | 3 +++
 tools/arch/x86/include/asm/irq_vectors.h | 3 +++
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index 73d45b0dfff2..c03a18cac78e 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -504,7 +504,7 @@ __visible noinstr void func(struct pt_regs *regs,			\
 	.align 8
 SYM_CODE_START(irq_entries_start)
     vector=FIRST_EXTERNAL_VECTOR
-    .rept (FIRST_SYSTEM_VECTOR - FIRST_EXTERNAL_VECTOR)
+    .rept NR_EXTERNAL_VECTORS
 	UNWIND_HINT_IRET_REGS
 0 :
 	.byte	0x6a, vector
@@ -520,7 +520,7 @@ SYM_CODE_END(irq_entries_start)
 	.align 8
 SYM_CODE_START(spurious_entries_start)
     vector=FIRST_SYSTEM_VECTOR
-    .rept (NR_VECTORS - FIRST_SYSTEM_VECTOR)
+    .rept NR_SYSTEM_VECTORS
 	UNWIND_HINT_IRET_REGS
 0 :
 	.byte	0x6a, vector
diff --git a/arch/x86/include/asm/irq_vectors.h b/arch/x86/include/asm/irq_vectors.h
index 889f8b1b5b7f..d2ef35927770 100644
--- a/arch/x86/include/asm/irq_vectors.h
+++ b/arch/x86/include/asm/irq_vectors.h
@@ -114,6 +114,9 @@
 #define FIRST_SYSTEM_VECTOR		NR_VECTORS
 #endif
 
+#define NR_EXTERNAL_VECTORS		(FIRST_SYSTEM_VECTOR - FIRST_EXTERNAL_VECTOR)
+#define NR_SYSTEM_VECTORS		(NR_VECTORS - FIRST_SYSTEM_VECTOR)
+
 /*
  * Size the maximum number of interrupts.
  *
diff --git a/tools/arch/x86/include/asm/irq_vectors.h b/tools/arch/x86/include/asm/irq_vectors.h
index 889f8b1b5b7f..d2ef35927770 100644
--- a/tools/arch/x86/include/asm/irq_vectors.h
+++ b/tools/arch/x86/include/asm/irq_vectors.h
@@ -114,6 +114,9 @@
 #define FIRST_SYSTEM_VECTOR		NR_VECTORS
 #endif
 
+#define NR_EXTERNAL_VECTORS		(FIRST_SYSTEM_VECTOR - FIRST_EXTERNAL_VECTOR)
+#define NR_SYSTEM_VECTORS		(NR_VECTORS - FIRST_SYSTEM_VECTOR)
+
 /*
  * Size the maximum number of interrupts.
  *
-- 
2.31.1

