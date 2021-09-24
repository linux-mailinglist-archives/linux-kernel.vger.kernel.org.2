Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1BC74178B8
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 18:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347926AbhIXQe1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 12:34:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25221 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347565AbhIXQdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 12:33:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632501131;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Gn1zn/rbvliUrNM/Z2t5HEAi7A10SPc9HMnuFcnoNQ4=;
        b=FBvnTxV/5vx6lNdP9kWS4boS6HEoAbi3VVbgMWC44nN7Sjlk2XaorYIkE5pxeKJOVIV/ch
        oZgvApRfI8T1jWBzlG8RvolJRuFweeCKAyYLndfXogd+5A7i0j5NO9CUSWFeCGk07xqKwN
        vlCI0ZF861k6gN4BjoSzVEKrRiafmJw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-296-j9x7XY8ZOlaH22ns46zx6g-1; Fri, 24 Sep 2021 12:32:08 -0400
X-MC-Unique: j9x7XY8ZOlaH22ns46zx6g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9E04F802E71;
        Fri, 24 Sep 2021 16:32:06 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E5B9F795B0;
        Fri, 24 Sep 2021 16:32:05 +0000 (UTC)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     dmatlack@google.com, seanjc@google.com
Subject: [PATCH v3 22/31] KVM: MMU: inline set_spte in mmu_set_spte
Date:   Fri, 24 Sep 2021 12:31:43 -0400
Message-Id: <20210924163152.289027-23-pbonzini@redhat.com>
In-Reply-To: <20210924163152.289027-1-pbonzini@redhat.com>
References: <20210924163152.289027-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the two callers of set_spte do different things with the results,
inlining it actually makes the code simpler to reason about.  For example,
mmu_set_spte looks quite like tdp_mmu_map_handle_target_level, but the
similarity is hidden by set_spte.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/mmu/mmu.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index d63fe7b10bd1..6ba7c60bd4f8 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -2700,10 +2700,12 @@ static int mmu_set_spte(struct kvm_vcpu *vcpu, u64 *sptep,
 			gfn_t gfn, kvm_pfn_t pfn, bool speculative,
 			bool host_writable)
 {
+	struct kvm_mmu_page *sp = sptep_to_sp(sptep);
 	int was_rmapped = 0;
-	int set_spte_ret;
 	int ret = RET_PF_FIXED;
 	bool flush = false;
+	int make_spte_ret;
+	u64 spte;
 
 	pgprintk("%s: spte %llx write_fault %d gfn %llx\n", __func__,
 		 *sptep, write_fault, gfn);
@@ -2734,30 +2736,29 @@ static int mmu_set_spte(struct kvm_vcpu *vcpu, u64 *sptep,
 			was_rmapped = 1;
 	}
 
-	set_spte_ret = set_spte(vcpu, sptep, pte_access, level, gfn, pfn,
-				speculative, true, host_writable);
-	if (set_spte_ret & SET_SPTE_WRITE_PROTECTED_PT) {
+	make_spte_ret = make_spte(vcpu, pte_access, level, gfn, pfn, *sptep, speculative,
+				 true, host_writable, sp_ad_disabled(sp), &spte);
+
+	if (*sptep == spte) {
+		ret = RET_PF_SPURIOUS;
+	} else {
+		trace_kvm_mmu_set_spte(level, gfn, sptep);
+		flush |= mmu_spte_update(sptep, spte);
+	}
+
+	if (make_spte_ret & SET_SPTE_WRITE_PROTECTED_PT) {
 		if (write_fault)
 			ret = RET_PF_EMULATE;
 	}
 
-	if (set_spte_ret & SET_SPTE_NEED_REMOTE_TLB_FLUSH || flush)
+	if (flush)
 		kvm_flush_remote_tlbs_with_address(vcpu->kvm, gfn,
 				KVM_PAGES_PER_HPAGE(level));
 
-	/*
-	 * The fault is fully spurious if and only if the new SPTE and old SPTE
-	 * are identical, and emulation is not required.
-	 */
-	if ((set_spte_ret & SET_SPTE_SPURIOUS) && ret == RET_PF_FIXED) {
-		WARN_ON_ONCE(!was_rmapped);
-		return RET_PF_SPURIOUS;
-	}
-
 	pgprintk("%s: setting spte %llx\n", __func__, *sptep);
-	trace_kvm_mmu_set_spte(level, gfn, sptep);
 
 	if (!was_rmapped) {
+		WARN_ON_ONCE(ret == RET_PF_SPURIOUS);
 		kvm_update_page_stats(vcpu->kvm, level, 1);
 		rmap_add(vcpu, sptep, gfn);
 	}
-- 
2.27.0


