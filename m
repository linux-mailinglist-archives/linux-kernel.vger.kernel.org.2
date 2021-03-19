Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFEFD341933
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 11:02:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbhCSKCM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 06:02:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbhCSKB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 06:01:59 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4603EC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 03:01:59 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id c1so33690720qke.8
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 03:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=CIsmkLE0g9uUYHkssLPzW8lJCvyWVlA0smh9KvafM8c=;
        b=mnl7DdYFyPquDIjBuKnrbJfi/MF00BIxJFV3lnTBSWOZX9/7P19EW7gFlI7SF9wdbV
         eMS48+JwDFabnYOTvcWuV/o/fEsYQKUW6ZBqD69Ez18aBz9mZbe9x/dMOCwfq6zW+/UK
         lqTkLnBl3x4bG2mtVbTHZyb5tcBoKhX4YyMOMBJDqrBcP2q86C+pttOdSpAhxP6fRAW+
         4Xqo7vbsy9JYWeN4qjLBZh9cswsIwv+Jd+ZKxrGx0Twy3e8ASpXmfJa5pS8+p7VHUaQD
         5Aedt4eQNieB9tnlsElzkwk+/91PGQL5GevNc9L4Vn4wLxaeQzJN4sqOyzDvi5SlMf7a
         9jPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=CIsmkLE0g9uUYHkssLPzW8lJCvyWVlA0smh9KvafM8c=;
        b=FfIpAaZb5qg/6TXsCDWsnHtRSI2PMCkshoyi7uGFW2xeLWTYLDejIQV5RkaWRvgW77
         2Z47qswSLUNvqZYiQBQbmHcq3aBH76pJbSmA00pySzn/VfYtNiM8/zmssGP8H8lUkWeN
         +T2X7YPW/6GJFIzAdrG72vaIa9k4BojLOl7QSzsa0aMimiWgB+UypfwFK0l4wMyCG7mT
         HrdXINiZSi2dEsHT5F+apMUJLQv+p79KCNgy9L3YmJlW3MwggN+W9Ap4m3zpWOmRyK8b
         6AA8zdly2vC8WEpCj+GX79tDnSI3DoK8aU7roWFEzTjmH6ZEDbj6lw03TViaPOSogtl1
         biGg==
X-Gm-Message-State: AOAM5330gnl79tDFKiwZ6pQrncg59Czr2zVLfA39ZbVeC1RTb6FWTygI
        cDRBcyEvGDaEeNVwWg39NKB7G39A695Z
X-Google-Smtp-Source: ABdhPJzA3oNh21daYWHPaxjjPBQ5fA1puT7gydtzxZDpB1C/5M+oTH08m6wJ7hRCp65FPJYBMfZbdl++kaZD
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:10:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:a05:6214:1051:: with SMTP id
 l17mr8500404qvr.49.1616148118421; Fri, 19 Mar 2021 03:01:58 -0700 (PDT)
Date:   Fri, 19 Mar 2021 10:01:12 +0000
In-Reply-To: <20210319100146.1149909-1-qperret@google.com>
Message-Id: <20210319100146.1149909-5-qperret@google.com>
Mime-Version: 1.0
References: <20210319100146.1149909-1-qperret@google.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH v6 04/38] KVM: arm64: Initialize kvm_nvhe_init_params early
From:   Quentin Perret <qperret@google.com>
To:     catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
        james.morse@arm.com, julien.thierry.kdev@gmail.com,
        suzuki.poulose@arm.com
Cc:     android-kvm@google.com, seanjc@google.com, mate.toth-pal@arm.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel-team@android.com,
        kvmarm@lists.cs.columbia.edu, tabba@google.com, ardb@kernel.org,
        mark.rutland@arm.com, dbrazdil@google.com, qperret@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the initialization of kvm_nvhe_init_params in a dedicated function
that is run early, and only once during KVM init, rather than every time
the KVM vectors are set and reset.

This also opens the opportunity for the hypervisor to change the init
structs during boot, hence simplifying the replacement of host-provided
page-table by the one the hypervisor will create for itself.

