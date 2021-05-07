Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9F15376042
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 08:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234553AbhEGGcq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 02:32:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24593 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234136AbhEGGcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 02:32:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620369105;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5wtMxEs66RSI1BsfrHtDwp2JKxLpfmi/qLV27wZM8xc=;
        b=YcZh5KCGYaO6LTRgCVCY0HQlecArR3gxXLdqkjZL23xCWf4YM1L2UmiqF9xRbZFkD06dhh
        Z0J20Cj2WIkIX90jJl3xQ9MDLkMvIKySZxewdVn2+eugu1KHFR+vDVs4wCMfWwlbybvVU6
        kL59J707xMuSFZq9t/wCCBi5GtaNQwQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-535-lMbK8V9yMTCJVtlJfRcc9g-1; Fri, 07 May 2021 02:31:43 -0400
X-MC-Unique: lMbK8V9yMTCJVtlJfRcc9g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6CE4A1006C82;
        Fri,  7 May 2021 06:31:40 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-42.bne.redhat.com [10.64.54.42])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1AD435D9CA;
        Fri,  7 May 2021 06:31:35 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     linux-kernel@vger.kernel.org, maz@kernel.org, will@kernel.org,
        pbonzini@redhat.com, james.morse@arm.com, mark.rutland@arm.com,
        Jonathan.Cameron@huawei.com, shan.gavin@gmail.com
Subject: [PATCH v3 02/21] KVM: arm64: Add SDEI virtualization infrastructure
Date:   Fri,  7 May 2021 16:31:05 +0800
Message-Id: <20210507083124.43347-3-gshan@redhat.com>
In-Reply-To: <20210507083124.43347-1-gshan@redhat.com>
References: <20210507083124.43347-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Software Delegated Exception Interface (SDEI) provides a mechanism for
registering and servicing system events. Those system events are high
priority events, which must be serviced immediately. It's going to be
used by Asynchronous Page Fault (APF) to deliver notification from KVM
to guest. It's noted that SDEI is defined by ARM DEN0054A specification.

This introduces SDEI virtualization infrastructure where the SDEI events
are registered and manuplated by the guest through hypercall. The SDEI
event is delivered to one specific vCPU by KVM once it's raised. This
introduces data structures to represent the needed objects to implement
the feature, which is highlighted as below. As those objects could be
migrated between VMs, these data structures are partially exported to
user space.

   * kvm_sdei_event
     SDEI events are exported from KVM so that guest is able to register
     and manuplate.
   * kvm_sdei_kvm_event
     SDEI event that has been registered by guest.
   * kvm_sdei_kvm_vcpu
     SDEI event that has been delivered to the target vCPU.
   * kvm_sdei_kvm
     Place holder of exported and registered SDEI events.
   * kvm_sdei_vcpu
     Auxiliary object to save the preempted context during SDEI event
     delivery.

The error is returned for all SDEI hypercalls for now. They will be
implemented by the subsequent patches.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 arch/arm64/include/asm/kvm_host.h      |   4 +
 arch/arm64/include/asm/kvm_sdei.h      | 118 +++++++++++++++
 arch/arm64/include/uapi/asm/kvm.h      |   1 +
 arch/arm64/include/uapi/asm/kvm_sdei.h |  60 ++++++++
 arch/arm64/kvm/Makefile                |   2 +-
 arch/arm64/kvm/arm.c                   |   7 +
 arch/arm64/kvm/hypercalls.c            |  18 +++
 arch/arm64/kvm/sdei.c                  | 198 +++++++++++++++++++++++++
 8 files changed, 407 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/include/asm/kvm_sdei.h
 create mode 100644 arch/arm64/include/uapi/asm/kvm_sdei.h
 create mode 100644 arch/arm64/kvm/sdei.c

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 7cd7d5c8c4bc..b66126853041 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -132,6 +132,8 @@ struct kvm_arch {
 
 	u8 pfr0_csv2;
 	u8 pfr0_csv3;
+
+	struct kvm_sdei_kvm *sdei;
 };
 
 struct kvm_vcpu_fault_info {
@@ -371,6 +373,8 @@ struct kvm_vcpu_arch {
 		u64 last_steal;
 		gpa_t base;
 	} steal;
+
+	struct kvm_sdei_vcpu *sdei;
 };
 
 /* Pointer to the vcpu's SVE FFR for sve_{save,load}_state() */
