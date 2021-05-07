Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1743F37608A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 08:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234553AbhEGGmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 02:42:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25176 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233885AbhEGGmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 02:42:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620369674;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2LI4eA946eDRWIry8QnZkm27lHt9ZmwJpghwYcjQ8ho=;
        b=LF+tHa6Uk8/UiM13GKTqHkAsn+prjrl94QD98ReXLuuEaZAYtedcOI9LWfaY+NResAzSv8
        g85qzos9hKIfUduCOkhR7YeGSfGV6yhqoDWcTVv1yycKL0YSBYKqhKbwJaSTbrskrWfUAJ
        EXVbixK1g2Es2/SssQmlAd2rdnZHpbs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-595-3DLZyLT6Oge5zxVWb319iQ-1; Fri, 07 May 2021 02:41:10 -0400
X-MC-Unique: 3DLZyLT6Oge5zxVWb319iQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 09160801817;
        Fri,  7 May 2021 06:41:09 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-42.bne.redhat.com [10.64.54.42])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B55655C276;
        Fri,  7 May 2021 06:41:06 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     linux-kernel@vger.kernel.org, maz@kernel.org, will@kernel.org,
        pbonzini@redhat.com, james.morse@arm.com, mark.rutland@arm.com,
        Jonathan.Cameron@huawei.com, shan.gavin@gmail.com
Subject: [PATCH v3 04/15] KVM: x86: Use generic async PF slot management
Date:   Fri,  7 May 2021 16:40:42 +0800
Message-Id: <20210507084053.44407-5-gshan@redhat.com>
In-Reply-To: <20210507084053.44407-1-gshan@redhat.com>
References: <20210507084053.44407-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This uses the generic slot management mechanism for asynchronous
page fault by enabling CONFIG_KVM_ASYNC_PF_SLOT because the private
implementation is totally duplicate to the generic one.

