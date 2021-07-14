Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5602C3C7D99
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 06:45:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237815AbhGNEs2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 00:48:28 -0400
Received: from foss.arm.com ([217.140.110.172]:57140 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229451AbhGNEs0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 00:48:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 996491FB;
        Tue, 13 Jul 2021 21:45:35 -0700 (PDT)
Received: from p8cg001049571a15.arm.com (unknown [10.163.65.222])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A3C893F694;
        Tue, 13 Jul 2021 21:45:33 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        James Morse <james.morse@arm.com>, linux-kernel@vger.kernel.org
Subject: [PATCH V2] arm64/kexec: Test page size support with new TGRAN range values
Date:   Wed, 14 Jul 2021 10:16:15 +0530
Message-Id: <1626237975-1909-1-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit 26f55386f964 ("arm64/mm: Fix __enable_mmu() for new TGRAN range
values") had already switched into testing ID_AA64MMFR0_TGRAN range values.
This just changes system_supports_[4|16|64]kb_granule() helpers to perform
similar range tests as well. While here, it standardizes page size specific
supported min and max TGRAN values.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: James Morse <james.morse@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
This applies on 5.14-rc1.

Changes in V2

- Fixed typo in ID_AA64MMFR0_TGRAM64_SUPPORTED_MAX

Changes in V1

https://lore.kernel.org/lkml/1626058969-14847-1-git-send-email-anshuman.khandual@arm.com/

 arch/arm64/include/asm/cpufeature.h |  9 ++++++---
 arch/arm64/include/asm/sysreg.h     | 28 ++++++++++++++++------------
 2 files changed, 22 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index 9bb9d11750d7..2395527a1bba 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -657,7 +657,8 @@ static inline bool system_supports_4kb_granule(void)
 	val = cpuid_feature_extract_unsigned_field(mmfr0,
 						ID_AA64MMFR0_TGRAN4_SHIFT);
 
-	return val == ID_AA64MMFR0_TGRAN4_SUPPORTED;
+	return (val >= ID_AA64MMFR0_TGRAN4_SUPPORTED_MIN) &&
+	       (val <= ID_AA64MMFR0_TGRAN4_SUPPORTED_MAX);
 }
 
 static inline bool system_supports_64kb_granule(void)
@@ -669,7 +670,8 @@ static inline bool system_supports_64kb_granule(void)
 	val = cpuid_feature_extract_unsigned_field(mmfr0,
 						ID_AA64MMFR0_TGRAN64_SHIFT);
 
-	return val == ID_AA64MMFR0_TGRAN64_SUPPORTED;
+	return (val >= ID_AA64MMFR0_TGRAN64_SUPPORTED_MIN) &&
+	       (val <= ID_AA64MMFR0_TGRAN64_SUPPORTED_MAX);
 }
 
 static inline bool system_supports_16kb_granule(void)
@@ -681,7 +683,8 @@ static inline bool system_supports_16kb_granule(void)
 	val = cpuid_feature_extract_unsigned_field(mmfr0,
 						ID_AA64MMFR0_TGRAN16_SHIFT);
 
-	return val == ID_AA64MMFR0_TGRAN16_SUPPORTED;
+	return (val >= ID_AA64MMFR0_TGRAN16_SUPPORTED_MIN) &&
+	       (val <= ID_AA64MMFR0_TGRAN16_SUPPORTED_MAX);
 }
 
 static inline bool system_supports_mixed_endian_el0(void)
diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 7b9c3acba684..aa53954c2f6b 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -847,12 +847,16 @@
 #define ID_AA64MMFR0_ASID_SHIFT		4
 #define ID_AA64MMFR0_PARANGE_SHIFT	0
 
-#define ID_AA64MMFR0_TGRAN4_NI		0xf
-#define ID_AA64MMFR0_TGRAN4_SUPPORTED	0x0
-#define ID_AA64MMFR0_TGRAN64_NI		0xf
-#define ID_AA64MMFR0_TGRAN64_SUPPORTED	0x0
-#define ID_AA64MMFR0_TGRAN16_NI		0x0
-#define ID_AA64MMFR0_TGRAN16_SUPPORTED	0x1
+#define ID_AA64MMFR0_TGRAN4_NI			0xf
+#define ID_AA64MMFR0_TGRAN4_SUPPORTED_MIN	0x0
+#define ID_AA64MMFR0_TGRAN4_SUPPORTED_MAX	0x7
+#define ID_AA64MMFR0_TGRAN64_NI			0xf
+#define ID_AA64MMFR0_TGRAN64_SUPPORTED_MIN	0x0
+#define ID_AA64MMFR0_TGRAN64_SUPPORTED_MAX	0x7
+#define ID_AA64MMFR0_TGRAN16_NI			0x0
+#define ID_AA64MMFR0_TGRAN16_SUPPORTED_MIN	0x1
+#define ID_AA64MMFR0_TGRAN16_SUPPORTED_MAX	0xf
+
 #define ID_AA64MMFR0_PARANGE_48		0x5
 #define ID_AA64MMFR0_PARANGE_52		0x6
 
@@ -1028,16 +1032,16 @@
 
 #if defined(CONFIG_ARM64_4K_PAGES)
 #define ID_AA64MMFR0_TGRAN_SHIFT		ID_AA64MMFR0_TGRAN4_SHIFT
-#define ID_AA64MMFR0_TGRAN_SUPPORTED_MIN	ID_AA64MMFR0_TGRAN4_SUPPORTED
-#define ID_AA64MMFR0_TGRAN_SUPPORTED_MAX	0x7
+#define ID_AA64MMFR0_TGRAN_SUPPORTED_MIN	ID_AA64MMFR0_TGRAN4_SUPPORTED_MIN
+#define ID_AA64MMFR0_TGRAN_SUPPORTED_MAX	ID_AA64MMFR0_TGRAN4_SUPPORTED_MAX
 #elif defined(CONFIG_ARM64_16K_PAGES)
 #define ID_AA64MMFR0_TGRAN_SHIFT		ID_AA64MMFR0_TGRAN16_SHIFT
-#define ID_AA64MMFR0_TGRAN_SUPPORTED_MIN	ID_AA64MMFR0_TGRAN16_SUPPORTED
-#define ID_AA64MMFR0_TGRAN_SUPPORTED_MAX	0xF
+#define ID_AA64MMFR0_TGRAN_SUPPORTED_MIN	ID_AA64MMFR0_TGRAN16_SUPPORTED_MIN
+#define ID_AA64MMFR0_TGRAN_SUPPORTED_MAX	ID_AA64MMFR0_TGRAN16_SUPPORTED_MAX
 #elif defined(CONFIG_ARM64_64K_PAGES)
 #define ID_AA64MMFR0_TGRAN_SHIFT		ID_AA64MMFR0_TGRAN64_SHIFT
-#define ID_AA64MMFR0_TGRAN_SUPPORTED_MIN	ID_AA64MMFR0_TGRAN64_SUPPORTED
-#define ID_AA64MMFR0_TGRAN_SUPPORTED_MAX	0x7
+#define ID_AA64MMFR0_TGRAN_SUPPORTED_MIN	ID_AA64MMFR0_TGRAN64_SUPPORTED_MIN
+#define ID_AA64MMFR0_TGRAN_SUPPORTED_MAX	ID_AA64MMFR0_TGRAN64_SUPPORTED_MAX
 #endif
 
 #define MVFR2_FPMISC_SHIFT		4
-- 
2.20.1

