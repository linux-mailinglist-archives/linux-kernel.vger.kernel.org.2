Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82E6337692D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 18:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238475AbhEGRA5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 13:00:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238462AbhEGRAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 13:00:55 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1544C061761
        for <linux-kernel@vger.kernel.org>; Fri,  7 May 2021 09:59:55 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id b3-20020a05620a0cc3b02902e9d5ca06f2so6623216qkj.19
        for <linux-kernel@vger.kernel.org>; Fri, 07 May 2021 09:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=VEqazMRlmbfIIn+WG70+8s+sSnlsOL4Ks0sRraeMi3w=;
        b=KoPzAD/24Udvfs3SJG4WetUnaKKUe3D0ar4Ivq2GQhThmRCDu9l3O7QsQNtw++wfHh
         65iBehtJpcXdNz3xkh/Ix9UCiyymzFgug1Sg+w/mb0ROVv7JPh5UYcyQti4LU6jfe7g7
         dtGAhaS6Sdo4ly9Q4bDmaT2UK0xrMhaghZ4W6ykzK5nrIdB8+UzANZ9GUfXcQl648dw9
         R7NFiAxmDheyavR+Pr4wT+sSwHDWTZAaDA+96U7yikIbrtBk7mha0v3DzFR3CjcSm/rc
         tBSFA94qgJnk3ayhcLFDYQJaZf2MJOeEO8pVot6E2fQd8w99wXF/+Zkjmb3dhWAVuY+R
         exnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=VEqazMRlmbfIIn+WG70+8s+sSnlsOL4Ks0sRraeMi3w=;
        b=md7Jc1pHSU44E72SBwBFY5PX2Njw6LMbNU8q7R/wsmz4V/SQPBaDBlRPkiP+bbz7Ag
         VUoHFPoa3cMbAw+owJ/cN9yawtbqi1bEysu0MzRYWb/irwrK2ubtPD3RxAgysWB40QWT
         c8w1YgmoB0mT6olrWd2JkTERhvPSQVu/ThX+Nlzixaghhtv9+JNNIsIc6K/j1xtQbKAh
         xYzNOMggY96lqroaWR4/hV8yD8ysTX5wThFWV2aXk4RxVZmZAxZ+cmMnepbWyYaM5XEY
         3KadVSn3Ebqs+duR9EyhjB0ZlorW+zRkzpSNc8coMTF+U19dbuZu/Qv66mj9nvZslDym
         d4Iw==
X-Gm-Message-State: AOAM531J9L2iue+4XZrR1Y3E4qJ+I7EgNaajbyuWhhNmu2S7fTlkcrgf
        X2d+UuhCZZ06XWLG3AZW22jJxPHfOmQ=
X-Google-Smtp-Source: ABdhPJw6zN0EFivUJ5aFuE1VE0FDRIzkiTdsJFLSDUACFvRn3SazAnoaxoqkJWhO97XADtkBnhJNB/aZ9FA=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:7352:5279:7518:418f])
 (user=seanjc job=sendgmr) by 2002:ad4:4e44:: with SMTP id eb4mr10683142qvb.3.1620406794805;
 Fri, 07 May 2021 09:59:54 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri,  7 May 2021 09:59:46 -0700
In-Reply-To: <20210507165947.2502412-1-seanjc@google.com>
Message-Id: <20210507165947.2502412-2-seanjc@google.com>
Mime-Version: 1.0
References: <20210507165947.2502412-1-seanjc@google.com>
X-Mailer: git-send-email 2.31.1.607.g51e8a6a459-goog
Subject: [PATCH 1/2] KVM: SVM: Update EFER software model on CR0 trap for SEV-ES
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Peter Gonda <pgonda@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For protected guests, a.k.a. SEV-ES guests, update KVM's model of EFER
when processing the side effect of the CPU entering long mode when paging
is enabled.  The whole point of intercepting CR0/CR4/EFER is to keep
KVM's software model up-to-date.

Fixes: f1c6366e3043 ("KVM: SVM: Add required changes to support intercepts under SEV-ES")
Reported-by: Peter Gonda <pgonda@google.com>
Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/svm.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index a7271f31df47..d271fe8e58de 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -1696,15 +1696,17 @@ void svm_set_cr0(struct kvm_vcpu *vcpu, unsigned long cr0)
 	u64 hcr0 = cr0;
 
 #ifdef CONFIG_X86_64
-	if (vcpu->arch.efer & EFER_LME && !vcpu->arch.guest_state_protected) {
+	if (vcpu->arch.efer & EFER_LME) {
 		if (!is_paging(vcpu) && (cr0 & X86_CR0_PG)) {
 			vcpu->arch.efer |= EFER_LMA;
-			svm->vmcb->save.efer |= EFER_LMA | EFER_LME;
+			if (!vcpu->arch.guest_state_protected)
+				svm->vmcb->save.efer |= EFER_LMA | EFER_LME;
 		}
 
 		if (is_paging(vcpu) && !(cr0 & X86_CR0_PG)) {
 			vcpu->arch.efer &= ~EFER_LMA;
-			svm->vmcb->save.efer &= ~(EFER_LMA | EFER_LME);
+			if (!vcpu->arch.guest_state_protected)
+				svm->vmcb->save.efer &= ~(EFER_LMA | EFER_LME);
 		}
 	}
 #endif
-- 
2.31.1.607.g51e8a6a459-goog

