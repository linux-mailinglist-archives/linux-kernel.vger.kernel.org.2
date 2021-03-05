Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8BC732DF90
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 03:18:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbhCECSR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 21:18:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbhCECSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 21:18:16 -0500
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3336DC061756
        for <linux-kernel@vger.kernel.org>; Thu,  4 Mar 2021 18:18:15 -0800 (PST)
Received: by mail-qk1-x749.google.com with SMTP id i69so473609qke.19
        for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021 18:18:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:reply-to:date:message-id:mime-version:subject:from:to:cc;
        bh=iFsu/EdgzPCi1WqYdYUBcFgRLZpgieXshXK9nnq/e2Q=;
        b=Dm7EqRrQGHwk4GNJMLxWsQTTtpmjMKr5XzzRltH4yF4XLUzdFFiyvsjnp1NTrFqAWD
         CjfRG3hCuW1YFGc6A9Y05LccX7aY94QO+wvrTna8ER7QCPvAqc9cTr+SDbDE7Ldpjw3t
         rgtktSM2aFRd0K33Dqco70ItekgC6OfWuwo0KQ+vkE9LIdkGuecrItyAYNY5IrqvtPnf
         IM5vybBlZZIJb6OQHKcf0RcSJiUJryCWGAhm5Qi0FNJWVncKswsoai/pll1Euh2JIGiA
         gbO6fIcNJdAVjAQtSPfOZWTgAaL5JAINvcWY30PuSr1We+YkowOrraGVXDfiXT9XhhEG
         nq9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:reply-to:date:message-id:mime-version
         :subject:from:to:cc;
        bh=iFsu/EdgzPCi1WqYdYUBcFgRLZpgieXshXK9nnq/e2Q=;
        b=kiy3Aq7bWCO6vINsJjznvw6FB2FB5IUbVmfSzHbQGtp20AwULJeHqP/0AheBbCMz1i
         GlHo0FHaHdB4yMYZUdciaSa53SOAMlN01kYKH5N4CDdwa950z9DtwyMAq1qvxwt8c3N3
         +zGgARnhjTwVZsa8KGO/Z5umBcRj+NQ7vb6uY9VdEHuIGGpRD7u5aSDHmk0PJxDsCGCz
         WkXZfYKbcidzj/6drPJZAysrr3M0GT1RA42ct/xF3HAnKUbjDNXNjXY4xt493H+Ou32t
         sOFyofifILzcmyTtvVfjdK68omFEj9QNtUKNo4vCX/ZSfL7GumtfuzCNfh6Q2I8YTJRg
         jrpg==
X-Gm-Message-State: AOAM532ZS+XLl2LCozcsG3qlbKwMs/nZJDPrks7EjJgbtaL+SlC44Vry
        rgHekTvtF8TyXZg+4MrM/bbOYE7Lvrw=
X-Google-Smtp-Source: ABdhPJyfHd60C/yt6/C0Ijkwk9RyVf8bjnYna4ppLSBzVsVQ7VGppNses7R6R1uiC2x3LrH3g3AER8JsCOo=
Sender: "seanjc via sendgmr" <seanjc@seanjc798194.pdx.corp.google.com>
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:9857:be95:97a2:e91c])
 (user=seanjc job=sendgmr) by 2002:a0c:fec8:: with SMTP id z8mr7027044qvs.59.1614910691867;
 Thu, 04 Mar 2021 18:18:11 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu,  4 Mar 2021 18:18:08 -0800
Message-Id: <20210305021808.3769732-1-seanjc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [PATCH] KVM: x86: Ensure deadline timer has truly expired before
 posting its IRQ
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When posting a deadline timer interrupt, open code the checks guarding
__kvm_wait_lapic_expire() in order to skip the lapic_timer_int_injected()
check in kvm_wait_lapic_expire().  The injection check will always fail
since the interrupt has not yet be injected.  Moving the call after
injection would also be wrong as that wouldn't actually delay delivery
of the IRQ if it is indeed sent via posted interrupt.

Fixes: 010fd37fddf6 ("KVM: LAPIC: Reduce world switch latency caused by timer_advance_ns")
Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/lapic.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 45d40bfacb7c..cb8ebfaccfb6 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -1642,7 +1642,16 @@ static void apic_timer_expired(struct kvm_lapic *apic, bool from_timer_fn)
 	}
 
 	if (kvm_use_posted_timer_interrupt(apic->vcpu)) {
-		kvm_wait_lapic_expire(vcpu);
+		/*
+		 * Ensure the guest's timer has truly expired before posting an
+		 * interrupt.  Open code the relevant checks to avoid querying
+		 * lapic_timer_int_injected(), which will be false since the
+		 * interrupt isn't yet injected.  Waiting until after injecting
+		 * is not an option since that won't help a posted interrupt.
+		 */
+		if (vcpu->arch.apic->lapic_timer.expired_tscdeadline &&
+		    vcpu->arch.apic->lapic_timer.timer_advance_ns)
+			__kvm_wait_lapic_expire(vcpu);
 		kvm_apic_inject_pending_timer_irqs(apic);
 		return;
 	}
-- 
2.30.1.766.gb4fecdf3b7-goog

