Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C52DA39E6F7
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 21:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231363AbhFGTB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 15:01:59 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:62241 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230516AbhFGTB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 15:01:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1623092406; x=1654628406;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jISdOgQ/JTsW0H3WM9A+q97dEXgXLmFL+7Pu1AAf/5U=;
  b=lUkAi663tLabMowYdJ8iGl1eqznBOtf5ZuZE00zXkGVKVLfPIjEvZHwA
   hYB/64D1ohQYDsalRgtWcRkoZCOtdEA6HlfHTIC4uSOSpKxPpc+C2Abqg
   6ZSLDX79bK2i+fKndnHcI5yD6+TBxnoXlbHVGblU3J/XIU/SVjbER+w7C
   0=;
X-IronPort-AV: E=Sophos;i="5.83,255,1616457600"; 
   d="scan'208";a="118583534"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2c-2225282c.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP; 07 Jun 2021 18:59:58 +0000
Received: from EX13D19EUA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-2c-2225282c.us-west-2.amazon.com (Postfix) with ESMTPS id 69681A1810;
        Mon,  7 Jun 2021 18:59:57 +0000 (UTC)
Received: from u5213831450fd59.ant.amazon.com (10.43.161.201) by
 EX13D19EUA001.ant.amazon.com (10.43.165.74) with Microsoft SMTP Server (TLS)
 id 15.0.1497.18; Mon, 7 Jun 2021 18:59:52 +0000
From:   Jinank Jain <jinankj@amazon.de>
To:     <linux-arm-kernel@lists.infradead.org>,
        <kvmarm@lists.cs.columbia.edu>, <linux-kernel@vger.kernel.org>
CC:     Jinank Jain <jinankj@amazon.de>, Marc Zyngier <maz@kernel.org>,
        Alexander Graf <graf@amazon.de>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Subject: [PATCH v2] KVM: arm64: Properly restore PMU state during live-migration
Date:   Mon, 7 Jun 2021 20:58:59 +0200
Message-ID: <20210607185858.2254-1-jinankj@amazon.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210603110554.13643-1-jinankj@amazon.de>
References: <20210603110554.13643-1-jinankj@amazon.de>
MIME-Version: 1.0
X-Originating-IP: [10.43.161.201]
X-ClientProxiedBy: EX13D46UWC003.ant.amazon.com (10.43.162.119) To
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
events which were registered for the source instance are not present for
the destination instance. Thus, passively restoring PMCR_EL0 using
KVM_SET_ONE_REG interface would not create the necessary host pmu events
which are crucial for seamless guest experience across live migration.

In ordet to fix the situation, on first vcpu load we should restore
PMCR_EL0 in the same exact way like the guest was trying to access
these counters. And then we will also recreate the relevant host pmu
events.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Jinank Jain <jinankj@amazon.de>
Cc: Alexander Graf (AWS) <graf@amazon.de>
Cc: Marc Zyngier <maz@kernel.org>
Cc: James Morse <james.morse@arm.com>
Cc: Alexandru Elisei <alexandru.elisei@arm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
---
 arch/arm64/include/asm/kvm_host.h | 1 +
 arch/arm64/kvm/arm.c              | 4 ++++
 arch/arm64/kvm/pmu-emul.c         | 3 +++
 3 files changed, 8 insertions(+)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 7cd7d5c8c4bc..6336b4309114 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -46,6 +46,7 @@
 #define KVM_REQ_VCPU_RESET	KVM_ARCH_REQ(2)
 #define KVM_REQ_RECORD_STEAL	KVM_ARCH_REQ(3)
 #define KVM_REQ_RELOAD_GICv4	KVM_ARCH_REQ(4)
+#define KVM_REQ_RELOAD_PMU	KVM_ARCH_REQ(5)
 
 #define KVM_DIRTY_LOG_MANUAL_CAPS   (KVM_DIRTY_LOG_MANUAL_PROTECT_ENABLE | \
 				     KVM_DIRTY_LOG_INITIALLY_SET)
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index e720148232a0..facf4d41d32a 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -689,6 +689,10 @@ static void check_vcpu_requests(struct kvm_vcpu *vcpu)
 			vgic_v4_load(vcpu);
 			preempt_enable();
 		}
+
+		if (kvm_check_request(KVM_REQ_RELOAD_PMU, vcpu))
+			kvm_pmu_handle_pmcr(vcpu,
+					    __vcpu_sys_reg(vcpu, PMCR_EL0));
 	}
 }
 
diff --git a/arch/arm64/kvm/pmu-emul.c b/arch/arm64/kvm/pmu-emul.c
index fd167d4f4215..a0bbb7111f57 100644
--- a/arch/arm64/kvm/pmu-emul.c
+++ b/arch/arm64/kvm/pmu-emul.c
@@ -850,6 +850,9 @@ int kvm_arm_pmu_v3_enable(struct kvm_vcpu *vcpu)
 		   return -EINVAL;
 	}
 
+	/* One-off reload of the PMU on first run */
+	kvm_make_request(KVM_REQ_RELOAD_PMU, vcpu);
+
 	return 0;
 }
 
-- 
2.31.1




Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879



