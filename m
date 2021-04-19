Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B64B3647C7
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 18:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242539AbhDSQDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 12:03:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20050 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242276AbhDSQCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 12:02:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618848132;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JYLMkrtsdldndITXa28QWcVF8pTMQEZbqc599hrP62A=;
        b=StXKf0oX6DwwP4xx82xdeu7yc4Rv1OQYtyCqtS43ZyDebJJZ705YuZqwcielJIKBKFMZPC
        vJqpeGt5DP1L2RkA1REluGWXwdSenPIbIzLJ+USAD2ZF76Zz5TUdDD01ZYryew7yMp5MKj
        CgJzHzmLWd4dsc3m+ixO//W4V6h0olw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-191-lGHb20CVOke2uYequEMMCg-1; Mon, 19 Apr 2021 12:02:09 -0400
X-MC-Unique: lGHb20CVOke2uYequEMMCg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B4E396D4E8;
        Mon, 19 Apr 2021 16:02:07 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.40.193.113])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BA9939CA0;
        Mon, 19 Apr 2021 16:02:05 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Siddharth Chandrasekaran <sidcha@amazon.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 15/30] KVM: x86: hyper-v: Honor HV_ACCESS_REENLIGHTENMENT privilege bit
Date:   Mon, 19 Apr 2021 18:01:12 +0200
Message-Id: <20210419160127.192712-16-vkuznets@redhat.com>
In-Reply-To: <20210419160127.192712-1-vkuznets@redhat.com>
References: <20210419160127.192712-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HV_X64_MSR_REENLIGHTENMENT_CONTROL/HV_X64_MSR_TSC_EMULATION_CONTROL/
HV_X64_MSR_TSC_EMULATION_STATUS are only available to guest when
HV_ACCESS_REENLIGHTENMENT bit is exposed.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/kvm/hyperv.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index 8821981e17d3..f416c9de73cb 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -1248,6 +1248,11 @@ static bool hv_check_msr_access(struct kvm_vcpu_hv *hv_vcpu, u32 msr)
 	case HV_X64_MSR_APIC_FREQUENCY:
 		return hv_vcpu->cpuid_cache.features_eax &
 			HV_ACCESS_FREQUENCY_MSRS;
+	case HV_X64_MSR_REENLIGHTENMENT_CONTROL:
+	case HV_X64_MSR_TSC_EMULATION_CONTROL:
+	case HV_X64_MSR_TSC_EMULATION_STATUS:
+		return hv_vcpu->cpuid_cache.features_eax &
+			HV_ACCESS_REENLIGHTENMENT;
 	default:
 		break;
 	}
-- 
2.30.2

