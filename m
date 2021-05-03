Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D741037157C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 14:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233933AbhECMz4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 08:55:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:34027 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230431AbhECMzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 08:55:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620046500;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mIEpsQd6XZSOwmDS5jk+XOTkhwLc0GrdWpfAAXyyA/g=;
        b=ecTAyumoN5MGwYQqSfOHC8ec9sjkKEzTq0umbUjhl7eXPMGfglDnb95v3VD3BWhe9M4dkl
        iJbX9ZRaJvWR2CBsXaEvFQ/S67QHvZiCqTNWm6PppGSfFPd6ZsYnY3D2AftAlA+SKkKjMZ
        8UWawSyDPc+1oDx6RN1OiknUrNAxKy0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-8-7kkZE34_Pb6zu7pHlgclHw-1; Mon, 03 May 2021 08:54:58 -0400
X-MC-Unique: 7kkZE34_Pb6zu7pHlgclHw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DD33E80ED96;
        Mon,  3 May 2021 12:54:56 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.193.27])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C3F7CBA6F;
        Mon,  3 May 2021 12:54:52 +0000 (UTC)
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Wanpeng Li <wanpengli@tencent.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND
        64-BIT)), Jim Mattson <jmattson@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        Joerg Roedel <joro@8bytes.org>, Ingo Molnar <mingo@redhat.com>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        Sean Christopherson <seanjc@google.com>,
        Cathy Avery <cavery@redhat.com>,
        Maxim Levitsky <mlevitsk@redhat.com>
Subject: [PATCH 1/5] KVM: nSVM: fix a typo in svm_leave_nested
Date:   Mon,  3 May 2021 15:54:42 +0300
Message-Id: <20210503125446.1353307-2-mlevitsk@redhat.com>
In-Reply-To: <20210503125446.1353307-1-mlevitsk@redhat.com>
References: <20210503125446.1353307-1-mlevitsk@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When forcibly leaving the nested mode, we should switch to vmcb01

Fixes: 4995a3685f1b ("KVM: SVM: Use a separate vmcb for the nested L2 guest")

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 arch/x86/kvm/svm/nested.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 540d43ba2cf4..3321220f3deb 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -886,7 +886,7 @@ void svm_leave_nested(struct vcpu_svm *svm)
 		svm->nested.nested_run_pending = 0;
 		leave_guest_mode(vcpu);
 
-		svm_switch_vmcb(svm, &svm->nested.vmcb02);
+		svm_switch_vmcb(svm, &svm->vmcb01);
 
 		nested_svm_uninit_mmu_context(vcpu);
 		vmcb_mark_all_dirty(svm->vmcb);
-- 
2.26.2

