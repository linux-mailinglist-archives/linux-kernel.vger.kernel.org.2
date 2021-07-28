Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D778D3D8B09
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 11:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235680AbhG1Jp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 05:45:28 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:54942 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S235506AbhG1Jp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 05:45:28 -0400
X-UUID: 03e47096485a4158aa523bb59784f8bd-20210728
X-UUID: 03e47096485a4158aa523bb59784f8bd-20210728
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <yee.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 362949387; Wed, 28 Jul 2021 17:45:22 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 28 Jul 2021 17:45:21 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 28 Jul 2021 17:45:21 +0800
From:   <yee.lee@mediatek.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <nicholas.Tang@mediatek.com>, <Kuan-Ying.lee@mediatek.com>,
        <chinwen.chang@mediatek.com>, Yee Lee <yee.lee@mediatek.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        David Brazdil <dbrazdil@google.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        Quentin Perret <qperret@google.com>,
        Andrew Scull <ascull@google.com>,
        James Morse <james.morse@arm.com>,
        Fuad Tabba <tabba@google.com>,
        "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH 1/1] arm64/cpufeature: Add option to disable mte support
Date:   Wed, 28 Jul 2021 17:42:58 +0800
Message-ID: <20210728094302.9949-2-yee.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210728094302.9949-1-yee.lee@mediatek.com>
References: <20210728094302.9949-1-yee.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yee Lee <yee.lee@mediatek.com>

Add a static key to exapnd the logic of system_supports_mte().
This function controls mte enablement in both EL1 and EL0.

The static key, "arm64_mte_support" is default true and can
be disabled via the early_param.

Signed-off-by: Yee Lee <yee.lee@mediatek.com>
---
 arch/arm64/include/asm/cpufeature.h |  4 +++-
 arch/arm64/kernel/cpufeature.c      | 13 +++++++++++++
 arch/arm64/kernel/image-vars.h      |  3 +++
 3 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index 9bb9d11750d7..0e5c82f2e012 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -420,6 +420,7 @@ static __always_inline bool is_hyp_code(void)
 extern DECLARE_BITMAP(cpu_hwcaps, ARM64_NCAPS);
 extern struct static_key_false cpu_hwcap_keys[ARM64_NCAPS];
 extern struct static_key_false arm64_const_caps_ready;
+extern struct static_key_true arm64_mte_support;
 
 /* ARM64 CAPS + alternative_cb */
 #define ARM64_NPATCHABLE (ARM64_NCAPS + 1)
@@ -756,7 +757,8 @@ static __always_inline bool system_uses_irq_prio_masking(void)
 static inline bool system_supports_mte(void)
 {
 	return IS_ENABLED(CONFIG_ARM64_MTE) &&
-		cpus_have_const_cap(ARM64_MTE);
+		cpus_have_const_cap(ARM64_MTE) &&
+		static_branch_likely(&arm64_mte_support);
 }
 
 static inline bool system_has_prio_mask_debugging(void)
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 0ead8bfedf20..b1602ad3d7c0 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1840,9 +1840,22 @@ static void bti_enable(const struct arm64_cpu_capabilities *__unused)
 }
 #endif /* CONFIG_ARM64_BTI */
 
+DEFINE_STATIC_KEY_TRUE(arm64_mte_support);
+EXPORT_SYMBOL(arm64_mte_support);
 #ifdef CONFIG_ARM64_MTE
+static int __init disable_arm64_mte_support(char *str)
+{
+	static_branch_disable(&arm64_mte_support);
+	return 0;
+}
+early_param("arm64_mte_not_support", disable_arm64_mte_support);
+
 static void cpu_enable_mte(struct arm64_cpu_capabilities const *cap)
 {
+	if(!system_supports_mte()){
+		pr_info("MTE is disabled since system does not support.\n");
+		return ;
+	}
 	/*
 	 * Clear the tags in the zero page. This needs to be done via the
 	 * linear map which has the Tagged attribute.
diff --git a/arch/arm64/kernel/image-vars.h b/arch/arm64/kernel/image-vars.h
index c96a9a0043bf..04cf30ec84e7 100644
--- a/arch/arm64/kernel/image-vars.h
+++ b/arch/arm64/kernel/image-vars.h
@@ -83,6 +83,9 @@ KVM_NVHE_ALIAS(__icache_flags);
 KVM_NVHE_ALIAS(arm64_const_caps_ready);
 KVM_NVHE_ALIAS(cpu_hwcap_keys);
 
+/* Static key which indicates if system supports mte */
+KVM_NVHE_ALIAS(arm64_mte_support);
+
 /* Static keys which are set if a vGIC trap should be handled in hyp. */
 KVM_NVHE_ALIAS(vgic_v2_cpuif_trap);
 KVM_NVHE_ALIAS(vgic_v3_cpuif_trap);
-- 
2.18.0

