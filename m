Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B2323C74A7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 18:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233268AbhGMQgi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 12:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233231AbhGMQge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 12:36:34 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE91CC0613E9
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 09:33:42 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id l11-20020a056902072bb029055ab4873f4cso27708815ybt.22
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 09:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=qVAaYnz6pX9NpBAvuefpA8nWzJech9ezcBMh3QJZR+s=;
        b=OR7dSXpwFlC+X0W7OqUvl4kIpeBJF+qjuDAJSMu2iAijKG2W0OPADSYrJ2Wlhv48mZ
         fgMSwugGchIv/CKKT4x2ilhtNc+qnQcrk8hQjzYDiR7aefplm7QDZGvv2zo6cVjGOjkH
         LJFpRk2h0pTzxk4r4bO5Hx8r+ZbiIfNVl8V4MmUGHxgwRHLeiFFNp0AWc0xE5YRzqf8Z
         7MBdicd6KCU7NsaXNX9b173HANfizgOfHUWoNINcFEf7t5MwiKgUIAfFjddfkZKfGsZZ
         S2+xwdBV4MhtbNLKwVLAB74Mx6z2AoDjZr7nxIspW7L3xOtOosiEdu3KZx0hn8gDmtUs
         HB4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=qVAaYnz6pX9NpBAvuefpA8nWzJech9ezcBMh3QJZR+s=;
        b=SWbno5qJDXdsiIGoEBHCJTKuZANT/akq1XmxIHgb8INRJk4KjfNlNEnRGhOv+Ixdq+
         z/5H893WQTe0VVRsGVsavUoNhXlgnwgFkU+N3V/bX0BA42jTrg0vLQmxZzm7SOkpwRVZ
         i0a7cIj13jfYL9KUFJvqqK0/3i2hulTZOHJd5n4moQlXWTW4bKfDxF/YycaDJqLzOXhv
         qz3v4TSE5U3GCAJU6PPRMFQd4OkxpZlSpB0fPdOBDqcq7DrULgK/jtgAjmQjVwy5m36T
         pdHqJpb1YbG3unQnj8hTfvBkMb86u1RXrzjCd+DOqF4NDYUf8HIDjWTdqyntPEeZMCOx
         Mg/Q==
X-Gm-Message-State: AOAM531/9OJ5PliEtXIKNmSKI/b/vDFRw9nt1xbgPV0cXP7l3uEBz00j
        7/CUEaL3GFtMU8Evy+N78/LAbuHQOe4=
X-Google-Smtp-Source: ABdhPJyiyPuUnBaRxZJxtDyjf+Sb+7Fe/yKqvjWGeg/m1vbZgaG2C17q3843vEj6qP4u2s+znFWM0FGOyAg=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:90:200:825e:11a1:364b:8109])
 (user=seanjc job=sendgmr) by 2002:a25:888b:: with SMTP id d11mr7526792ybl.385.1626194022140;
 Tue, 13 Jul 2021 09:33:42 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 13 Jul 2021 09:32:42 -0700
In-Reply-To: <20210713163324.627647-1-seanjc@google.com>
Message-Id: <20210713163324.627647-5-seanjc@google.com>
Mime-Version: 1.0
References: <20210713163324.627647-1-seanjc@google.com>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
Subject: [PATCH v2 04/46] KVM: VMX: Set EDX at INIT with CPUID.0x1, Family-Model-Stepping
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

Set EDX at RESET/INIT based on the userspace-defined CPUID model when
possible, i.e. when CPUID.0x1.EAX is defind by userspace.  At RESET/INIT,
all CPUs that support CPUID set EDX to the FMS enumerated in
CPUID.0x1.EAX.  If no CPUID match is found, fall back to KVM's default
of 0x600 (Family '6'), which is the least awful approximation of KVM's
virtual CPU model.

Fixes: 6aa8b732ca01 ("[PATCH] kvm: userspace interface")
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/vmx.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 927a552393b9..825197f21700 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -4394,6 +4394,7 @@ static void vmx_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 	struct msr_data apic_base_msr;
+	u32 eax, dummy;
 	u64 cr0;
 
 	vmx->rmode.vm86_active = 0;
@@ -4401,7 +4402,11 @@ static void vmx_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
 
 	vmx->msr_ia32_umwait_control = 0;
 
-	vmx->vcpu.arch.regs[VCPU_REGS_RDX] = get_rdx_init_val();
+	eax = 1;
+	if (!kvm_cpuid(vcpu, &eax, &dummy, &dummy, &dummy, true))
+		eax = get_rdx_init_val();
+	kvm_rdx_write(vcpu, eax);
+
 	vmx->hv_deadline_tsc = -1;
 	kvm_set_cr8(vcpu, 0);
 
-- 
2.32.0.93.g670b81a890-goog

