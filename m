Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E18ED37608D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 08:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234814AbhEGGmd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 02:42:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38422 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233971AbhEGGmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 02:42:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620369679;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hO4u9GtOW+oeNjEzwA96BYW48zYWKV+NBj9u1rYL9pE=;
        b=Wk8SLEbJ4fotZ67+XTqP3J0piZCAN4KGpaGX1QNDnPZWsVGzqQSL24BNRJN8esOStjO//U
        bkID5O+7x1dW1g6reH26wLlyxt0IaliDEHXrPHyFFZQtCm9LBy9ljiflL+RSY8rxnDkZ39
        GTSZCTcb1W2fFpAavEya0xZXqokEd9Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-332-7RKIP9jUPueX4lpoRMQFsQ-1; Fri, 07 May 2021 02:41:14 -0400
X-MC-Unique: 7RKIP9jUPueX4lpoRMQFsQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4E2FE1898297;
        Fri,  7 May 2021 06:41:13 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-42.bne.redhat.com [10.64.54.42])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8FBD15C276;
        Fri,  7 May 2021 06:41:09 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     linux-kernel@vger.kernel.org, maz@kernel.org, will@kernel.org,
        pbonzini@redhat.com, james.morse@arm.com, mark.rutland@arm.com,
        Jonathan.Cameron@huawei.com, shan.gavin@gmail.com
Subject: [PATCH v3 05/15] KVM: arm64: Export kvm_handle_user_mem_abort()
Date:   Fri,  7 May 2021 16:40:43 +0800
Message-Id: <20210507084053.44407-6-gshan@redhat.com>
In-Reply-To: <20210507084053.44407-1-gshan@redhat.com>
References: <20210507084053.44407-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The main work of stage-2 page fault is handled by user_mem_abort().
When asynchronous page fault is supported, one page fault need to
be handled with two calls to this function. It means the page fault
needs to be replayed asynchronously in that case.

   * This renames the function to kvm_handle_user_mem_abort() and
     exports it.

   * Add arguments @esr and @prefault to user_mem_abort(). @esr is
     the cached value of ESR_EL2 instead of fetching from the current
     vCPU when the page fault is replayed in scenario of asynchronous
     page fault. @prefault is used to indicate the page fault is replayed
     one or not.

   * Define helper functions esr_dbat_*() in asm/esr.h to extract
     or check various fields of the passed ESR_EL2 value because
     those helper functions defined in asm/kvm_emulate.h assumes
     the ESR_EL2 value has been cached in vCPU struct. It won't
     be true on handling the replayed page fault in scenario of
     asynchronous page fault.

   * Some helper functions defined in asm/kvm_emulate.h are used
     by mmu.c only and seem not to be used by other source file
     in near future. They are moved to mmu.c and renamed accordingly.

     is_exec_fault: kvm_vcpu_trap_is_exec_fault
     is_write_fault: kvm_is_write_fault()
     esr_abt_fault_level: kvm_vcpu_trap_get_fault_level

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 arch/arm64/include/asm/esr.h         |  6 ++++
 arch/arm64/include/asm/kvm_emulate.h | 27 ++---------------
 arch/arm64/include/asm/kvm_host.h    |  4 +++
 arch/arm64/kvm/mmu.c                 | 43 ++++++++++++++++++++++------
 4 files changed, 48 insertions(+), 32 deletions(-)

diff --git a/arch/arm64/include/asm/esr.h b/arch/arm64/include/asm/esr.h
index 29f97eb3dad4..0f2cb27691de 100644
--- a/arch/arm64/include/asm/esr.h
+++ b/arch/arm64/include/asm/esr.h
@@ -321,8 +321,14 @@
 					 ESR_ELx_CP15_32_ISS_DIR_READ)
 
 #ifndef __ASSEMBLY__
+#include <linux/bitfield.h>
 #include <asm/types.h>
 
