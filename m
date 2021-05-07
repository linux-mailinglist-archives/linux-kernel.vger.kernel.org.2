Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD3A6376065
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 08:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234841AbhEGGeN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 02:34:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:56260 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234720AbhEGGdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 02:33:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620369165;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xCWpfXG9AP3+4hUCK3B+6LXmgGYB1C174Oot9O/O/mw=;
        b=V8xzarCd2mdOShsqgpEwCAW8KkjZ/8tp2HIPoq1v5s9R9SiZenoZ2p9XMiz6hmBXB+qzqU
        G8hRynxmS9H5YFAbAFa/UMCUzMumjnQR6LADQlvNIj3Bpo7uSELqWMw2ptAcbVERetygqF
        t3EVabQDcV6dVbUPPZULeEEwRENIp2Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-174-HfLY87fiOPW0qgWtW-dvEw-1; Fri, 07 May 2021 02:32:41 -0400
X-MC-Unique: HfLY87fiOPW0qgWtW-dvEw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3F32764157;
        Fri,  7 May 2021 06:32:40 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-42.bne.redhat.com [10.64.54.42])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E51895D9CA;
        Fri,  7 May 2021 06:32:36 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     linux-kernel@vger.kernel.org, maz@kernel.org, will@kernel.org,
        pbonzini@redhat.com, james.morse@arm.com, mark.rutland@arm.com,
        Jonathan.Cameron@huawei.com, shan.gavin@gmail.com
Subject: [PATCH v3 17/21] KVM: arm64: Support SDEI ioctl commands on vCPU
Date:   Fri,  7 May 2021 16:31:20 +0800
Message-Id: <20210507083124.43347-18-gshan@redhat.com>
In-Reply-To: <20210507083124.43347-1-gshan@redhat.com>
References: <20210507083124.43347-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This supports ioctl commands on vCPU to manage the various object.
It's primarily used by VMM to accomplish live migration. The ioctl
commands introduced by this are highlighted as below:

   * KVM_SDEI_CMD_GET_VEVENT_COUNT
     Retrieve number of SDEI events that pend for handling on the
     vCPU
   * KVM_SDEI_CMD_GET_VEVENT
     Retrieve the state of SDEI event, which has been delivered to
     the vCPU for handling
   * KVM_SDEI_CMD_SET_VEVENT
     Populate the SDEI event, which has been delivered to the vCPU
     for handling
   * KVM_SDEI_CMD_GET_VCPU_STATE
     Retrieve vCPU state related to SDEI handling
   * KVM_SDEI_CMD_SET_VCPU_STATE
     Populate vCPU state related to SDEI handling

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 arch/arm64/include/asm/kvm_sdei.h      |   1 +
 arch/arm64/include/uapi/asm/kvm_sdei.h |   7 +
 arch/arm64/kvm/arm.c                   |   3 +
 arch/arm64/kvm/sdei.c                  | 228 +++++++++++++++++++++++++
 4 files changed, 239 insertions(+)

diff --git a/arch/arm64/include/asm/kvm_sdei.h b/arch/arm64/include/asm/kvm_sdei.h
index 8f5ea947ed0e..a997989bab77 100644
--- a/arch/arm64/include/asm/kvm_sdei.h
+++ b/arch/arm64/include/asm/kvm_sdei.h
@@ -126,6 +126,7 @@ int kvm_sdei_register_notifier(struct kvm *kvm, unsigned long num,
 			       kvm_sdei_notifier notifier);
 void kvm_sdei_deliver(struct kvm_vcpu *vcpu);
 long kvm_sdei_vm_ioctl(struct kvm *kvm, unsigned long arg);
+long kvm_sdei_vcpu_ioctl(struct kvm_vcpu *vcpu, unsigned long arg);
 void kvm_sdei_destroy_vcpu(struct kvm_vcpu *vcpu);
 void kvm_sdei_destroy_vm(struct kvm *kvm);
 
diff --git a/arch/arm64/include/uapi/asm/kvm_sdei.h b/arch/arm64/include/uapi/asm/kvm_sdei.h
index 323d7ff24662..1e96dbe2aa6f 100644
--- a/arch/arm64/include/uapi/asm/kvm_sdei.h
+++ b/arch/arm64/include/uapi/asm/kvm_sdei.h
@@ -62,6 +62,11 @@ struct kvm_sdei_vcpu_state {
 #define KVM_SDEI_CMD_GET_KEVENT_COUNT		2
 #define KVM_SDEI_CMD_GET_KEVENT			3
 #define KVM_SDEI_CMD_SET_KEVENT			4
+#define KVM_SDEI_CMD_GET_VEVENT_COUNT		5
+#define KVM_SDEI_CMD_GET_VEVENT			6
+#define KVM_SDEI_CMD_SET_VEVENT			7
+#define KVM_SDEI_CMD_GET_VCPU_STATE		8
+#define KVM_SDEI_CMD_SET_VCPU_STATE		9
 
 struct kvm_sdei_cmd {
 	__u32						cmd;
@@ -71,6 +76,8 @@ struct kvm_sdei_cmd {
 		__u64					num;
 		struct kvm_sdei_event_state		kse_state;
 		struct kvm_sdei_kvm_event_state		kske_state;
+		struct kvm_sdei_vcpu_event_state	ksve_state;
+		struct kvm_sdei_vcpu_state		ksv_state;
 	};
 };
 
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 490c1c62702b..0f4ccec7dc04 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -1272,6 +1272,9 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 
 		return kvm_arm_vcpu_finalize(vcpu, what);
 	}
