Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9247376080
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 08:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233948AbhEGGmC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 02:42:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:29742 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230446AbhEGGmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 02:42:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620369660;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M8lFeeN8be7qhuOQQpXtHcaLdac3IpsizI/USRchIjU=;
        b=SRLL8xXb9na4hLcwmpXb6Cn5y1P0R+MLljmEJpGDfzFc1WuQeK8TyIMyVzJClq/pjrdGPo
        7A5vsDfgZ1hPttPhA/qaLXncy/adIAF7CCV38iXo3npo85AwE21g7c2unjbekmgmCjqvQf
        8gAb+8hmqq/QdIDnZrWW6ko/EZk+5n0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-482-L3HFR7wINaeUNi4LrcfFOg-1; Fri, 07 May 2021 02:40:59 -0400
X-MC-Unique: L3HFR7wINaeUNi4LrcfFOg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C139C80059E;
        Fri,  7 May 2021 06:40:57 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-42.bne.redhat.com [10.64.54.42])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9EC065C276;
        Fri,  7 May 2021 06:40:54 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     linux-kernel@vger.kernel.org, maz@kernel.org, will@kernel.org,
        pbonzini@redhat.com, james.morse@arm.com, mark.rutland@arm.com,
        Jonathan.Cameron@huawei.com, shan.gavin@gmail.com
Subject: [PATCH v3 01/15] KVM: async_pf: Move struct kvm_async_pf around
Date:   Fri,  7 May 2021 16:40:39 +0800
Message-Id: <20210507084053.44407-2-gshan@redhat.com>
In-Reply-To: <20210507084053.44407-1-gshan@redhat.com>
References: <20210507084053.44407-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This moves the definitions of "struct kvm_async_pf" and the related
functions after "struct kvm_vcpu" so that newly added inline functions
in the subsequent patches can dereference "struct kvm_vcpu" properly.
Otherwise, the unexpected build error will be raised:

   error: dereferencing pointer to incomplete type ‘struct kvm_vcpu’
   return !list_empty_careful(&vcpu->async_pf.done);
                                   ^~

Some cleanups are also applied since we're here:

   * The sepator between type and field is replaced by tab for "struct
     kvm_async_pf".

   * Added stub kvm_check_async_pf_completion() when CONFIG_KVM_ASYMC_PF
     is disabled.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 include/linux/kvm_host.h | 44 +++++++++++++++++++++-------------------
 1 file changed, 23 insertions(+), 21 deletions(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 8895b95b6a22..d54adba6ebf7 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -197,27 +197,6 @@ int kvm_io_bus_unregister_dev(struct kvm *kvm, enum kvm_bus bus_idx,
 struct kvm_io_device *kvm_io_bus_get_dev(struct kvm *kvm, enum kvm_bus bus_idx,
 					 gpa_t addr);
 
-#ifdef CONFIG_KVM_ASYNC_PF
-struct kvm_async_pf {
-	struct work_struct work;
-	struct list_head link;
-	struct list_head queue;
-	struct kvm_vcpu *vcpu;
-	struct mm_struct *mm;
-	gpa_t cr2_or_gpa;
-	unsigned long addr;
-	struct kvm_arch_async_pf arch;
-	bool   wakeup_all;
-	bool notpresent_injected;
-};
-
-void kvm_clear_async_pf_completion_queue(struct kvm_vcpu *vcpu);
-void kvm_check_async_pf_completion(struct kvm_vcpu *vcpu);
-bool kvm_setup_async_pf(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
-			unsigned long hva, struct kvm_arch_async_pf *arch);
-int kvm_async_pf_wakeup_all(struct kvm_vcpu *vcpu);
-#endif
-
 #ifdef KVM_ARCH_WANT_MMU_NOTIFIER
 struct kvm_gfn_range {
 	struct kvm_memory_slot *slot;
@@ -338,6 +317,29 @@ struct kvm_vcpu {
 	struct kvm_dirty_ring dirty_ring;
 };
 
+#ifdef CONFIG_KVM_ASYNC_PF
+struct kvm_async_pf {
+	struct work_struct		work;
+	struct list_head		link;
+	struct list_head		queue;
+	struct kvm_vcpu			*vcpu;
+	struct mm_struct		*mm;
+	gpa_t				cr2_or_gpa;
+	unsigned long			addr;
+	struct kvm_arch_async_pf	arch;
+	bool				wakeup_all;
+	bool				notpresent_injected;
+};
+
+void kvm_clear_async_pf_completion_queue(struct kvm_vcpu *vcpu);
+void kvm_check_async_pf_completion(struct kvm_vcpu *vcpu);
+bool kvm_setup_async_pf(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
+			unsigned long hva, struct kvm_arch_async_pf *arch);
+int kvm_async_pf_wakeup_all(struct kvm_vcpu *vcpu);
+#else
+static inline void kvm_check_async_pf_completion(struct kvm_vcpu *vcpu) { }
+#endif
+
 static inline int kvm_vcpu_exiting_guest_mode(struct kvm_vcpu *vcpu)
 {
 	/*
-- 
2.23.0

