Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 081953EAA8D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 21:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234360AbhHLTDJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 15:03:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:59332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234916AbhHLTC7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 15:02:59 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 79232610A7;
        Thu, 12 Aug 2021 19:02:34 +0000 (UTC)
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1mEFyK-004c9r-SQ; Thu, 12 Aug 2021 20:02:32 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, kernel-team@android.com
Subject: [PATCH 3/5] arm64: Detect disabled HVC early
Date:   Thu, 12 Aug 2021 20:02:11 +0100
Message-Id: <20210812190213.2601506-4-maz@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210812190213.2601506-1-maz@kernel.org>
References: <20210812190213.2601506-1-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, zajec5@gmail.com, will@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com, ardb@kernel.org, f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Having HVC disabled from EL3 while the kernel is entered at EL2
is a complete nightmare.

We end-up taking an UNDEF at the worse possible moment (checking
for VHE) and even if we didn't, having KVM enabled would signify
the premature end of the kernel.

Instead, try and detect this stupid case by issuing a HVC
for HVC_RESET_VECTORS, which does nothing when the stubs
are live. If we get HVC_STUB_ERR back, that's because the
UNDEF handler has kicked in.

In this situation, close your eyes, block your nose, and gracefully
pretend we have booted at EL1.

Reported-by: Rafał Miłecki <zajec5@gmail.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/kernel/head.S | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 9d5aa56a98cc..d6b2b05f5d3a 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -519,6 +519,28 @@ SYM_INNER_LABEL(init_el2, SYM_L_LOCAL)
 	msr	vbar_el2, x0
 	isb
 
+	// Check that HVC actually works...
+	mov	x0, #HVC_RESET_VECTORS
+	hvc	#0
+
+	mov_q	x1, HVC_STUB_ERR
+	cmp	x0, x1
+	b.ne	0f
+
+	/*
+	 * HVC is unusable, so pretend we actually booted at EL1.
+	 * Once we have left EL2, there will be no going back.
+	 */
+	mov_q	x0, INIT_SCTLR_EL1_MMU_OFF
+	msr	sctlr_el1, x0
+
+	mov_q	x0, INIT_PSTATE_EL1
+	msr	spsr_el2, x0
+	msr	elr_el2, lr
+	mov_q	w0, BOOT_CPU_MODE_EL1
+	eret
+
+0:
 	/*
 	 * Fruity CPUs seem to have HCR_EL2.E2H set to RES1,
 	 * making it impossible to start in nVHE mode. Is that
-- 
2.30.2

