Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94C36376063
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 08:33:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234762AbhEGGeC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 02:34:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42469 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230299AbhEGGdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 02:33:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620369159;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MUt1HNVopxhIe3yDxq8qsLy7cQQ9fvBJ1mcYTqlNRco=;
        b=IHXVL12OnocgWV50bfqOSJSBPseA/SP2SSpSBWUQhCkDD73k5ySPeTFaFT+UZe6Gnu34S2
        S/UpaSdHkx6fmbxjaXcUPyGYf+ryP/1vYdkYQd3a9P6PJLdiY0vtwrhmR9RF77Fnq01jPF
        XNIC0je8OxgKGsUkBucNZaed/zkqQmo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-415-cgBqxzi2Ns6SoQzfyJc2Kg-1; Fri, 07 May 2021 02:32:37 -0400
X-MC-Unique: cgBqxzi2Ns6SoQzfyJc2Kg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 66649801817;
        Fri,  7 May 2021 06:32:36 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-42.bne.redhat.com [10.64.54.42])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0AC2E5D9CA;
        Fri,  7 May 2021 06:32:32 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     linux-kernel@vger.kernel.org, maz@kernel.org, will@kernel.org,
        pbonzini@redhat.com, james.morse@arm.com, mark.rutland@arm.com,
        Jonathan.Cameron@huawei.com, shan.gavin@gmail.com
Subject: [PATCH v3 16/21] KVM: arm64: Support SDEI ioctl commands on VM
Date:   Fri,  7 May 2021 16:31:19 +0800
Message-Id: <20210507083124.43347-17-gshan@redhat.com>
In-Reply-To: <20210507083124.43347-1-gshan@redhat.com>
References: <20210507083124.43347-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This supports ioctl commands on VM to manage the various objects.
It's primarily used by VMM to accomplish live migration. The ioctl
commands introduced by this are highlighted as blow:

   * KVM_SDEI_CMD_GET_VERSION
     Retrieve the version of current implementation
   * KVM_SDEI_CMD_SET_EVENT
     Add event to be exported from KVM so that guest can register
     against it afterwards
   * KVM_SDEI_CMD_GET_KEVENT_COUNT
     Retrieve number of registered SDEI events
   * KVM_SDEI_CMD_GET_KEVENT
     Retrieve the state of the registered SDEI event
   * KVM_SDEI_CMD_SET_KEVENT
     Populate the registered SDEI event

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 arch/arm64/include/asm/kvm_sdei.h      |   1 +
 arch/arm64/include/uapi/asm/kvm_sdei.h |  17 +++
 arch/arm64/kvm/arm.c                   |   3 +
 arch/arm64/kvm/sdei.c                  | 171 +++++++++++++++++++++++++
 include/uapi/linux/kvm.h               |   3 +
 5 files changed, 195 insertions(+)

diff --git a/arch/arm64/include/asm/kvm_sdei.h b/arch/arm64/include/asm/kvm_sdei.h
index 19f2d9b91f85..8f5ea947ed0e 100644
--- a/arch/arm64/include/asm/kvm_sdei.h
+++ b/arch/arm64/include/asm/kvm_sdei.h
@@ -125,6 +125,7 @@ int kvm_sdei_hypercall(struct kvm_vcpu *vcpu);
 int kvm_sdei_register_notifier(struct kvm *kvm, unsigned long num,
 			       kvm_sdei_notifier notifier);
 void kvm_sdei_deliver(struct kvm_vcpu *vcpu);
+long kvm_sdei_vm_ioctl(struct kvm *kvm, unsigned long arg);
 void kvm_sdei_destroy_vcpu(struct kvm_vcpu *vcpu);
 void kvm_sdei_destroy_vm(struct kvm *kvm);
 
diff --git a/arch/arm64/include/uapi/asm/kvm_sdei.h b/arch/arm64/include/uapi/asm/kvm_sdei.h
index 78ff26e49ee6..323d7ff24662 100644
--- a/arch/arm64/include/uapi/asm/kvm_sdei.h
+++ b/arch/arm64/include/uapi/asm/kvm_sdei.h
@@ -57,5 +57,22 @@ struct kvm_sdei_vcpu_state {
 	struct kvm_sdei_vcpu_regs	normal_regs;
 };
 