Acked-by: Will Deacon <will@kernel.org>
Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/kvm/arm.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index c2df58be5b0c..2adb8d878bb9 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -1388,22 +1388,18 @@ static int kvm_init_vector_slots(void)
 	return 0;
 }
 
-static void cpu_init_hyp_mode(void)
+static void cpu_prepare_hyp_mode(int cpu)
 {
-	struct kvm_nvhe_init_params *params = this_cpu_ptr_nvhe_sym(kvm_init_params);
-	struct arm_smccc_res res;
+	struct kvm_nvhe_init_params *params = per_cpu_ptr_nvhe_sym(kvm_init_params, cpu);
 	unsigned long tcr;
 
-	/* Switch from the HYP stub to our own HYP init vector */
-	__hyp_set_vectors(kvm_get_idmap_vector());
-
 	/*
 	 * Calculate the raw per-cpu offset without a translation from the
 	 * kernel's mapping to the linear mapping, and store it in tpidr_el2
 	 * so that we can use adr_l to access per-cpu variables in EL2.
 	 * Also drop the KASAN tag which gets in the way...
 	 */
-	params->tpidr_el2 = (unsigned long)kasan_reset_tag(this_cpu_ptr_nvhe_sym(__per_cpu_start)) -
+	params->tpidr_el2 = (unsigned long)kasan_reset_tag(per_cpu_ptr_nvhe_sym(__per_cpu_start, cpu)) -
 			    (unsigned long)kvm_ksym_ref(CHOOSE_NVHE_SYM(__per_cpu_start));
 
 	params->mair_el2 = read_sysreg(mair_el1);
@@ -1427,7 +1423,7 @@ static void cpu_init_hyp_mode(void)
 	tcr |= (idmap_t0sz & GENMASK(TCR_TxSZ_WIDTH - 1, 0)) << TCR_T0SZ_OFFSET;
 	params->tcr_el2 = tcr;
 
-	params->stack_hyp_va = kern_hyp_va(__this_cpu_read(kvm_arm_hyp_stack_page) + PAGE_SIZE);
+	params->stack_hyp_va = kern_hyp_va(per_cpu(kvm_arm_hyp_stack_page, cpu) + PAGE_SIZE);
 	params->pgd_pa = kvm_mmu_get_httbr();
 
 	/*
@@ -1435,6 +1431,15 @@ static void cpu_init_hyp_mode(void)
 	 * be read while the MMU is off.
 	 */
 	kvm_flush_dcache_to_poc(params, sizeof(*params));
+}
+
+static void cpu_init_hyp_mode(void)
+{
+	struct kvm_nvhe_init_params *params;
+	struct arm_smccc_res res;
+
+	/* Switch from the HYP stub to our own HYP init vector */
+	__hyp_set_vectors(kvm_get_idmap_vector());
 
 	/*
 	 * Call initialization code, and switch to the full blown HYP code.
@@ -1443,6 +1448,7 @@ static void cpu_init_hyp_mode(void)
 	 * cpus_have_const_cap() wrapper.
 	 */
 	BUG_ON(!system_capabilities_finalized());
+	params = this_cpu_ptr_nvhe_sym(kvm_init_params);
 	arm_smccc_1_1_hvc(KVM_HOST_SMCCC_FUNC(__kvm_hyp_init), virt_to_phys(params), &res);
 	WARN_ON(res.a0 != SMCCC_RET_SUCCESS);
 
@@ -1790,19 +1796,19 @@ static int init_hyp_mode(void)
 		}
 	}
 
-	/*
-	 * Map Hyp percpu pages
-	 */
 	for_each_possible_cpu(cpu) {
 		char *percpu_begin = (char *)kvm_arm_hyp_percpu_base[cpu];
 		char *percpu_end = percpu_begin + nvhe_percpu_size();
 
+		/* Map Hyp percpu pages */
 		err = create_hyp_mappings(percpu_begin, percpu_end, PAGE_HYP);
-
 		if (err) {
 			kvm_err("Cannot map hyp percpu region\n");
 			goto out_err;
 		}
+
+		/* Prepare the CPU initialization parameters */
+		cpu_prepare_hyp_mode(cpu);
 	}
 
 	if (is_protected_kvm_enabled()) {
-- 
2.31.0.rc2.261.g7f71774620-goog

