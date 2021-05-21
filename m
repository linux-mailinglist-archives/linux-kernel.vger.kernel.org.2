Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C24E38C426
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 11:56:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237016AbhEUJ5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 05:57:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20477 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237271AbhEUJyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 05:54:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621590810;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uFFJyYsGinFWRUfBgXSMFbwaCr84HcgqzbG9Gvbm4qk=;
        b=HUdJlNc2nGFgDTz1vYohHndaECIgy99hrrBkQ57u0pggeSe0jix1iZxKEEASsxu0v//HGl
        rySheiwtAw0du6RcGjGBuR7QgXjzRwGTVV3P3OYQhiBMmrtycbXroFGTR9DwQKiixg85ej
        tVPmzVr9SOS/X/Wx7x1QFTDk4D/3AqU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-485-vDeoN0FsNI2EyMQZy96eyQ-1; Fri, 21 May 2021 05:53:29 -0400
X-MC-Unique: vDeoN0FsNI2EyMQZy96eyQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CC48A801106;
        Fri, 21 May 2021 09:53:27 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.40.195.55])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C708C687F7;
        Fri, 21 May 2021 09:53:25 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Siddharth Chandrasekaran <sidcha@amazon.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 25/30] KVM: x86: hyper-v: Honor HV_X64_REMOTE_TLB_FLUSH_RECOMMENDED bit
Date:   Fri, 21 May 2021 11:51:59 +0200
Message-Id: <20210521095204.2161214-26-vkuznets@redhat.com>
In-Reply-To: <20210521095204.2161214-1-vkuznets@redhat.com>
References: <20210521095204.2161214-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hyper-V partition must possess 'HV_X64_REMOTE_TLB_FLUSH_RECOMMENDED'
privilege ('recommended' is rather a misnomer) to issue
HVCALL_FLUSH_VIRTUAL_ADDRESS_LIST/SPACE hypercalls.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/kvm/hyperv.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index 36ec688cda4e..f99072e092d0 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -2044,6 +2044,12 @@ static bool hv_check_hypercall_access(struct kvm_vcpu_hv *hv_vcpu, u16 code)
 		 */
 		return !kvm_hv_is_syndbg_enabled(hv_vcpu->vcpu) ||
 			hv_vcpu->cpuid_cache.features_ebx & HV_DEBUGGING;
+	case HVCALL_FLUSH_VIRTUAL_ADDRESS_LIST_EX:
+	case HVCALL_FLUSH_VIRTUAL_ADDRESS_SPACE_EX:
+	case HVCALL_FLUSH_VIRTUAL_ADDRESS_LIST:
+	case HVCALL_FLUSH_VIRTUAL_ADDRESS_SPACE:
+		return hv_vcpu->cpuid_cache.enlightenments_eax &
+			HV_X64_REMOTE_TLB_FLUSH_RECOMMENDED;
 	default:
 		break;
 	}
-- 
2.31.1

