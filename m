Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6740C376066
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 08:33:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234909AbhEGGeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 02:34:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25338 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234744AbhEGGdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 02:33:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620369169;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hVwwKdXnrlF17rr7ICUpWrckXNK7bZs/jTIpWezDxag=;
        b=TzMYaJRV/hjUODGuIUNix/AApjBP0hQhDKDh9FORXRm6HN0bqJzbhNnhlcKfo9N66BY0qD
        /FhgVdyXuQ43RVZGV2xknE8V/pS1AprnXVQ1/t99U6VNzBJutBEbU/BpT91XbGphx8ohsc
        i8SQA5ISO4s2ze7r/qVtJmmZRqzegpU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-452-9TUvz9g1OHaw3NjnDunWSg-1; Fri, 07 May 2021 02:32:48 -0400
X-MC-Unique: 9TUvz9g1OHaw3NjnDunWSg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3106564159;
        Fri,  7 May 2021 06:32:47 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-42.bne.redhat.com [10.64.54.42])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 650315D9CA;
        Fri,  7 May 2021 06:32:44 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     linux-kernel@vger.kernel.org, maz@kernel.org, will@kernel.org,
        pbonzini@redhat.com, james.morse@arm.com, mark.rutland@arm.com,
        Jonathan.Cameron@huawei.com, shan.gavin@gmail.com
Subject: [PATCH v3 19/21] KVM: arm64: Support SDEI event cancellation
Date:   Fri,  7 May 2021 16:31:22 +0800
Message-Id: <20210507083124.43347-20-gshan@redhat.com>
In-Reply-To: <20210507083124.43347-1-gshan@redhat.com>
References: <20210507083124.43347-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The injected SDEI event is to send notification to guest. The SDEI
event might not be needed after it's injected. This introduces API
to support cancellation on the injected SDEI event if it's not fired
to the guest yet.

This mechanism will be needed when we're going to support asynchronous
page fault.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 arch/arm64/include/asm/kvm_sdei.h |  1 +
 arch/arm64/kvm/sdei.c             | 49 +++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/arch/arm64/include/asm/kvm_sdei.h b/arch/arm64/include/asm/kvm_sdei.h
index 51087fe971ba..353744c7bad9 100644
--- a/arch/arm64/include/asm/kvm_sdei.h
+++ b/arch/arm64/include/asm/kvm_sdei.h
@@ -126,6 +126,7 @@ int kvm_sdei_register_notifier(struct kvm *kvm, unsigned long num,
 			       kvm_sdei_notifier notifier);
 int kvm_sdei_inject(struct kvm_vcpu *vcpu,
 		    unsigned long num, bool immediate);
+int kvm_sdei_cancel(struct kvm_vcpu *vcpu, unsigned long num);
 void kvm_sdei_deliver(struct kvm_vcpu *vcpu);
 long kvm_sdei_vm_ioctl(struct kvm *kvm, unsigned long arg);
 long kvm_sdei_vcpu_ioctl(struct kvm_vcpu *vcpu, unsigned long arg);
diff --git a/arch/arm64/kvm/sdei.c b/arch/arm64/kvm/sdei.c
index 7c2789cd1421..4f5a582daa97 100644
--- a/arch/arm64/kvm/sdei.c
+++ b/arch/arm64/kvm/sdei.c
@@ -907,6 +907,55 @@ int kvm_sdei_inject(struct kvm_vcpu *vcpu,
 	return ret;
 }
 
+int kvm_sdei_cancel(struct kvm_vcpu *vcpu, unsigned long num)
+{
+	struct kvm *kvm = vcpu->kvm;
+	struct kvm_sdei_kvm *ksdei = kvm->arch.sdei;
+	struct kvm_sdei_vcpu *vsdei = vcpu->arch.sdei;
+	struct kvm_sdei_kvm_event *kske = NULL;
+	struct kvm_sdei_vcpu_event *ksve = NULL;
+	int ret = 0;
+
+	if (!(ksdei && vsdei)) {
+		ret = -EPERM;
+		goto out;
+	}
+
+	/* Find the vCPU event */
+	spin_lock(&vsdei->lock);
+	ksve = kvm_sdei_find_vcpu_event(vcpu, num);
+	if (!ksve) {
+		ret = -EINVAL;
+		goto unlock;
+	}
+
+	/* Event can't be cancelled if it has been delivered */
+	if (ksve->state.refcount <= 1 &&
+	    (vsdei->critical_event == ksve ||
+	     vsdei->normal_event == ksve)) {
+		ret = -EINPROGRESS;
+		goto unlock;
+	}
+
+	/* Free the vCPU event if necessary */
+	kske = ksve->kske;
+	ksve->state.refcount--;
+	if (!ksve->state.refcount) {
+		list_del(&ksve->link);
+		kfree(ksve);
+	}
+
+unlock:
+	spin_unlock(&vsdei->lock);
+	if (kske) {
+		spin_lock(&ksdei->lock);
+		kske->state.refcount--;
+		spin_unlock(&ksdei->lock);
+	}
+out:
+	return ret;
+}
+
 void kvm_sdei_deliver(struct kvm_vcpu *vcpu)
 {
 	struct kvm *kvm = vcpu->kvm;
-- 
2.23.0