diff --git a/arch/arm64/include/asm/kvm_sdei.h b/arch/arm64/include/asm/kvm_sdei.h
new file mode 100644
index 000000000000..b0abc13a0256
--- /dev/null
+++ b/arch/arm64/include/asm/kvm_sdei.h
@@ -0,0 +1,118 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Definitions of various KVM SDEI events.
+ *
+ * Copyright (C) 2021 Red Hat, Inc.
+ *
+ * Author(s): Gavin Shan <gshan@redhat.com>
+ */
+
+#ifndef __ARM64_KVM_SDEI_H__
+#define __ARM64_KVM_SDEI_H__
+
+#include <uapi/linux/arm_sdei.h>
+#include <uapi/asm/kvm_sdei.h>
+#include <linux/bitmap.h>
+#include <linux/list.h>
+#include <linux/spinlock.h>
+
+struct kvm_sdei_event {
+	struct kvm_sdei_event_state		state;
+	struct kvm				*kvm;
+	struct list_head			link;
+};
+
+struct kvm_sdei_kvm_event {
+	struct kvm_sdei_kvm_event_state		state;
+	struct kvm_sdei_event			*kse;
+	struct kvm				*kvm;
+	struct list_head			link;
+};
+
+struct kvm_sdei_vcpu_event {
+	struct kvm_sdei_vcpu_event_state	state;
+	struct kvm_sdei_kvm_event		*kske;
+	struct kvm_vcpu				*vcpu;
+	struct list_head			link;
+};
+
+struct kvm_sdei_kvm {
+	spinlock_t		lock;
+	struct list_head	events;		/* kvm_sdei_event */
+	struct list_head	kvm_events;	/* kvm_sdei_kvm_event */
+};
+
+struct kvm_sdei_vcpu {
+	spinlock_t                      lock;
+	struct kvm_sdei_vcpu_state      state;
+	struct kvm_sdei_vcpu_event      *critical_event;
+	struct kvm_sdei_vcpu_event      *normal_event;
+	struct list_head                critical_events;
+	struct list_head                normal_events;
+};
+
+/*
+ * According to SDEI specification (v1.0), the event number spans 32-bits
+ * and the lower 24-bits are used as the (real) event number. I don't
+ * think we can use that much SDEI numbers in one system. So we reserve
+ * two bits from the 24-bits real event number, to indicate its types:
+ * physical event and virtual event. One reserved bit is enough for now,
+ * but two bits are reserved for possible extension in future.
+ *
+ * The physical events are owned by underly firmware while the virtual
+ * events are used by VMM and KVM.
+ */
+#define KVM_SDEI_EV_NUM_TYPE_SHIFT	22
+#define KVM_SDEI_EV_NUM_TYPE_MASK	3
+#define KVM_SDEI_EV_NUM_TYPE_PHYS	0
+#define KVM_SDEI_EV_NUM_TYPE_VIRT	1
+
+static inline bool kvm_sdei_is_valid_event_num(unsigned long num)
+{
+	unsigned long type;
+
+	if (num >> 32)
+		return false;
+
+	type = (num >> KVM_SDEI_EV_NUM_TYPE_SHIFT) & KVM_SDEI_EV_NUM_TYPE_MASK;
+	if (type != KVM_SDEI_EV_NUM_TYPE_VIRT)
+		return false;
+
+	return true;
+}
+
+/* Accessors for the registration or enablement states of KVM event */
+#define KVM_SDEI_FLAG_FUNC(field)					   \
+static inline bool kvm_sdei_is_##field(struct kvm_sdei_kvm_event *kske,	   \
+				       unsigned int index)		   \
+{									   \
+	return !!test_bit(index, (void *)(kske->state.field));		   \
+}									   \
+									   \
+static inline bool kvm_sdei_empty_##field(struct kvm_sdei_kvm_event *kske) \
+{									   \
+	return bitmap_empty((void *)(kske->state.field),		   \
+			    KVM_SDEI_MAX_VCPUS);			   \
+}									   \
+static inline void kvm_sdei_set_##field(struct kvm_sdei_kvm_event *kske,   \
+					unsigned int index)		   \
+{									   \
+	set_bit(index, (void *)(kske->state.field));			   \
+}									   \
+static inline void kvm_sdei_clear_##field(struct kvm_sdei_kvm_event *kske, \
+					  unsigned int index)		   \
+{									   \
+	clear_bit(index, (void *)(kske->state.field));			   \
+}
+
+KVM_SDEI_FLAG_FUNC(registered)
+KVM_SDEI_FLAG_FUNC(enabled)
+
+/* APIs */
+void kvm_sdei_init_vm(struct kvm *kvm);
+void kvm_sdei_create_vcpu(struct kvm_vcpu *vcpu);
+int kvm_sdei_hypercall(struct kvm_vcpu *vcpu);
+void kvm_sdei_destroy_vcpu(struct kvm_vcpu *vcpu);
+void kvm_sdei_destroy_vm(struct kvm *kvm);
+
+#endif /* __ARM64_KVM_SDEI_H__ */
diff --git a/arch/arm64/include/uapi/asm/kvm.h b/arch/arm64/include/uapi/asm/kvm.h
index 24223adae150..15499751997d 100644
--- a/arch/arm64/include/uapi/asm/kvm.h
+++ b/arch/arm64/include/uapi/asm/kvm.h
@@ -36,6 +36,7 @@
 #include <linux/types.h>
 #include <asm/ptrace.h>
 #include <asm/sve_context.h>
