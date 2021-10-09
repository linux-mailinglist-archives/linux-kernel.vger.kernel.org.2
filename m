Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0D6A427667
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Oct 2021 04:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244755AbhJICTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 22:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244823AbhJICSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 22:18:31 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BB13C06176F
        for <linux-kernel@vger.kernel.org>; Fri,  8 Oct 2021 19:14:18 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id 100-20020aed30ed000000b002a6b3dc6465so8821998qtf.13
        for <linux-kernel@vger.kernel.org>; Fri, 08 Oct 2021 19:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=60FaGe3jHfzi2vANN4FyfF/i5oEKd4JaFx8/SVEFBNk=;
        b=Z1P8991nqO/keHHcPNDLRVMsJotsLW7zCMS8prAeIixKQ9mUd7DFllwUbuaHgVSrWZ
         FkvVrJgBJx0hc4CnzRBKZSR1hitB3Pk7jqHRDt0WmtqyCKKVVvm7gD0Q9FoIUaVCRIyp
         YiCXIJxWnPrhfp4kvu9z8/hF1gQOGdE7O7cz6QeTcYuVmieoH7ELJCd7UMv/HDJr1lHI
         JdSdjZZTm0cDCLqT8cUYvWrMLcAK8JU652nI2ulS+DYSnd22rQAqVDPjiZw3qVcCjDi0
         GqTi9TAncXe+Iuc9CVjDDeSGYGD369tFbR8wEt1kGo66QnpkLVtv3NIEb5UQVw6604Ie
         3W8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=60FaGe3jHfzi2vANN4FyfF/i5oEKd4JaFx8/SVEFBNk=;
        b=Od6nfXPGFd/LqGtWL2QjcTUPaHEMSUdr/ET9EHgKkLiMOJ03eTDkTzqDNxb/Z4hYed
         BqCe5w4nZi1VWEH9S9VUBIrmSOQF5KFIjdnrWlqtcpLlgsNNylqQpl4GMPV2JPuYTLkf
         DpAtNKcTx+LHFKsqY9x9wofqtTEoCbu1Woy5lIQe+f3DoT5SL2qM+FghQVagsBOOcv2b
         pfpGkkBzjdzZVMNBiDH8fkYP7bMBXC1wbj9jWUOpRha0voh2lhtsHViLvcsZQpautxVb
         rTvSLDT8gcg9x+ZpJcqObwhzl1QOVqkegNAAnrRvh/r4licgdetvSLRqbxLv1Le3xuKI
         0pIg==
X-Gm-Message-State: AOAM5306DGM7xI3U4pEhIUH4FFwlECvwLoy4WoS1GnFCsqbr8Xpyvt11
        BQhS6aKy/yFswa4vv+rCKlu1LWFd1ZU=
X-Google-Smtp-Source: ABdhPJzz4hkmJ133tsw9efdKVMZh6wi7X37BBmBb9YEFsyE1x8BdZiU7lUBQl0qiUIYV4wWlbCGAte9NXc4=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:90:200:e39b:6333:b001:cb])
 (user=seanjc job=sendgmr) by 2002:ac8:42da:: with SMTP id g26mr1839130qtm.368.1633745657436;
 Fri, 08 Oct 2021 19:14:17 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri,  8 Oct 2021 19:12:32 -0700
In-Reply-To: <20211009021236.4122790-1-seanjc@google.com>
Message-Id: <20211009021236.4122790-40-seanjc@google.com>
Mime-Version: 1.0
References: <20211009021236.4122790-1-seanjc@google.com>
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
Subject: [PATCH v2 39/43] KVM: VMX: Don't do full kick when triggering posted
 interrupt "fails"
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

Replace the full "kick" with just the "wake" in the fallback path when
triggering a virtual interrupt via a posted interrupt fails because the
guest is not IN_GUEST_MODE.  If the guest transitions into guest mode
between the check and the kick, then it's guaranteed to see the pending
interrupt as KVM syncs the PIR to IRR (and onto GUEST_RVI) after setting
IN_GUEST_MODE.  Kicking the guest in this case is nothing more than an
unnecessary VM-Exit (and host IRQ).

Opportunistically update comments to explain the various ordering rules
and barriers at play.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/vmx.c | 16 ++++++++++++++--
 arch/x86/kvm/x86.c     |  5 +++--
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 13e732a818f3..44d760dde0f9 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -3978,10 +3978,16 @@ static int vmx_deliver_nested_posted_interrupt(struct kvm_vcpu *vcpu,
 		 * we will accomplish it in the next vmentry.
 		 */
 		vmx->nested.pi_pending = true;
+		/*
+		 * The smp_wmb() in kvm_make_request() pairs with the smp_mb_*()
+		 * after setting vcpu->mode in vcpu_enter_guest(), thus the vCPU
+		 * is guaranteed to see the event request if triggering a posted
+		 * interrupt "fails" because vcpu->mode != IN_GUEST_MODE.
+		 */
 		kvm_make_request(KVM_REQ_EVENT, vcpu);
 		/* the PIR and ON have been set by L1. */
 		if (!kvm_vcpu_trigger_posted_interrupt(vcpu, true))
-			kvm_vcpu_kick(vcpu);
+			kvm_vcpu_wake_up(vcpu);
 		return 0;
 	}
 	return -1;
@@ -4012,9 +4018,15 @@ static int vmx_deliver_posted_interrupt(struct kvm_vcpu *vcpu, int vector)
 	if (pi_test_and_set_on(&vmx->pi_desc))
 		return 0;
 
+	/*
+	 * The implied barrier in pi_test_and_set_on() pairs with the smp_mb_*()
+	 * after setting vcpu->mode in vcpu_enter_guest(), thus the vCPU is
+	 * guaranteed to see PID.ON=1 and sync the PIR to IRR if triggering a
+	 * posted interrupt "fails" because vcpu->mode != IN_GUEST_MODE.
+	 */
 	if (vcpu != kvm_get_running_vcpu() &&
 	    !kvm_vcpu_trigger_posted_interrupt(vcpu, false))
-		kvm_vcpu_kick(vcpu);
+		kvm_vcpu_wake_up(vcpu);
 
 	return 0;
 }
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 9643f23c28c7..274d295cabfb 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -9752,8 +9752,9 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 	smp_mb__after_srcu_read_unlock();
 
 	/*
-	 * This handles the case where a posted interrupt was
-	 * notified with kvm_vcpu_kick.
+	 * Process pending posted interrupts to handle the case where the
+	 * notification IRQ arrived in the host, or was never sent (because the
+	 * target vCPU wasn't running).
 	 */
 	if (kvm_lapic_enabled(vcpu) && vcpu->arch.apicv_active)
 		static_call(kvm_x86_sync_pir_to_irr)(vcpu);
-- 
2.33.0.882.g93a45727a2-goog

