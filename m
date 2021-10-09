Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E562342765B
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Oct 2021 04:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244512AbhJICSc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 22:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244651AbhJICSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 22:18:02 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FD97C061347
        for <linux-kernel@vger.kernel.org>; Fri,  8 Oct 2021 19:14:11 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id i21-20020a253b15000000b005b9c0fbba45so15083745yba.20
        for <linux-kernel@vger.kernel.org>; Fri, 08 Oct 2021 19:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=6xwGp+yCPRNZeLMFXXBjBMcyDDhJc3kOdh7+GdwoBtU=;
        b=O3uyycCB0m4rETPo/2EXg7KzDS0Kxxd5QSMOgN5++pIlRXIKx8d0yrsAd7IRsknDXU
         jfPpfSaBpR+vzVZLfe2k/aYazJeb1V2OYVJeM9zHGQGZhxYlUVKxD+cBCI62fGJRZVEl
         yp3sVQ08Q330CkbJTchqmDuBifPyeL6Ww3QjU3eQOha0KDm0IBJuDzOMnyesSyo+q+I/
         lJ8xG8ZB8d3AYNpLPtB4eWA/pyqYaGmh5tBZ/8rId9AshkSUfwuM0AAs41HY+kSD+IsV
         W4/ngk/MxUvX4B342qXh08T69yL8VAymitYL9u6x/enfR2SkDRVs3Yd1g27SdUPXsZPn
         0GRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=6xwGp+yCPRNZeLMFXXBjBMcyDDhJc3kOdh7+GdwoBtU=;
        b=sjuSdAg+IPVE65Hs55osEri33iNjv1ir+QRcQC9Rs1yEp8026WpOyIhI33QUW/8v7S
         NU07Vyy8TmnJPF1mjKzrFiaLO6szPjdkQkX00GqQKhOsaPSzi/Q6x5kI10mJQeIJtdBO
         lp2zXNkqMSH7R7/ZWY8ZcYHpSxlKEEdolsRY3aBzRLNCrMGH3z5lDmzQ6MvjJwaYfWTw
         2auHaeo2r3tYHWXTmcV3pLYas3E15Jv6bHH1QVmLpGGcGi/HbAGtPqhIaMOuLK9/P00O
         nA2mnSCZYuQ6rDhzT+Oo8GwSDNTYqoBVkdpuJ/Zvngyjoeir4SxI5E+3jcP25kfF8lay
         /t/w==
X-Gm-Message-State: AOAM532cMR1qwt348iSK3UuZ0wZBY/BgWa6P3ikampe+OFY6jZc311X8
        dN9tQT3zOllNhiVl04Aml+rSofxkOcw=
X-Google-Smtp-Source: ABdhPJxGMQ2uf1Tp63zXiZ9a6+eAt9/mXxTl51gnqbi9PaWar+CNyJX66rPwqvsO9Gv4EvKTMkdMfFkjiGQ=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:90:200:e39b:6333:b001:cb])
 (user=seanjc job=sendgmr) by 2002:a05:6902:154f:: with SMTP id
 r15mr8259463ybu.379.1633745650411; Fri, 08 Oct 2021 19:14:10 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri,  8 Oct 2021 19:12:29 -0700
In-Reply-To: <20211009021236.4122790-1-seanjc@google.com>
Message-Id: <20211009021236.4122790-37-seanjc@google.com>
Mime-Version: 1.0
References: <20211009021236.4122790-1-seanjc@google.com>
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
Subject: [PATCH v2 36/43] KVM: SVM: Don't bother checking for "running" AVIC
 when kicking for IPIs
From:   Sean Christopherson <seanjc@google.com>
To:     Marc Zyngier <maz@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
        Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Anup Patel <anup.patel@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Atish Patra <atish.patra@wdc.com>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-mips@vger.kernel.org, kvm@vger.kernel.org,
        kvm-ppc@vger.kernel.org, kvm-riscv@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        David Matlack <dmatlack@google.com>,
        Oliver Upton <oupton@google.com>,
        Jing Zhang <jingzhangos@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the avic_vcpu_is_running() check when waking vCPUs in response to a
VM-Exit due to incomplete IPI delivery.  The check isn't wrong per se, but
it's not 100% accurate in the sense that it doesn't guarantee that the vCPU
was one of the vCPUs that didn't receive the IPI.

The check isn't required for correctness as blocking == !running in this
context.

From a performance perspective, waking a live task is not expensive as the
only moderately costly operation is a locked operation to temporarily
disable preemption.  And if that is indeed a performance issue,
kvm_vcpu_is_blocking() would be a better check than poking into the AVIC.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/avic.c | 15 +++++++++------
 arch/x86/kvm/svm/svm.h  | 11 -----------
 2 files changed, 9 insertions(+), 17 deletions(-)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index cbf02e7e20d0..b43b05610ade 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -295,13 +295,16 @@ static void avic_kick_target_vcpus(struct kvm *kvm, struct kvm_lapic *source,
 	struct kvm_vcpu *vcpu;
 	int i;
 
+	/*
+	 * Wake any target vCPUs that are blocking, i.e. waiting for a wake
+	 * event.  There's no need to signal doorbells, as hardware has handled
+	 * vCPUs that were in guest at the time of the IPI, and vCPUs that have
+	 * since entered the guest will have processed pending IRQs at VMRUN.
+	 */
 	kvm_for_each_vcpu(i, vcpu, kvm) {
-		bool m = kvm_apic_match_dest(vcpu, source,
-					     icrl & APIC_SHORT_MASK,
-					     GET_APIC_DEST_FIELD(icrh),
-					     icrl & APIC_DEST_MASK);
-
-		if (m && !avic_vcpu_is_running(vcpu))
+		if (kvm_apic_match_dest(vcpu, source, icrl & APIC_SHORT_MASK,
+					GET_APIC_DEST_FIELD(icrh),
+					icrl & APIC_DEST_MASK))
 			kvm_vcpu_wake_up(vcpu);
 	}
 }
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 0d7bbe548ac3..7f5b01bbee29 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -509,17 +509,6 @@ extern struct kvm_x86_nested_ops svm_nested_ops;
 
 #define VMCB_AVIC_APIC_BAR_MASK		0xFFFFFFFFFF000ULL
 
-static inline bool avic_vcpu_is_running(struct kvm_vcpu *vcpu)
-{
-	struct vcpu_svm *svm = to_svm(vcpu);
-	u64 *entry = svm->avic_physical_id_cache;
-
-	if (!entry)
-		return false;
-
-	return (READ_ONCE(*entry) & AVIC_PHYSICAL_ID_ENTRY_IS_RUNNING_MASK);
-}
-
 int avic_ga_log_notifier(u32 ga_tag);
 void avic_vm_destroy(struct kvm *kvm);
 int avic_vm_init(struct kvm *kvm);
-- 
2.33.0.882.g93a45727a2-goog

