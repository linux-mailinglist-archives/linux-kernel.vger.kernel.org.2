Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 291C3366D26
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 15:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242806AbhDUNuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 09:50:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:57270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235222AbhDUNuC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 09:50:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 715C261439;
        Wed, 21 Apr 2021 13:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619012969;
        bh=3JOEoDIfnaWwGOlo+8UCRIcFvWxqNH742UwCb6Bunsw=;
        h=From:To:Cc:Subject:Date:From;
        b=AJni0jwQfWQGMuhJ1iw9JPbOb3fZ6nT1Ti0gxEaAYRcrOfru1mmcChSuiLoWY1Mo/
         H9Y3m9xrHuVVPGh8JYLHKE5jH6YopLIXA3oRDubPbnLqw/Q0B/OZi7TSfGXo1sLV6q
         Ts+vD1yvplPmi8u7/SpcVzCD+tdsTQMToYbdgxlAGQHcbvpl/HZ4OAn6JAHyI2ehFJ
         wqefYwsEvSw5Vm7ABNjS14SNFKP1J4aojQjbb0PdXHF3zsmYz5JAqiQEOSNJKXpnx6
         yHE5b7EjOOu5O9hsIc8lq3QbwGVtSM5BGp3ZU8NlBkMBiaklHiMeUwYlfroUjBhW7z
         P/I2acEcaNQnw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Marc Zyngier <maz@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Fuad Tabba <tabba@google.com>,
        Andrew Scull <ascull@google.com>,
        David Brazdil <dbrazdil@google.com>,
        Quentin Perret <qperret@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org
Subject: [PATCH] KVM: arm64: build perf support only when enabled
Date:   Wed, 21 Apr 2021 15:49:01 +0200
Message-Id: <20210421134922.3309033-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The perf_num_counters() function is only defined when CONFIG_PERF_EVENTS
is enabled:

arch/arm64/kvm/perf.c: In function 'kvm_perf_init':
arch/arm64/kvm/perf.c:58:43: error: implicit declaration of function 'perf_num_counters'; did you mean 'dec_mm_counter'? [-Werror=implicit-function-declaration]
   58 |         if (IS_ENABLED(CONFIG_ARM_PMU) && perf_num_counters() > 0
      |                                           ^~~~~~~~~~~~~~~~~

Use conditional compilation to disable this feature entirely when
CONFIG_PERF_EVENTS is disabled in the host.

Fixes: 6b5b368fccd7 ("KVM: arm64: Turn kvm_arm_support_pmu_v3() into a static key")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
Not sure if this is the correct symbol to check for, but this is
one way to avoid the build failure.
---
 arch/arm64/kvm/Makefile | 4 +++-
 arch/arm64/kvm/arm.c    | 8 +++++---
 include/kvm/arm_pmu.h   | 7 +++++++
 3 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kvm/Makefile b/arch/arm64/kvm/Makefile
index 589921392cb1..9adf12ba5047 100644
--- a/arch/arm64/kvm/Makefile
+++ b/arch/arm64/kvm/Makefile
@@ -12,7 +12,7 @@ obj-$(CONFIG_KVM) += hyp/
 
 kvm-y := $(KVM)/kvm_main.o $(KVM)/coalesced_mmio.o $(KVM)/eventfd.o \
 	 $(KVM)/vfio.o $(KVM)/irqchip.o \
-	 arm.o mmu.o mmio.o psci.o perf.o hypercalls.o pvtime.o \
+	 arm.o mmu.o mmio.o psci.o hypercalls.o pvtime.o \
 	 inject_fault.o va_layout.o handle_exit.o \
 	 guest.o debug.o reset.o sys_regs.o \
 	 vgic-sys-reg-v3.o fpsimd.o pmu.o \
@@ -24,4 +24,6 @@ kvm-y := $(KVM)/kvm_main.o $(KVM)/coalesced_mmio.o $(KVM)/eventfd.o \
 	 vgic/vgic-mmio-v3.o vgic/vgic-kvm-device.o \
 	 vgic/vgic-its.o vgic/vgic-debug.o
 
+kvm-$(CONFIG_PERF_EVENTS) += perf.o
+
 kvm-$(CONFIG_HW_PERF_EVENTS)  += pmu-emul.o
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 4808aca8c87c..720e075c70f9 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -1694,7 +1694,8 @@ static int init_subsystems(void)
 	if (err)
 		goto out;
 
-	kvm_perf_init();
+	if (IS_ENABLED(CONFIG_PERF_EVENTS))
+		kvm_perf_init();
 	kvm_sys_reg_table_init();
 
 out:
@@ -1899,7 +1900,8 @@ static int init_hyp_mode(void)
 	return 0;
 
 out_err:
-	teardown_hyp_mode();
+	if (IS_ENABLED(CONFIG_PERF_EVENTS))
+		teardown_hyp_mode();
 	kvm_err("error initializing Hyp mode: %d\n", err);
 	return err;
 }
@@ -2101,7 +2103,7 @@ int kvm_arch_init(void *opaque)
 
 out_hyp:
 	hyp_cpu_pm_exit();
-	if (!in_hyp_mode)
+	if (!IS_ENABLED(CONFIG_PERF_EVENTS) && in_hyp_mode)
 		teardown_hyp_mode();
 out_err:
 	return err;
diff --git a/include/kvm/arm_pmu.h b/include/kvm/arm_pmu.h
index 6fd3cda608e4..d84307a1ebd5 100644
--- a/include/kvm/arm_pmu.h
+++ b/include/kvm/arm_pmu.h
@@ -13,12 +13,19 @@
 #define ARMV8_PMU_CYCLE_IDX		(ARMV8_PMU_MAX_COUNTERS - 1)
 #define ARMV8_PMU_MAX_COUNTER_PAIRS	((ARMV8_PMU_MAX_COUNTERS + 1) >> 1)
 
+#ifdef CONFIG_PERF_EVENTS
 DECLARE_STATIC_KEY_FALSE(kvm_arm_pmu_available);
 
 static __always_inline bool kvm_arm_support_pmu_v3(void)
 {
 	return static_branch_likely(&kvm_arm_pmu_available);
 }
+#else
+static __always_inline bool kvm_arm_support_pmu_v3(void)
+{
+	return 0;
+}
+#endif
 
 #ifdef CONFIG_HW_PERF_EVENTS
 
-- 
2.29.2

