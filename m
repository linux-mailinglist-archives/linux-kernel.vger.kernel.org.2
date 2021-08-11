Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B9903E88C9
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 05:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232747AbhHKD0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 23:26:53 -0400
Received: from foss.arm.com ([217.140.110.172]:41300 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232498AbhHKD0u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 23:26:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7BB8D6D;
        Tue, 10 Aug 2021 20:26:27 -0700 (PDT)
Received: from p8cg001049571a15.arm.com (unknown [10.163.67.241])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7D7C83F40C;
        Tue, 10 Aug 2021 20:26:24 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Marc Zyngier <maz@kernel.org>,
        linux-perf-users@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2] KVM: arm64: perf: Replace '0xf' instances with ID_AA64DFR0_PMUVER_IMP_DEF
Date:   Wed, 11 Aug 2021 08:57:06 +0530
Message-Id: <1628652427-24695-1-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ID_AA64DFR0_PMUVER_IMP_DEF which indicate implementation defined PMU, never
actually gets used although there are '0xf' instances scattered all around.
Just do the macro replacement to improve readability.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Marc Zyngier <maz@kernel.org>
Cc: linux-perf-users@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: kvmarm@lists.cs.columbia.edu
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
This applies on v5.14-rc5

Changes in V2:

- Split out the KVM part

Changes in V1:

https://lore.kernel.org/linux-perf-users/1628571998-13634-1-git-send-email-anshuman.khandual@arm.com/

 arch/arm64/kvm/perf.c     | 2 +-
 arch/arm64/kvm/pmu-emul.c | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kvm/perf.c b/arch/arm64/kvm/perf.c
index 151c31fb9860..f9bb3b14130e 100644
--- a/arch/arm64/kvm/perf.c
+++ b/arch/arm64/kvm/perf.c
@@ -50,7 +50,7 @@ static struct perf_guest_info_callbacks kvm_guest_cbs = {
 
 int kvm_perf_init(void)
 {
-	if (kvm_pmu_probe_pmuver() != 0xf && !is_protected_kvm_enabled())
+	if (kvm_pmu_probe_pmuver() != ID_AA64DFR0_PMUVER_IMP_DEF && !is_protected_kvm_enabled())
 		static_branch_enable(&kvm_arm_pmu_available);
 
 	return perf_register_guest_info_callbacks(&kvm_guest_cbs);
diff --git a/arch/arm64/kvm/pmu-emul.c b/arch/arm64/kvm/pmu-emul.c
index f33825c995cb..60f89bdbeebb 100644
--- a/arch/arm64/kvm/pmu-emul.c
+++ b/arch/arm64/kvm/pmu-emul.c
@@ -745,7 +745,7 @@ int kvm_pmu_probe_pmuver(void)
 	struct perf_event_attr attr = { };
 	struct perf_event *event;
 	struct arm_pmu *pmu;
-	int pmuver = 0xf;
+	int pmuver = ID_AA64DFR0_PMUVER_IMP_DEF;
 
 	/*
 	 * Create a dummy event that only counts user cycles. As we'll never
@@ -770,7 +770,7 @@ int kvm_pmu_probe_pmuver(void)
 	if (IS_ERR(event)) {
 		pr_err_once("kvm: pmu event creation failed %ld\n",
 			    PTR_ERR(event));
-		return 0xf;
+		return ID_AA64DFR0_PMUVER_IMP_DEF;
 	}
 
 	if (event->pmu) {
@@ -923,7 +923,7 @@ int kvm_arm_pmu_v3_set_attr(struct kvm_vcpu *vcpu, struct kvm_device_attr *attr)
 	if (!vcpu->kvm->arch.pmuver)
 		vcpu->kvm->arch.pmuver = kvm_pmu_probe_pmuver();
 
-	if (vcpu->kvm->arch.pmuver == 0xf)
+	if (vcpu->kvm->arch.pmuver == ID_AA64DFR0_PMUVER_IMP_DEF)
 		return -ENODEV;
 
 	switch (attr->attr) {
-- 
2.20.1

