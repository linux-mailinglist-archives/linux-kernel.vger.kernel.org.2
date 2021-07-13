Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1E843C74B3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 18:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234061AbhGMQgz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 12:36:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232813AbhGMQgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 12:36:45 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FD14C0613EE
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 09:33:54 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id x12-20020a05620a448cb02903b3dabbe857so17377201qkp.15
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 09:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=LCuijp/LgWy7Zf7nKMsAJ/SqN4uwlKk3jFpZ0B2dGyo=;
        b=chy0oHxym/ue2ksnIVnqz8+fw9GXKUgLXtGVmUl+sFwwgboS/wOTM2nzRO9ESgMBtL
         hclJywDEgQ+8V5ox2uhi+cqCLKkD4DWHuroZCF0UCKNGOLGY3CVxTkF14aicTr67ytWv
         aoIhtkRkyyisUMhMDCs5kWQs1n8Qh1FDRiF5ehw2NJTajag0Ym25ERziA6Dvfb+NeEjE
         jnDVlf8tJp82W2lHaqw8EJe8iH59tzh9jhdlYmicGFuoAkbKNUSlyNbQ68Bukqvy2Udi
         oNwJDB1LYERljoSAHrUv4SIxbFuTBjpxH5lDnKiGJo2YKG9OZPWRrrlhY5GFgH3Gql0C
         1juQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=LCuijp/LgWy7Zf7nKMsAJ/SqN4uwlKk3jFpZ0B2dGyo=;
        b=eSQc8jPrY6fAOWvbWuhcoHlP394h+wlGY0stdbF6GtpIMoYnDfMIrT5mPCER1eucMV
         5VOW54LbWp1QDviEu2pGhyXlCqSUfgwb0DLkosa2/JoKe0efgsIZcpOHOySuqJDFIUCo
         lCGksDkeAJjsUwr6REP2UVuBJ1Cp/KnWZXH7F8jJz4dnQwa8l5b3ENv44d9QDTIbdkIL
         bPE9nQvUBajIXTj4r19j6d+qxKh9qpmNqSnGzsdRl35D3a9FQ0YpO5sJC7G9yW53i1JQ
         UOiwlyputnR6bdv51VqEghRKPC7ysQTzQI9zcbdq//AbrmDegVu7c/B+W4sILaGXsU8o
         5e5Q==
X-Gm-Message-State: AOAM531nyI2MCB7iIjxq5m6y9WU/j42igGa+x6sVbP6VZntVZIdyhMaJ
        f6GEBV0UTZw1EdvHvT5/Jab0wN25KgI=
X-Google-Smtp-Source: ABdhPJyExWoaSPN4yVn66GFYgoo1Y+P3Z9I0FwdoNB0tbDz/4uSJ9d/HWwh3kjVX22cXxNrew0K/s7Ox8EE=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:90:200:825e:11a1:364b:8109])
 (user=seanjc job=sendgmr) by 2002:a05:6214:14e2:: with SMTP id
 k2mr5662267qvw.21.1626194033616; Tue, 13 Jul 2021 09:33:53 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 13 Jul 2021 09:32:48 -0700
In-Reply-To: <20210713163324.627647-1-seanjc@google.com>
Message-Id: <20210713163324.627647-11-seanjc@google.com>
Mime-Version: 1.0
References: <20210713163324.627647-1-seanjc@google.com>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
Subject: [PATCH v2 10/46] KVM: VMX: Move init_vmcs() invocation to vmx_vcpu_reset()
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

Initialize constant VMCS state in vcpu_vcpu_reset() instead of in
vmx_vcpu_create(), which allows for the removal of the open coded "vCPU
load" sequence since ->vcpu_reset() is invoked while the vCPU is properly
loaded (which is the entire point of vCPU reset...).

Deferring initialization is effectively a nop as it's impossible to
safely access the VMCS between the current call site and its new home, as
both the vCPU and the pCPU are put immediately after init_vmcs(), i.e.
the VMCS isn't guaranteed to be loaded.

Note, task preemption is not a problem as vmx_sched_in() _can't_ touch
the VMCS as ->sched_in() is invoked before the vCPU, and thus VMCS, is
reloaded.  I.e. the preemption path also can't consume VMCS state.

Reviewed-by: Reiji Watanabe <reijiw@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/vmx.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 0f5e97a904e5..26c0e776827c 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -4293,10 +4293,6 @@ static void vmx_compute_secondary_exec_control(struct vcpu_vmx *vmx)
 
 #define VMX_XSS_EXIT_BITMAP 0
 
-/*
- * Noting that the initialization of Guest-state Area of VMCS is in
- * vmx_vcpu_reset().
- */
 static void init_vmcs(struct vcpu_vmx *vmx)
 {
 	if (nested)
@@ -4395,6 +4391,9 @@ static void vmx_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
 	u32 eax, dummy;
 	u64 cr0;
 
+	if (!init_event)
+		init_vmcs(vmx);
+
 	vmx->rmode.vm86_active = 0;
 	vmx->spec_ctrl = 0;
 
@@ -6782,7 +6781,7 @@ static int vmx_create_vcpu(struct kvm_vcpu *vcpu)
 {
 	struct vmx_uret_msr *tsx_ctrl;
 	struct vcpu_vmx *vmx;
-	int i, cpu, err;
+	int i, err;
 
 	BUILD_BUG_ON(offsetof(struct vcpu_vmx, vcpu) != 0);
 	vmx = to_vmx(vcpu);
@@ -6844,12 +6843,7 @@ static int vmx_create_vcpu(struct kvm_vcpu *vcpu)
 	vmx->msr_bitmap_mode = 0;
 
 	vmx->loaded_vmcs = &vmx->vmcs01;
-	cpu = get_cpu();
-	vmx_vcpu_load(vcpu, cpu);
-	vcpu->cpu = cpu;
-	init_vmcs(vmx);
-	vmx_vcpu_put(vcpu);
-	put_cpu();
+
 	if (cpu_need_virtualize_apic_accesses(vcpu)) {
 		err = alloc_apic_access_page(vcpu->kvm);
 		if (err)
-- 
2.32.0.93.g670b81a890-goog