+#include <asm/kvm_sdei.h>
 
 #define __KVM_HAVE_GUEST_DEBUG
 #define __KVM_HAVE_IRQ_LINE
diff --git a/arch/arm64/include/uapi/asm/kvm_sdei.h b/arch/arm64/include/uapi/asm/kvm_sdei.h
new file mode 100644
index 000000000000..2961a79b8a69
--- /dev/null
+++ b/arch/arm64/include/uapi/asm/kvm_sdei.h
@@ -0,0 +1,60 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * Definitions of various KVM SDEI event states.
+ *
+ * Copyright (C) 2021 Red Hat, Inc.
+ *
+ * Author(s): Gavin Shan <gshan@redhat.com>
+ */
+
+#ifndef _UAPI__ASM_KVM_SDEI_H
+#define _UAPI__ASM_KVM_SDEI_H
+
+#ifndef __ASSEMBLY__
+#include <linux/types.h>
+
+#define KVM_SDEI_MAX_VCPUS     512
+#define KVM_SDEI_INVALID_NUM   0
+#define KVM_SDEI_DEFAULT_NUM   0x40400000
+
+struct kvm_sdei_event_state {
+	__u64	num;
+
+	__u8	type;
+	__u8	signaled;
+	__u8	priority;
+};
+
+struct kvm_sdei_kvm_event_state {
+	__u64	num;
+	__u32	refcount;
+
+	__u8	route_mode;
+	__u64	route_affinity;
+	__u64	entries[KVM_SDEI_MAX_VCPUS];
+	__u64	params[KVM_SDEI_MAX_VCPUS];
+	__u64	registered[KVM_SDEI_MAX_VCPUS/64];
+	__u64	enabled[KVM_SDEI_MAX_VCPUS/64];
+};
+
+struct kvm_sdei_vcpu_event_state {
+	__u64	num;
+	__u32	refcount;
+};
+
+struct kvm_sdei_vcpu_regs {
+	__u64	regs[18];
+	__u64	pc;
+	__u64	pstate;
+};
+
+struct kvm_sdei_vcpu_state {
+	__u8				masked;
+	__u64				critical_num;
+	__u64				normal_num;
+	struct kvm_sdei_vcpu_regs	critical_regs;
+	struct kvm_sdei_vcpu_regs	normal_regs;
+};
+
+#endif /* !__ASSEMBLY__ */
+#endif /* _UAPI__ASM_KVM_SDEI_H */
diff --git a/arch/arm64/kvm/Makefile b/arch/arm64/kvm/Makefile
index 589921392cb1..695dbefb3a3c 100644
--- a/arch/arm64/kvm/Makefile
+++ b/arch/arm64/kvm/Makefile
@@ -16,7 +16,7 @@ kvm-y := $(KVM)/kvm_main.o $(KVM)/coalesced_mmio.o $(KVM)/eventfd.o \
 	 inject_fault.o va_layout.o handle_exit.o \
 	 guest.o debug.o reset.o sys_regs.o \
 	 vgic-sys-reg-v3.o fpsimd.o pmu.o \
