Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05E8B369E00
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Apr 2021 02:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244494AbhDXAtv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 20:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244209AbhDXAs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 20:48:27 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76E43C06134B
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 17:47:27 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id b20-20020a0cf0540000b02901a471b6ccbaso15004855qvl.22
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 17:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=nJ0Vx6GbmijZ7PDR3hwIYLOvt4K+KdVv1iVkzVPrEHQ=;
        b=CHIwF6Upat5nEcmPw+p2goGG9yaxiZOo90wW5j+8Ba6nIAr/qCVhZjxVzBatY501fR
         eV5lT1JFrSyfjrhrfANk8BrRdSZ7U6BmPXGHRFpY2dF/AmqrRf+73RYscgZ5s2Hb2Ev0
         y3hm3xcNsxFKAHYTkjDIceYwbdND7SkIwvU4s+RsLvNxG7NzeoYNc6KyMnObn96yaKPW
         +6pBQA7hpeshb4tY5GN+CgmVw6UUni99Ou+1XR6kYBsGrjEA1x0EWTi48+Z+fd37bA6+
         Xi9pdfp9oVXpyc1g0PUqzF7plNbRkQ7AoRRWB0Pxj59OvWTEabRdBw4AyHl/Mi76w56y
         l3hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=nJ0Vx6GbmijZ7PDR3hwIYLOvt4K+KdVv1iVkzVPrEHQ=;
        b=EUEwS+NgWsjlPwdgafEdg/2yMNDGiYnylmmrfVAitsyFOUv06ux7VAIHVt1W6OAAM6
         jJvxzT3FCEC5xFFENUL5b8SS56dZdcnYE8sLSe6LcDrWh6Ya8E9DMswIgGb7K7986+1e
         hpwRI8zwoEZlxJE01c8GEzC/CkdxWPSU90QpLsGdTuFeW4MEbOGEzb2ACgluPNeqPI7v
         WQcHpyzuYqfdF4xi33Ln1m3H0yESXg0k6NsaGwm471+wXJkfbJUeXomRa9xzkU7BG68i
         0Pi5JpBH7uGfSEIxXqKHoUwUkIGIB+neney6l9tG0kteYFbX8cWqYDlh1wj8MI3juvkR
         1hEg==
X-Gm-Message-State: AOAM530MLuLjLDpDrqmumpu14ggGj/1I5FM1Uop6NNrc04kHm2f01PPd
        0IA49vm1TpMrFWLBN1gsbMDt3BzD8uE=
X-Google-Smtp-Source: ABdhPJzE1UuuDxgXT49WcOpqRxfDihcDQIPaRpjw5EuExsxUh27ZmE1uejEh1Sue2I20i856RBEu6FSYlJU=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:ad52:3246:e190:f070])
 (user=seanjc job=sendgmr) by 2002:a0c:db05:: with SMTP id d5mr7191402qvk.41.1619225246707;
 Fri, 23 Apr 2021 17:47:26 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 23 Apr 2021 17:46:14 -0700
In-Reply-To: <20210424004645.3950558-1-seanjc@google.com>
Message-Id: <20210424004645.3950558-13-seanjc@google.com>
Mime-Version: 1.0
References: <20210424004645.3950558-1-seanjc@google.com>
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
Subject: [PATCH 12/43] KVM: x86: Remove defunct BSP "update" in local APIC reset
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

Remove a BSP APIC update in kvm_lapic_reset() that is a glorified and
confusing nop.  When the code was originally added, kvm_vcpu_is_bsp()
queried kvm->arch.bsp_vcpu, i.e. the intent was to set the BSP bit in the
BSP vCPU's APIC.  But, stuffing the BSP bit at INIT was wrong since the
guest can change its BSP(s); this was fixed by commit 58d269d8cccc ("KVM:
x86: BSP in MSR_IA32_APICBASE is writable").

In other words, kvm_vcpu_is_bsp() is now purely a reflection of
vcpu->arch.apic_base.MSR_IA32_APICBASE_BSP, thus the update will always
set the current value and kvm_lapic_set_base() is effectively a nop if
the new and old values match.  The RESET case, which does need to stuff
the BSP for the reset vCPU, is handled by vendor code (though this will
soon be moved to common code).

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/lapic.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 655eb1d07344..b99630c6d7fe 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -2351,9 +2351,7 @@ void kvm_lapic_reset(struct kvm_vcpu *vcpu, bool init_event)
 	apic->highest_isr_cache = -1;
 	update_divide_count(apic);
 	atomic_set(&apic->lapic_timer.pending, 0);
-	if (kvm_vcpu_is_bsp(vcpu))
-		kvm_lapic_set_base(vcpu,
-				vcpu->arch.apic_base | MSR_IA32_APICBASE_BSP);
+
 	vcpu->arch.pv_eoi.msr_val = 0;
 	apic_update_ppr(apic);
 	if (vcpu->arch.apicv_active) {
-- 
2.31.1.498.g6c1eba8ee3d-goog

