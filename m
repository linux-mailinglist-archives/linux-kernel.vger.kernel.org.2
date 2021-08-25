Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 436A23F7A12
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 18:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241138AbhHYQSd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 12:18:33 -0400
Received: from foss.arm.com ([217.140.110.172]:54726 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240429AbhHYQSP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 12:18:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D42CB113E;
        Wed, 25 Aug 2021 09:17:29 -0700 (PDT)
Received: from monolith.cable.virginm.net (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 838793F66F;
        Wed, 25 Aug 2021 09:17:28 -0700 (PDT)
From:   Alexandru Elisei <alexandru.elisei@arm.com>
To:     maz@kernel.org, james.morse@arm.com, suzuki.poulose@arm.com,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        will@kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v4 11/39] KVM: arm64: Allow userspace to lock and unlock memslots
Date:   Wed, 25 Aug 2021 17:17:47 +0100
Message-Id: <20210825161815.266051-12-alexandru.elisei@arm.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210825161815.266051-1-alexandru.elisei@arm.com>
References: <20210825161815.266051-1-alexandru.elisei@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ioctls have been implemented, allow the userspace to lock and unlock
memslots.

Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---
 arch/arm64/kvm/arm.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index c47e96ae4f7c..4bd4b8b082a4 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -80,11 +80,6 @@ int kvm_arch_check_processor_compat(void *opaque)
 	return 0;
 }
 
-static int kvm_arm_lock_memslot_supported(void)
-{
-	return 0;
-}
-
 static int kvm_lock_user_memory_region_ioctl(struct kvm *kvm,
 					     struct kvm_enable_cap *cap)
 {
@@ -127,8 +122,6 @@ int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
 		kvm->arch.mte_enabled = true;
 		break;
 	case KVM_CAP_ARM_LOCK_USER_MEMORY_REGION:
-		if (!kvm_arm_lock_memslot_supported())
-			return -EINVAL;
 		r = kvm_lock_user_memory_region_ioctl(kvm, cap);
 		break;
 	default:
@@ -306,7 +299,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 		r = system_has_full_ptr_auth();
 		break;
 	case KVM_CAP_ARM_LOCK_USER_MEMORY_REGION:
-		r = kvm_arm_lock_memslot_supported();
+		r = 1;
 		break;
 	default:
 		r = 0;
-- 
2.33.0

