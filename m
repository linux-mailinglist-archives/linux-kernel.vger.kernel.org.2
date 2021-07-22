Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F212D3D2B7A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 19:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbhGVRMi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 13:12:38 -0400
Received: from foss.arm.com ([217.140.110.172]:57990 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230079AbhGVRMc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 13:12:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0AA5011D4;
        Thu, 22 Jul 2021 10:53:07 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E7E713F73D;
        Thu, 22 Jul 2021 10:53:04 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rt-users@vger.kernel.org, x86@kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Mark Brown <broonie@kernel.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH 2/3] x86/fpu: Make FPU protection reuse common helper
Date:   Thu, 22 Jul 2021 18:51:56 +0100
Message-Id: <20210722175157.1367122-3-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210722175157.1367122-1-valentin.schneider@arm.com>
References: <20210722175157.1367122-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The newly-introduced preempt_{enable, disable}_bh() helpers are an exact
stand-in for fpregs_{lock, unlock}(). Use them there.

No change in behaviour intended.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 arch/x86/include/asm/fpu/api.h | 19 ++-----------------
 1 file changed, 2 insertions(+), 17 deletions(-)

diff --git a/arch/x86/include/asm/fpu/api.h b/arch/x86/include/asm/fpu/api.h
index 62cf3e4c06fb..ffebb9316bfd 100644
--- a/arch/x86/include/asm/fpu/api.h
+++ b/arch/x86/include/asm/fpu/api.h
@@ -54,31 +54,16 @@ static inline void kernel_fpu_begin(void)
  * fpu->state and set TIF_NEED_FPU_LOAD leaving CPU's FPU registers in
  * a random state.
  *
- * local_bh_disable() protects against both preemption and soft interrupts
- * on !RT kernels.
- *
- * On RT kernels local_bh_disable() is not sufficient because it only
- * serializes soft interrupt related sections via a local lock, but stays
- * preemptible. Disabling preemption is the right choice here as bottom
- * half processing is always in thread context on RT kernels so it
- * implicitly prevents bottom half processing as well.
- *
  * Disabling preemption also serializes against kernel_fpu_begin().
  */
 static inline void fpregs_lock(void)
 {
-	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
-		local_bh_disable();
-	else
-		preempt_disable();
+	preempt_disable_bh();
 }
 
 static inline void fpregs_unlock(void)
 {
-	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
-		local_bh_enable();
-	else
-		preempt_enable();
+	preempt_enable_bh();
 }
 
 #ifdef CONFIG_X86_DEBUG_FPU
-- 
2.25.1