+#define esr_dabt_fault_type(esr)	(esr & ESR_ELx_FSC_TYPE)
+#define esr_dabt_fault_level(esr)	(FIELD_GET(ESR_ELx_FSC_LEVEL, esr))
+#define esr_dabt_is_wnr(esr)		(!!(FIELD_GET(ESR_ELx_WNR, esr)))
+#define esr_dabt_is_s1ptw(esr)		(!!(FIELD_GET(ESR_ELx_S1PTW, esr)))
+
 static inline bool esr_is_data_abort(u32 esr)
 {
 	const u32 ec = ESR_ELx_EC(esr);
diff --git a/arch/arm64/include/asm/kvm_emulate.h b/arch/arm64/include/asm/kvm_emulate.h
index 0ef213b715a5..4dd6a658ff86 100644
--- a/arch/arm64/include/asm/kvm_emulate.h
+++ b/arch/arm64/include/asm/kvm_emulate.h
@@ -282,13 +282,13 @@ static __always_inline int kvm_vcpu_dabt_get_rd(const struct kvm_vcpu *vcpu)
 
 static __always_inline bool kvm_vcpu_abt_iss1tw(const struct kvm_vcpu *vcpu)
 {
-	return !!(kvm_vcpu_get_esr(vcpu) & ESR_ELx_S1PTW);
+	return esr_dabt_is_s1ptw(kvm_vcpu_get_esr(vcpu));
 }
 
 /* Always check for S1PTW *before* using this. */
 static __always_inline bool kvm_vcpu_dabt_iswrite(const struct kvm_vcpu *vcpu)
 {
-	return kvm_vcpu_get_esr(vcpu) & ESR_ELx_WNR;
+	return esr_dabt_is_wnr(kvm_vcpu_get_esr(vcpu));
 }
 
 static inline bool kvm_vcpu_dabt_is_cm(const struct kvm_vcpu *vcpu)
@@ -317,11 +317,6 @@ static inline bool kvm_vcpu_trap_is_iabt(const struct kvm_vcpu *vcpu)
 	return kvm_vcpu_trap_get_class(vcpu) == ESR_ELx_EC_IABT_LOW;
 }
 
-static inline bool kvm_vcpu_trap_is_exec_fault(const struct kvm_vcpu *vcpu)
-{
-	return kvm_vcpu_trap_is_iabt(vcpu) && !kvm_vcpu_abt_iss1tw(vcpu);
-}
-
 static __always_inline u8 kvm_vcpu_trap_get_fault(const struct kvm_vcpu *vcpu)
 {
 	return kvm_vcpu_get_esr(vcpu) & ESR_ELx_FSC;
@@ -329,12 +324,7 @@ static __always_inline u8 kvm_vcpu_trap_get_fault(const struct kvm_vcpu *vcpu)
 
 static __always_inline u8 kvm_vcpu_trap_get_fault_type(const struct kvm_vcpu *vcpu)
 {
-	return kvm_vcpu_get_esr(vcpu) & ESR_ELx_FSC_TYPE;
-}
-
-static __always_inline u8 kvm_vcpu_trap_get_fault_level(const struct kvm_vcpu *vcpu)
-{
-	return kvm_vcpu_get_esr(vcpu) & ESR_ELx_FSC_LEVEL;
+	return esr_dabt_fault_type(kvm_vcpu_get_esr(vcpu));
 }
 
 static __always_inline bool kvm_vcpu_abt_issea(const struct kvm_vcpu *vcpu)
@@ -362,17 +352,6 @@ static __always_inline int kvm_vcpu_sys_get_rt(struct kvm_vcpu *vcpu)
 	return ESR_ELx_SYS64_ISS_RT(esr);
 }
 
