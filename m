Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB2F3647B8
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 18:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242113AbhDSQCl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 12:02:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:58500 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242089AbhDSQC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 12:02:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618848117;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rLfEZQYANgmIdG86E3rNy/LIm1jZSWPvo00aLqGI/Sk=;
        b=IFBX8Kf32jqHdtZt82xPOi2iUGOUX9ktVAYdibL55RRL4hCYKeTB1sFdbP8lN6CTdjV/xV
        blKzBE8fQYdnap/zFSO/Og30sHXlknyEz9AFBPAfXD4pThOCDDNuMEfTGuZ9wSIaUkTHse
        Dss/R3KfUEqxdnlIdYiIWKOScQFGw/g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-454-8LYLUpldMJ-ulH-z9WZVOA-1; Mon, 19 Apr 2021 12:01:55 -0400
X-MC-Unique: 8LYLUpldMJ-ulH-z9WZVOA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 49B3A6D4EC;
        Mon, 19 Apr 2021 16:01:54 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.40.193.113])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8B02960636;
        Mon, 19 Apr 2021 16:01:52 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Siddharth Chandrasekaran <sidcha@amazon.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 09/30] KVM: x86: hyper-v: Honor HV_MSR_RESET_AVAILABLE privilege bit
Date:   Mon, 19 Apr 2021 18:01:06 +0200
Message-Id: <20210419160127.192712-10-vkuznets@redhat.com>
In-Reply-To: <20210419160127.192712-1-vkuznets@redhat.com>
References: <20210419160127.192712-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HV_X64_MSR_RESET is only available to guest when HV_MSR_RESET_AVAILABLE bit
is exposed.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/kvm/hyperv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index 0f3f30f6ca69..affc6e0cda09 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -1213,6 +1213,9 @@ static bool hv_check_msr_access(struct kvm_vcpu_hv *hv_vcpu, u32 msr)
 	case HV_X64_MSR_VP_INDEX:
 		return hv_vcpu->cpuid_cache.features_eax &
 			HV_MSR_VP_INDEX_AVAILABLE;
+	case HV_X64_MSR_RESET:
+		return hv_vcpu->cpuid_cache.features_eax &
+			HV_MSR_RESET_AVAILABLE;
 	default:
 		break;
 	}
-- 
2.30.2

