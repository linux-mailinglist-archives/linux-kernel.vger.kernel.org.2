Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2B5C379BC5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 02:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbhEKA5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 20:57:30 -0400
Received: from terminus.zytor.com ([198.137.202.136]:37761 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229980AbhEKA5I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 20:57:08 -0400
Received: from tazenda.hos.anvin.org ([IPv6:2601:646:8602:8be0:7285:c2ff:fefb:fd4])
        (authenticated bits=0)
        by mail.zytor.com (8.16.1/8.15.2) with ESMTPSA id 14B0tdw72504247
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 10 May 2021 17:55:49 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 14B0tdw72504247
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2021042801; t=1620694550;
        bh=b6Pm9Da93G0mktOYEh8EcyhbJDM2lkg5wM5WXiBhdNI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rcB5SuUCHDgtERvY7bJD/p5UE2Vpq4lD77CI8JAk3sXZuvyduuSn4cRIozXHoH1gv
         Z2o/RS+nKuViHw0Jf7vj964208LUZbzFT896zDVu9f4P0D4TCeX5G9aTD/Up9RoyR7
         qQ1nTTQVmCfJGY3uUKy1t8L/11KKv+3wi/I5Bk/MpmV75UtugJP6equQCdQl4TqjIQ
         dCFenuElH9ZRVVnBKkvck3qvBcXHl/Xp3K3MMGJVWNLrTkMdJ+QiRIdAJgKdZziEFN
         XuUDIZRjuo7naWzXPsjrlFPAovMguC/tYbYK7vjxPG6BSD0VGL4W4Nc8joLSe4k/FT
         asO+iIMI7Q/rg==
From:   "H. Peter Anvin" <hpa@zytor.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Steve Wahl <steve.wahl@hpe.com>, Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "H. Peter Anvin (Intel)" <hpa@zytor.com>
Subject: [PATCH 2/6] x86/irqvector: add NR_EXTERNAL_VECTORS and NR_SYSTEM_VECTORS
Date:   Mon, 10 May 2021 17:55:27 -0700
Message-Id: <20210511005531.1065536-3-hpa@zytor.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210511005531.1065536-1-hpa@zytor.com>
References: <20210511005531.1065536-1-hpa@zytor.com>
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