+	case KVM_ARM_SDEI_COMMAND: {
+		return kvm_sdei_vcpu_ioctl(vcpu, arg);
+	}
 	default:
 		r = -EINVAL;
 	}
diff --git a/arch/arm64/kvm/sdei.c b/arch/arm64/kvm/sdei.c
index bdd76c3e5153..79315b77f24b 100644
--- a/arch/arm64/kvm/sdei.c
+++ b/arch/arm64/kvm/sdei.c
@@ -35,6 +35,25 @@ static struct kvm_sdei_event *kvm_sdei_find_event(struct kvm *kvm,
 	return NULL;
 }
 
+static struct kvm_sdei_vcpu_event *kvm_sdei_find_vcpu_event(struct kvm_vcpu *vcpu,
+							    unsigned long num)
+{
+	struct kvm_sdei_vcpu *vsdei = vcpu->arch.sdei;
+	struct kvm_sdei_vcpu_event *ksve;
+
+	list_for_each_entry(ksve, &vsdei->critical_events, link) {
+		if (ksve->state.num == num)
+			return ksve;
+	}
+
+	list_for_each_entry(ksve, &vsdei->normal_events, link) {
+		if (ksve->state.num == num)
+			return ksve;
+	}
+
+	return NULL;
+}
+
 static void kvm_sdei_remove_events(struct kvm *kvm)
 {
 	struct kvm_sdei_kvm *ksdei = kvm->arch.sdei;
@@ -1102,6 +1121,215 @@ long kvm_sdei_vm_ioctl(struct kvm *kvm, unsigned long arg)
 	return ret;
 }
 
