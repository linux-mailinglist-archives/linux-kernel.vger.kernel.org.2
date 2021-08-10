Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9690D3E522F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 06:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236048AbhHJE3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 00:29:41 -0400
Received: from foss.arm.com ([217.140.110.172]:46678 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231794AbhHJE3j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 00:29:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 365FC6D;
        Mon,  9 Aug 2021 21:29:17 -0700 (PDT)
Received: from p8cg001049571a15.arm.com (unknown [10.163.67.89])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A9D663F70D;
        Mon,  9 Aug 2021 21:29:14 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64/mm: Define ID_AA64MMFR0_TGRAN_2_SHIFT
Date:   Tue, 10 Aug 2021 09:59:42 +0530
Message-Id: <1628569782-30213-1-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Streamline the Stage-2 TGRAN value extraction from ID_AA64MMFR0 register by
adding a page size agnostic ID_AA64MMFR0_TGRAN_2_SHIFT. This is similar to
the existing Stage-1 TGRAN shift i.e ID_AA64MMFR0_TGRAN_SHIFT.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: kvmarm@lists.cs.columbia.edu
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
This applies on v5.14-rc5.

 arch/arm64/include/asm/sysreg.h |  3 +++
 arch/arm64/kvm/reset.c          | 17 ++---------------
 2 files changed, 5 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 7b9c3acba684..943d31d92b5b 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -1028,14 +1028,17 @@
 
 #if defined(CONFIG_ARM64_4K_PAGES)
 #define ID_AA64MMFR0_TGRAN_SHIFT		ID_AA64MMFR0_TGRAN4_SHIFT
+#define ID_AA64MMFR0_TGRAN_2_SHIFT		ID_AA64MMFR0_TGRAN4_2_SHIFT
 #define ID_AA64MMFR0_TGRAN_SUPPORTED_MIN	ID_AA64MMFR0_TGRAN4_SUPPORTED
 #define ID_AA64MMFR0_TGRAN_SUPPORTED_MAX	0x7
 #elif defined(CONFIG_ARM64_16K_PAGES)
 #define ID_AA64MMFR0_TGRAN_SHIFT		ID_AA64MMFR0_TGRAN16_SHIFT
+#define ID_AA64MMFR0_TGRAN_2_SHIFT		ID_AA64MMFR0_TGRAN16_2_SHIFT
 #define ID_AA64MMFR0_TGRAN_SUPPORTED_MIN	ID_AA64MMFR0_TGRAN16_SUPPORTED
 #define ID_AA64MMFR0_TGRAN_SUPPORTED_MAX	0xF
 #elif defined(CONFIG_ARM64_64K_PAGES)
 #define ID_AA64MMFR0_TGRAN_SHIFT		ID_AA64MMFR0_TGRAN64_SHIFT
+#define ID_AA64MMFR0_TGRAN_2_SHIFT		ID_AA64MMFR0_TGRAN64_2_SHIFT
 #define ID_AA64MMFR0_TGRAN_SUPPORTED_MIN	ID_AA64MMFR0_TGRAN64_SUPPORTED
 #define ID_AA64MMFR0_TGRAN_SUPPORTED_MAX	0x7
 #endif
diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
index cba7872d69a8..20588220fe66 100644
--- a/arch/arm64/kvm/reset.c
+++ b/arch/arm64/kvm/reset.c
@@ -311,7 +311,7 @@ u32 get_kvm_ipa_limit(void)
 
 int kvm_set_ipa_limit(void)
 {
-	unsigned int parange, tgran_2;
+	unsigned int parange;
 	u64 mmfr0;
 
 	mmfr0 = read_sanitised_ftr_reg(SYS_ID_AA64MMFR0_EL1);
@@ -322,20 +322,7 @@ int kvm_set_ipa_limit(void)
 	 * Check with ARMv8.5-GTG that our PAGE_SIZE is supported at
 	 * Stage-2. If not, things will stop very quickly.
 	 */
-	switch (PAGE_SIZE) {
-	default:
-	case SZ_4K:
-		tgran_2 = ID_AA64MMFR0_TGRAN4_2_SHIFT;
-		break;
-	case SZ_16K:
-		tgran_2 = ID_AA64MMFR0_TGRAN16_2_SHIFT;
-		break;
-	case SZ_64K:
-		tgran_2 = ID_AA64MMFR0_TGRAN64_2_SHIFT;
-		break;
-	}
-
-	switch (cpuid_feature_extract_unsigned_field(mmfr0, tgran_2)) {
+	switch (cpuid_feature_extract_unsigned_field(mmfr0, ID_AA64MMFR0_TGRAN_2_SHIFT)) {
 	case ID_AA64MMFR0_TGRAN_2_SUPPORTED_NONE:
 		kvm_err("PAGE_SIZE not supported at Stage-2, giving up\n");
 		return -EINVAL;
-- 
2.20.1

