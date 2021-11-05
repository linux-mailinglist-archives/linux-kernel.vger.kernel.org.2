Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75091445D52
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 02:32:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbhKEBeh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 21:34:37 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:27115 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbhKEBeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 21:34:36 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Hljbt6SdRz1DJB8;
        Fri,  5 Nov 2021 09:29:46 +0800 (CST)
Received: from dggema769-chm.china.huawei.com (10.1.198.211) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.15; Fri, 5 Nov 2021 09:31:41 +0800
Received: from localhost (10.174.179.215) by dggema769-chm.china.huawei.com
 (10.1.198.211) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.15; Fri, 5
 Nov 2021 09:31:41 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <maz@kernel.org>, <james.morse@arm.com>,
        <alexandru.elisei@arm.com>, <suzuki.poulose@arm.com>,
        <catalin.marinas@arm.com>, <will@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <kvmarm@lists.cs.columbia.edu>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] KVM: arm64: change the return type of kvm_vcpu_preferred_target()
Date:   Fri, 5 Nov 2021 09:15:00 +0800
Message-ID: <20211105011500.16280-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggema769-chm.china.huawei.com (10.1.198.211)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kvm_vcpu_preferred_target() always return 0 because kvm_target_cpu()
never returns a negative error code.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 arch/arm64/include/asm/kvm_host.h | 2 +-
 arch/arm64/kvm/arm.c              | 5 +----
 arch/arm64/kvm/guest.c            | 7 +------
 3 files changed, 3 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 4be8486042a7..2a5f7f38006f 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -584,7 +584,7 @@ struct kvm_vcpu_stat {
 	u64 exits;
 };
 
-int kvm_vcpu_preferred_target(struct kvm_vcpu_init *init);
+void kvm_vcpu_preferred_target(struct kvm_vcpu_init *init);
 unsigned long kvm_arm_num_regs(struct kvm_vcpu *vcpu);
 int kvm_arm_copy_reg_indices(struct kvm_vcpu *vcpu, u64 __user *indices);
 int kvm_arm_get_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg);
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index f5490afe1ebf..2f03cbfefe67 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -1389,12 +1389,9 @@ long kvm_arch_vm_ioctl(struct file *filp,
 		return kvm_vm_ioctl_set_device_addr(kvm, &dev_addr);
 	}
 	case KVM_ARM_PREFERRED_TARGET: {
-		int err;
 		struct kvm_vcpu_init init;
 
-		err = kvm_vcpu_preferred_target(&init);
-		if (err)
-			return err;
+		kvm_vcpu_preferred_target(&init);
 
 		if (copy_to_user(argp, &init, sizeof(init)))
 			return -EFAULT;
diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
index 5ce26bedf23c..e116c7767730 100644
--- a/arch/arm64/kvm/guest.c
+++ b/arch/arm64/kvm/guest.c
@@ -869,13 +869,10 @@ u32 __attribute_const__ kvm_target_cpu(void)
 	return KVM_ARM_TARGET_GENERIC_V8;
 }
 
-int kvm_vcpu_preferred_target(struct kvm_vcpu_init *init)
+void kvm_vcpu_preferred_target(struct kvm_vcpu_init *init)
 {
 	u32 target = kvm_target_cpu();
 
-	if (target < 0)
-		return -ENODEV;
-
 	memset(init, 0, sizeof(*init));
 
 	/*
@@ -885,8 +882,6 @@ int kvm_vcpu_preferred_target(struct kvm_vcpu_init *init)
 	 * target type.
 	 */
 	init->target = (__u32)target;
-
-	return 0;
 }
 
 int kvm_arch_vcpu_ioctl_get_fpu(struct kvm_vcpu *vcpu, struct kvm_fpu *fpu)
-- 
2.17.1

