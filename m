Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC6B23147E1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 06:07:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbhBIFGy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 00:06:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22926 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229774AbhBIFF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 00:05:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612847071;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+uUnGwSf0oqnSub/JjSQvM5XUCg9XUtINd+duInZ6C0=;
        b=DJrOkpOnqj1PKjNUT246k8+tRn+9TtqwraEEd3zNf/gwpBdv7gO+phF4iVEcQRC662wqrA
        v1FkIOY0gQWvJclO7Ejr/bjjV7tHD7LzZwcfIWsLMpynMXQxovZjeqU2m1/7XpZ4xT45Dt
        oAeRzQwDUSbOSfwxxvj5Foc0FqQR/GE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-577-_34aPoISPpCzPj-LTK_cZg-1; Tue, 09 Feb 2021 00:04:29 -0500
X-MC-Unique: _34aPoISPpCzPj-LTK_cZg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ADB4A801962;
        Tue,  9 Feb 2021 05:04:27 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-26.bne.redhat.com [10.64.54.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A52E15D9C0;
        Tue,  9 Feb 2021 05:04:23 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     linux-kernel@vger.kernel.org, pbonzini@redhat.com, maz@kernel.org,
        james.morse@arm.com, Jonathan.Cameron@huawei.com,
        mark.rutland@arm.com, will@kernel.org, shan.gavin@gmail.com
Subject: [PATCH v2 03/17] KVM: async_pf: Make GFN slot management generic
Date:   Tue,  9 Feb 2021 13:03:49 +0800
Message-Id: <20210209050403.103143-4-gshan@redhat.com>
In-Reply-To: <20210209050403.103143-1-gshan@redhat.com>
References: <20210209050403.103143-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's not allowed to fire duplicate notification for same GFN on
x86 platform, with help of a hash table. This mechanism is going
to be used by arm64 and this makes the code generic and shareable
by multiple platforms.

   * As this mechanism isn't needed by all platforms, a new kernel
     config option (CONFIG_ASYNC_PF_SLOT) is introduced so that it
     can be disabled at compiling time.

   * The code is basically copied from x86 platform and the functions
     are renamed to reflect the fact: (a) the input parameters are
     vCPU and GFN. (b) The operations are resetting, searching, adding
     and removing.

   * Helper stub is also added on !CONFIG_KVM_ASYNC_PF because we're
     going to use IS_ENABLED() instead of #ifdef on arm64 when the
     asynchronous page fault is supported.

This is preparatory work to use the newly introduced functions on x86
platform and arm64 in subsequent patches.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 include/linux/kvm_host.h | 18 +++++++++
 virt/kvm/Kconfig         |  3 ++
 virt/kvm/async_pf.c      | 79 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 100 insertions(+)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 041d93f8f4b0..b52d71030f25 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -277,6 +277,9 @@ struct kvm_vcpu {
 
 #ifdef CONFIG_KVM_ASYNC_PF
 	struct {
+#ifdef CONFIG_KVM_ASYNC_PF_SLOT
+		gfn_t gfns[ASYNC_PF_PER_VCPU];
+#endif
 		u32 queued;
 		struct list_head queue;
 		struct list_head done;
@@ -321,12 +324,27 @@ static inline bool kvm_check_async_pf_completion_queue(struct kvm_vcpu *vcpu)
 	return !list_empty_careful(&vcpu->async_pf.done);
 }
 
+#ifdef CONFIG_KVM_ASYNC_PF_SLOT
+void kvm_async_pf_reset_slot(struct kvm_vcpu *vcpu);
+void kvm_async_pf_add_slot(struct kvm_vcpu *vcpu, gfn_t gfn);
+void kvm_async_pf_remove_slot(struct kvm_vcpu *vcpu, gfn_t gfn);
+bool kvm_async_pf_find_slot(struct kvm_vcpu *vcpu, gfn_t gfn);
+#endif
+
 void kvm_clear_async_pf_completion_queue(struct kvm_vcpu *vcpu);
 void kvm_check_async_pf_completion(struct kvm_vcpu *vcpu);
 bool kvm_setup_async_pf(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
 			unsigned long hva, struct kvm_arch_async_pf *arch);
 int kvm_async_pf_wakeup_all(struct kvm_vcpu *vcpu);
 #else
+static inline void kvm_async_pf_reset_slot(struct kvm_vcpu *vcpu) { }
+static inline void kvm_async_pf_add_slot(struct kvm_vcpu *vcpu, gfn_t gfn) { }
+static inline void kvm_async_pf_remove_slot(struct kvm_vcpu *vcpu, gfn_t gfn) { }
+static inline bool kvm_async_pf_find_slot(struct kvm_vcpu *vcpu, gfn_t gfn)
+{
+	return false;
+}
+
 static inline bool kvm_check_async_pf_completion_queue(struct kvm_vcpu *vcpu)
 {
 	return false;
diff --git a/virt/kvm/Kconfig b/virt/kvm/Kconfig
index 1c37ccd5d402..69a282aaa4df 100644
--- a/virt/kvm/Kconfig
+++ b/virt/kvm/Kconfig
@@ -23,6 +23,9 @@ config KVM_MMIO
 config KVM_ASYNC_PF
        bool
 
+config KVM_ASYNC_PF_SLOT
+       bool
+
 # Toggle to switch between direct notification and batch job
 config KVM_ASYNC_PF_SYNC
        bool
diff --git a/virt/kvm/async_pf.c b/virt/kvm/async_pf.c
index 2cf864aafd0e..7bf22b20af45 100644
--- a/virt/kvm/async_pf.c
+++ b/virt/kvm/async_pf.c
@@ -19,6 +19,85 @@
 
 static struct kmem_cache *async_pf_cache;
 
+#ifdef CONFIG_KVM_ASYNC_PF_SLOT
+static inline u32 kvm_async_pf_hash(gfn_t gfn)
+{
+	BUILD_BUG_ON(!is_power_of_2(ASYNC_PF_PER_VCPU));
+
+	return hash_32(gfn & 0xffffffff, order_base_2(ASYNC_PF_PER_VCPU));
+}
+
+static inline u32 kvm_async_pf_next_slot(u32 key)
+{
+	return (key + 1) & (ASYNC_PF_PER_VCPU - 1);
+}
+
+static u32 kvm_async_pf_slot(struct kvm_vcpu *vcpu, gfn_t gfn)
+{
+	int i;
+	u32 key = kvm_async_pf_hash(gfn);
+
+	for (i = 0; i < ASYNC_PF_PER_VCPU &&
+		(vcpu->async_pf.gfns[key] != gfn &&
+		vcpu->async_pf.gfns[key] != ~0); i++)
+		key = kvm_async_pf_next_slot(key);
+
+	return key;
+}
+
+void kvm_async_pf_reset_slot(struct kvm_vcpu *vcpu)
+{
+	int i;
+
+	for (i = 0; i < ASYNC_PF_PER_VCPU; i++)
+		vcpu->async_pf.gfns[i] = ~0;
+}
+
+bool kvm_async_pf_find_slot(struct kvm_vcpu *vcpu, gfn_t gfn)
+{
+	return vcpu->async_pf.gfns[kvm_async_pf_slot(vcpu, gfn)] == gfn;
+}
+
+void kvm_async_pf_add_slot(struct kvm_vcpu *vcpu, gfn_t gfn)
+{
+	u32 key = kvm_async_pf_hash(gfn);
+
+	while (vcpu->async_pf.gfns[key] != ~0)
+		key = kvm_async_pf_next_slot(key);
+
+	vcpu->async_pf.gfns[key] = gfn;
+}
+
+void kvm_async_pf_remove_slot(struct kvm_vcpu *vcpu, gfn_t gfn)
+{
+	u32 i, j, k;
+
+	i = j = kvm_async_pf_slot(vcpu, gfn);
+
+	if (WARN_ON_ONCE(vcpu->async_pf.gfns[i] != gfn))
+		return;
+
+	while (true) {
+		vcpu->async_pf.gfns[i] = ~0;
+		do {
+			j = kvm_async_pf_next_slot(j);
+			if (vcpu->async_pf.gfns[j] == ~0)
+				return;
+
+			k = kvm_async_pf_hash(vcpu->async_pf.gfns[j]);
+			/*
+			 * k lies cyclically in ]i,j]
+			 * |    i.k.j |
+			 * |....j i.k.| or  |.k..j i...|
+			 */
+		} while ((i <= j) ? (i < k && k <= j) : (i < k || k <= j));
+
+		vcpu->async_pf.gfns[i] = vcpu->async_pf.gfns[j];
+		i = j;
+	}
+}
+#endif /* CONFIG_KVM_ASYNC_PF_SLOT */
+
 int kvm_async_pf_init(void)
 {
 	async_pf_cache = KMEM_CACHE(kvm_async_pf, 0);
-- 
2.23.0

