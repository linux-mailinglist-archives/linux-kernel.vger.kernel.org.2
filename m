Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5664F3E540B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 09:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237547AbhHJHCk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 03:02:40 -0400
Received: from foss.arm.com ([217.140.110.172]:48920 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237587AbhHJHCg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 03:02:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1E0E3D6E;
        Tue, 10 Aug 2021 00:02:15 -0700 (PDT)
Received: from p8cg001049571a15.arm.com (unknown [10.163.67.89])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BD1093F718;
        Tue, 10 Aug 2021 00:02:11 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] KVM: arm64: Drop check_kvm_target_cpu() based percpu probe
Date:   Tue, 10 Aug 2021 12:32:39 +0530
Message-Id: <1628578961-29097-4-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1628578961-29097-1-git-send-email-anshuman.khandual@arm.com>
References: <1628578961-29097-1-git-send-email-anshuman.khandual@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kvm_target_cpu() never returns a negative error code, so check_kvm_target()
would never have 'ret' filled with a negative error code. Hence the percpu
probe via check_kvm_target_cpu() does not make sense as its never going to
find an unsupported CPU, forcing kvm_arch_init() to exit early. Hence lets
just drop this percpu probe (and also check_kvm_target_cpu()) altogether.

Cc: Marc Zyngier <maz@kernel.org>
Cc: James Morse <james.morse@arm.com>
Cc: Alexandru Elisei <alexandru.elisei@arm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: kvmarm@lists.cs.columbia.edu
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/kvm/arm.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 19560e457c11..16f93678c17e 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -2010,11 +2010,6 @@ static int finalize_hyp_mode(void)
 	return 0;
 }
 
-static void check_kvm_target_cpu(void *ret)
-{
-	*(int *)ret = kvm_target_cpu();
-}
-
 struct kvm_vcpu *kvm_mpidr_to_vcpu(struct kvm *kvm, unsigned long mpidr)
 {
 	struct kvm_vcpu *vcpu;
@@ -2074,7 +2069,6 @@ void kvm_arch_irq_bypass_start(struct irq_bypass_consumer *cons)
 int kvm_arch_init(void *opaque)
 {
 	int err;
-	int ret, cpu;
 	bool in_hyp_mode;
 
 	if (!is_hyp_mode_available()) {
@@ -2089,14 +2083,6 @@ int kvm_arch_init(void *opaque)
 		kvm_info("Guests without required CPU erratum workarounds can deadlock system!\n" \
 			 "Only trusted guests should be used on this system.\n");
 
-	for_each_online_cpu(cpu) {
-		smp_call_function_single(cpu, check_kvm_target_cpu, &ret, 1);
-		if (ret < 0) {
-			kvm_err("Error, CPU %d not supported!\n", cpu);
-			return -ENODEV;
-		}
-	}
-
 	err = kvm_set_ipa_limit();
 	if (err)
 		return err;
-- 
2.20.1

