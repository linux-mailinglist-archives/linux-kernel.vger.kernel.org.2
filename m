Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA8F3E5E3F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 16:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241641AbhHJOp4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 10:45:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241557AbhHJOpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 10:45:54 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D784C0613D3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 07:45:32 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id x5-20020a0569020505b0290592c25b8c59so21096774ybs.18
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 07:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:message-id:mime-version:subject:from:to:cc;
        bh=fVT0hBA40C0LYYk76ta6EuoYQS16Vzv9m9E3pri5Sko=;
        b=eXcmuXn4ohzRBy+B2yycgbf6Q6K/WHmliwQDwiOovgjlBe/XBFTfYs6tLQ13nUGDN5
         KeGiDUeczy5kOEqyFE9Nz8j/3XsA94NStOOSvpiHuWQjvDpfr2MbN+4Sv1III+6VCUKu
         Z6/Jv9kYxK1QARv7gPgM6c0S2tfuaAlQ0ZFB1LbxuXVpLMNmLGofXUbhQR8eXFhUMUhj
         vNhCdEb93mlu67VJ1iWz8psh5uPqjNWi7NQEercCZ3SlysermDvUoWI1GERpUi8GzqNf
         FExukgOH8AGl1DYEyi7uMZzS5YGoxRP/GLww4KvQMEGMxOlKGsh8B+N10DAqDqxbVxzg
         r2gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:message-id:mime-version:subject
         :from:to:cc;
        bh=fVT0hBA40C0LYYk76ta6EuoYQS16Vzv9m9E3pri5Sko=;
        b=FcUGonL5+PlPQ4sZQqK/QHmaGdF3AR4OyTxjz4XJt6I2LCQVAHeMsLBSVZRAuht5dh
         eyxJ5n5Pe+2HwJPcsQXfxLlS4EWQPGpusPuEuP/Zfav6u0R9rzCS+gp+9rnVb3NWrCNP
         J4kefBuzK1NPABVUGFuNrWZCU2E98QVO3LBLgsO3VzceciPTnjTW07jqb3ymZ+ficlEx
         XjMwWLdlzBHOQY0gsj11zYXHeWmJlew/4xpJu6N4cTRPtJRhINFaJTx6AR1brcMMST8X
         XavzHxQSdpzrQAhFPE9XWeN5LB3ppsZ/xBTPdX9tWTic0+bJHHUp3H7MCyEJXqTswdPn
         v1kw==
X-Gm-Message-State: AOAM530I16U2gNO/VARCFNmoOQz0kQW4BYyTuYDPzibaMRn6040Yx/09
        PleOQQT0mY0IQKtsNxszRs/TQ7EgukA=
X-Google-Smtp-Source: ABdhPJzheM+uy2bDog3KXbSirbSArrsPgFBANujV0ogo8E1JRUllsPjbW3EAfVDuSIiUxzb5eHSP1B15Iw0=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:90:200:de69:b19a:1af5:866d])
 (user=seanjc job=sendgmr) by 2002:a25:8101:: with SMTP id o1mr41332749ybk.83.1628606731477;
 Tue, 10 Aug 2021 07:45:31 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 10 Aug 2021 07:45:26 -0700
Message-Id: <20210810144526.2662272-1-seanjc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.605.g8dce9f2422-goog
Subject: [PATCH] KVM: nVMX: Unconditionally clear nested.pi_pending on nested VM-Enter
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

Clear nested.pi_pending on nested VM-Enter even if L2 will run without
posted interrupts enabled.  If nested.pi_pending is left set from a
previous L2, vmx_complete_nested_posted_interrupt() will pick up the
stale flag and exit to userspace with an "internal emulation error" due
the new L2 not having a valid nested.pi_desc.

Arguably, vmx_complete_nested_posted_interrupt() should first check for
posted interrupts being enabled, but it's also completely reasonable that
KVM wouldn't screw up a fundamental flag.  Not to mention that the mere
existence of nested.pi_pending is a long-standing bug as KVM shouldn't
move the posted interrupt out of the IRR until it's actually processed,
e.g. KVM effectively drops an interrupt when it performs a nested VM-Exit
with a "pending" posted interrupt.  Fixing the mess is a future problem.

Prior to vmx_complete_nested_posted_interrupt() interpreting a null PI
descriptor as an error, this was a benign bug as the null PI descriptor
effectively served as a check on PI not being enabled.  Even then, the
new flow did not become problematic until KVM started checking the result
of kvm_check_nested_events().

Fixes: 705699a13994 ("KVM: nVMX: Enable nested posted interrupt processing")
Fixes: 966eefb89657 ("KVM: nVMX: Disable vmcs02 posted interrupts if vmcs12 PID isn't mappable")
Fixes: 47d3530f86c0 ("KVM: x86: Exit to userspace when kvm_check_nested_events fails")
Cc: stable@vger.kernel.org
Cc: Jim Mattson <jmattson@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/nested.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 0d0dd6580cfd..079f99e0ece1 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -2186,12 +2186,11 @@ static void prepare_vmcs02_early(struct vcpu_vmx *vmx, struct vmcs12 *vmcs12)
 			 ~PIN_BASED_VMX_PREEMPTION_TIMER);
 
 	/* Posted interrupts setting is only taken from vmcs12.  */
-	if (nested_cpu_has_posted_intr(vmcs12)) {
+	vmx->nested.pi_pending = false;
+	if (nested_cpu_has_posted_intr(vmcs12))
 		vmx->nested.posted_intr_nv = vmcs12->posted_intr_nv;
-		vmx->nested.pi_pending = false;
-	} else {
+	else
 		exec_control &= ~PIN_BASED_POSTED_INTR;
-	}
 	pin_controls_set(vmx, exec_control);
 
 	/*
-- 
2.32.0.605.g8dce9f2422-goog

