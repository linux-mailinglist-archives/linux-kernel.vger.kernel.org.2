Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B89E312E95
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 11:09:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232491AbhBHKJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 05:09:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:58426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232096AbhBHKBQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 05:01:16 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B71D64E99;
        Mon,  8 Feb 2021 09:57:59 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1l93Ir-00Ck14-Hw; Mon, 08 Feb 2021 09:57:57 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        David Brazdil <dbrazdil@google.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Jing Zhang <jingzhangos@google.com>,
        Ajay Patil <pajay@qti.qualcomm.com>,
        Prasad Sodagudi <psodagud@codeaurora.org>,
        Srinivas Ramana <sramana@codeaurora.org>,
        Hector Martin <marcan@marcan.st>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        kernel-team@android.com
Subject: [PATCH v7 09/23] arm64: Move SCTLR_EL1 initialisation to EL-agnostic code
Date:   Mon,  8 Feb 2021 09:57:18 +0000
Message-Id: <20210208095732.3267263-10-maz@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210208095732.3267263-1-maz@kernel.org>
References: <20210208095732.3267263-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org, catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com, dbrazdil@google.com, alexandru.elisei@arm.com, ardb@kernel.org, jingzhangos@google.com, pajay@qti.qualcomm.com, psodagud@codeaurora.org, sramana@codeaurora.org, marcan@marcan.st, james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can now move the initial SCTLR_EL1 setup to be used for both
EL1 and EL2 setup.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Acked-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/kernel/head.S | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 36212c05df42..b425d2587cdb 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -479,13 +479,14 @@ EXPORT_SYMBOL(kimage_vaddr)
  * booted in EL1 or EL2 respectively.
  */
 SYM_FUNC_START(init_kernel_el)
+	mov_q	x0, INIT_SCTLR_EL1_MMU_OFF
+	msr	sctlr_el1, x0
+
 	mrs	x0, CurrentEL
 	cmp	x0, #CurrentEL_EL2
 	b.eq	init_el2
 
 SYM_INNER_LABEL(init_el1, SYM_L_LOCAL)
-	mov_q	x0, INIT_SCTLR_EL1_MMU_OFF
-	msr	sctlr_el1, x0
 	isb
 	mov_q	x0, INIT_PSTATE_EL1
 	msr	spsr_el1, x0
@@ -494,9 +495,6 @@ SYM_INNER_LABEL(init_el1, SYM_L_LOCAL)
 	eret
 
 SYM_INNER_LABEL(init_el2, SYM_L_LOCAL)
-	mov_q	x0, INIT_SCTLR_EL1_MMU_OFF
-	msr	sctlr_el1, x0
-
 	mov_q	x0, HCR_HOST_NVHE_FLAGS
 	msr	hcr_el2, x0
 	isb
-- 
2.29.2

