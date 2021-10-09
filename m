Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 401014275AA
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Oct 2021 04:13:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244156AbhJICOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 22:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244150AbhJICOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 22:14:41 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B090C061762
        for <linux-kernel@vger.kernel.org>; Fri,  8 Oct 2021 19:12:45 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id y16-20020a2586d0000000b005b752db8f97so14924104ybm.18
        for <linux-kernel@vger.kernel.org>; Fri, 08 Oct 2021 19:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=w4L6vXRJ0maktiMAI5s6nCFzv55tjBmh5H3fVwAOt14=;
        b=X+K/y94DG3/b1JwgUiidlr5JeHnupRLaoGF9napckdwupzcFgHo7UhOu+eaY5Q3yog
         XhI0zkKhF5wkPh8Ydk25q+Y6isKLBL2UTcjGlPF0l4wc+szJzZ+JS+y62GUkYFglqcAv
         QEhhm2InfBVgcKeILtjC+nb523rb7ir7sFxAzKbiDvXJe9slv28lGTNA/1i2qVg+2ZxD
         lcB1g1dodHVQwinZspEr86T0h4e/T83A8dtpOzreXMAVzScFVYs7UuuVHgCR8Jaa9rV6
         4SJDFMRK9BqcmV318zbEUoQPsVks4CsIxNiDejukWU0lQBj8XUkGo/6kRljZYzrdrmiZ
         JZig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=w4L6vXRJ0maktiMAI5s6nCFzv55tjBmh5H3fVwAOt14=;
        b=fcXVtcK3znGPaFn3XvBVXib6ckUiUAhBB4Wt0kdTBmKxZy5xAetYXYolx/JSe7cLee
         2IN1Sjrr35lA3bzgLg9LIqNM+JtasjF3sk4lcno1iL/AW4KJLYgkHp7VnbZCZoRlWHOp
         uUU6rob11p4uHLvCcsBlTfiGn34GmXkiGjl54YqsmosDnh5O+2fbSS0zkbG2izK7b92p
         dUounJHvIMyuCzWPskzgILuKUI3SgJosEfJK/CweV6PVhe/mbGh7mUSmwr3PIOIXTcZW
         jmqcXAvZRuJtrS1Qvs7UxkZaU5/Euy3g9hCLjIlJkeMXBpIMjmq2D8qSEULmpiwvqWlC
         Nwog==
X-Gm-Message-State: AOAM533u9t6IWOVN0OM46fYBbfXypBvD32QvWGZKT+gghe6zS3WVTBK+
        SBKCtyyXswzwo72CP1cRDZ9ESXDBV64=
X-Google-Smtp-Source: ABdhPJy3Pz92yv6yudb/1AOSel+YnYYgSBx0ow80ujr4yl8gW3uR4aG1EcxnBZn7LAuMkH73lWi945jfNwQ=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:90:200:e39b:6333:b001:cb])
 (user=seanjc job=sendgmr) by 2002:a25:5ed6:: with SMTP id s205mr7850217ybb.31.1633745564156;
 Fri, 08 Oct 2021 19:12:44 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri,  8 Oct 2021 19:11:54 -0700
In-Reply-To: <20211009021236.4122790-1-seanjc@google.com>
Message-Id: <20211009021236.4122790-2-seanjc@google.com>
Mime-Version: 1.0
References: <20211009021236.4122790-1-seanjc@google.com>
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
Subject: [PATCH v2 01/43] KVM: VMX: Don't unblock vCPU w/ Posted IRQ if IRQs
 are disabled in guest
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

Don't configure the wakeup handler when a vCPU is blocking with IRQs
disabled, in which case any IRQ, posted or otherwise, should not be
recognized and thus should not wake the vCPU.

Fixes: bf9f6ac8d749 ("KVM: Update Posted-Interrupts Descriptor when vCPU is blocked")
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/posted_intr.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/vmx/posted_intr.c b/arch/x86/kvm/vmx/posted_intr.c
index 5f81ef092bd4..3263056784f5 100644
--- a/arch/x86/kvm/vmx/posted_intr.c
+++ b/arch/x86/kvm/vmx/posted_intr.c
@@ -142,8 +142,9 @@ int pi_pre_block(struct kvm_vcpu *vcpu)
 	struct pi_desc *pi_desc = vcpu_to_pi_desc(vcpu);
 
 	if (!kvm_arch_has_assigned_device(vcpu->kvm) ||
-		!irq_remapping_cap(IRQ_POSTING_CAP)  ||
-		!kvm_vcpu_apicv_active(vcpu))
+	    !irq_remapping_cap(IRQ_POSTING_CAP) ||
+	    !kvm_vcpu_apicv_active(vcpu) ||
+	    vmx_interrupt_blocked(vcpu))
 		return 0;
 
 	WARN_ON(irqs_disabled());
-- 
2.33.0.882.g93a45727a2-goog

