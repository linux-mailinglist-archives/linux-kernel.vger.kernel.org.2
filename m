Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D48AE3F7A0A
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 18:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240287AbhHYQS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 12:18:27 -0400
Received: from foss.arm.com ([217.140.110.172]:54692 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240593AbhHYQSK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 12:18:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0CEC8D6E;
        Wed, 25 Aug 2021 09:17:25 -0700 (PDT)
Received: from monolith.cable.virginm.net (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B362E3F66F;
        Wed, 25 Aug 2021 09:17:23 -0700 (PDT)
From:   Alexandru Elisei <alexandru.elisei@arm.com>
To:     maz@kernel.org, james.morse@arm.com, suzuki.poulose@arm.com,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        will@kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v4 08/39] KVM: arm64: Deny changes to locked memslots
Date:   Wed, 25 Aug 2021 17:17:44 +0100
Message-Id: <20210825161815.266051-9-alexandru.elisei@arm.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210825161815.266051-1-alexandru.elisei@arm.com>
References: <20210825161815.266051-1-alexandru.elisei@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Forbid userspace from making changes to a locked memslot. If userspace
wants to modify a locked memslot, then they will need to unlock it.

One special case is allowed: memslots locked for read, but not for write,
can have dirty page logging turned on.

Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---
 arch/arm64/kvm/mmu.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index 27b7befd4fa9..3ab8eba808ae 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -1842,8 +1842,23 @@ int kvm_arch_prepare_memory_region(struct kvm *kvm,
 {
 	hva_t hva = mem->userspace_addr;
 	hva_t reg_end = hva + mem->memory_size;
+	struct kvm_memory_slot *old;
 	int ret = 0;
 
+	/*
+	 * Forbid all changes to locked memslots with the exception of turning
+	 * on dirty page logging for memslots locked only for reads.
+	 */
+	old = id_to_memslot(kvm_memslots(kvm), memslot->id);
+	if (old && memslot_is_locked(old)) {
+		if (change == KVM_MR_FLAGS_ONLY &&
+		    memslot_is_logging(memslot) &&
+		    !(old->arch.flags & KVM_MEMSLOT_LOCK_WRITE))
+			memcpy(&memslot->arch, &old->arch, sizeof(old->arch));
+		else
+			return -EBUSY;
+	}
+
 	if (change != KVM_MR_CREATE && change != KVM_MR_MOVE &&
 			change != KVM_MR_FLAGS_ONLY)
 		return 0;
-- 
2.33.0