The changes introduced by this is pretty mechanical and shouldn't
cause any logical changes.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 arch/x86/include/asm/kvm_host.h |  2 -
 arch/x86/kvm/Kconfig            |  1 +
 arch/x86/kvm/mmu/mmu.c          |  2 +-
 arch/x86/kvm/x86.c              | 86 +++------------------------------
 4 files changed, 8 insertions(+), 83 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index cbbcee0a84f9..9b344a71f083 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -766,7 +766,6 @@ struct kvm_vcpu_arch {
 
 	struct {
 		bool halted;
-		gfn_t gfns[ASYNC_PF_PER_VCPU];
 		struct gfn_to_hva_cache data;
 		u64 msr_en_val; /* MSR_KVM_ASYNC_PF_EN */
 		u64 msr_int_val; /* MSR_KVM_ASYNC_PF_INT */
@@ -1797,7 +1796,6 @@ void kvm_arch_async_page_ready(struct kvm_vcpu *vcpu,
 			       struct kvm_async_pf *work);
 void kvm_arch_async_page_present_queued(struct kvm_vcpu *vcpu);
 bool kvm_arch_can_dequeue_async_page_present(struct kvm_vcpu *vcpu);
-extern bool kvm_find_async_pf_gfn(struct kvm_vcpu *vcpu, gfn_t gfn);
 
 int kvm_skip_emulated_instruction(struct kvm_vcpu *vcpu);
 int kvm_complete_insn_gp(struct kvm_vcpu *vcpu, int err);
diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
index f6b93a35ce14..8b8ae8a0467d 100644
--- a/arch/x86/kvm/Kconfig
+++ b/arch/x86/kvm/Kconfig
@@ -34,6 +34,7 @@ config KVM
 	select HAVE_KVM_IRQ_ROUTING
 	select HAVE_KVM_EVENTFD
 	select KVM_ASYNC_PF
+	select KVM_ASYNC_PF_SLOT
 	select USER_RETURN_NOTIFIER
 	select KVM_MMIO
 	select TASKSTATS
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 4b3ee244ebe0..c355d980fd9a 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -3701,7 +3701,7 @@ static bool try_async_pf(struct kvm_vcpu *vcpu, bool prefault, gfn_t gfn,
 
 	if (!prefault && kvm_can_do_async_pf(vcpu)) {
 		trace_kvm_try_async_get_page(cr2_or_gpa, gfn);
-		if (kvm_find_async_pf_gfn(vcpu, gfn)) {
+		if (kvm_async_pf_find_slot(vcpu, gfn)) {
 			trace_kvm_async_pf_doublefault(cr2_or_gpa, gfn);
 			kvm_make_request(KVM_REQ_APF_HALT, vcpu);
 			return true;
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 300661dc6ca4..55d53082a8df 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -305,13 +305,6 @@ static struct kmem_cache *kvm_alloc_emulator_cache(void)
 
 static int emulator_fix_hypercall(struct x86_emulate_ctxt *ctxt);
 
-static inline void kvm_async_pf_hash_reset(struct kvm_vcpu *vcpu)
-{
-	int i;
-	for (i = 0; i < ASYNC_PF_PER_VCPU; i++)
-		vcpu->arch.apf.gfns[i] = ~0;
-}
-
 static void kvm_on_user_return(struct user_return_notifier *urn)
 {
 	unsigned slot;
@@ -829,7 +822,7 @@ void kvm_post_set_cr0(struct kvm_vcpu *vcpu, unsigned long old_cr0, unsigned lon
 
 	if ((cr0 ^ old_cr0) & X86_CR0_PG) {
 		kvm_clear_async_pf_completion_queue(vcpu);
-		kvm_async_pf_hash_reset(vcpu);
+		kvm_async_pf_reset_slot(vcpu);
 	}
 
 	if ((cr0 ^ old_cr0) & update_bits)
@@ -2959,7 +2952,7 @@ static int kvm_pv_enable_async_pf(struct kvm_vcpu *vcpu, u64 data)
 
 	if (!kvm_pv_async_pf_enabled(vcpu)) {
 		kvm_clear_async_pf_completion_queue(vcpu);
-		kvm_async_pf_hash_reset(vcpu);
+		kvm_async_pf_reset_slot(vcpu);
 		return 0;
 	}
 
@@ -10264,7 +10257,7 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
 
 	vcpu->arch.pat = MSR_IA32_CR_PAT_DEFAULT;
 
-	kvm_async_pf_hash_reset(vcpu);
+	kvm_async_pf_reset_slot(vcpu);
 	kvm_pmu_init(vcpu);
 
 	vcpu->arch.pending_external_vector = -1;
@@ -10381,7 +10374,7 @@ void kvm_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
 	kvmclock_reset(vcpu);
 
 	kvm_clear_async_pf_completion_queue(vcpu);
-	kvm_async_pf_hash_reset(vcpu);
+	kvm_async_pf_reset_slot(vcpu);
 	vcpu->arch.apf.halted = false;
 
 	if (vcpu->arch.guest_fpu && kvm_mpx_supported()) {
@@ -11221,73 +11214,6 @@ void kvm_arch_async_page_ready(struct kvm_vcpu *vcpu, struct kvm_async_pf *work)
 	kvm_mmu_do_page_fault(vcpu, work->cr2_or_gpa, 0, true);
 }
 
-static inline u32 kvm_async_pf_hash_fn(gfn_t gfn)
-{
-	BUILD_BUG_ON(!is_power_of_2(ASYNC_PF_PER_VCPU));
-
-	return hash_32(gfn & 0xffffffff, order_base_2(ASYNC_PF_PER_VCPU));
-}
-
-static inline u32 kvm_async_pf_next_probe(u32 key)
-{
-	return (key + 1) & (ASYNC_PF_PER_VCPU - 1);
-}
-
-static void kvm_add_async_pf_gfn(struct kvm_vcpu *vcpu, gfn_t gfn)
-{
-	u32 key = kvm_async_pf_hash_fn(gfn);
-
-	while (vcpu->arch.apf.gfns[key] != ~0)
-		key = kvm_async_pf_next_probe(key);
-
-	vcpu->arch.apf.gfns[key] = gfn;
-}
-
-static u32 kvm_async_pf_gfn_slot(struct kvm_vcpu *vcpu, gfn_t gfn)
-{
-	int i;
-	u32 key = kvm_async_pf_hash_fn(gfn);
-
-	for (i = 0; i < ASYNC_PF_PER_VCPU &&
-		     (vcpu->arch.apf.gfns[key] != gfn &&
-		      vcpu->arch.apf.gfns[key] != ~0); i++)
-		key = kvm_async_pf_next_probe(key);
-
-	return key;
-}
-
-bool kvm_find_async_pf_gfn(struct kvm_vcpu *vcpu, gfn_t gfn)
-{
-	return vcpu->arch.apf.gfns[kvm_async_pf_gfn_slot(vcpu, gfn)] == gfn;
-}
-
-static void kvm_del_async_pf_gfn(struct kvm_vcpu *vcpu, gfn_t gfn)
-{
-	u32 i, j, k;
-
-	i = j = kvm_async_pf_gfn_slot(vcpu, gfn);
-
-	if (WARN_ON_ONCE(vcpu->arch.apf.gfns[i] != gfn))
-		return;
-
-	while (true) {
-		vcpu->arch.apf.gfns[i] = ~0;
-		do {
-			j = kvm_async_pf_next_probe(j);
-			if (vcpu->arch.apf.gfns[j] == ~0)
-				return;
-			k = kvm_async_pf_hash_fn(vcpu->arch.apf.gfns[j]);
-			/*
-			 * k lies cyclically in ]i,j]
-			 * |    i.k.j |
-			 * |....j i.k.| or  |.k..j i...|
-			 */
-		} while ((i <= j) ? (i < k && k <= j) : (i < k || k <= j));
-		vcpu->arch.apf.gfns[i] = vcpu->arch.apf.gfns[j];
-		i = j;
-	}
-}
-
 static inline int apf_put_user_notpresent(struct kvm_vcpu *vcpu)
 {
 	u32 reason = KVM_PV_REASON_PAGE_NOT_PRESENT;
@@ -11351,7 +11277,7 @@ bool kvm_arch_async_page_not_present(struct kvm_vcpu *vcpu,
 	struct x86_exception fault;
 
 	trace_kvm_async_pf_not_present(work->arch.token, work->cr2_or_gpa);
-	kvm_add_async_pf_gfn(vcpu, work->arch.gfn);
+	kvm_async_pf_add_slot(vcpu, work->arch.gfn);
 
 	if (kvm_can_deliver_async_pf(vcpu) &&
 	    !apf_put_user_notpresent(vcpu)) {
@@ -11388,7 +11314,7 @@ void kvm_arch_async_page_present(struct kvm_vcpu *vcpu,
 	if (work->wakeup_all)
 		work->arch.token = ~0; /* broadcast wakeup */
 	else
-		kvm_del_async_pf_gfn(vcpu, work->arch.gfn);
+		kvm_async_pf_remove_slot(vcpu, work->arch.gfn);
 	trace_kvm_async_pf_ready(work->arch.token, work->cr2_or_gpa);
 
 	if ((work->wakeup_all || work->notpresent_injected) &&
-- 
2.23.0