-	 arch_timer.o trng.o\
+	 arch_timer.o trng.o sdei.o \
 	 vgic/vgic.o vgic/vgic-init.o \
 	 vgic/vgic-irqfd.o vgic/vgic-v2.o \
 	 vgic/vgic-v3.o vgic/vgic-v4.o \
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 1cb39c0803a4..1faae4e38c13 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -144,6 +144,8 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 
 	kvm_vgic_early_init(kvm);
 
+	kvm_sdei_init_vm(kvm);
+
 	/* The maximum number of VCPUs is limited by the host's GIC model */
 	kvm->arch.max_vcpus = kvm_arm_default_max_vcpus();
 
@@ -173,6 +175,8 @@ void kvm_arch_destroy_vm(struct kvm *kvm)
 
 	kvm_vgic_destroy(kvm);
 
+	kvm_sdei_destroy_vm(kvm);
+
 	for (i = 0; i < KVM_MAX_VCPUS; ++i) {
 		if (kvm->vcpus[i]) {
 			kvm_vcpu_destroy(kvm->vcpus[i]);
@@ -324,6 +328,8 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
 
 	kvm_arm_pvtime_vcpu_init(&vcpu->arch);
 
+	kvm_sdei_create_vcpu(vcpu);
+
 	vcpu->arch.hw_mmu = &vcpu->kvm->arch.mmu;
 
 	err = kvm_vgic_vcpu_init(vcpu);
@@ -345,6 +351,7 @@ void kvm_arch_vcpu_destroy(struct kvm_vcpu *vcpu)
 	kvm_mmu_free_memory_cache(&vcpu->arch.mmu_page_cache);
 	kvm_timer_vcpu_terminate(vcpu);
 	kvm_pmu_vcpu_destroy(vcpu);
+	kvm_sdei_destroy_vcpu(vcpu);
 
 	kvm_arm_vcpu_destroy(vcpu);
 }
diff --git a/arch/arm64/kvm/hypercalls.c b/arch/arm64/kvm/hypercalls.c
index 30da78f72b3b..d3fc893a4f58 100644
--- a/arch/arm64/kvm/hypercalls.c
+++ b/arch/arm64/kvm/hypercalls.c
@@ -139,6 +139,24 @@ int kvm_hvc_call_handler(struct kvm_vcpu *vcpu)
 	case ARM_SMCCC_TRNG_RND32:
 	case ARM_SMCCC_TRNG_RND64:
 		return kvm_trng_call(vcpu);
+	case SDEI_1_0_FN_SDEI_VERSION:
+	case SDEI_1_0_FN_SDEI_EVENT_REGISTER:
+	case SDEI_1_0_FN_SDEI_EVENT_ENABLE:
+	case SDEI_1_0_FN_SDEI_EVENT_DISABLE:
+	case SDEI_1_0_FN_SDEI_EVENT_CONTEXT:
+	case SDEI_1_0_FN_SDEI_EVENT_COMPLETE:
+	case SDEI_1_0_FN_SDEI_EVENT_COMPLETE_AND_RESUME:
+	case SDEI_1_0_FN_SDEI_EVENT_UNREGISTER:
+	case SDEI_1_0_FN_SDEI_EVENT_STATUS:
+	case SDEI_1_0_FN_SDEI_EVENT_GET_INFO:
+	case SDEI_1_0_FN_SDEI_EVENT_ROUTING_SET:
+	case SDEI_1_0_FN_SDEI_PE_MASK:
+	case SDEI_1_0_FN_SDEI_PE_UNMASK:
+	case SDEI_1_0_FN_SDEI_INTERRUPT_BIND:
+	case SDEI_1_0_FN_SDEI_INTERRUPT_RELEASE:
+	case SDEI_1_0_FN_SDEI_PRIVATE_RESET:
+	case SDEI_1_0_FN_SDEI_SHARED_RESET:
+		return kvm_sdei_hypercall(vcpu);
 	default:
 		return kvm_psci_call(vcpu);
 	}
