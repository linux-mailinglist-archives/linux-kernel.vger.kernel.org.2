Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3966D38C3FA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 11:54:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237391AbhEUJzs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 05:55:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:33880 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232005AbhEUJyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 05:54:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621590760;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Gqr2JEhMJejiTSYAVVMdL9QDCt7QfUsf+T8S8qdLKks=;
        b=hJeahkNFHdEq62rJfXCK7RcjpTZgyGbwAA3itWmUNqmntDVOuGUu2AL9mlSCfoQKI82UTj
        +8aGEh00/p61sLKTuuXuWDHU1j7M9BpwoFi9zLBUbAzh64QFWu4dU79HDmjgCMLCnwWBcv
        YHQTCNUhvRGmqFj8FXf3uPV65qN3XVQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-552-bZZlPROiO-KdgpfmuOCHUA-1; Fri, 21 May 2021 05:52:36 -0400
X-MC-Unique: bZZlPROiO-KdgpfmuOCHUA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C363B427C4;
        Fri, 21 May 2021 09:52:35 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.40.195.55])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B2BEF687F7;
        Fri, 21 May 2021 09:52:33 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Siddharth Chandrasekaran <sidcha@amazon.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 11/30] KVM: x86: hyper-v: Honor HV_MSR_SYNIC_AVAILABLE privilege bit
Date:   Fri, 21 May 2021 11:51:45 +0200
Message-Id: <20210521095204.2161214-12-vkuznets@redhat.com>
In-Reply-To: <20210521095204.2161214-1-vkuznets@redhat.com>
References: <20210521095204.2161214-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SynIC MSRs (HV_X64_MSR_SCONTROL, HV_X64_MSR_SVERSION, HV_X64_MSR_SIEFP,
HV_X64_MSR_SIMP, HV_X64_MSR_EOM, HV_X64_MSR_SINT0 ... HV_X64_MSR_SINT15)
are only available to guest when HV_MSR_SYNIC_AVAILABLE bit is exposed.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/kvm/hyperv.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index be6156a27bd7..17bdf8e8196e 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -1219,6 +1219,14 @@ static bool hv_check_msr_access(struct kvm_vcpu_hv *hv_vcpu, u32 msr)
 	case HV_X64_MSR_REFERENCE_TSC:
 		return hv_vcpu->cpuid_cache.features_eax &
 			HV_MSR_REFERENCE_TSC_AVAILABLE;
+	case HV_X64_MSR_SCONTROL:
+	case HV_X64_MSR_SVERSION:
+	case HV_X64_MSR_SIEFP:
+	case HV_X64_MSR_SIMP:
+	case HV_X64_MSR_EOM:
+	case HV_X64_MSR_SINT0 ... HV_X64_MSR_SINT15:
+		return hv_vcpu->cpuid_cache.features_eax &
+			HV_MSR_SYNIC_AVAILABLE;
 	default:
 		break;
 	}
-- 
2.31.1

