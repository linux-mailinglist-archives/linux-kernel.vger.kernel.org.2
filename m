Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD77427678
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Oct 2021 04:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244157AbhJICTp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 22:19:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244561AbhJICTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 22:19:08 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31CF1C061776
        for <linux-kernel@vger.kernel.org>; Fri,  8 Oct 2021 19:14:28 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id b9-20020a5b07890000b0290558245b7eabso15006071ybq.10
        for <linux-kernel@vger.kernel.org>; Fri, 08 Oct 2021 19:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=DNh7SHjv27CkTpVQ6UDQfpazfFfU/7m49a7OyCmxJ04=;
        b=OmBEyvgBxrWmm+DnEXtUY5SGJEDJ8rfSRexcZ/sLohcuuuU8wRBxtkVvWgAcEXTtDu
         CSHWkz3NrHAP8CQWDZPjwrNyXQv8t3ZVqtgnkJTeroV4I4ofTpUhF08tAgeFlhHpdjz5
         DSzs4995JQ4bvC8+hT2zhEZx03XMTSTWwaAlUhES+GMR0I/ltEGK03OtIT6xjHVnTBjL
         MK1iAMhumx1HDCHEN7Q0/UoppdBB6U1GwAdJ4EO2l1vq2DEjW94MHM8qR3/RmALo617b
         gz6KYIdYwOM9rgqP7AeVSQ/Il0lIODnMHAbfZnMNEpK7JCaMpNzkLfJZPqdAxx+LfqzC
         +uFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=DNh7SHjv27CkTpVQ6UDQfpazfFfU/7m49a7OyCmxJ04=;
        b=C3/NAAtY7yegU6DKUTahBZJOQim9pD1t3gvu4k1yKUTsmieJ3npj96EjVXZdfS9F0O
         pJc2624t+beqPKf+WOzrdVVrtNZMHPOY5Cq5e2dH22qaiSc/bwnzbb3NU6ffmOS7frbr
         7GX40F/kWScw2GqyFdZp2C0GxCR9x1MbPfGrnx2DJM9Frglp+LC3Am3fMFUHJhtARbEl
         Q9O05t3vhuoNsbPuOqkezRne54aYO4zLWh+U2tlSc1/3J4yY5de4oaO+3gcboxZ5sTN4
         SyvL46FJ2a9QI28d1RUuzxlpunlC0b3b9PfWvCN0DklGljz5mJog8rG40felwDyjCn9F
         7eLQ==
X-Gm-Message-State: AOAM531ySlc59Og8L4cwQ1nSPVSy5c6ftc4QSY12brq1Eg/glDPs1RtT
        hB+WC8bB3231yCS5M2hmuRSO8SfE4/w=
X-Google-Smtp-Source: ABdhPJwFBTWTsWfiioDi0mhoc4HC7I+aMeFu459xFpIEzn2YdCstAMDsfKMjJFSfY3skCf0Gp9GZ4fuQR4M=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:90:200:e39b:6333:b001:cb])
 (user=seanjc job=sendgmr) by 2002:a25:77d6:: with SMTP id s205mr6993283ybc.529.1633745667357;
 Fri, 08 Oct 2021 19:14:27 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri,  8 Oct 2021 19:12:36 -0700
In-Reply-To: <20211009021236.4122790-1-seanjc@google.com>
Message-Id: <20211009021236.4122790-44-seanjc@google.com>
Mime-Version: 1.0
References: <20211009021236.4122790-1-seanjc@google.com>
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
Subject: [PATCH v2 43/43] KVM: VMX: Don't do full kick when handling posted
 interrupt wakeup
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

When waking vCPUs in the posted interrupt wakeup handling, do exactly
that and no more.  There is no need to kick the vCPU as the wakeup
handler just need to get the vCPU task running, and if it's in the guest
then it's definitely running.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/posted_intr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx/posted_intr.c b/arch/x86/kvm/vmx/posted_intr.c
index f1bcf8c32b6d..06eb9c950760 100644
--- a/arch/x86/kvm/vmx/posted_intr.c
+++ b/arch/x86/kvm/vmx/posted_intr.c
@@ -192,7 +192,7 @@ void pi_wakeup_handler(void)
 			    pi_wakeup_list) {
 
 		if (pi_test_on(&vmx->pi_desc))
-			kvm_vcpu_kick(&vmx->vcpu);
+			kvm_vcpu_wake_up(&vmx->vcpu);
 	}
 	spin_unlock(&per_cpu(wakeup_vcpus_on_cpu_lock, cpu));
 }
-- 
2.33.0.882.g93a45727a2-goog

