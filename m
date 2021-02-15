Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAD0531B90D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 13:22:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbhBOMVH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 07:21:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbhBOMTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 07:19:05 -0500
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CE13C06178B;
        Mon, 15 Feb 2021 04:18:14 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: hector@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id D55664249E;
        Mon, 15 Feb 2021 12:18:08 +0000 (UTC)
From:   Hector Martin <marcan@marcan.st>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Hector Martin <marcan@marcan.st>, Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Tony Lindgren <tony@atomide.com>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Stan Skowronek <stan@corellium.com>,
        Alexander Graf <graf@amazon.com>,
        Will Deacon <will@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 07/25] arm64: cpufeature: Add a feature for FIQ support
Date:   Mon, 15 Feb 2021 21:16:55 +0900
Message-Id: <20210215121713.57687-8-marcan@marcan.st>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210215121713.57687-1-marcan@marcan.st>
References: <20210215121713.57687-1-marcan@marcan.st>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Apple ARM SoCs (A11 and newer) have some interrupt sources hard-wired to
the FIQ line. Introduce a cpufeature that can be used to enable FIQ
handling via alternatives.

This is currently enabled for all Apple CPUs. If/when support is
implemented for older (pre-A11) iPhone/iPad SoCs which do not need FIQs,
or if newer SoCs are released without the FIQ requirement, we can
revisit the condition.

Signed-off-by: Hector Martin <marcan@marcan.st>
---
 arch/arm64/Kconfig               | 11 +++++++++++
 arch/arm64/include/asm/cpucaps.h |  3 ++-
 arch/arm64/kernel/cpufeature.c   | 14 ++++++++++++++
 3 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index f39568b28ec1..fbc02af404b6 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1756,6 +1756,17 @@ config ARM64_DEBUG_PRIORITY_MASKING
 	  If unsure, say N
 endif
 
+config ARM64_FIQ_SUPPORT
+	bool "Support for FIQ interrupts"
+	help
+	  Adds support for handling FIQ interrupts as normal IRQs.
+	  This is required on Apple platforms where some IRQ sources are
+	  hardwired to the FIQ interrupt line.
+
+	  This option only affects platforms that require FIQ handling.
+	  On all other platforms, unexpected FIQs will continue to
+	  trigger a kernel panic.
+
 config RELOCATABLE
 	bool "Build a relocatable kernel image" if EXPERT
 	select ARCH_HAS_RELR
diff --git a/arch/arm64/include/asm/cpucaps.h b/arch/arm64/include/asm/cpucaps.h
index b77d997b173b..c36d926ad801 100644
--- a/arch/arm64/include/asm/cpucaps.h
+++ b/arch/arm64/include/asm/cpucaps.h
@@ -66,7 +66,8 @@
 #define ARM64_WORKAROUND_1508412		58
 #define ARM64_HAS_LDAPR				59
 #define ARM64_KVM_PROTECTED_MODE		60
+#define ARM64_NEEDS_FIQ				61
 
-#define ARM64_NCAPS				61
+#define ARM64_NCAPS				62
 
 #endif /* __ASM_CPUCAPS_H */
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index e99eddec0a46..9fde84beabf1 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1237,6 +1237,12 @@ static bool has_cache_idc(const struct arm64_cpu_capabilities *entry,
 	return ctr & BIT(CTR_IDC_SHIFT);
 }
 
+static bool needs_fiq(const struct arm64_cpu_capabilities *entry, int __unused)
+{
+	/* All supported Apple cores need this */
+	return read_cpuid_implementor() == ARM_CPU_IMP_APPLE;
+}
+
 static void cpu_emulate_effective_ctr(const struct arm64_cpu_capabilities *__unused)
 {
 	/*
@@ -2154,6 +2160,14 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.matches = has_cpuid_feature,
 		.min_field_value = 1,
 	},
+#ifdef CONFIG_ARM64_FIQ_SUPPORT
+	{
+		.desc = "FIQs",
+		.capability = ARM64_NEEDS_FIQ,
+		.type = ARM64_CPUCAP_BOOT_CPU_FEATURE,
+		.matches = needs_fiq,
+	},
+#endif
 	{},
 };
 
-- 
2.30.0