+#define KVM_SDEI_CMD_GET_VERSION		0
+#define KVM_SDEI_CMD_SET_EVENT			1
+#define KVM_SDEI_CMD_GET_KEVENT_COUNT		2
+#define KVM_SDEI_CMD_GET_KEVENT			3
+#define KVM_SDEI_CMD_SET_KEVENT			4
+
+struct kvm_sdei_cmd {
+	__u32						cmd;
+	union {
+		__u32					version;
+		__u32					count;
+		__u64					num;
+		struct kvm_sdei_event_state		kse_state;
+		struct kvm_sdei_kvm_event_state		kske_state;
+	};
+};
+
 #endif /* !__ASSEMBLY__ */
 #endif /* _UAPI__ASM_KVM_SDEI_H */
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 345083dc5144..490c1c62702b 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -1346,6 +1346,9 @@ long kvm_arch_vm_ioctl(struct file *filp,
 
 		return 0;
 	}
+	case KVM_ARM_SDEI_COMMAND: {
+		return kvm_sdei_vm_ioctl(kvm, arg);
+	}
 	default:
 		return -EINVAL;
 	}
diff --git a/arch/arm64/kvm/sdei.c b/arch/arm64/kvm/sdei.c
index 5f7a37dcaa77..bdd76c3e5153 100644
--- a/arch/arm64/kvm/sdei.c
+++ b/arch/arm64/kvm/sdei.c
@@ -931,6 +931,177 @@ void kvm_sdei_create_vcpu(struct kvm_vcpu *vcpu)
 	vcpu->arch.sdei = vsdei;
 }
 