-static inline bool kvm_is_write_fault(struct kvm_vcpu *vcpu)
-{
-	if (kvm_vcpu_abt_iss1tw(vcpu))
-		return true;
-
-	if (kvm_vcpu_trap_is_iabt(vcpu))
-		return false;
-
-	return kvm_vcpu_dabt_iswrite(vcpu);
-}
-
 static inline unsigned long kvm_vcpu_get_mpidr_aff(struct kvm_vcpu *vcpu)
 {
 	return vcpu_read_sys_reg(vcpu, MPIDR_EL1) & MPIDR_HWID_BITMASK;
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 8944176efa94..822781f94cb0 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -599,6 +599,10 @@ int __kvm_arm_vcpu_set_events(struct kvm_vcpu *vcpu,
 
 #define KVM_ARCH_WANT_MMU_NOTIFIER
 
+int kvm_handle_user_mem_abort(struct kvm_vcpu *vcpu,
+			      struct kvm_memory_slot *memslot,
+			      phys_addr_t fault_ipa, unsigned long hva,
+			      unsigned int esr, bool prefault);
 void kvm_arm_halt_guest(struct kvm *kvm);
 void kvm_arm_resume_guest(struct kvm *kvm);
 
diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index c5d1f3c87dbd..2b8035fc7b47 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -822,9 +822,34 @@ transparent_hugepage_adjust(struct kvm_memory_slot *memslot,
 	return PAGE_SIZE;
 }
 
-static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
-			  struct kvm_memory_slot *memslot, unsigned long hva,
-			  unsigned long fault_status)
+static inline bool is_exec_fault(unsigned int esr)
+{
+	if (ESR_ELx_EC(esr) != ESR_ELx_EC_IABT_LOW)
+		return false;
+
+	if (esr_dabt_is_s1ptw(esr))
+		return false;
+
+	return true;
+}
+
+static inline bool is_write_fault(unsigned int esr)
+{
+	if (esr_dabt_is_s1ptw(esr))
+		return true;
+
+	if (ESR_ELx_EC(esr) == ESR_ELx_EC_IABT_LOW)
+		return false;
+
+	return esr_dabt_is_wnr(esr);
+}
+
+int kvm_handle_user_mem_abort(struct kvm_vcpu *vcpu,
+			      struct kvm_memory_slot *memslot,
+			      phys_addr_t fault_ipa,
+			      unsigned long hva,
+			      unsigned int esr,
+			      bool prefault)
 {
 	int ret = 0;
 	bool write_fault, writable, force_pte = false;
@@ -838,14 +863,15 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 	gfn_t gfn;
 	kvm_pfn_t pfn;
 	bool logging_active = memslot_is_logging(memslot);
-	unsigned long fault_level = kvm_vcpu_trap_get_fault_level(vcpu);
+	unsigned int fault_status = esr_dabt_fault_type(esr);
+	unsigned long fault_level = esr_dabt_fault_level(esr);
 	unsigned long vma_pagesize, fault_granule;
 	enum kvm_pgtable_prot prot = KVM_PGTABLE_PROT_R;
 	struct kvm_pgtable *pgt;
 
 	fault_granule = 1UL << ARM64_HW_PGTABLE_LEVEL_SHIFT(fault_level);
-	write_fault = kvm_is_write_fault(vcpu);
-	exec_fault = kvm_vcpu_trap_is_exec_fault(vcpu);
+	write_fault = is_write_fault(kvm_vcpu_get_esr(vcpu));
+	exec_fault = is_exec_fault(kvm_vcpu_get_esr(vcpu));
 	VM_BUG_ON(write_fault && exec_fault);
 
 	if (fault_status == FSC_PERM && !write_fault && !exec_fault) {
@@ -1085,7 +1111,7 @@ int kvm_handle_guest_abort(struct kvm_vcpu *vcpu)
 	gfn = fault_ipa >> PAGE_SHIFT;
 	memslot = gfn_to_memslot(vcpu->kvm, gfn);
 	hva = gfn_to_hva_memslot_prot(memslot, gfn, &writable);
-	write_fault = kvm_is_write_fault(vcpu);
+	write_fault = is_write_fault(kvm_vcpu_get_esr(vcpu));
 	if (kvm_is_error_hva(hva) || (write_fault && !writable)) {
 		/*
 		 * The guest has put either its instructions or its page-tables
@@ -1140,7 +1166,8 @@ int kvm_handle_guest_abort(struct kvm_vcpu *vcpu)
 		goto out_unlock;
 	}
 
-	ret = user_mem_abort(vcpu, fault_ipa, memslot, hva, fault_status);
+	ret = kvm_handle_user_mem_abort(vcpu, memslot, fault_ipa, hva,
+					kvm_vcpu_get_esr(vcpu), false);
 	if (ret == 0)
 		ret = 1;
 out:
-- 
2.23.0

