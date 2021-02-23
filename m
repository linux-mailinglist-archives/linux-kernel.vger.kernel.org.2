Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92C58322E2A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 16:59:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233313AbhBWP7I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 10:59:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233326AbhBWP6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 10:58:55 -0500
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB599C06178B
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 07:58:10 -0800 (PST)
Received: by mail-qt1-x84a.google.com with SMTP id r18so10320108qta.19
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 07:58:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=Yq3UF/O6ghf1oapvxUJWBbk4uV2Kh5VLtR3aNkbqwLU=;
        b=gpmDUt1OHWLR5BJcB5vOUDieK/iuS3jdCYC/3Qqk1Uz7Vs2ER8YjQZNbRMmIKQo9+L
         clTMbUAasQIAG+/2wwlNsQFJ02PnBMqvIi6KHCGECAuGcjJ0oI2y9NG0+dkHVuJ5BKS4
         Kj6fuXxVv9YctZ65M/d5X7k/HrVi8qZpi5B8Rf2pmkWcerPU6Rxm8MqW+5dFXgoOk4gX
         XgdQ8ljGq5Ba9c/DWmc7qO/yMOLJieMU6kawxoFxG/XrxdhzMKdE8PZ/7YSiwNLSffpL
         MZx6qeh80KI6yVYxeCjr51Bucj3amveXOATtQzkmRDBdMrD4Gr8Opbew4gilcJJ3m9u1
         ei4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Yq3UF/O6ghf1oapvxUJWBbk4uV2Kh5VLtR3aNkbqwLU=;
        b=ANi0XT02uHgTiuVZcPjSkoe4kEAsVjhZ0+hRvLTTk6odM9AYidb3quaFY8MJRWOCjJ
         WHf60pl2pkbANl9ZjQUY+UUcPDD9e+BOajSxgxT6U407twriR7T48+wGtW9RMYHBto66
         JYI7W1/IT4EzfL1dFbcXVqx10P8zMphSawpA0Y8wLMB59Y0Verd93l7PSyT3HTGavVks
         5a/iu87av5GnDICxTNnFHBp4V2LED1xYrUn0UfnU0xraYhAERbVwOfQ5/6O66HiCS3HK
         4pJ7F86bVYlf5ROEnfcl5kGd+3X19w/62uTZZzMIXiJf0jHO4Jday4r/pI1h9sxv5Em/
         V4sA==
X-Gm-Message-State: AOAM531UdG95ABHRTUw8aRHWc7TcrSTKgT2rbH4HA/Dmjx2dM1wY9gTM
        0g2rF83arfqRXwZU33mU/fkZZpyv92s=
X-Google-Smtp-Source: ABdhPJxaNChA01qsecoe418jaw7NU2vcfrgh9tBh+/Qt5CHyN7goXPTTmu8BVzVBgR13/Jvc45rDTHpubSw=
Sender: "ascull via sendgmr" <ascull@ascull.c.googlers.com>
X-Received: from ascull.c.googlers.com ([fda3:e722:ac3:10:28:9cb1:c0a8:1510])
 (user=ascull job=sendgmr) by 2002:ad4:48c3:: with SMTP id v3mr22683374qvx.51.1614095889872;
 Tue, 23 Feb 2021 07:58:09 -0800 (PST)
Date:   Tue, 23 Feb 2021 15:57:58 +0000
In-Reply-To: <20210223155759.3495252-1-ascull@google.com>
Message-Id: <20210223155759.3495252-4-ascull@google.com>
Mime-Version: 1.0
References: <20210223155759.3495252-1-ascull@google.com>
X-Mailer: git-send-email 2.30.0.617.g56c4b15f3c-goog
Subject: [PATCH v2 3/4] KVM: arm64: Use BUG and BUG_ON in nVHE hyp
From:   Andrew Scull <ascull@google.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     linux-kernel@vger.kernel.org, maz@kernel.org, james.morse@arm.com,
        suzuki.poulose@arm.com, julien.thierry.kdev@gmail.com,
        will@kernel.org, catalin.marinas@arm.com, kernel-team@android.com,
        Andrew Scull <ascull@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hyp_panic() reports the address of the panic by using ELR_EL2, but this
isn't a useful address when hyp_panic() is called directly. Replace such
direct calls with BUG() and BUG_ON() which use BRK to trigger and
exception that then goes to hyp_panic() with the correct address. Also
remove the hyp_panic() declaration from the header file to avoid
accidental misuse.

Signed-off-by: Andrew Scull <ascull@google.com>
---
 arch/arm64/include/asm/kvm_hyp.h   | 1 -
 arch/arm64/kvm/hyp/nvhe/hyp-main.c | 2 +-
 arch/arm64/kvm/hyp/nvhe/hyp-smp.c  | 6 ++----
 3 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_hyp.h b/arch/arm64/include/asm/kvm_hyp.h
index fb8404fefd1f..746eb9a2891b 100644
--- a/arch/arm64/include/asm/kvm_hyp.h
+++ b/arch/arm64/include/asm/kvm_hyp.h
@@ -95,7 +95,6 @@ u64 __guest_enter(struct kvm_vcpu *vcpu);
 
 bool kvm_host_psci_handler(struct kvm_cpu_context *host_ctxt);
 
-void __noreturn hyp_panic(void);
 #ifdef __KVM_NVHE_HYPERVISOR__
 void __noreturn __hyp_do_panic(struct kvm_cpu_context *host_ctxt, u64 spsr,
 			       u64 elr, u64 par);
diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-main.c b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
index a906f9e2ff34..9f37a4240562 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-main.c
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
@@ -181,6 +181,6 @@ void handle_trap(struct kvm_cpu_context *host_ctxt)
 		handle_host_smc(host_ctxt);
 		break;
 	default:
-		hyp_panic();
+		BUG();
 	}
 }
diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-smp.c b/arch/arm64/kvm/hyp/nvhe/hyp-smp.c
index 2997aa156d8e..4495aed04240 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-smp.c
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-smp.c
@@ -18,8 +18,7 @@ u64 __ro_after_init hyp_cpu_logical_map[NR_CPUS] = { [0 ... NR_CPUS-1] = INVALID
 
 u64 cpu_logical_map(unsigned int cpu)
 {
-	if (cpu >= ARRAY_SIZE(hyp_cpu_logical_map))
-		hyp_panic();
+	BUG_ON(cpu >= ARRAY_SIZE(hyp_cpu_logical_map));
 
 	return hyp_cpu_logical_map[cpu];
 }
@@ -30,8 +29,7 @@ unsigned long __hyp_per_cpu_offset(unsigned int cpu)
 	unsigned long this_cpu_base;
 	unsigned long elf_base;
 
-	if (cpu >= ARRAY_SIZE(kvm_arm_hyp_percpu_base))
-		hyp_panic();
+	BUG_ON(cpu >= ARRAY_SIZE(kvm_arm_hyp_percpu_base));
 
 	cpu_base_array = (unsigned long *)hyp_symbol_addr(kvm_arm_hyp_percpu_base);
 	this_cpu_base = kern_hyp_va(cpu_base_array[cpu]);
-- 
2.30.0.617.g56c4b15f3c-goog