+static long kvm_sdei_set_event(struct kvm *kvm,
+			       struct kvm_sdei_event_state *kse_state)
+{
+	struct kvm_sdei_kvm *ksdei = kvm->arch.sdei;
+	struct kvm_sdei_event *kse = NULL;
+
+	if (!kvm_sdei_is_valid_event_num(kse_state->num))
+		return -EINVAL;
+
+	if (!(kse_state->type == SDEI_EVENT_TYPE_SHARED ||
+	      kse_state->type == SDEI_EVENT_TYPE_PRIVATE))
+		return -EINVAL;
+
+	if (!(kse_state->priority == SDEI_EVENT_PRIORITY_NORMAL ||
+	      kse_state->priority == SDEI_EVENT_PRIORITY_CRITICAL))
+		return -EINVAL;
+
+	kse = kvm_sdei_find_event(kvm, kse_state->num);
+	if (kse)
+		return -EEXIST;
+
+	kse = kzalloc(sizeof(*kse), GFP_KERNEL);
+	if (!kse)
+		return -ENOMEM;
+
+	kse->state = *kse_state;
+	kse->kvm = kvm;
+	list_add_tail(&kse->link, &ksdei->events);
+
+	return 0;
+}
+
+static long kvm_sdei_get_kevent_count(struct kvm *kvm, int *count)
+{
+	struct kvm_sdei_kvm *ksdei = kvm->arch.sdei;
+	struct kvm_sdei_kvm_event *kske = NULL;
+	int total = 0;
+
+	list_for_each_entry(kske, &ksdei->kvm_events, link) {
+		total++;
+	}
+
+	*count = total;
+	return 0;
+}
+
+static long kvm_sdei_get_kevent(struct kvm *kvm,
+				struct kvm_sdei_kvm_event_state *kske_state)
+{
+	struct kvm_sdei_kvm *ksdei = kvm->arch.sdei;
+	struct kvm_sdei_kvm_event *kske = NULL;
+
+	/*
+	 * The first entry is fetched if the event number is invalid.
+	 * Otherwise, the next entry is fetched.
+	 */
+	if (!kvm_sdei_is_valid_event_num(kske_state->num)) {
+		kske = list_first_entry_or_null(&ksdei->kvm_events,
+				struct kvm_sdei_kvm_event, link);
+	} else {
+		kske = kvm_sdei_find_kvm_event(kvm, kske_state->num);
+		if (kske && !list_is_last(&kske->link, &ksdei->kvm_events))
+			kske = list_next_entry(kske, link);
+		else
+			kske = NULL;
+	}
+
+	if (!kske)
+		return -ENOENT;
+
+	*kske_state = kske->state;
+
+	return 0;
+}
+
+static long kvm_sdei_set_kevent(struct kvm *kvm,
+				struct kvm_sdei_kvm_event_state *kske_state)
+{
+	struct kvm_sdei_kvm *ksdei = kvm->arch.sdei;
+	struct kvm_sdei_event *kse = NULL;
+	struct kvm_sdei_kvm_event *kske = NULL;
+
+	/* Sanity check */
+	if (!kvm_sdei_is_valid_event_num(kske_state->num))
+		return -EINVAL;
+
+	if (!(kske_state->route_mode == SDEI_EVENT_REGISTER_RM_ANY ||
+	      kske_state->route_mode == SDEI_EVENT_REGISTER_RM_PE))
+		return -EINVAL;
+
+	/* Check if the event number is valid */
+	kse = kvm_sdei_find_event(kvm, kske_state->num);
+	if (!kse)
+		return -ENOENT;
+
+	/* Check if the event has been populated */
+	kske = kvm_sdei_find_kvm_event(kvm, kske_state->num);
+	if (kske)
+		return -EEXIST;
+
+	kske = kzalloc(sizeof(*kske), GFP_KERNEL);
+	if (!kske)
+		return -ENOMEM;
+
+	kske->state = *kske_state;
+	kske->kse   = kse;
+	kske->kvm   = kvm;
+	list_add_tail(&kske->link, &ksdei->kvm_events);
+
+	return 0;
+}
+
+long kvm_sdei_vm_ioctl(struct kvm *kvm, unsigned long arg)
+{
+	struct kvm_sdei_kvm *ksdei = kvm->arch.sdei;
+	struct kvm_sdei_cmd *cmd = NULL;
+	void __user *argp = (void __user *)arg;
+	bool copy = false;
+	long ret = 0;
+
+	/* Sanity check */
+	if (!ksdei) {
+		ret = -EPERM;
+		goto out;
+	}
+
+	cmd = kzalloc(sizeof(*cmd), GFP_KERNEL);
+	if (!cmd) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	if (copy_from_user(cmd, argp, sizeof(*cmd))) {
+		ret = -EFAULT;
+		goto out;
+	}
+
+	spin_lock(&ksdei->lock);
+
+	switch (cmd->cmd) {
+	case KVM_SDEI_CMD_GET_VERSION:
+		copy = true;
+		cmd->version = (1 << 16);       /* v1.0.0 */
+		break;
+	case KVM_SDEI_CMD_SET_EVENT:
+		ret = kvm_sdei_set_event(kvm, &cmd->kse_state);
+		break;
+	case KVM_SDEI_CMD_GET_KEVENT_COUNT:
+		copy = true;
+		ret = kvm_sdei_get_kevent_count(kvm, &cmd->count);
+		break;
+	case KVM_SDEI_CMD_GET_KEVENT:
+		copy = true;
+		ret = kvm_sdei_get_kevent(kvm, &cmd->kske_state);
+		break;
+	case KVM_SDEI_CMD_SET_KEVENT:
+		ret = kvm_sdei_set_kevent(kvm, &cmd->kske_state);
+		break;
+	default:
+		ret = -EINVAL;
+	}
+
+	spin_unlock(&ksdei->lock);
+out:
+	if (!ret && copy && copy_to_user(argp, cmd, sizeof(*cmd)))
+		ret = -EFAULT;
+
+	kfree(cmd);
+	return ret;
+}
+
 void kvm_sdei_destroy_vcpu(struct kvm_vcpu *vcpu)
 {
 	struct kvm_sdei_vcpu *vsdei = vcpu->arch.sdei;
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 3fd9a7e9d90c..9a7052da76a9 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -1645,6 +1645,9 @@ struct kvm_xen_vcpu_attr {
 #define KVM_XEN_VCPU_ATTR_TYPE_RUNSTATE_DATA	0x4
 #define KVM_XEN_VCPU_ATTR_TYPE_RUNSTATE_ADJUST	0x5
 
+/* Available with KVM_CAP_ARM_SDEI */
+#define KVM_ARM_SDEI_COMMAND	_IOWR(KVMIO, 0xcc, struct kvm_sdei_cmd)
+
 /* Secure Encrypted Virtualization command */
 enum sev_cmd_id {
 	/* Guest initialization commands */
-- 
2.23.0

