Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5AAC376096
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 08:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234947AbhEGGmv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 02:42:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33351 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233866AbhEGGmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 02:42:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620369696;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TlzI8g4u2ps4vKEwx1qgxahyZySv9EgDdxcIWqQNZKw=;
        b=Cz0pzHFwuvCgj9rZGk2FZbZN4ec1Ruocp0eLO1Y7IgKZVyREH8b/hm71l40Itxz+hRKCZv
        EPWRqJ/j/NIt8vI/URfpWeoaNXmhWd4Q62SmvARRo/376PzW68ecbWLeqfm+ZwfiLcmiME
        7GTU3Vvj6O1YLBT3O1JMwxGZdLOWb2o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-441-bd6A1TTtO0eOVIX3bwKX6A-1; Fri, 07 May 2021 02:41:32 -0400
X-MC-Unique: bd6A1TTtO0eOVIX3bwKX6A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 87FBB10066E6;
        Fri,  7 May 2021 06:41:30 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-42.bne.redhat.com [10.64.54.42])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8B15F5C3E0;
        Fri,  7 May 2021 06:41:27 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     linux-kernel@vger.kernel.org, maz@kernel.org, will@kernel.org,
        pbonzini@redhat.com, james.morse@arm.com, mark.rutland@arm.com,
        Jonathan.Cameron@huawei.com, shan.gavin@gmail.com
Subject: [PATCH v3 10/15] KVM: arm64: Support async PF ioctl commands
Date:   Fri,  7 May 2021 16:40:48 +0800
Message-Id: <20210507084053.44407-11-gshan@redhat.com>
In-Reply-To: <20210507084053.44407-1-gshan@redhat.com>
References: <20210507084053.44407-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This supports ioctl commands for configuration and migration:

   KVM_ARM_ASYNC_PF_CMD_GET_VERSION
      Return implementation version
   KVM_ARM_ASYNC_PF_CMD_GET_SDEI
      Return SDEI event number used for page-not-present notification
   KVM_ARM_ASYNC_PF_CMD_GET_IRQ
      Return IRQ number used for page-ready notification
   KVM_ARM_ASYNC_PF_CMD_GET_CONTROL
      Get control block when VM is migrated
   KVM_ARM_ASYNC_PF_CMD_SET_SDEI
      Set SDEI event number when VM is started or migrated
   KVM_ARM_ASYNC_PF_CMD_SET_IRQ
      Set IRQ number during when VM is started or migrated
   KVM_ARM_ASYNC_PF_CMD_SET_CONTROL
      Set control block when VM is migrated

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 arch/arm64/include/asm/kvm_host.h | 14 +++++++
 arch/arm64/include/uapi/asm/kvm.h | 19 +++++++++
 arch/arm64/kvm/arm.c              |  6 +++
 arch/arm64/kvm/async_pf.c         | 64 +++++++++++++++++++++++++++++++
 include/uapi/linux/kvm.h          |  3 ++
 5 files changed, 106 insertions(+)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 98aab1c910d0..f21b58733eba 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -774,6 +774,8 @@ void kvm_arch_async_page_ready(struct kvm_vcpu *vcpu,
 void kvm_arch_async_page_present(struct kvm_vcpu *vcpu,
 				 struct kvm_async_pf *work);
 void kvm_arch_async_pf_hypercall(struct kvm_vcpu *vcpu, u64 *val);
+long kvm_arch_async_pf_vm_ioctl(struct kvm *kvm, unsigned long arg);
+long kvm_arch_async_pf_vcpu_ioctl(struct kvm_vcpu *vcpu, unsigned long arg);
 void kvm_arch_async_pf_destroy_vcpu(struct kvm_vcpu *vcpu);
 #else
 static inline void kvm_arch_async_pf_create_vcpu(struct kvm_vcpu *vcpu) { }
@@ -794,6 +796,18 @@ static inline void kvm_arch_async_pf_hypercall(struct kvm_vcpu *vcpu, u64 *val)
 {
 	val[0] = SMCCC_RET_NOT_SUPPORTED;
 }
+
+static inline long kvm_arch_async_pf_vm_ioctl(struct kvm *kvm,
+					      unsigned long arg)
+{
+	return -EPERM;
+}
+
+static inline long kvm_arch_async_pf_vcpu_ioctl(struct kvm_vcpu *vcpu,
+						unsigned long arg)
+{
+	return -EPERM;
+}
 #endif
 
 /* Guest/host FPSIMD coordination helpers */
diff --git a/arch/arm64/include/uapi/asm/kvm.h b/arch/arm64/include/uapi/asm/kvm.h
index 15499751997d..a6124068bee6 100644
--- a/arch/arm64/include/uapi/asm/kvm.h
+++ b/arch/arm64/include/uapi/asm/kvm.h
@@ -403,6 +403,25 @@ struct kvm_vcpu_events {
 #define KVM_PSCI_RET_INVAL		PSCI_RET_INVALID_PARAMS
 #define KVM_PSCI_RET_DENIED		PSCI_RET_DENIED
 
+/* Asynchronous page fault */
+#define KVM_ARM_ASYNC_PF_CMD_GET_VERSION	0
+#define KVM_ARM_ASYNC_PF_CMD_GET_SDEI		1
+#define KVM_ARM_ASYNC_PF_CMD_GET_IRQ		2
+#define KVM_ARM_ASYNC_PF_CMD_GET_CONTROL	3
+#define KVM_ARM_ASYNC_PF_CMD_SET_SDEI		4
+#define KVM_ARM_ASYNC_PF_CMD_SET_IRQ		5
+#define KVM_ARM_ASYNC_PF_CMD_SET_CONTROL	6
+
+struct kvm_arm_async_pf_cmd {
+	__u32		cmd;
+	union {
+		__u32	version;
+		__u64	sdei;
+		__u32	irq;
+		__u64	control;
+	};
+};
+
 #endif
 
 #endif /* __ARM_KVM_H__ */
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 70ba3593880a..1f869eaf93d6 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -1299,6 +1299,9 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 	case KVM_ARM_SDEI_COMMAND: {
 		return kvm_sdei_vcpu_ioctl(vcpu, arg);
 	}
+	case KVM_ARM_ASYNC_PF_COMMAND: {
+		return kvm_arch_async_pf_vcpu_ioctl(vcpu, arg);
+	}
 	default:
 		r = -EINVAL;
 	}
@@ -1376,6 +1379,9 @@ long kvm_arch_vm_ioctl(struct file *filp,
 	case KVM_ARM_SDEI_COMMAND: {
 		return kvm_sdei_vm_ioctl(kvm, arg);
 	}
+	case KVM_ARM_ASYNC_PF_COMMAND: {
+		return kvm_arch_async_pf_vm_ioctl(kvm, arg);
+	}
 	default:
 		return -EINVAL;
 	}
diff --git a/arch/arm64/kvm/async_pf.c b/arch/arm64/kvm/async_pf.c
index 3bc69a631996..3aaed516540f 100644
--- a/arch/arm64/kvm/async_pf.c
+++ b/arch/arm64/kvm/async_pf.c
@@ -462,6 +462,70 @@ void kvm_arch_async_pf_hypercall(struct kvm_vcpu *vcpu, u64 *val)
 	val[0] = ret;
 }
 
