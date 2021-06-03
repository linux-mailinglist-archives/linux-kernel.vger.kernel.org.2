Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 844E3399F80
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 13:06:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbhFCLI3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 07:08:29 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:16597 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbhFCLI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 07:08:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1622718404; x=1654254404;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=K+0oPe34r2sxRJU/dWRexa/Kd4hYNxUDzrdHmmCri4A=;
  b=WLVojGcutd6QZ64sBM6W3z/B8XcvdYgOJ6fN77ybwHXVfUbwQeduv5Pk
   FDdLnCjHM1CQf9sZRSlFXanfmZglQF/91l4W1+ZqZNQM5Cix5wfmFR8A+
   +EJVHKt65AZvaH2XoqD4UX4OT4t5MEP42mGvk7xV+QtaNwsT1aQGYbgYb
   g=;
X-IronPort-AV: E=Sophos;i="5.83,244,1616457600"; 
   d="scan'208";a="113431615"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2a-22cc717f.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP; 03 Jun 2021 11:06:36 +0000
Received: from EX13D19EUA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-2a-22cc717f.us-west-2.amazon.com (Postfix) with ESMTPS id D8545A1C81;
        Thu,  3 Jun 2021 11:06:34 +0000 (UTC)
Received: from u5213831450fd59.ant.amazon.com (10.43.161.201) by
 EX13D19EUA001.ant.amazon.com (10.43.165.74) with Microsoft SMTP Server (TLS)
 id 15.0.1497.18; Thu, 3 Jun 2021 11:06:29 +0000
From:   Jinank Jain <jinankj@amazon.de>
To:     <linux-arm-kernel@lists.infradead.org>,
        <kvmarm@lists.cs.columbia.edu>, <linux-kernel@vger.kernel.org>
CC:     Jinank Jain <jinankj@amazon.de>, Alexander Graf <graf@amazon.de>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Subject: [PATCH] KVM: arm64: Properly restore PMU state during live-migration
Date:   Thu, 3 Jun 2021 13:05:54 +0200
Message-ID: <20210603110554.13643-1-jinankj@amazon.de>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
X-Originating-IP: [10.43.161.201]
X-ClientProxiedBy: EX13D29UWC003.ant.amazon.com (10.43.162.80) To
 EX13D19EUA001.ant.amazon.com (10.43.165.74)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently if a guest is live-migrated while it is actively using perf
counters, then after live-migrate it will notice that all counters would
suddenly start reporting 0s. This is due to the fact we are not
re-creating the relevant perf events inside the kernel.

Usually on live-migration guest state is restored using KVM_SET_ONE_REG
ioctl interface, which simply restores the value of PMU registers
values but does not re-program the perf events so that the guest can seamlessly
use these counters even after live-migration like it was doing before
live-migration.

Instead there are two completely different code path between guest
accessing PMU registers and VMM restoring counters on
live-migration.

In case of KVM_SET_ONE_REG:

kvm_arm_set_reg()
...... kvm_arm_sys_reg_set_reg()
........... reg_from_user()

but in case when guest tries to access these counters:

handle_exit()
..... kvm_handle_sys_reg()
..........perform_access()
...............access_pmu_evcntr()
...................kvm_pmu_set_counter_value()
.......................kvm_pmu_create_perf_event()

The drawback of using the KVM_SET_ONE_REG interface is that the host pmu
events which were registered for the source instance and not present for
the destination instance. Thus passively restoring PMCR_EL0 using
KVM_SET_ONE_REG interface would not create the necessary host pmu events
which are crucial for seamless guest experience across live migration.

In ordet to fix the situation, on first vcpu load we should restore
PMCR_EL0 in the same exact way like the guest was trying to access
these counters. And then we will also recreate the relevant host pmu
events.

Signed-off-by: Jinank Jain <jinankj@amazon.de>
Cc: Alexander Graf (AWS) <graf@amazon.de>
Cc: Marc Zyngier <maz@kernel.org>
Cc: James Morse <james.morse@arm.com>
Cc: Alexandru Elisei <alexandru.elisei@arm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
---
 arch/arm64/include/asm/kvm_host.h |  1 +
 arch/arm64/kvm/arm.c              |  1 +
 arch/arm64/kvm/pmu-emul.c         | 10 ++++++++--
 arch/arm64/kvm/pmu.c              | 15 +++++++++++++++
 include/kvm/arm_pmu.h             |  3 +++
 5 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 7cd7d5c8c4bc..2376ad3c2fc2 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -745,6 +745,7 @@ static inline int kvm_arch_vcpu_run_pid_change(struct kvm_vcpu *vcpu)
 void kvm_set_pmu_events(u32 set, struct perf_event_attr *attr);
 void kvm_clr_pmu_events(u32 clr);
 
