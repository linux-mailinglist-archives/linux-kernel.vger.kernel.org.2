Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 291003647D6
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 18:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242742AbhDSQES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 12:04:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54515 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238135AbhDSQC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 12:02:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618848149;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rrsuA+n77H7mscq2pch+7B+Yx92F5Wzye2hgMJStNbs=;
        b=iOhXdR/0misXKLRqj6SPgW0WoGqkGVLaTBAObF7f/gFyBAUj1mdMkU9UuFaU3VduWjaYbC
        +DJzeRFwxN/Yh63cdIG98M7cae9MN0T5rCe89qjnozoa88hHU2K+dW0pCr/UQAZhvRjfQY
        3tqwUzurvJEZvuMYTP9m5rxXTPGt2OY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-267-pxC7z7DqMNGgut-Vwkjzpw-1; Mon, 19 Apr 2021 12:02:27 -0400
X-MC-Unique: pxC7z7DqMNGgut-Vwkjzpw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D71A018397B4;
        Mon, 19 Apr 2021 16:02:25 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.40.193.113])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2E28919809;
        Mon, 19 Apr 2021 16:02:24 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Siddharth Chandrasekaran <sidcha@amazon.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 23/30] KVM: x86: hyper-v: Honor HV_SIGNAL_EVENTS privilege bit
Date:   Mon, 19 Apr 2021 18:01:20 +0200
Message-Id: <20210419160127.192712-24-vkuznets@redhat.com>
In-Reply-To: <20210419160127.192712-1-vkuznets@redhat.com>
References: <20210419160127.192712-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hyper-V partition must possess 'HV_SIGNAL_EVENTS' privilege to issue
HVCALL_SIGNAL_EVENT hypercalls.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/kvm/hyperv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index ff86c00d1396..523f63287636 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -2033,6 +2033,8 @@ static bool hv_check_hypercall_access(struct kvm_vcpu_hv *hv_vcpu, u16 code)
 			hv_vcpu->cpuid_cache.enlightenments_ebx != U32_MAX;
 	case HVCALL_POST_MESSAGE:
 		return hv_vcpu->cpuid_cache.features_ebx & HV_POST_MESSAGES;
+	case HVCALL_SIGNAL_EVENT:
+		return hv_vcpu->cpuid_cache.features_ebx & HV_SIGNAL_EVENTS;
 	default:
 		break;
 	}
-- 
2.30.2

