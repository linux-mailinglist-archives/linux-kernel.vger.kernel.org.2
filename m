Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F0773B3AB8
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 04:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233087AbhFYCGa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 22:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233054AbhFYCGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 22:06:24 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55265C061574
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 19:04:03 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id q20-20020a0cf5d40000b029027498137223so8730542qvm.15
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 19:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=t8s+pvbQrz2/tW+ZtZ3QelMWNeVBiBz16haIl2b1ZgQ=;
        b=XNmWmkIwJcknizUuHkmw1N7P5TY3heXjyvMuLh8IlO58WeWbDr1u8xezH8S6bwsMwt
         OzN5dIDEiLml4byCrkkHhtwC1c3bVYevVxALruzXL6faQa9m1JKEzM0U13d1AWOAyoba
         s5wLOkhBXqUGWB4o+4JbnqdePfU6GLaioszQ3l/gGFlE6Ga4s3l9nBoY0kpTFQP3xEL/
         XZaxSmTYBmD2+n+UELtZT6MIBEPMZoWNxYFpXZAO7cf6cyBiSPrbRDXRBccJV/wQV7bW
         Jz5U1/nVHpbCjEB8Ld/VBN4SdnToAQVlhWR93gtOBNMTXY0kGUDzRr9aZlWqNb4HVWvd
         VK6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=t8s+pvbQrz2/tW+ZtZ3QelMWNeVBiBz16haIl2b1ZgQ=;
        b=unwPKP1UkKdVeJL2Ej+JjVIcrUlFzzS7RSkbEkw2vz7e70GmI6zb+QmMsgqv/xvc3M
         /l+m5xLyI/EL0msfdPf+3l++xsDIntWnMmRFRtuaNap/3W85wqohRUCCzJH/BYaJOAd4
         KfOokOsLFH525tUVgx+iw5pvHHhkt7qksL4yXjg1zZuxVkS/I0H4szRKDuDM8pf/8NEe
         M5ORPoygDagt6qnlDOVxnz04a67luChwiNSA6ivZDe+L+q32Jpuc8uwnGuJPMi4jTMZE
         C1viQ36mmWN4XdI69BBDibeBeQN2QhoBsta8gEYHiTtivyUEc6p0VRMGhIDWJAua3APf
         DgpQ==
X-Gm-Message-State: AOAM532iZtngj3H3YWEmuVa56of4VRYWzmpi1YKH+32nJOaRzc0XuZJ+
        lU8NZPfZ/EMMVcEyNHo+nOFDAJP41tc=
X-Google-Smtp-Source: ABdhPJzeVRHboZb5US4kKmefBAR/OKLFvqKUwvXLHO58v6La8hPwvJJnRDcKi5tqwbkHYjYcZLHfXLWJVUc=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:7c83:7704:b3b6:754c])
 (user=seanjc job=sendgmr) by 2002:a05:6214:966:: with SMTP id
 do6mr8576844qvb.57.1624586642404; Thu, 24 Jun 2021 19:04:02 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu, 24 Jun 2021 19:03:54 -0700
In-Reply-To: <20210625020354.431829-1-seanjc@google.com>
Message-Id: <20210625020354.431829-3-seanjc@google.com>
Mime-Version: 1.0
References: <20210625020354.431829-1-seanjc@google.com>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
Subject: [PATCH 2/2] KVM: SVM: Revert clearing of C-bit on GPA in #NPF handler
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Peter Gonda <pgonda@google.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't clear the C-bit in the #NPF handler, as it is a legal GPA bit for
non-SEV guests, and for SEV guests the C-bit is dropped before the GPA
hits the NPT in hardware.  Clearing the bit for non-SEV guests causes KVM
to mishandle #NPFs with that collide with the host's C-bit.

Although the APM doesn't explicitly state that the C-bit is not reserved
for non-SEV, Tom Lendacky confirmed that the following snippet about the
effective reduction due to the C-bit does indeed apply only to SEV guests.

  Note that because guest physical addresses are always translated
  through the nested page tables, the size of the guest physical address
  space is not impacted by any physical address space reduction indicated
  in CPUID 8000_001F[EBX]. If the C-bit is a physical address bit however,
  the guest physical address space is effectively reduced by 1 bit.

And for SEV guests, the APM clearly states that the bit is dropped before
walking the nested page tables.

  If the C-bit is an address bit, this bit is masked from the guest
  physical address when it is translated through the nested page tables.
  Consequently, the hypervisor does not need to be aware of which pages
  the guest has chosen to mark private.

Note, the bogus C-bit clearing was removed from legacy #PF handler in
commit 6d1b867d0456 ("KVM: SVM: Don't strip the C-bit from CR2 on #PF
interception").

Fixes: 0ede79e13224 ("KVM: SVM: Clear C-bit from the page fault address")
Cc: Peter Gonda <pgonda@google.com>
Cc: Brijesh Singh <brijesh.singh@amd.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/svm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 8834822c00cd..ca5614a48b21 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -1923,7 +1923,7 @@ static int npf_interception(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 
-	u64 fault_address = __sme_clr(svm->vmcb->control.exit_info_2);
+	u64 fault_address = svm->vmcb->control.exit_info_2;
 	u64 error_code = svm->vmcb->control.exit_info_1;
 
 	trace_kvm_page_fault(fault_address, error_code);
-- 
2.32.0.93.g670b81a890-goog