+void kvm_vcpu_pmu_restore(struct kvm_vcpu *vcpu);
 void kvm_vcpu_pmu_restore_guest(struct kvm_vcpu *vcpu);
 void kvm_vcpu_pmu_restore_host(struct kvm_vcpu *vcpu);
 #else
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index e720148232a0..c66f6d16ec06 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -408,6 +408,7 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 	if (has_vhe())
 		kvm_vcpu_load_sysregs_vhe(vcpu);
 	kvm_arch_vcpu_load_fp(vcpu);
+	kvm_vcpu_pmu_restore(vcpu);
 	kvm_vcpu_pmu_restore_guest(vcpu);
 	if (kvm_arm_is_pvtime_enabled(&vcpu->arch))
 		kvm_make_request(KVM_REQ_RECORD_STEAL, vcpu);
diff --git a/arch/arm64/kvm/pmu-emul.c b/arch/arm64/kvm/pmu-emul.c
index fd167d4f4215..12a40f4b5f0d 100644
--- a/arch/arm64/kvm/pmu-emul.c
+++ b/arch/arm64/kvm/pmu-emul.c
@@ -574,10 +574,16 @@ void kvm_pmu_handle_pmcr(struct kvm_vcpu *vcpu, u64 val)
 		kvm_pmu_disable_counter_mask(vcpu, mask);
 	}
 
-	if (val & ARMV8_PMU_PMCR_C)
+	/*
+	 * Cycle counter needs to reset in case of first vcpu load.
+	 */
+	if (val & ARMV8_PMU_PMCR_C || !kvm_arm_pmu_v3_restored(vcpu))
 		kvm_pmu_set_counter_value(vcpu, ARMV8_PMU_CYCLE_IDX, 0);
 
-	if (val & ARMV8_PMU_PMCR_P) {
+	/*
+	 * All the counters needs to reset in case of first vcpu load.
+	 */
+	if (val & ARMV8_PMU_PMCR_P || !kvm_arm_pmu_v3_restored(vcpu)) {
 		for_each_set_bit(i, &mask, 32)
 			kvm_pmu_set_counter_value(vcpu, i, 0);
 	}
diff --git a/arch/arm64/kvm/pmu.c b/arch/arm64/kvm/pmu.c
index 03a6c1f4a09a..574daeeaa4e4 100644
--- a/arch/arm64/kvm/pmu.c
+++ b/arch/arm64/kvm/pmu.c
@@ -161,6 +161,21 @@ static void kvm_vcpu_pmu_disable_el0(unsigned long events)
 	}
 }
 
+/*
+ * Restore PMU events on first vcpu load.
+ */
+void kvm_vcpu_pmu_restore(struct kvm_vcpu *vcpu)
+{
+	if (kvm_arm_pmu_v3_restored(vcpu))
+		return;
+ 
+	u64 val = __vcpu_sys_reg(vcpu, PMCR_EL0);
+ 
+	kvm_pmu_handle_pmcr(vcpu, val);
+ 
+	vcpu->arch.pmu.restored = true;
+}
+
 /*
  * On VHE ensure that only guest events have EL0 counting enabled.
  * This is called from both vcpu_{load,put} and the sysreg handling.
diff --git a/include/kvm/arm_pmu.h b/include/kvm/arm_pmu.h
index 864b9997efb2..7444fd894cf3 100644
--- a/include/kvm/arm_pmu.h
+++ b/include/kvm/arm_pmu.h
@@ -32,10 +32,12 @@ struct kvm_pmu {
 	struct kvm_pmc pmc[ARMV8_PMU_MAX_COUNTERS];
 	DECLARE_BITMAP(chained, ARMV8_PMU_MAX_COUNTER_PAIRS);
 	bool created;
+	bool restored;
 	bool irq_level;
 	struct irq_work overflow_work;
 };
 
+#define kvm_arm_pmu_v3_restored(v)	((v)->arch.pmu.restored)
 #define kvm_arm_pmu_irq_initialized(v)	((v)->arch.pmu.irq_num >= VGIC_NR_SGIS)
 u64 kvm_pmu_get_counter_value(struct kvm_vcpu *vcpu, u64 select_idx);
 void kvm_pmu_set_counter_value(struct kvm_vcpu *vcpu, u64 select_idx, u64 val);
@@ -67,6 +69,7 @@ struct kvm_pmu {
 };
 
 #define kvm_arm_pmu_irq_initialized(v)	(false)
+#define kvm_arm_pmu_v3_restored(v)	(false)
 static inline u64 kvm_pmu_get_counter_value(struct kvm_vcpu *vcpu,
 					    u64 select_idx)
 {
-- 
2.31.1




Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879