diff --git a/arch/arm64/kvm/sdei.c b/arch/arm64/kvm/sdei.c
new file mode 100644
index 000000000000..ab330b74a965
--- /dev/null
+++ b/arch/arm64/kvm/sdei.c
@@ -0,0 +1,198 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * SDEI virtualization support.
+ *
+ * Copyright (C) 2021 Red Hat, Inc.
+ *
+ * Author(s): Gavin Shan <gshan@redhat.com>
+ */
+
+#include <linux/kernel.h>
+#include <linux/kvm_host.h>
+#include <linux/spinlock.h>
+#include <linux/slab.h>
+#include <kvm/arm_hypercalls.h>
+
+static struct kvm_sdei_event_state defined_kse[] = {
+	{ KVM_SDEI_DEFAULT_NUM,
+	  SDEI_EVENT_TYPE_PRIVATE,
+	  1,
+	  SDEI_EVENT_PRIORITY_CRITICAL
+	},
+};
+
+static void kvm_sdei_remove_events(struct kvm *kvm)
+{
+	struct kvm_sdei_kvm *ksdei = kvm->arch.sdei;
+	struct kvm_sdei_event *kse, *tmp;
+
+	list_for_each_entry_safe(kse, tmp, &ksdei->events, link) {
+		list_del(&kse->link);
+		kfree(kse);
+	}
+}
+
+static void kvm_sdei_remove_kvm_events(struct kvm *kvm,
+				       unsigned int mask,
+				       bool force)
+{
+	struct kvm_sdei_kvm *ksdei = kvm->arch.sdei;
+	struct kvm_sdei_event *kse;
+	struct kvm_sdei_kvm_event *kske, *tmp;
+
+	list_for_each_entry_safe(kske, tmp, &ksdei->kvm_events, link) {
+		kse = kske->kse;
+
+		if (!((1 << kse->state.type) & mask))
+			continue;
+
+		if (!force && kske->state.refcount)
+			continue;
+
+		list_del(&kske->link);
+		kfree(kske);
+	}
+}
+
+static void kvm_sdei_remove_vcpu_events(struct kvm_vcpu *vcpu)
+{
+	struct kvm_sdei_vcpu *vsdei = vcpu->arch.sdei;
+	struct kvm_sdei_vcpu_event *ksve, *tmp;
+
+	list_for_each_entry_safe(ksve, tmp, &vsdei->critical_events, link) {
+		list_del(&ksve->link);
+		kfree(ksve);
+	}
+
+	list_for_each_entry_safe(ksve, tmp, &vsdei->normal_events, link) {
+		list_del(&ksve->link);
+		kfree(ksve);
+	}
+}
+
+int kvm_sdei_hypercall(struct kvm_vcpu *vcpu)
+{
+	u32 func = smccc_get_function(vcpu);
+	bool has_result = true;
+	unsigned long ret;
+
+	switch (func) {
+	case SDEI_1_0_FN_SDEI_VERSION:
+	case SDEI_1_0_FN_SDEI_EVENT_REGISTER:
+	case SDEI_1_0_FN_SDEI_EVENT_ENABLE:
+	case SDEI_1_0_FN_SDEI_EVENT_DISABLE:
+	case SDEI_1_0_FN_SDEI_EVENT_CONTEXT:
+	case SDEI_1_0_FN_SDEI_EVENT_COMPLETE:
+	case SDEI_1_0_FN_SDEI_EVENT_COMPLETE_AND_RESUME:
+	case SDEI_1_0_FN_SDEI_EVENT_UNREGISTER:
+	case SDEI_1_0_FN_SDEI_EVENT_STATUS:
+	case SDEI_1_0_FN_SDEI_EVENT_GET_INFO:
+	case SDEI_1_0_FN_SDEI_EVENT_ROUTING_SET:
+	case SDEI_1_0_FN_SDEI_PE_MASK:
+	case SDEI_1_0_FN_SDEI_PE_UNMASK:
+	case SDEI_1_0_FN_SDEI_INTERRUPT_BIND:
+	case SDEI_1_0_FN_SDEI_INTERRUPT_RELEASE:
+	case SDEI_1_0_FN_SDEI_PRIVATE_RESET:
+	case SDEI_1_0_FN_SDEI_SHARED_RESET:
+	default:
+		ret = SDEI_NOT_SUPPORTED;
+	}
+
+	/*
+	 * We don't have return value for COMPLETE or COMPLETE_AND_RESUME
+	 * hypercalls. Otherwise, the restored context will be corrupted.
+	 */
+	if (has_result)
+		smccc_set_retval(vcpu, ret, 0, 0, 0);
+
+	return 1;
+}
+
+void kvm_sdei_init_vm(struct kvm *kvm)
+{
+	struct kvm_sdei_kvm *ksdei;
+	struct kvm_sdei_event *kse;
+	int i;
+
+	ksdei = kzalloc(sizeof(*ksdei), GFP_KERNEL);
+	if (!ksdei)
+		return;
+
+	spin_lock_init(&ksdei->lock);
+	INIT_LIST_HEAD(&ksdei->events);
+	INIT_LIST_HEAD(&ksdei->kvm_events);
+
+	/*
+	 * Populate the defined KVM SDEI events. The whole functionality
+	 * will be disabled on any errors.
+	 */
+	for (i = 0; i < ARRAY_SIZE(defined_kse); i++) {
+		kse = kzalloc(sizeof(*kse), GFP_KERNEL);
+		if (!kse) {
+			kvm_sdei_remove_events(kvm);
+			kfree(ksdei);
+			return;
+		}
+
+		kse->kvm   = kvm;
+		kse->state = defined_kse[i];
+		list_add_tail(&kse->link, &ksdei->events);
+	}
+
+	kvm->arch.sdei = ksdei;
+}
+
+void kvm_sdei_create_vcpu(struct kvm_vcpu *vcpu)
+{
+	struct kvm *kvm = vcpu->kvm;
+	struct kvm_sdei_vcpu *vsdei;
+
+	if (!kvm->arch.sdei)
+		return;
+
+	vsdei = kzalloc(sizeof(*vsdei), GFP_KERNEL);
+	if (!vsdei)
+		return;
+
+	spin_lock_init(&vsdei->lock);
+	vsdei->state.masked       = 1;
+	vsdei->state.critical_num = KVM_SDEI_INVALID_NUM;
+	vsdei->state.normal_num   = KVM_SDEI_INVALID_NUM;
+	vsdei->critical_event     = NULL;
+	vsdei->normal_event       = NULL;
+	INIT_LIST_HEAD(&vsdei->critical_events);
+	INIT_LIST_HEAD(&vsdei->normal_events);
+
+	vcpu->arch.sdei = vsdei;
+}
+
+void kvm_sdei_destroy_vcpu(struct kvm_vcpu *vcpu)
+{
+	struct kvm_sdei_vcpu *vsdei = vcpu->arch.sdei;
+
+	if (vsdei) {
+		spin_lock(&vsdei->lock);
+		kvm_sdei_remove_vcpu_events(vcpu);
+		spin_unlock(&vsdei->lock);
+
+		kfree(vsdei);
+		vcpu->arch.sdei = NULL;
+	}
+}
+
+void kvm_sdei_destroy_vm(struct kvm *kvm)
+{
+	struct kvm_sdei_kvm *ksdei = kvm->arch.sdei;
+	unsigned int mask = (1 << SDEI_EVENT_TYPE_PRIVATE) |
+			    (1 << SDEI_EVENT_TYPE_SHARED);
+
+	if (ksdei) {
+		spin_lock(&ksdei->lock);
+		kvm_sdei_remove_kvm_events(kvm, mask, true);
+		kvm_sdei_remove_events(kvm);
+		spin_unlock(&ksdei->lock);
+
+		kfree(ksdei);
+		kvm->arch.sdei = NULL;
+	}
+}
-- 
2.23.0

