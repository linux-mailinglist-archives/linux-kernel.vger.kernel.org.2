Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68EBB33CC71
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 05:13:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233593AbhCPEMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 00:12:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:51303 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229894AbhCPELq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 00:11:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615867906;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hGQu6Iyp8Y2I2yKE1NAdsEcAZL0FpRmrQ13l4m0YyJc=;
        b=JsxE+DiolcHDSVkMLPuK9+L7efYrTMmmifX8EtI6rwaaVPGJ4SP39TnfQ7HIJLyINDfT7R
        jmes71JOvJX/AMn4hdDDvLftXQ1+e5xtbsL1n3D3ADhWCMTRifmOeTzVnGhqgHt7QPG1QA
        z66x+bfZAyMeBsFrBEoyBcydOqs7020=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-158-wInswR3qPoeVpv7yQz-IlA-1; Tue, 16 Mar 2021 00:11:42 -0400
X-MC-Unique: wInswR3qPoeVpv7yQz-IlA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2658D107ACCA;
        Tue, 16 Mar 2021 04:11:41 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-175.bne.redhat.com [10.64.54.175])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 73C595B4A8;
        Tue, 16 Mar 2021 04:11:39 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     linux-kernel@vger.kernel.org, maz@kernel.org, will@kernel.org,
        zhukeqian1@huawei.com, shan.gavin@gmail.com
Subject: [PATCH v2 3/3] KVM: arm64: Don't retrieve memory slot again in page fault handler
Date:   Tue, 16 Mar 2021 12:11:26 +0800
Message-Id: <20210316041126.81860-4-gshan@redhat.com>
In-Reply-To: <20210316041126.81860-1-gshan@redhat.com>
References: <20210316041126.81860-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We needn't retrieve the memory slot again in user_mem_abort() because
the corresponding memory slot has been passed from the caller. This
would save some CPU cycles. For example, the time used to write 1GB
memory, which is backed by 2MB hugetlb pages and write-protected, is
dropped by 6.8% from 928ms to 864ms.

Signed-off-by: Gavin Shan <gshan@redhat.com>
Reviewed-by: Keqian Zhu <zhukeqian1@huawei.com>
---
 arch/arm64/kvm/mmu.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index 192e0df2fc8e..2491b40a294a 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -843,10 +843,15 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 	 * unmapped afterwards, the call to kvm_unmap_hva will take it away
 	 * from us again properly. This smp_rmb() interacts with the smp_wmb()
 	 * in kvm_mmu_notifier_invalidate_<page|range_end>.
+	 *
+	 * Besides, __gfn_to_pfn_memslot() instead of gfn_to_pfn_prot() is
+	 * used to avoid unnecessary overhead introduced to locate the memory
+	 * slot because it's always fixed even @gfn is adjusted for huge pages.
 	 */
 	smp_rmb();
 
-	pfn = gfn_to_pfn_prot(kvm, gfn, write_fault, &writable);
+	pfn = __gfn_to_pfn_memslot(memslot, gfn, false, NULL,
+				   write_fault, &writable, NULL);
 	if (pfn == KVM_PFN_ERR_HWPOISON) {
 		kvm_send_hwpoison_signal(hva, vma_shift);
 		return 0;
@@ -912,7 +917,7 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 	/* Mark the page dirty only if the fault is handled successfully */
 	if (writable && !ret) {
 		kvm_set_pfn_dirty(pfn);
-		mark_page_dirty(kvm, gfn);
+		mark_page_dirty_in_slot(kvm, memslot, gfn);
 	}
 
 out_unlock:
-- 
2.23.0

