Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E42DD3DA847
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 18:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232281AbhG2QCP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 12:02:15 -0400
Received: from foss.arm.com ([217.140.110.172]:51512 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233557AbhG2QBF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 12:01:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B10661FB;
        Thu, 29 Jul 2021 09:01:00 -0700 (PDT)
Received: from e112269-lin.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0D33B3F73D;
        Thu, 29 Jul 2021 09:00:58 -0700 (PDT)
From:   Steven Price <steven.price@arm.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>
Cc:     Steven Price <steven.price@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] KVM: arm64: Fix race when enabling KVM_ARM_CAP_MTE
Date:   Thu, 29 Jul 2021 17:00:36 +0100
Message-Id: <20210729160036.20433-1-steven.price@arm.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When enabling KVM_CAP_ARM_MTE the ioctl checks that there are no VCPUs
created to ensure that the capability is enabled before the VM is
running. However no locks are held at that point so it is
(theoretically) possible for another thread in the VMM to create VCPUs
between the check and actually setting mte_enabled. Close the race by
taking kvm->lock.

Reported-by: Alexandru Elisei <alexandru.elisei@arm.com>
Fixes: 673638f434ee ("KVM: arm64: Expose KVM_ARM_CAP_MTE")
Signed-off-by: Steven Price <steven.price@arm.com>
---
 arch/arm64/kvm/arm.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index e9a2b8f27792..0ca72f5cda41 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -94,10 +94,14 @@ int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
 		kvm->arch.return_nisv_io_abort_to_user = true;
 		break;
 	case KVM_CAP_ARM_MTE:
-		if (!system_supports_mte() || kvm->created_vcpus)
-			return -EINVAL;
-		r = 0;
-		kvm->arch.mte_enabled = true;
+		mutex_lock(&kvm->lock);
+		if (!system_supports_mte() || kvm->created_vcpus) {
+			r = -EINVAL;
+		} else {
+			r = 0;
+			kvm->arch.mte_enabled = true;
+		}
+		mutex_unlock(&kvm->lock);
 		break;
 	default:
 		r = -EINVAL;
-- 
2.20.1

