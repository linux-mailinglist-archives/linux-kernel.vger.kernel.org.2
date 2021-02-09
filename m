Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 708783147DE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 06:07:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbhBIFGT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 00:06:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41558 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229472AbhBIFFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 00:05:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612847064;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0II6lOIWtDqZONeydOmeOtky4VbHS29zjzqopD/ZPWM=;
        b=ag5b9DpFB4E/JUogQGJXJ6oYpWSJCvI90n9//7ocTlYzXBPubjEJ2swnSZ5nYnqtAWwgTL
        1/g+YTa/tL11wl7hWvs8ZfScQEBofZJnWQ6qBT1L2IggjSJSlWpCs1MzKZiNeOkw8wEG6/
        Q7vkHQu+qdG/kQxHs3vCjCgxED8Ts8Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-513-Ivgy9iiUNoO7sTYvi6--fw-1; Tue, 09 Feb 2021 00:04:21 -0500
X-MC-Unique: Ivgy9iiUNoO7sTYvi6--fw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 932DD803F4D;
        Tue,  9 Feb 2021 05:04:19 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-26.bne.redhat.com [10.64.54.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9E16F5D9C0;
        Tue,  9 Feb 2021 05:04:16 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     linux-kernel@vger.kernel.org, pbonzini@redhat.com, maz@kernel.org,
        james.morse@arm.com, Jonathan.Cameron@huawei.com,
        mark.rutland@arm.com, will@kernel.org, shan.gavin@gmail.com
Subject: [PATCH v2 01/17] KVM: async_pf: Move struct kvm_async_pf around
Date:   Tue,  9 Feb 2021 13:03:47 +0800
Message-Id: <20210209050403.103143-2-gshan@redhat.com>
In-Reply-To: <20210209050403.103143-1-gshan@redhat.com>
References: <20210209050403.103143-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This moves the definitions of "struct kvm_async_pf" and the related
functions after "struct kvm_vcpu" so that newly added inline function
can dereference "struct kvm_vcpu" properly. Otherwise, the unexpected
build error will be raised:

   error: dereferencing pointer to incomplete type ‘struct kvm_vcpu’
   return !list_empty_careful(&vcpu->async_pf.done);
                                   ^~

The sepator between type and field is replaced by tab for "struct
kvm_async_pf" since we're here. This is preparatory work for adding
new inline function for next patch. This shouldn't cause logical
changes.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 include/linux/kvm_host.h | 43 ++++++++++++++++++++--------------------
 1 file changed, 22 insertions(+), 21 deletions(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index f3b1013fb22c..b6697ee1182e 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -196,27 +196,6 @@ void kvm_io_bus_unregister_dev(struct kvm *kvm, enum kvm_bus bus_idx,
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
 enum {
 	OUTSIDE_GUEST_MODE,
 	IN_GUEST_MODE,
@@ -323,6 +302,28 @@ struct kvm_vcpu {
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
+#endif
+
+
 static inline int kvm_vcpu_exiting_guest_mode(struct kvm_vcpu *vcpu)
 {
 	/*
-- 
2.23.0

