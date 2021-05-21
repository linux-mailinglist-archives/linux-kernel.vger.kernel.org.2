Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB71538C3FD
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 11:54:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237117AbhEUJzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 05:55:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21019 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235733AbhEUJyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 05:54:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621590765;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m8EWwZqFoaBcdfJhsEam+65aHB3SYeclKlGOWW0aLIg=;
        b=RZN/Wk5M6pVKgDJz8AM0JtxIl2NLEThUcEpvFSAkLGpKrkgSIPQ073vlwneudbHOnZ44Ef
        6YhbGLjR47J7oPE/jCLEED2VZuheL+AkKHJdAtD/Ht833DZHK7adoHYp/ny5sfQWi+BN07
        4dFQc/m22EIzy21zVBWmOG0W88tTu3E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-357-xb0gLtfhPgWTecK-0x9yJg-1; Fri, 21 May 2021 05:52:43 -0400
X-MC-Unique: xb0gLtfhPgWTecK-0x9yJg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 73317101F7AD;
        Fri, 21 May 2021 09:52:42 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.40.195.55])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 24E24687F7;
        Fri, 21 May 2021 09:52:35 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Siddharth Chandrasekaran <sidcha@amazon.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 12/30] KVM: x86: hyper-v: Honor HV_MSR_SYNTIMER_AVAILABLE privilege bit
Date:   Fri, 21 May 2021 11:51:46 +0200
Message-Id: <20210521095204.2161214-13-vkuznets@redhat.com>
In-Reply-To: <20210521095204.2161214-1-vkuznets@redhat.com>
References: <20210521095204.2161214-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Synthetic timers MSRs (HV_X64_MSR_STIMER[0-3]_CONFIG,
HV_X64_MSR_STIMER[0-3]_COUNT) are only available to guest when
HV_MSR_SYNTIMER_AVAILABLE bit is exposed.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/kvm/hyperv.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index 17bdf8e8196e..2582c23126fa 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -1227,6 +1227,16 @@ static bool hv_check_msr_access(struct kvm_vcpu_hv *hv_vcpu, u32 msr)
 	case HV_X64_MSR_SINT0 ... HV_X64_MSR_SINT15:
 		return hv_vcpu->cpuid_cache.features_eax &
 			HV_MSR_SYNIC_AVAILABLE;
+	case HV_X64_MSR_STIMER0_CONFIG:
+	case HV_X64_MSR_STIMER1_CONFIG:
+	case HV_X64_MSR_STIMER2_CONFIG:
+	case HV_X64_MSR_STIMER3_CONFIG:
+	case HV_X64_MSR_STIMER0_COUNT:
+	case HV_X64_MSR_STIMER1_COUNT:
+	case HV_X64_MSR_STIMER2_COUNT:
+	case HV_X64_MSR_STIMER3_COUNT:
+		return hv_vcpu->cpuid_cache.features_eax &
+			HV_MSR_SYNTIMER_AVAILABLE;
 	default:
 		break;
 	}
-- 
2.31.1

