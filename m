Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D478427651
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Oct 2021 04:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244704AbhJICSI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 22:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244402AbhJICRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 22:17:41 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3DE3C061766
        for <linux-kernel@vger.kernel.org>; Fri,  8 Oct 2021 19:14:03 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id i21-20020a253b15000000b005b9c0fbba45so15083425yba.20
        for <linux-kernel@vger.kernel.org>; Fri, 08 Oct 2021 19:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=C2PBzYfpswTkvsOYeskWQEML51RRougebHfj0Alyx5A=;
        b=WYMPTsMzDt+AsjiCyZJ1B4+ZpYxh2OtDt82Ju6kAg5cXo6tqXm1ZgRYGEPixBeGSUX
         csu0nnUcxqKDiQ1eAmAeGes+LUQg2mXWzAyCEZN0ncq8JRJRFlJFF87rnbemqyBf6tBd
         V9ViKRAH1hB1quUnaDowk1/9kTi2JyNnkHWTKfzzmhY7AxslA7BLbxo1ZA8eLcYWLnjz
         YbQ0w447PhslHJ3ZxBNJRnTcGLYtNfmZQAOeWXXJuualGN4NlLQe9GK7rEtrWgH0mtsp
         VqsmagApekmgICqy79O2umIOGpnKlEqjA71PkSs0Bk91M4cBLEAn1bGCQe9gx+1d5Zvx
         1xGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=C2PBzYfpswTkvsOYeskWQEML51RRougebHfj0Alyx5A=;
        b=PGpOxYOonOt++hV4FcDChIqnhy6YQWQXuzfEp2Dyhx6HPOUpz7gNiqaSWmv0apoYY9
         GYQR112a5UlHYdKoB7LiOpJDUYgYB/ymR+DqbkydwEEuDfnVsvVk7zCebeyAevAAHMEx
         /GlhUPFJbOLZGpEOr/afuYYVTjwNtOfEYWgYYKgrx+xEpQX36p1iTXqQ/cDjGqH2EEuS
         GFM0ul/cDDoWKEu7i21EPrvu7NelO0C6XKVm5YjQEHPBO/UcejaKIx+KvzBTJx/llE6g
         aHp1qKw69IQKrCqx0Vj67yye8U0af8eUtsVqkmlBkqp2nG16uaO+V0DSE3U/CQ7DzhDI
         Lwhw==
X-Gm-Message-State: AOAM530Ws/B5IP4Bym7zA9rN8uJmd5JdWYMZRodQ7BoyiBZ/rQExuXZe
        BFaBU3vlPZq+j33INH7YQPq8OTlQc0E=
X-Google-Smtp-Source: ABdhPJzcpn5DTPQuPSfZUPDLuPAfkBrPTcc8cEPmAKwjDwkk0IcaBIdBFMmznx5JjVGnWgQQ1Ay+qs9Sp8s=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:90:200:e39b:6333:b001:cb])
 (user=seanjc job=sendgmr) by 2002:a25:5954:: with SMTP id n81mr7136674ybb.435.1633745643213;
 Fri, 08 Oct 2021 19:14:03 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri,  8 Oct 2021 19:12:26 -0700
In-Reply-To: <20211009021236.4122790-1-seanjc@google.com>
Message-Id: <20211009021236.4122790-34-seanjc@google.com>
Mime-Version: 1.0
References: <20211009021236.4122790-1-seanjc@google.com>
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
Subject: [PATCH v2 33/43] KVM: x86: Unexport LAPIC's switch_to_{hv,sw}_timer() helpers
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

Unexport switch_to_{hv,sw}_timer() now that common x86 handles the
transitions.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/lapic.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 0cd7ed21b205..cfb64bd4a1c1 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -1948,7 +1948,6 @@ void kvm_lapic_switch_to_hv_timer(struct kvm_vcpu *vcpu)
 {
 	restart_apic_timer(vcpu->arch.apic);
 }
-EXPORT_SYMBOL_GPL(kvm_lapic_switch_to_hv_timer);
 
 void kvm_lapic_switch_to_sw_timer(struct kvm_vcpu *vcpu)
 {
@@ -1960,7 +1959,6 @@ void kvm_lapic_switch_to_sw_timer(struct kvm_vcpu *vcpu)
 		start_sw_timer(apic);
 	preempt_enable();
 }
-EXPORT_SYMBOL_GPL(kvm_lapic_switch_to_sw_timer);
 
 void kvm_lapic_restart_hv_timer(struct kvm_vcpu *vcpu)
 {
-- 
2.33.0.882.g93a45727a2-goog

