Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAEDD4152BD
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 23:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238036AbhIVV2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 17:28:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:43438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236476AbhIVV2T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 17:28:19 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C89860F6D;
        Wed, 22 Sep 2021 21:26:49 +0000 (UTC)
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1mT9em-00CPSk-6Q; Wed, 22 Sep 2021 22:19:56 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Shier <pshier@google.com>,
        Raghavendra Rao Ananta <rananta@google.com>,
        Ricardo Koller <ricarkol@google.com>,
        Oliver Upton <oupton@google.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        kernel-team@android.com
Subject: [PATCH v2 16/16] arm64: Add handling of CNTVCTSS traps
Date:   Wed, 22 Sep 2021 22:19:41 +0100
Message-Id: <20210922211941.2756270-17-maz@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210922211941.2756270-1-maz@kernel.org>
References: <20210922211941.2756270-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, mark.rutland@arm.com, daniel.lezcano@linaro.org, tglx@linutronix.de, pshier@google.com, rananta@google.com, ricarkol@google.com, oupton@google.com, will@kernel.org, catalin.marinas@arm.com, linus.walleij@linaro.org, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since CNTVCTSS obey the same control bits as CNTVCT, add the necessary
decoding to the hook table. Note that there is no known user of
this at the moment.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/include/asm/esr.h |  6 ++++++
 arch/arm64/kernel/traps.c    | 11 +++++++++++
 2 files changed, 17 insertions(+)

diff --git a/arch/arm64/include/asm/esr.h b/arch/arm64/include/asm/esr.h
index 29f97eb3dad4..a305ce256090 100644
--- a/arch/arm64/include/asm/esr.h
+++ b/arch/arm64/include/asm/esr.h
@@ -227,6 +227,9 @@
 #define ESR_ELx_SYS64_ISS_SYS_CNTVCT	(ESR_ELx_SYS64_ISS_SYS_VAL(3, 3, 2, 14, 0) | \
 					 ESR_ELx_SYS64_ISS_DIR_READ)
 
+#define ESR_ELx_SYS64_ISS_SYS_CNTVCTSS	(ESR_ELx_SYS64_ISS_SYS_VAL(3, 3, 6, 14, 0) | \
+					 ESR_ELx_SYS64_ISS_DIR_READ)
+
 #define ESR_ELx_SYS64_ISS_SYS_CNTFRQ	(ESR_ELx_SYS64_ISS_SYS_VAL(3, 3, 0, 14, 0) | \
 					 ESR_ELx_SYS64_ISS_DIR_READ)
 
@@ -317,6 +320,9 @@
 #define ESR_ELx_CP15_64_ISS_SYS_CNTVCT	(ESR_ELx_CP15_64_ISS_SYS_VAL(1, 14) | \
 					 ESR_ELx_CP15_64_ISS_DIR_READ)
 
+#define ESR_ELx_CP15_64_ISS_SYS_CNTVCTSS (ESR_ELx_CP15_64_ISS_SYS_VAL(9, 14) | \
+					 ESR_ELx_CP15_64_ISS_DIR_READ)
+
 #define ESR_ELx_CP15_32_ISS_SYS_CNTFRQ	(ESR_ELx_CP15_32_ISS_SYS_VAL(0, 0, 14, 0) |\
 					 ESR_ELx_CP15_32_ISS_DIR_READ)
 
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index b03e383d944a..16710ca55fbb 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -653,6 +653,12 @@ static const struct sys64_hook sys64_hooks[] = {
 		.esr_val = ESR_ELx_SYS64_ISS_SYS_CNTVCT,
 		.handler = cntvct_read_handler,
 	},
+	{
+		/* Trap read access to CNTVCTSS_EL0 */
+		.esr_mask = ESR_ELx_SYS64_ISS_SYS_OP_MASK,
+		.esr_val = ESR_ELx_SYS64_ISS_SYS_CNTVCTSS,
+		.handler = cntvct_read_handler,
+	},
 	{
 		/* Trap read access to CNTFRQ_EL0 */
 		.esr_mask = ESR_ELx_SYS64_ISS_SYS_OP_MASK,
@@ -729,6 +735,11 @@ static const struct sys64_hook cp15_64_hooks[] = {
 		.esr_val = ESR_ELx_CP15_64_ISS_SYS_CNTVCT,
 		.handler = compat_cntvct_read_handler,
 	},
+	{
+		.esr_mask = ESR_ELx_CP15_64_ISS_SYS_MASK,
+		.esr_val = ESR_ELx_CP15_64_ISS_SYS_CNTVCTSS,
+		.handler = compat_cntvct_read_handler,
+	},
 	{},
 };
 
-- 
2.30.2

