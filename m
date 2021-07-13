Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25F993C74FB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 18:36:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236426AbhGMQjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 12:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234933AbhGMQi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 12:38:26 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F26EC0613BB
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 09:34:46 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id k11-20020a056902070bb029055a2303fc2dso27776515ybt.11
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 09:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=7TYutvwiNQ0wwwZfy6Csacs/gOXz4YtFws186782Baw=;
        b=lDyzSVB8js2o047UWN71BM8/WfEwkxLDHVzimxp2ThMT2lJuStsKlT+8jU2eCOZsds
         QMg5A/eVoPNOz8SnG7Q2cVoIqjg1ogQ+J1uOiMvosgh36iDIbPvrD/bnc2m0hcDB8rXW
         dSqJGy9m0qz1snNWlrUIDNrzkz1lQF3FjDbYGJVVnh/YWgPr2d0Lzj/nvpbHBoWJd1U5
         LaCNIzT4bg8aU41wtyJ1KJhtpwuVH+47X4IGWDmmAX61avOIr1HPfrEv1RupNhbX22Dv
         Hra7g6Fa9nSbPEn8at8DuI6trY91NfsboK1n0d/Z9N4Id/cjLBga1SEXXnJ+UVmBB7Y5
         j8KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=7TYutvwiNQ0wwwZfy6Csacs/gOXz4YtFws186782Baw=;
        b=heIvr9LvZCwGooVASUTTeXk7mL5fsbo1fWDDGhLmXykadGncpdIPIF3X+a7cTchGbQ
         pUGU0kloqy0fOVnjoGuKXFXkyT3UMx6DuNg+E/Mjfyi99t0voEN/5LjbidMrsFXMJn/7
         b0F0tg7wRzurVtKpUFNo53aeS6FeBIzxNKgOjR4WWabC9yLiX9XsgKnut0wJplfMnKJ9
         i1zPmh02TcQyqFzgj+vMU2gKThPM/33G1eYRRRVf1zzPfotPOsjhMxpfzzhQyWQCWr6N
         59jLGhQ5+oY+FYoERIjhQ9+210XaDjaN6TyEIGH+1BEdAz6Bp5BOtRXKi+L3f75xZ1HG
         YV8A==
X-Gm-Message-State: AOAM530ZCdjgoEpHvCQ7mi3ofzVhvZJQpDFsVGjGIsBkaraEN3UPrucS
        uvd52klk2ZtiIOlGLWhBrRhxlfMCG40=
X-Google-Smtp-Source: ABdhPJz9BrOtOdA4tipcZJ7RCVOjdwjB2CaLZaXT0dUnSI2USqQTlYZpY3sNb/D4smdOz4Iwe7qjAKTP/zk=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:90:200:825e:11a1:364b:8109])
 (user=seanjc job=sendgmr) by 2002:a25:38c7:: with SMTP id f190mr7076549yba.5.1626194085652;
 Tue, 13 Jul 2021 09:34:45 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 13 Jul 2021 09:33:15 -0700
In-Reply-To: <20210713163324.627647-1-seanjc@google.com>
Message-Id: <20210713163324.627647-38-seanjc@google.com>
Mime-Version: 1.0
References: <20210713163324.627647-1-seanjc@google.com>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
Subject: [PATCH v2 37/46] KVM: VMX: Remove obsolete MSR bitmap refresh at vCPU RESET/INIT
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Reiji Watanabe <reijiw@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove an unnecessary MSR bitmap refresh during vCPU RESET/INIT.  In both
cases, the MSR bitmap already has the desired values and state.

At RESET, the vCPU is guaranteed to be running with x2APIC disabled, the
x2APIC MSRs are guaranteed to be intercepted due to the MSR bitmap being
initialized to all ones by alloc_loaded_vmcs(), and vmx->msr_bitmap_mode
is guaranteed to be zero, i.e. reflecting x2APIC disabled.

At INIT, the APIC_BASE MSR is not modified, thus there can't be any
change in x2APIC state.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/vmx.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index ef92ec40d3d9..7e99535a4cbb 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -4466,9 +4466,6 @@ static void vmx_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
 	if (kvm_mpx_supported())
 		vmcs_write64(GUEST_BNDCFGS, 0);
 
-	if (cpu_has_vmx_msr_bitmap())
-		vmx_update_msr_bitmap(&vmx->vcpu);
-
 	vmcs_write32(VM_ENTRY_INTR_INFO_FIELD, 0);  /* 22.2.1 */
 
 	if (cpu_has_vmx_tpr_shadow() && !init_event) {
-- 
2.32.0.93.g670b81a890-goog

