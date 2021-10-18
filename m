Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFF0A432263
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 17:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232098AbhJRPQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 11:16:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37985 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231921AbhJRPQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 11:16:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634570058;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ITZwjENSq81FiJiI76HRsEVj0Df1FfhM1x0DN4yhQYw=;
        b=CMw6RjctB9GlHBaa2b/jxXM55VtQ9+Sj2iCpZXi//YnIozo5PKDp1GTUwKewc7TOk3zLhr
        A9NSPwLTo94HHACX+EpEhaXob548QTcqKtO12gBzyu4nwn80D974kdaVAJ9yvC+RCEBt7I
        Y756i36My67mpyXJT3vl29D32tGOMoM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-10-gqBotatuOLS0cCSnivgCyw-1; Mon, 18 Oct 2021 11:14:12 -0400
X-MC-Unique: gqBotatuOLS0cCSnivgCyw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C0663362FC;
        Mon, 18 Oct 2021 15:14:10 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.40.194.147])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7D2215DF35;
        Mon, 18 Oct 2021 15:14:08 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] KVM: Drop stale kvm_is_transparent_hugepage() declaration
Date:   Mon, 18 Oct 2021 17:14:07 +0200
Message-Id: <20211018151407.2107363-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kvm_is_transparent_hugepage() was removed in commit 205d76ff0684 ("KVM:
Remove kvm_is_transparent_hugepage() and PageTransCompoundMap()") but its
declaration in include/linux/kvm_host.h persisted. Drop it.

Fixes: 205d76ff0684 (""KVM: Remove kvm_is_transparent_hugepage() and PageTransCompoundMap()")
Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 include/linux/kvm_host.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 0f18df7fe874..2dc62a8cc96c 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1164,7 +1164,6 @@ int kvm_cpu_has_pending_timer(struct kvm_vcpu *vcpu);
 
 bool kvm_is_reserved_pfn(kvm_pfn_t pfn);
 bool kvm_is_zone_device_pfn(kvm_pfn_t pfn);
-bool kvm_is_transparent_hugepage(kvm_pfn_t pfn);
 
 struct kvm_irq_ack_notifier {
 	struct hlist_node link;
-- 
2.31.1

