Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0CF43647AB
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 18:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242044AbhDSQCW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 12:02:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50115 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241763AbhDSQCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 12:02:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618848109;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XHLKxK8ssTkxupbvy6XT0y1hEA2Ol0wFqVzEqTuAa6Q=;
        b=IoqIhzT9E6NyvIL1+EB0FEfY8A+2b8J3Vmn41LVomTJlyMz/7w/rTHbdnUsN1BLsP31W6Y
        /gSa9D8/EkMmrEf5rgseNWYXjAD5i2Twr3z6MVFhKCqMO9KLiZBVxdejXBWrLYHIS4E5Am
        EhdDFH4UrCn+H09auxEdzfv/hFy7fk4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-345-4JR14it7N7C2e0742l3vMw-1; Mon, 19 Apr 2021 12:01:47 -0400
X-MC-Unique: 4JR14it7N7C2e0742l3vMw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 410B01922037;
        Mon, 19 Apr 2021 16:01:46 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.40.193.113])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 47BF360636;
        Mon, 19 Apr 2021 16:01:41 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Siddharth Chandrasekaran <sidcha@amazon.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 05/30] KVM: x86: hyper-v: Honor HV_MSR_HYPERCALL_AVAILABLE privilege bit
Date:   Mon, 19 Apr 2021 18:01:02 +0200
Message-Id: <20210419160127.192712-6-vkuznets@redhat.com>
In-Reply-To: <20210419160127.192712-1-vkuznets@redhat.com>
References: <20210419160127.192712-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HV_X64_MSR_GUEST_OS_ID/HV_X64_MSR_HYPERCALL are only available to guest
when HV_MSR_HYPERCALL_AVAILABLE bit is exposed.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/kvm/hyperv.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index b5bc16ea2595..13011803ebbd 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -1196,6 +1196,18 @@ void kvm_hv_invalidate_tsc_page(struct kvm *kvm)
 
 static bool hv_check_msr_access(struct kvm_vcpu_hv *hv_vcpu, u32 msr)
 {
+	if (!hv_vcpu->enforce_cpuid)
+		return true;
+
+	switch (msr) {
+	case HV_X64_MSR_GUEST_OS_ID:
+	case HV_X64_MSR_HYPERCALL:
+		return hv_vcpu->cpuid_cache.features_eax &
+			HV_MSR_HYPERCALL_AVAILABLE;
+	default:
+		break;
+	}
+
 	return true;
 }
 
-- 
2.30.2