+long kvm_arch_async_pf_vm_ioctl(struct kvm *kvm, unsigned long arg)
+{
+	struct kvm_arm_async_pf_cmd cmd;
+	unsigned int version = 0x010000; /* v1.0.0 */
+	void __user *argp = (void __user *)arg;
+
+	if (copy_from_user(&cmd, argp, sizeof(cmd)))
+		return -EFAULT;
+
+	if (cmd.cmd != KVM_ARM_ASYNC_PF_CMD_GET_VERSION)
+		return -EINVAL;
+
+	cmd.version = version;
+	if (copy_to_user(argp, &cmd, sizeof(cmd)))
+		return -EFAULT;
+
+	return 0;
+}
+
+long kvm_arch_async_pf_vcpu_ioctl(struct kvm_vcpu *vcpu, unsigned long arg)
+{
+	struct kvm_arch_async_pf_control *apf = vcpu->arch.apf;
+	struct kvm_arm_async_pf_cmd cmd;
+	void __user *argp = (void __user *)arg;
+	long ret = 0;
+
+	if (!apf)
+		return -EPERM;
+
+	if (copy_from_user(&cmd, argp, sizeof(cmd)))
+		return -EFAULT;
+
+	switch (cmd.cmd) {
+	case KVM_ARM_ASYNC_PF_CMD_GET_SDEI:
+		cmd.sdei = apf->sdei_event_num;
+		break;
+	case KVM_ARM_ASYNC_PF_CMD_GET_IRQ:
+		cmd.irq = apf->irq;
+		break;
+	case KVM_ARM_ASYNC_PF_CMD_GET_CONTROL:
+		cmd.control = apf->control_block;
+		break;
+	case KVM_ARM_ASYNC_PF_CMD_SET_SDEI:
+		apf->sdei_event_num = cmd.sdei;
+		break;
+	case KVM_ARM_ASYNC_PF_CMD_SET_IRQ:
+		apf->irq = cmd.irq;
+		break;
+	case KVM_ARM_ASYNC_PF_CMD_SET_CONTROL:
+		if (kvm_arch_async_enable(vcpu, cmd.control) !=
+		    SMCCC_RET_SUCCESS)
+			ret = -EIO;
+
+		break;
+	default:
+		ret = -EINVAL;
+	}
+
+	if (!ret && copy_to_user(argp, &cmd, sizeof(cmd)))
+		ret = -EFAULT;
+
+	return ret;
+}
+
 void kvm_arch_async_pf_destroy_vcpu(struct kvm_vcpu *vcpu)
 {
 	kfree(vcpu->arch.apf);
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 96641e528526..8f5ec382954e 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -1649,6 +1649,9 @@ struct kvm_xen_vcpu_attr {
 /* Available with KVM_CAP_ARM_SDEI */
 #define KVM_ARM_SDEI_COMMAND	_IOWR(KVMIO, 0xcc, struct kvm_sdei_cmd)
 
+/* Available with KVM_CAP_ASYNC_PF or KVM_CAP_ASYNC_PF_INT */
+#define KVM_ARM_ASYNC_PF_COMMAND _IOWR(KVMIO, 0xcd, struct kvm_arm_async_pf_cmd)
+
 /* Secure Encrypted Virtualization command */
 enum sev_cmd_id {
 	/* Guest initialization commands */
-- 
2.23.0

