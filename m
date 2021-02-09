Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C1C73147E3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 06:08:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbhBIFHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 00:07:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:38749 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229853AbhBIFGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 00:06:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612847078;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zcIOJsfR5kW5YDNliY+nt3uBPyj7GiL6t2yI8D04j0s=;
        b=G0Uaug5BS/dp1PmPcTE5A8E9ksgE1WBAXz3cws5QSzTUdIbIK8cxlfobity3LciJHjn1ri
        UZWuMOdnBru0QyM/CIKxVV5w7pFMSb3ZdZO4KVzHfxCFJiERaFWaVRWjEgATE8L/oLb2q/
        Gf3LvbBObYCznnIAKMcv1vTC+LD8Klo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-336-kPIsWSOAO6aoi595So5JjA-1; Tue, 09 Feb 2021 00:04:35 -0500
X-MC-Unique: kPIsWSOAO6aoi595So5JjA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 47D22803F49;
        Tue,  9 Feb 2021 05:04:34 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-26.bne.redhat.com [10.64.54.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 49E385D9C0;
        Tue,  9 Feb 2021 05:04:27 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     linux-kernel@vger.kernel.org, pbonzini@redhat.com, maz@kernel.org,
        james.morse@arm.com, Jonathan.Cameron@huawei.com,
        mark.rutland@arm.com, will@kernel.org, shan.gavin@gmail.com
Subject: [PATCH v2 04/17] KVM: x86: Use generic async PF slot management
Date:   Tue,  9 Feb 2021 13:03:50 +0800
Message-Id: <20210209050403.103143-5-gshan@redhat.com>
In-Reply-To: <20210209050403.103143-1-gshan@redhat.com>
References: <20210209050403.103143-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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
 arch/x86/include/asm/kvm_host.h |  1 -
 arch/x86/kvm/Kconfig            |  1 +
 arch/x86/kvm/mmu/mmu.c          |  2 +-
 arch/x86/kvm/x86.c              | 86 +++------------------------------
 4 files changed, 8 insertions(+), 82 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 3d6616f6f6ef..3488eeb79c79 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1714,7 +1714,6 @@ void kvm_arch_async_page_ready(struct kvm_vcpu *vcpu,
 			       struct kvm_async_pf *work);
 void kvm_arch_async_page_present_queued(struct kvm_vcpu *vcpu);
 bool kvm_arch_can_dequeue_async_page_present(struct kvm_vcpu *vcpu);
-extern bool kvm_find_async_pf_gfn(struct kvm_vcpu *vcpu, gfn_t gfn);
 
 int kvm_skip_emulated_instruction(struct kvm_vcpu *vcpu);
 int kvm_complete_insn_gp(struct kvm_vcpu *vcpu, int err);
diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
index 7ac592664c52..b0ad75087ab5 100644
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
index 6d16481aa29d..ca2e84d6743c 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -3678,7 +3678,7 @@ static bool try_async_pf(struct kvm_vcpu *vcpu, bool prefault, gfn_t gfn,
 
 	if (!prefault && kvm_can_do_async_pf(vcpu)) {
 		trace_kvm_try_async_get_page(cr2_or_gpa, gfn);
-		if (kvm_find_async_pf_gfn(vcpu, gfn)) {
+		if (kvm_async_pf_find_slot(vcpu, gfn)) {
 			trace_kvm_async_pf_doublefault(cr2_or_gpa, gfn);
 			kvm_make_request(KVM_REQ_APF_HALT, vcpu);
 			return true;
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index f3c9fe5c424e..b04d78a87abe 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -290,13 +290,6 @@ static struct kmem_cache *kvm_alloc_emulator_cache(void)
 
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
@@ -812,7 +805,7 @@ void kvm_post_set_cr0(struct kvm_vcpu *vcpu, unsigned long old_cr0, unsigned lon
 
 	if ((cr0 ^ old_cr0) & X86_CR0_PG) {
 		kvm_clear_async_pf_completion_queue(vcpu);
-		kvm_async_pf_hash_reset(vcpu);
+		kvm_async_pf_reset_slot(vcpu);
 	}
 
 	if ((cr0 ^ old_cr0) & update_bits)
@@ -2905,7 +2898,7 @@ static int kvm_pv_enable_async_pf(struct kvm_vcpu *vcpu, u64 data)
 
 	if (!kvm_pv_async_pf_enabled(vcpu)) {
 		kvm_clear_async_pf_completion_queue(vcpu);
-		kvm_async_pf_hash_reset(vcpu);
+		kvm_async_pf_reset_slot(vcpu);
 		return 0;
 	}
 
@@ -9996,7 +9989,7 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
 
 	vcpu->arch.pat = MSR_IA32_CR_PAT_DEFAULT;
 
-	kvm_async_pf_hash_reset(vcpu);
+	kvm_async_pf_reset_slot(vcpu);
 	kvm_pmu_init(vcpu);
 
 	vcpu->arch.pending_external_vector = -1;
@@ -10117,7 +10110,7 @@ void kvm_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
 	kvmclock_reset(vcpu);
 
 	kvm_clear_async_pf_completion_queue(vcpu);
-	kvm_async_pf_hash_reset(vcpu);
+	kvm_async_pf_reset_slot(vcpu);
 	vcpu->arch.apf.halted = false;
 
 	if (vcpu->arch.guest_fpu && kvm_mpx_supported()) {
@@ -10932,73 +10925,6 @@ void kvm_arch_async_page_ready(struct kvm_vcpu *vcpu, struct kvm_async_pf *work)
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
@@ -11062,7 +10988,7 @@ bool kvm_arch_async_page_not_present(struct kvm_vcpu *vcpu,
 	struct x86_exception fault;
 
 	trace_kvm_async_pf_not_present(work->arch.token, work->cr2_or_gpa);
-	kvm_add_async_pf_gfn(vcpu, work->arch.gfn);
+	kvm_async_pf_add_slot(vcpu, work->arch.gfn);
 
 	if (kvm_can_deliver_async_pf(vcpu) &&
 	    !apf_put_user_notpresent(vcpu)) {
@@ -11099,7 +11025,7 @@ void kvm_arch_async_page_present(struct kvm_vcpu *vcpu,
 	if (work->wakeup_all)
 		work->arch.token = ~0; /* broadcast wakeup */
 	else
-		kvm_del_async_pf_gfn(vcpu, work->arch.gfn);
+		kvm_async_pf_remove_slot(vcpu, work->arch.gfn);
 	trace_kvm_async_pf_ready(work->arch.token, work->cr2_or_gpa);
 
 	if ((work->wakeup_all || work->notpresent_injected) &&
-- 
2.23.0

