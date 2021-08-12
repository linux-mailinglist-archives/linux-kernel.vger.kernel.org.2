Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86E8C3E9DC9
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 07:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234235AbhHLFJo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 01:09:44 -0400
Received: from foss.arm.com ([217.140.110.172]:37634 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229956AbhHLFJl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 01:09:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 01EE31063;
        Wed, 11 Aug 2021 22:09:17 -0700 (PDT)
Received: from p8cg001049571a15.arm.com (unknown [10.163.68.17])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 674963F40C;
        Wed, 11 Aug 2021 22:09:14 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 1/5] arm64/mm: Add remaining ID_AA64MMFR0_PARANGE_ macros
Date:   Thu, 12 Aug 2021 10:39:50 +0530
Message-Id: <1628744994-16623-2-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1628744994-16623-1-git-send-email-anshuman.khandual@arm.com>
References: <1628744994-16623-1-git-send-email-anshuman.khandual@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently there are macros only for 48 and 52 bits parange value extracted
from the ID_AA64MMFR0.PARANGE field. This change completes the enumeration
and updates the helper id_aa64mmfr0_parange_to_phys_shift(). While here it
also defines ARM64_MIN_PARANGE_BITS as the absolute minimum shift value PA
range which could be supported on a given platform.

Cc: Marc Zyngier <maz@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: kvmarm@lists.cs.columbia.edu
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/include/asm/cpufeature.h | 14 +++++++-------
 arch/arm64/include/asm/sysreg.h     |  7 +++++++
 2 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index 9bb9d11750d7..8633bdb21f33 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -781,13 +781,13 @@ extern int do_emulate_mrs(struct pt_regs *regs, u32 sys_reg, u32 rt);
 static inline u32 id_aa64mmfr0_parange_to_phys_shift(int parange)
 {
 	switch (parange) {
-	case 0: return 32;
-	case 1: return 36;
-	case 2: return 40;
-	case 3: return 42;
-	case 4: return 44;
-	case 5: return 48;
-	case 6: return 52;
+	case ID_AA64MMFR0_PARANGE_32: return 32;
+	case ID_AA64MMFR0_PARANGE_36: return 36;
+	case ID_AA64MMFR0_PARANGE_40: return 40;
+	case ID_AA64MMFR0_PARANGE_42: return 42;
+	case ID_AA64MMFR0_PARANGE_44: return 44;
+	case ID_AA64MMFR0_PARANGE_48: return 48;
+	case ID_AA64MMFR0_PARANGE_52: return 52;
 	/*
 	 * A future PE could use a value unknown to the kernel.
 	 * However, by the "D10.1.4 Principles of the ID scheme
diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 7b9c3acba684..504e909129ea 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -853,9 +853,16 @@
 #define ID_AA64MMFR0_TGRAN64_SUPPORTED	0x0
 #define ID_AA64MMFR0_TGRAN16_NI		0x0
 #define ID_AA64MMFR0_TGRAN16_SUPPORTED	0x1
+#define ID_AA64MMFR0_PARANGE_32		0x0
+#define ID_AA64MMFR0_PARANGE_36		0x1
+#define ID_AA64MMFR0_PARANGE_40		0x2
+#define ID_AA64MMFR0_PARANGE_42		0x3
+#define ID_AA64MMFR0_PARANGE_44		0x4
 #define ID_AA64MMFR0_PARANGE_48		0x5
 #define ID_AA64MMFR0_PARANGE_52		0x6
 
+#define ARM64_MIN_PARANGE_BITS		32
+
 #define ID_AA64MMFR0_TGRAN_2_SUPPORTED_DEFAULT	0x0
 #define ID_AA64MMFR0_TGRAN_2_SUPPORTED_NONE	0x1
 #define ID_AA64MMFR0_TGRAN_2_SUPPORTED_MIN	0x2
-- 
2.20.1

