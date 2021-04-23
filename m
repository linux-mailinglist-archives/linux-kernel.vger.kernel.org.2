Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0C10369CD2
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Apr 2021 00:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244204AbhDWWfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 18:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243974AbhDWWe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 18:34:58 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09CECC06138C
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 15:34:16 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id t1-20020a0ca6810000b029019e892416e6so18965833qva.9
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 15:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=3FZQgk34SCAEH/5Yfdg9zYeevM/f3oDzvK0CNaN8pUI=;
        b=JtoysbVW5puihHQaqaRHim3A+fvT9gM3bW0Yh1fW5gu9UayVB92Z7sJ6NmSn4oS6K/
         q2U0dwecaNAfvVAIHR0jfyntDPgAoA57qWEEOVNWRXPo55/oN/W5s04QwRFj8aog1hQQ
         ObDP/mDZdYnQaSZis9jLlSbfHN3Wrk9fxh0sVbuCEHuUbE8a/k4oi6GkJ335XH93dmjj
         k37roNT+RzRenabv+x6zqJxERbPIpCmy08N5qY+3Gr/NqRN9DKdUY8UJEh4a7RBBJLmy
         C4lpwQBiQYjRgZ7ZMtDXMA/fHKGmWKsILCPlHB+XSivd6xX+ouH7XbgIQhBdZdPOaExL
         7PLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=3FZQgk34SCAEH/5Yfdg9zYeevM/f3oDzvK0CNaN8pUI=;
        b=YY/RHXG4AXjcvTSDa+BBHPGh87jCdhiAIIxiaSI64hk5Fpg03OVr6y7TvmOI1pEW93
         6gq0FgUXCydpMEXMb4xPlnB3MrY9jeX0o/o/9IHTf+Cqd/D6lxuqA4nWVPvO/CJdSyHV
         VqQoG8Qjb0bOq0XtJZwCFd+3vVSymxfzQdQWrIw+R02P7CS2ol9+l9O0sFYU3uZrm8IZ
         Bd+vuhj8oG3xdWMmLn23Zuc2Q+stuVzvH9cxBWdUo6DD7zk99s6mQfx6mG+5TfWUk8OW
         eS3ue7gAZek1g25upAow2NcC7xFnn44RL1YoCL8VfdzjxYIcYInSXrzShOEgf2A1fS4Y
         SU6Q==
X-Gm-Message-State: AOAM530ccT0/8MPqDp7OM9HzAmLvP4VjwwzCDgiEqcV5L63FD8IUxSmz
        fyCAFYaVkOxYQXaaI15Z9nGG9l9vZ4s=
X-Google-Smtp-Source: ABdhPJxACcZTceTA892PPr06aY0ZOa8IzN92MHMftjtUJzrnZ7FTZWV9phOU2atke0Mj1TIigGfMfGqFS2E=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:ad52:3246:e190:f070])
 (user=seanjc job=sendgmr) by 2002:a0c:e6c5:: with SMTP id l5mr6901795qvn.2.1619217255239;
 Fri, 23 Apr 2021 15:34:15 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 23 Apr 2021 15:34:02 -0700
In-Reply-To: <20210423223404.3860547-1-seanjc@google.com>
Message-Id: <20210423223404.3860547-3-seanjc@google.com>
Mime-Version: 1.0
References: <20210423223404.3860547-1-seanjc@google.com>
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
Subject: [PATCH v3 2/4] KVM: SVM: Clear MSR_TSC_AUX[63:32] on write
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

Force clear bits 63:32 of MSR_TSC_AUX on write to emulate current AMD
CPUs, which completely ignore the upper 32 bits, including dropping them
on write.  Emulating AMD hardware will also allow migrating a vCPU from
AMD hardware to Intel hardware without requiring userspace to manually
clear the upper bits, which are reserved on Intel hardware.

Presumably, MSR_TSC_AUX[63:32] are intended to be reserved on AMD, but
sadly the APM doesn't say _anything_ about those bits in the context of
MSR access.  The RDTSCP entry simply states that RCX contains bits 31:0
of the MSR, zero extended.  And even worse is that the RDPID description
implies that it can consume all 64 bits of the MSR:

  RDPID reads the value of TSC_AUX MSR used by the RDTSCP instruction
  into the specified destination register. Normal operand size prefixes
  do not apply and the update is either 32 bit or 64 bit based on the
  current mode.

Emulate current hardware behavior to give KVM the best odds of playing
nice with whatever the behavior of future AMD CPUs happens to be.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/svm.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 9ed9c7bd7cfd..71d704f8d569 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -2904,8 +2904,17 @@ static int svm_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr)
 		 * direct_access_msrs.  Doing that would require a rdmsr in
 		 * svm_vcpu_put.
 		 */
-		svm->tsc_aux = data;
 		wrmsrl(MSR_TSC_AUX, svm->tsc_aux);
+
+		/*
+		 * Per Intel's SDM, bits 63:32 are reserved, but AMD's APM has
+		 * incomplete and conflicting architectural behavior.  Current
+		 * AMD CPUs completely ignore bits 63:32, i.e. they aren't
+		 * reserved and always read as zeros.  Emulate AMD CPU behavior
+		 * to avoid explosions if the vCPU is migrated from an AMD host
+		 * to an Intel host.
+		 */
+		svm->tsc_aux = (u32)data;
 		break;
 	case MSR_IA32_DEBUGCTLMSR:
 		if (!boot_cpu_has(X86_FEATURE_LBRV)) {
-- 
2.31.1.498.g6c1eba8ee3d-goog

