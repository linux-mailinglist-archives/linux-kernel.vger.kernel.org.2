Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6020544A41F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 02:41:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238350AbhKIBnX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 20:43:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234013AbhKIBnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 20:43:10 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB358C079267
        for <linux-kernel@vger.kernel.org>; Mon,  8 Nov 2021 17:30:52 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id m17-20020a170902db1100b001421cb34857so7298615plx.15
        for <linux-kernel@vger.kernel.org>; Mon, 08 Nov 2021 17:30:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=+KxFuclLEQjMNzd9DfXLBQyCK88qHz6BEZ6s8fNNocc=;
        b=BcC8ihEwhIomjBdZOmFHYpk0Yi8XUysCNdw9spbv7rhHvckAIuBYr8vdspOlPSt0zZ
         2I68Hz/ufUuLDHL9arTQeQpsnLJ1YZ+KJgYz3IxLDuMYKQRWOxspctMF+/2pC3o/a6Gu
         B/aRaL6W4zuSVgzWBJWycldfS0Iky9GHB4qXBtfnuCKrfiTBmwlxQswsgW+7Vbkl6z6Y
         yYHGYyNvxlhXJeMonTbz5S/2mfdKleVIvWjrPPCHEiriSTbpyPQxJMOtcEq4VOJ9pvfq
         Fs9RwO8R8TlJN7XDOFU9CcjMMwTgDs05FjdE1ELciN63BweEjN/GjEsEWhrkqoLdOcXx
         lFgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=+KxFuclLEQjMNzd9DfXLBQyCK88qHz6BEZ6s8fNNocc=;
        b=Mz3FKi8gA4zWuh4ZZ9nShNKKmsq8aEgV8063DQEibZgzWgk5lmUuzpfPn9zTW2UbLq
         IrbFuTTZFGP6K8+vHTTMTe0XsqD9oVNTnbRiAu4nxmeGCiIwHJSzb/XD2weynbb7drnj
         O4B6exEwOpzBHpegK5bTssC9a+byoKBQQlOEpKUuHg/PI019kMyr/OF0xB4AiSxR2niC
         qJAJE6RDO5YHVltFp++M0cqRg0YqbME95dVuXIEFjsnOEQ1FDQLZvo1I0B5lnJ1/KbN3
         iyneYxmhP1l4y9PUJMPs6SSGkWJubtzIJQp42hXIGkyHkRNtv5rOdZdzIZrNuRuk80ve
         ZblQ==
X-Gm-Message-State: AOAM530emNmvavc09kh5zY2Io/tFlAr/MFLqr0ALhdcFg1sltnbYBHqK
        2Fy6Oo3YCqwctWeVl1mbsxT9tN2KCqY=
X-Google-Smtp-Source: ABdhPJwkMd/9N871qc24SlYDmD7DzBg9zEDCn0B1/p7QIg20UeqAGjpAT+GOAXo6N+8am3j2LKFPN/YkRCo=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:90b:1b03:: with SMTP id
 nu3mr2976745pjb.47.1636421452360; Mon, 08 Nov 2021 17:30:52 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue,  9 Nov 2021 01:30:44 +0000
In-Reply-To: <20211109013047.2041518-1-seanjc@google.com>
Message-Id: <20211109013047.2041518-2-seanjc@google.com>
Mime-Version: 1.0
References: <20211109013047.2041518-1-seanjc@google.com>
X-Mailer: git-send-email 2.34.0.rc0.344.g81b53c2807-goog
Subject: [PATCH v4 1/4] KVM: nVMX: Query current VMCS when determining if MSR
 bitmaps are in use
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Alexander Graf <graf@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check the current VMCS controls to determine if an MSR write will be
intercepted due to MSR bitmaps being disabled.  In the nested VMX case,
KVM will disable MSR bitmaps in vmcs02 if they're disabled in vmcs12 or
if KVM can't map L1's bitmaps for whatever reason.

Note, the bad behavior is relatively benign in the current code base as
KVM sets all bits in vmcs02's MSR bitmap by default, clears bits if and
only if L0 KVM also disables interception of an MSR, and only uses the
buggy helper for MSR_IA32_SPEC_CTRL.  Because KVM explicitly tests WRMSR
before disabling interception of MSR_IA32_SPEC_CTRL, the flawed check
will only result in KVM reading MSR_IA32_SPEC_CTRL from hardware when it
isn't strictly necessary.

Tag the fix for stable in case a future fix wants to use
msr_write_intercepted(), in which case a buggy implementation in older
kernels could prove subtly problematic.

Fixes: d28b387fb74d ("KVM/VMX: Allow direct access to MSR_IA32_SPEC_CTRL")
Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/vmx.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 71f54d85f104..334323bd787d 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -769,15 +769,15 @@ void vmx_update_exception_bitmap(struct kvm_vcpu *vcpu)
 /*
  * Check if MSR is intercepted for currently loaded MSR bitmap.
  */
-static bool msr_write_intercepted(struct kvm_vcpu *vcpu, u32 msr)
+static bool msr_write_intercepted(struct vcpu_vmx *vmx, u32 msr)
 {
 	unsigned long *msr_bitmap;
 	int f = sizeof(unsigned long);
 
-	if (!cpu_has_vmx_msr_bitmap())
+	if (!(exec_controls_get(vmx) & CPU_BASED_USE_MSR_BITMAPS))
 		return true;
 
-	msr_bitmap = to_vmx(vcpu)->loaded_vmcs->msr_bitmap;
+	msr_bitmap = vmx->loaded_vmcs->msr_bitmap;
 
 	if (msr <= 0x1fff) {
 		return !!test_bit(msr, msr_bitmap + 0x800 / f);
@@ -6751,7 +6751,7 @@ static fastpath_t vmx_vcpu_run(struct kvm_vcpu *vcpu)
 	 * If the L02 MSR bitmap does not intercept the MSR, then we need to
 	 * save it.
 	 */
-	if (unlikely(!msr_write_intercepted(vcpu, MSR_IA32_SPEC_CTRL)))
+	if (unlikely(!msr_write_intercepted(vmx, MSR_IA32_SPEC_CTRL)))
 		vmx->spec_ctrl = native_read_msr(MSR_IA32_SPEC_CTRL);
 
 	x86_spec_ctrl_restore_host(vmx->spec_ctrl, 0);
-- 
2.34.0.rc0.344.g81b53c2807-goog

