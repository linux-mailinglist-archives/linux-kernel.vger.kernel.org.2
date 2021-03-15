Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 375AA33AA5D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 05:22:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbhCOETs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 00:19:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28554 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229644AbhCOETM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 00:19:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615781952;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rXSTijt7gidLQQPy/2rs5NRzRMOxw7i4/nxpFVXB7rg=;
        b=A7gwIRSE/WwTYi0xd5kpbzkd0PAaLgpPBdnMPbiCbdasHDuFsaQdCQGWZsaIYOUOI+qEh3
        JWOL+I5XqdddzcFZkan3PNYHQsPsas1dYk5WJT6QejFJELFFB4+ccSD2kBHrAJkrxOA0Bp
        a1NMvk5RPWm5omSEHhmo1uIuyVPQAg4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-565-w5Gh56fvPIulZ3CuVGf7-g-1; Mon, 15 Mar 2021 00:19:10 -0400
X-MC-Unique: w5Gh56fvPIulZ3CuVGf7-g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3B41292500;
        Mon, 15 Mar 2021 04:19:09 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-175.bne.redhat.com [10.64.54.175])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B84A8437F;
        Mon, 15 Mar 2021 04:19:06 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     linux-kernel@vger.kernel.org, maz@kernel.org, will@kernel.org,
        alexandru.elisei@arm.com, shan.gavin@gmail.com
Subject: [PATCH 4/4] KVM: arm64: Don't retrieve memory slot again in page fault handler
Date:   Mon, 15 Mar 2021 12:18:44 +0800
Message-Id: <20210315041844.64915-5-gshan@redhat.com>
In-Reply-To: <20210315041844.64915-1-gshan@redhat.com>
References: <20210315041844.64915-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We needn't retrieve the memory slot again in user_mem_abort() because
the corresponding memory slot has been passed from the caller. This
would save some CPU cycles. For example, the time used to write 1GB
memory, which is backed by 2MB hugetlb pages and write-protected, is
dropped by 6.8% from 928ms to 864ms.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 arch/arm64/kvm/mmu.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index a5a8ade9fde4..4a4abcccfafb 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -846,7 +846,8 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 	 */
 	smp_rmb();
 
-	pfn = gfn_to_pfn_prot(kvm, gfn, write_fault, &writable);
+	pfn = __gfn_to_pfn_memslot(memslot, gfn, false, NULL,
+				   write_fault, &writable, NULL);
 	if (pfn == KVM_PFN_ERR_HWPOISON) {
 		kvm_send_hwpoison_signal(hva, vma_shift);
 		return 0;
@@ -912,7 +913,7 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 	/* Mark the page dirty only if the fault is handled successfully */
 	if (writable && !ret) {
 		kvm_set_pfn_dirty(pfn);
-		mark_page_dirty(kvm, gfn);
+		mark_page_dirty_in_slot(kvm, memslot, gfn);
 	}
 
 out_unlock:
-- 
2.23.0

