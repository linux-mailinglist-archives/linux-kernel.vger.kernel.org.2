Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFD9733AA5A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 05:22:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbhCOETp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 00:19:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55194 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229466AbhCOETD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 00:19:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615781942;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=niUH05AVdN2hhbnj1s3y6k14bUreXft9TbXu/Kcwhaw=;
        b=Qxq0VOYDKy6VV9yHNEff2z54cR2JfVKe1Vj7J/kZnpfNNEATN2WivEkAHRzna/A6UGCT41
        jrsZIBtivM8opdMclJEOidgll/d8O3qcwbrRplF0UQEqgZAKJpfYirQwupOyKiyeIUq7Pa
        fpx5aTOwpvoIu1694yTCMxX8iMnoMGE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-592-H1EEynhRPpKfXSjO5diaRg-1; Mon, 15 Mar 2021 00:19:01 -0400
X-MC-Unique: H1EEynhRPpKfXSjO5diaRg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B7C29802B7E;
        Mon, 15 Mar 2021 04:18:59 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-175.bne.redhat.com [10.64.54.175])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DC0F8437F;
        Mon, 15 Mar 2021 04:18:57 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     linux-kernel@vger.kernel.org, maz@kernel.org, will@kernel.org,
        alexandru.elisei@arm.com, shan.gavin@gmail.com
Subject: [PATCH 1/4] KVM: arm64: Hide kvm_mmu_wp_memory_region()
Date:   Mon, 15 Mar 2021 12:18:41 +0800
Message-Id: <20210315041844.64915-2-gshan@redhat.com>
In-Reply-To: <20210315041844.64915-1-gshan@redhat.com>
References: <20210315041844.64915-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We needn't expose the function as it's only used by mmu.c.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 arch/arm64/include/asm/kvm_host.h | 1 -
 arch/arm64/kvm/mmu.c              | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 3d10e6527f7d..688f2df1957b 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -632,7 +632,6 @@ void kvm_arm_resume_guest(struct kvm *kvm);
 	})
 
 void force_vm_exit(const cpumask_t *mask);
-void kvm_mmu_wp_memory_region(struct kvm *kvm, int slot);
 
 int handle_exit(struct kvm_vcpu *vcpu, int exception_index);
 void handle_exit_early(struct kvm_vcpu *vcpu, int exception_index);
diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index 77cb2d28f2a4..84e70f953de6 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -555,7 +555,7 @@ static void stage2_wp_range(struct kvm_s2_mmu *mmu, phys_addr_t addr, phys_addr_
  * Acquires kvm_mmu_lock. Called with kvm->slots_lock mutex acquired,
  * serializing operations for VM memory regions.
  */
-void kvm_mmu_wp_memory_region(struct kvm *kvm, int slot)
+static void kvm_mmu_wp_memory_region(struct kvm *kvm, int slot)
 {
 	struct kvm_memslots *slots = kvm_memslots(kvm);
 	struct kvm_memory_slot *memslot = id_to_memslot(slots, slot);
-- 
2.23.0

