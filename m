Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E115731473A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 04:54:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbhBIDxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 22:53:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:24435 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230131AbhBIDmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 22:42:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612842007;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4O3bR91OQhTBAzOCEMKSoKJvq1Mfv9//Gx0KMgTUafM=;
        b=W1WpOHT5RkH7I+mxo5B+vTj4/5wSPdZ8Gu0UnMildZwEQMxNntnjyrw5616xTqa+KnlEC3
        l0McDRG3H9qgjHTZp8rzUyhB2msi/F0xndlxVJEKucm+PoUVQWWAk/O6zICgEFOtJK/Png
        CPDM4eAEZmV6UN7dmM8i8xD0GyblbBQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-543-OFYASXHrP-W9KPcB4JVWmA-1; Mon, 08 Feb 2021 22:28:59 -0500
X-MC-Unique: OFYASXHrP-W9KPcB4JVWmA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D8577100CC85;
        Tue,  9 Feb 2021 03:28:57 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-26.bne.redhat.com [10.64.54.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0AA2A19C66;
        Tue,  9 Feb 2021 03:28:52 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     linux-kernel@vger.kernel.org, pbonzini@redhat.com, maz@kernel.org,
        james.morse@arm.com, Jonathan.Cameron@huawei.com,
        mark.rutland@arm.com, will@kernel.org, shan.gavin@gmail.com
Subject: [PATCH v2 16/21] KVM: arm64: Support SDEI ioctl commands on VM
Date:   Tue,  9 Feb 2021 11:27:28 +0800
Message-Id: <20210209032733.99996-17-gshan@redhat.com>
In-Reply-To: <20210209032733.99996-1-gshan@redhat.com>
References: <20210209032733.99996-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
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
index 20ad724f63c8..55de8baff841 100644
--- a/arch/arm64/include/uapi/asm/kvm_sdei.h
+++ b/arch/arm64/include/uapi/asm/kvm_sdei.h
@@ -54,4 +54,21 @@ struct kvm_sdei_vcpu_state {
 	struct kvm_sdei_vcpu_regs	normal_regs;
 };
 
+#define KVM_SDEI_CMD_GET_VERSION		0
+#define KVM_SDEI_CMD_SET_EVENT			1
+#define KVM_SDEI_CMD_GET_KEVENT_COUNT		2
+#define KVM_SDEI_CMD_GET_KEVENT			3
+#define KVM_SDEI_CMD_SET_KEVENT			4
+
+struct kvm_sdei_cmd {
+	uint32_t					cmd;
+	union {
+		uint32_t				version;
+		uint32_t				count;
+		uint64_t				num;
+		struct kvm_sdei_event_state		kse_state;
+		struct kvm_sdei_kvm_event_state		kske_state;
+	};
+};
+
 #endif /* _UAPI__ASM_KVM_SDEI_H */
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index e243bd5ad730..96b41bf1d094 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -1334,6 +1334,9 @@ long kvm_arch_vm_ioctl(struct file *filp,
 
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
index 374c67875cdb..b056b4ac884b 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -1565,6 +1565,9 @@ struct kvm_pv_cmd {
 /* Available with KVM_CAP_DIRTY_LOG_RING */
 #define KVM_RESET_DIRTY_RINGS		_IO(KVMIO, 0xc7)
 
+/* Available with KVM_CAP_ARM_SDEI */
+#define KVM_ARM_SDEI_COMMAND   _IOWR(KVMIO, 0xc8, struct kvm_sdei_cmd)
+
 /* Secure Encrypted Virtualization command */
 enum sev_cmd_id {
 	/* Guest initialization commands */
-- 
2.23.0

