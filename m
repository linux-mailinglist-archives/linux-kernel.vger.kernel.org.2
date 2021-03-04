Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3E9632DC06
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 22:43:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240352AbhCDVle (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 16:41:34 -0500
Received: from marcansoft.com ([212.63.210.85]:33628 "EHLO mail.marcansoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240158AbhCDVlQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 16:41:16 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: hector@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 155F0426ED;
        Thu,  4 Mar 2021 21:40:52 +0000 (UTC)
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
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        "David S. Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFT PATCH v3 13/27] arm64: Add Apple vendor-specific system registers
Date:   Fri,  5 Mar 2021 06:38:48 +0900
Message-Id: <20210304213902.83903-14-marcan@marcan.st>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210304213902.83903-1-marcan@marcan.st>
References: <20210304213902.83903-1-marcan@marcan.st>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Apple ARM64 SoCs have a ton of vendor-specific registers we're going to
have to deal with, and those don't really belong in sysreg.h with all
the architectural registers. Make a new home for them, and add some
registers which are useful for early bring-up.

Signed-off-by: Hector Martin <marcan@marcan.st>
---
 MAINTAINERS                           |  1 +
 arch/arm64/include/asm/sysreg_apple.h | 69 +++++++++++++++++++++++++++
 2 files changed, 70 insertions(+)
 create mode 100644 arch/arm64/include/asm/sysreg_apple.h

diff --git a/MAINTAINERS b/MAINTAINERS
index aec14fbd61b8..3a352c687d4b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1646,6 +1646,7 @@ B:	https://github.com/AsahiLinux/linux/issues
 C:	irc://chat.freenode.net/asahi-dev
 T:	git https://github.com/AsahiLinux/linux.git
 F:	Documentation/devicetree/bindings/arm/apple.yaml
+F:	arch/arm64/include/asm/sysreg_apple.h
 
 ARM/ARTPEC MACHINE SUPPORT
 M:	Jesper Nilsson <jesper.nilsson@axis.com>
diff --git a/arch/arm64/include/asm/sysreg_apple.h b/arch/arm64/include/asm/sysreg_apple.h
new file mode 100644
index 000000000000..48347a51d564
--- /dev/null
+++ b/arch/arm64/include/asm/sysreg_apple.h
@@ -0,0 +1,69 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Apple SoC vendor-defined system register definitions
+ *
+ * Copyright The Asahi Linux Contributors
+
+ * This file contains only well-understood registers that are useful to
+ * Linux. If you are looking for things to add here, you should visit:
+ *
+ * https://github.com/AsahiLinux/docs/wiki/HW:ARM-System-Registers
+ */
+
+#ifndef __ASM_SYSREG_APPLE_H
+#define __ASM_SYSREG_APPLE_H
+
+#include <asm/sysreg.h>
+#include <linux/bits.h>
+#include <linux/bitfield.h>
+
+/*
+ * Keep these registers in encoding order, except for register arrays;
+ * those should be listed in array order starting from the position of
+ * the encoding of the first register.
+ */
+
+#define SYS_APL_PMCR0_EL1		sys_reg(3, 1, 15, 0, 0)
+#define PMCR0_IMODE			GENMASK(10, 8)
+#define PMCR0_IMODE_OFF			0
+#define PMCR0_IMODE_PMI			1
+#define PMCR0_IMODE_AIC			2
+#define PMCR0_IMODE_HALT		3
+#define PMCR0_IMODE_FIQ			4
+#define PMCR0_IACT			BIT(11)
+
+/* IPI request registers */
+#define SYS_APL_IPI_RR_LOCAL_EL1	sys_reg(3, 5, 15, 0, 0)
+#define SYS_APL_IPI_RR_GLOBAL_EL1	sys_reg(3, 5, 15, 0, 1)
+#define IPI_RR_CPU			GENMASK(7, 0)
+/* Cluster only used for the GLOBAL register */
+#define IPI_RR_CLUSTER			GENMASK(23, 16)
+#define IPI_RR_TYPE			GENMASK(29, 28)
+#define IPI_RR_IMMEDIATE		0
+#define IPI_RR_RETRACT			1
+#define IPI_RR_DEFERRED			2
+#define IPI_RR_NOWAKE			3
+
+/* IPI status register */
+#define SYS_APL_IPI_SR_EL1		sys_reg(3, 5, 15, 1, 1)
+#define IPI_SR_PENDING			BIT(0)
+
+/* Guest timer FIQ enable register */
+#define SYS_APL_VM_TMR_FIQ_ENA_EL1	sys_reg(3, 5, 15, 1, 3)
+#define VM_TMR_FIQ_ENABLE_V		BIT(0)
+#define VM_TMR_FIQ_ENABLE_P		BIT(1)
+
+/* Deferred IPI countdown register */
+#define SYS_APL_IPI_CR_EL1		sys_reg(3, 5, 15, 3, 1)
+
+#define SYS_APL_UPMCR0_EL1		sys_reg(3, 7, 15, 0, 4)
+#define UPMCR0_IMODE			GENMASK(18, 16)
+#define UPMCR0_IMODE_OFF		0
+#define UPMCR0_IMODE_AIC		2
+#define UPMCR0_IMODE_HALT		3
+#define UPMCR0_IMODE_FIQ		4
+
+#define SYS_APL_UPMSR_EL1		sys_reg(3, 7, 15, 6, 4)
+#define UPMSR_IACT			BIT(0)
+
+#endif	/* __ASM_SYSREG_APPLE_H */
-- 
2.30.0

