Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35E1A33AA5B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 05:22:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbhCOETq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 00:19:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56527 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229596AbhCOETG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 00:19:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615781946;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BvHS/BwF/luD/hfhFoVXXGDgs7t17bADQvdo7r5hdpM=;
        b=A6f2+P5WaoCNolrWhqvLBNN/aPkDYy+1RBoycT3ZOosvH9YuiL9Gkkcm01QJkZcTm8ppC9
        HNr+qNd7Mq2NjAB1EZ0dvFkou3UB7dnTovuGYFp9s2nkRbiyc+9sOQ8DV+q9sazppiUxLp
        GM9bHkQjpPdfdugegiKKV/nAZwhqEw4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-273-S_trdE0ANZapXgRqgBAK8w-1; Mon, 15 Mar 2021 00:19:04 -0400
X-MC-Unique: S_trdE0ANZapXgRqgBAK8w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A5CD51074644;
        Mon, 15 Mar 2021 04:19:02 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-175.bne.redhat.com [10.64.54.175])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 34777437F;
        Mon, 15 Mar 2021 04:19:00 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     linux-kernel@vger.kernel.org, maz@kernel.org, will@kernel.org,
        alexandru.elisei@arm.com, shan.gavin@gmail.com
Subject: [PATCH 2/4] KVM: arm64: Use find_vma_intersection()
Date:   Mon, 15 Mar 2021 12:18:42 +0800
Message-Id: <20210315041844.64915-3-gshan@redhat.com>
In-Reply-To: <20210315041844.64915-1-gshan@redhat.com>
References: <20210315041844.64915-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

find_vma_intersection() has been existing to search the intersected
vma. This uses the function where it's applicable, to simplify the
code.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 arch/arm64/kvm/mmu.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index 84e70f953de6..286b603ed0d3 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -421,10 +421,11 @@ static void stage2_unmap_memslot(struct kvm *kvm,
 	 *     +--------------------------------------------+
 	 */
 	do {
-		struct vm_area_struct *vma = find_vma(current->mm, hva);
+		struct vm_area_struct *vma;
 		hva_t vm_start, vm_end;
 
-		if (!vma || vma->vm_start >= reg_end)
+		vma = find_vma_intersection(current->mm, hva, reg_end);
+		if (!vma)
 			break;
 
 		/*
@@ -1330,10 +1331,11 @@ int kvm_arch_prepare_memory_region(struct kvm *kvm,
 	 *     +--------------------------------------------+
 	 */
 	do {
-		struct vm_area_struct *vma = find_vma(current->mm, hva);
+		struct vm_area_struct *vma;
 		hva_t vm_start, vm_end;
 
-		if (!vma || vma->vm_start >= reg_end)
+		vma = find_vma_intersection(current->mm, hva, reg_end);
+		if (!vma)
 			break;
 
 		/*
-- 
2.23.0

