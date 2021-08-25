Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDF643F7A11
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 18:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241116AbhHYQSb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 12:18:31 -0400
Received: from foss.arm.com ([217.140.110.172]:54720 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240303AbhHYQSO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 12:18:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3F9F7101E;
        Wed, 25 Aug 2021 09:17:28 -0700 (PDT)
Received: from monolith.cable.virginm.net (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E222B3F66F;
        Wed, 25 Aug 2021 09:17:26 -0700 (PDT)
From:   Alexandru Elisei <alexandru.elisei@arm.com>
To:     maz@kernel.org, james.morse@arm.com, suzuki.poulose@arm.com,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        will@kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v4 10/39] KVM: arm64: Print a warning for unexpected faults on locked memslots
Date:   Wed, 25 Aug 2021 17:17:46 +0100
Message-Id: <20210825161815.266051-11-alexandru.elisei@arm.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210825161815.266051-1-alexandru.elisei@arm.com>
References: <20210825161815.266051-1-alexandru.elisei@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When userspace unmaps a VMA backing a memslot, the corresponding stage 2
address range gets unmapped via the MMU notifiers. This makes it possible
to get stage 2 faults on a locked memslot, which might not be what
userspace wants because the purpose of locking a memslot is to avoid stage
2 faults in the first place.

Addresses being unmapped from stage 2 can happen from other reasons too,
like bugs in the implementation of the lock memslot API, however unlikely
that might seem.

Let's try to make debugging easier by printing a warning when this happens.

Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---
 arch/arm64/kvm/mmu.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index 3ab8eba808ae..d66d89c18045 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -1298,6 +1298,27 @@ int kvm_handle_guest_abort(struct kvm_vcpu *vcpu)
 	/* Userspace should not be able to register out-of-bounds IPAs */
 	VM_BUG_ON(fault_ipa >= kvm_phys_size(vcpu->kvm));
 
+	if (memslot_is_locked(memslot)) {
+		const char *fault_type_str;
+
+		if (kvm_vcpu_trap_is_exec_fault(vcpu))
+			goto handle_fault;
+
+		if (fault_status == FSC_ACCESS)
+			fault_type_str = "access";
+		else if (write_fault && (memslot->arch.flags & KVM_MEMSLOT_LOCK_WRITE))
+			fault_type_str = "write";
+		else if (!write_fault)
+			fault_type_str = "read";
+		else
+			goto handle_fault;
+
+		kvm_warn_ratelimited("Unexpected L2 %s fault on locked memslot %d: IPA=%#llx, ESR_EL2=%#08x]\n",
+				     fault_type_str, memslot->id, fault_ipa,
+				     kvm_vcpu_get_esr(vcpu));
+	}
+
+handle_fault:
 	if (fault_status == FSC_ACCESS) {
 		handle_access_fault(vcpu, fault_ipa);
 		ret = 1;
-- 
2.33.0

