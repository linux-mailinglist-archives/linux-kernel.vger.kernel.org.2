Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89467344DE2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 18:57:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbhCVR5R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 13:57:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:51342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230231AbhCVR4r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 13:56:47 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A81EC6198E;
        Mon, 22 Mar 2021 17:56:46 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1lOOnE-0038Fj-5q; Mon, 22 Mar 2021 17:56:44 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Quentin Perret <qperret@google.com>
Cc:     catalin.marinas@arm.com, james.morse@arm.com,
        julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com,
        android-kvm@google.com, seanjc@google.com, mate.toth-pal@arm.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel-team@android.com, kvmarm@lists.cs.columbia.edu,
        tabba@google.com, ardb@kernel.org, mark.rutland@arm.com,
        dbrazdil@google.com
Subject: [PATCH v2 2/3] KVM: arm64: Generate final CTR_EL0 value when running in Protected mode
Date:   Mon, 22 Mar 2021 17:56:38 +0000
Message-Id: <20210322175639.801566-3-maz@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210322175639.801566-1-maz@kernel.org>
References: <20210322175639.801566-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: qperret@google.com, catalin.marinas@arm.com, james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, android-kvm@google.com, seanjc@google.com, mate.toth-pal@arm.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel-team@android.com, kvmarm@lists.cs.columbia.edu, tabba@google.com, ardb@kernel.org, mark.rutland@arm.com, dbrazdil@google.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In protected mode, late CPUs are not allowed to boot (enforced by
the PSCI relay). We can thus specialise the read_ctr macro to
always return a pre-computed, sanitised value.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/include/asm/assembler.h | 9 +++++++++
 arch/arm64/kernel/image-vars.h     | 1 +
 arch/arm64/kvm/va_layout.c         | 7 +++++++
 3 files changed, 17 insertions(+)

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index fb651c1f26e9..1a4cee7eb3c9 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -270,12 +270,21 @@ alternative_endif
  * provide the system wide safe value from arm64_ftr_reg_ctrel0.sys_val
  */
 	.macro	read_ctr, reg
+#ifndef __KVM_NVHE_HYPERVISOR__
 alternative_if_not ARM64_MISMATCHED_CACHE_TYPE
 	mrs	\reg, ctr_el0			// read CTR
 	nop
 alternative_else
 	ldr_l	\reg, arm64_ftr_reg_ctrel0 + ARM64_FTR_SYSVAL
 alternative_endif
+#else
+alternative_cb kvm_compute_final_ctr_el0
+	movz	\reg, #0
+	movk	\reg, #0, lsl #16
+	movk	\reg, #0, lsl #32
+	movk	\reg, #0, lsl #48
+alternative_cb_end
+#endif
 	.endm
 
 
diff --git a/arch/arm64/kernel/image-vars.h b/arch/arm64/kernel/image-vars.h
index d5dc2b792651..fdd60cd1d7e8 100644
--- a/arch/arm64/kernel/image-vars.h
+++ b/arch/arm64/kernel/image-vars.h
@@ -65,6 +65,7 @@ __efistub__ctype		= _ctype;
 KVM_NVHE_ALIAS(kvm_patch_vector_branch);
 KVM_NVHE_ALIAS(kvm_update_va_mask);
 KVM_NVHE_ALIAS(kvm_get_kimage_voffset);
+KVM_NVHE_ALIAS(kvm_compute_final_ctr_el0);
 
 /* Global kernel state accessed by nVHE hyp code. */
 KVM_NVHE_ALIAS(kvm_vgic_global_state);
diff --git a/arch/arm64/kvm/va_layout.c b/arch/arm64/kvm/va_layout.c
index 978301392d67..acdb7b3cc97d 100644
--- a/arch/arm64/kvm/va_layout.c
+++ b/arch/arm64/kvm/va_layout.c
@@ -288,3 +288,10 @@ void kvm_get_kimage_voffset(struct alt_instr *alt,
 {
 	generate_mov_q(kimage_voffset, origptr, updptr, nr_inst);
 }
+
+void kvm_compute_final_ctr_el0(struct alt_instr *alt,
+			       __le32 *origptr, __le32 *updptr, int nr_inst)
+{
+	generate_mov_q(read_sanitised_ftr_reg(SYS_CTR_EL0),
+		       origptr, updptr, nr_inst);
+}
-- 
2.29.2