+static long kvm_sdei_get_vevent_count(struct kvm_vcpu *vcpu, int *count)
+{
+	struct kvm_sdei_vcpu *vsdei = vcpu->arch.sdei;
+	struct kvm_sdei_vcpu_event *ksve = NULL;
+	int total = 0;
+
+	list_for_each_entry(ksve, &vsdei->critical_events, link) {
+		total++;
+	}
+
+	list_for_each_entry(ksve, &vsdei->normal_events, link) {
+		total++;
+	}
+
+	*count = total;
+	return 0;
+}
+
+static struct kvm_sdei_vcpu_event *next_vcpu_event(struct kvm_vcpu *vcpu,
+						   unsigned long num)
+{
+	struct kvm_sdei_vcpu *vsdei = vcpu->arch.sdei;
+	struct kvm_sdei_event *kse = NULL;
+	struct kvm_sdei_kvm_event *kske = NULL;
+	struct kvm_sdei_vcpu_event *ksve = NULL;
+
+	ksve = kvm_sdei_find_vcpu_event(vcpu, num);
+	if (!ksve)
+		return NULL;
+
+	kske = ksve->kske;
+	kse  = kske->kse;
+	if (kse->state.priority == SDEI_EVENT_PRIORITY_CRITICAL) {
+		if (!list_is_last(&ksve->link, &vsdei->critical_events)) {
+			ksve = list_next_entry(ksve, link);
+			return ksve;
+		}
+
+		ksve = list_first_entry_or_null(&vsdei->normal_events,
+					struct kvm_sdei_vcpu_event, link);
+		return ksve;
+	}
+
+	if (!list_is_last(&ksve->link, &vsdei->normal_events)) {
+		ksve = list_next_entry(ksve, link);
+		return ksve;
+	}
+
+	return NULL;
+}
+
+static long kvm_sdei_get_vevent(struct kvm_vcpu *vcpu,
+				struct kvm_sdei_vcpu_event_state *ksve_state)
+{
+	struct kvm_sdei_vcpu *vsdei = vcpu->arch.sdei;
+	struct kvm_sdei_vcpu_event *ksve = NULL;
+
+	/*
+	 * If the event number is invalid, the first critical or
+	 * normal event is fetched. Otherwise, the next valid event
+	 * is returned.
+	 */
+	if (!kvm_sdei_is_valid_event_num(ksve_state->num)) {
+		ksve = list_first_entry_or_null(&vsdei->critical_events,
+					struct kvm_sdei_vcpu_event, link);
+		if (!ksve) {
+			ksve = list_first_entry_or_null(&vsdei->normal_events,
+					struct kvm_sdei_vcpu_event, link);
+		}
+	} else {
+		ksve = next_vcpu_event(vcpu, ksve_state->num);
+	}
+
+	if (!ksve)
+		return -ENOENT;
+
+	*ksve_state = ksve->state;
+
+	return 0;
+}
+
+static long kvm_sdei_set_vevent(struct kvm_vcpu *vcpu,
+				struct kvm_sdei_vcpu_event_state *ksve_state)
+{
+	struct kvm *kvm = vcpu->kvm;
+	struct kvm_sdei_vcpu *vsdei = vcpu->arch.sdei;
+	struct kvm_sdei_event *kse = NULL;
+	struct kvm_sdei_kvm_event *kske = NULL;
+	struct kvm_sdei_vcpu_event *ksve = NULL;
+
+	if (!kvm_sdei_is_valid_event_num(ksve_state->num))
+		return -EINVAL;
+
+	kske = kvm_sdei_find_kvm_event(kvm, ksve_state->num);
+	if (!kske)
+		return -ENOENT;
+
+	ksve = kvm_sdei_find_vcpu_event(vcpu, ksve_state->num);
+	if (ksve)
+		return -EEXIST;
+
+	ksve = kzalloc(sizeof(*ksve), GFP_KERNEL);
+	if (!ksve)
+		return -ENOMEM;
+
+	kse = kske->kse;
+	ksve->state = *ksve_state;
+	ksve->kske  = kske;
+	ksve->vcpu  = vcpu;
+
+	if (kse->state.priority == SDEI_EVENT_PRIORITY_CRITICAL)
+		list_add_tail(&ksve->link, &vsdei->critical_events);
+	else
+		list_add_tail(&ksve->link, &vsdei->normal_events);
+
+	kvm_make_request(KVM_REQ_SDEI, vcpu);
+
+	return 0;
+}
+
+static long kvm_sdei_set_vcpu_state(struct kvm_vcpu *vcpu,
+				    struct kvm_sdei_vcpu_state *ksv_state)
+{
+	struct kvm_sdei_vcpu *vsdei = vcpu->arch.sdei;
+	struct kvm_sdei_vcpu_event *critical_ksve = NULL;
+	struct kvm_sdei_vcpu_event *normal_ksve = NULL;
+
+	if (kvm_sdei_is_valid_event_num(ksv_state->critical_num)) {
+		critical_ksve = kvm_sdei_find_vcpu_event(vcpu,
+					ksv_state->critical_num);
+		if (!critical_ksve)
+			return -EINVAL;
+	}
+
+	if (kvm_sdei_is_valid_event_num(ksv_state->critical_num)) {
+		normal_ksve = kvm_sdei_find_vcpu_event(vcpu,
+					ksv_state->critical_num);
+		if (!normal_ksve)
+			return -EINVAL;
+	}
+
+	vsdei->state = *ksv_state;
+	vsdei->critical_event = critical_ksve;
+	vsdei->normal_event   = normal_ksve;
+
+	return  0;
+}
+
+long kvm_sdei_vcpu_ioctl(struct kvm_vcpu *vcpu, unsigned long arg)
+{
+	struct kvm *kvm = vcpu->kvm;
+	struct kvm_sdei_kvm *ksdei = kvm->arch.sdei;
+	struct kvm_sdei_vcpu *vsdei = vcpu->arch.sdei;
+	struct kvm_sdei_cmd *cmd = NULL;
+	void __user *argp = (void __user *)arg;
+	bool copy = false;
+	long ret = 0;
+
+	/* Sanity check */
+	if (!(ksdei && vsdei)) {
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
+	spin_lock(&vsdei->lock);
+
+	switch (cmd->cmd) {
+	case KVM_SDEI_CMD_GET_VEVENT_COUNT:
+		copy = true;
+		ret = kvm_sdei_get_vevent_count(vcpu, &cmd->count);
+		break;
+	case KVM_SDEI_CMD_GET_VEVENT:
+		copy = true;
+		ret = kvm_sdei_get_vevent(vcpu, &cmd->ksve_state);
+		break;
+	case KVM_SDEI_CMD_SET_VEVENT:
+		ret = kvm_sdei_set_vevent(vcpu, &cmd->ksve_state);
+		break;
+	case KVM_SDEI_CMD_GET_VCPU_STATE:
+		copy = true;
+		cmd->ksv_state = vsdei->state;
+		break;
+	case KVM_SDEI_CMD_SET_VCPU_STATE:
+		ret = kvm_sdei_set_vcpu_state(vcpu, &cmd->ksv_state);
+		break;
+	default:
+		ret = -EINVAL;
+	}
+
+	spin_unlock(&vsdei->lock);
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
-- 
2.23.0

