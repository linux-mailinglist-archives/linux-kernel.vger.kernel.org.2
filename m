Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBC323345F7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 18:58:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233582AbhCJR6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 12:58:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233628AbhCJR6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 12:58:04 -0500
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B3CAC061760
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 09:58:04 -0800 (PST)
Received: by mail-wm1-x349.google.com with SMTP id s192so2975239wme.6
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 09:58:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=jVYWjziEKUKc3S+4nq/6jQVOOomaowaXjC9E5zES6pQ=;
        b=nsvOfXUVW6h8kIQh3yiueCj6FV4dlzSfhRdKHnNGnCkKPZI5fNxOpJJFoBLk7a54Ra
         0GPqUFtoTtHggQ+6IiV2+VOOIhT901RRTg5+YuxqE+ARSv1/VUKqHMpwQ1MdLCYl8k2b
         Xb283tTIwYqpbwCorQjUPznmdKjXxotCgclOs8CvTcamx8etgspyG34WIuYYcE0QWrlr
         8bo6+eBnQTPquXEMRDOSwJeb+gbU8uCFsF/Y1VUKs15yWviezlT9lUmCraZz/TI46qlV
         BTsS2Hw6XyHDuUwibzLiCcEgGmd/mXEW6BxSqwDw6CHUZYbLm1m+KGVFOu7ettih+hXF
         zIdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=jVYWjziEKUKc3S+4nq/6jQVOOomaowaXjC9E5zES6pQ=;
        b=Q2+vdOH07cUyP2FxV5b7k7qYSHr+KkfPMKrGU42KwoItcb5ph1cncvM7nilB1bmvT0
         ezp3puJDAIs051o/QVFEM3iGY1/QZUAlslv3o5J3pKWaG5zSA8SMesI1QSlnXHp6ocsh
         zNeMlK7BFFyI0WzEbd9zh7oD8r1F+WLF9znPwTJrzWbfmNZHmWJgyDh3tjG8jBQdt2xy
         ZUzrR54jG7Afa5U8qxeQNs5PNSjAicYmcYuTztX4lmnDVh0Z4oi9+xPW58xcA7YoEMrh
         nxgXzqFrYaVOb2RQ7SOy6bjpcx1ic81jJJ93BzToOr75XL6nR0EfHUyLrxBjYAQa/ZG5
         vF1A==
X-Gm-Message-State: AOAM530NGwt/s5nYqhRhOMrJvjQgnTQtcTQ6S1AwHLs+sGyKx0OfJjGj
        0xMa0qcJOZkWPfv9NMQeeR4eH3AK54KP
X-Google-Smtp-Source: ABdhPJyO6+G1NNLekpztDtLp4v2lf7XQ4BBn1PTycPaCeHbJSNnRb9NKPHusbNv9yGG4hMs7VKpqhSmBM23a
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:10:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:adf:a406:: with SMTP id
 d6mr4774378wra.141.1615399083137; Wed, 10 Mar 2021 09:58:03 -0800 (PST)
Date:   Wed, 10 Mar 2021 17:57:21 +0000
In-Reply-To: <20210310175751.3320106-1-qperret@google.com>
Message-Id: <20210310175751.3320106-5-qperret@google.com>
Mime-Version: 1.0
References: <20210310175751.3320106-1-qperret@google.com>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [PATCH v4 04/34] KVM: arm64: Initialize kvm_nvhe_init_params early
From:   Quentin Perret <qperret@google.com>
To:     catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
        james.morse@arm.com, julien.thierry.kdev@gmail.com,
        suzuki.poulose@arm.com
Cc:     android-kvm@google.com, linux-kernel@vger.kernel.org,
        kernel-team@android.com, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org, tabba@google.com,
        mark.rutland@arm.com, dbrazdil@google.com, mate.toth-pal@arm.com,
        seanjc@google.com, qperret@google.com, robh+dt@kernel.org,
        ardb@kernel.org
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
index fc4c95dd2d26..2d1e7ef69c04 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -1383,22 +1383,18 @@ static int kvm_init_vector_slots(void)
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
@@ -1422,7 +1418,7 @@ static void cpu_init_hyp_mode(void)
 	tcr |= (idmap_t0sz & GENMASK(TCR_TxSZ_WIDTH - 1, 0)) << TCR_T0SZ_OFFSET;
 	params->tcr_el2 = tcr;
 
-	params->stack_hyp_va = kern_hyp_va(__this_cpu_read(kvm_arm_hyp_stack_page) + PAGE_SIZE);
+	params->stack_hyp_va = kern_hyp_va(per_cpu(kvm_arm_hyp_stack_page, cpu) + PAGE_SIZE);
 	params->pgd_pa = kvm_mmu_get_httbr();
 
 	/*
@@ -1430,6 +1426,15 @@ static void cpu_init_hyp_mode(void)
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
@@ -1438,6 +1443,7 @@ static void cpu_init_hyp_mode(void)
 	 * cpus_have_const_cap() wrapper.
 	 */
 	BUG_ON(!system_capabilities_finalized());
+	params = this_cpu_ptr_nvhe_sym(kvm_init_params);
 	arm_smccc_1_1_hvc(KVM_HOST_SMCCC_FUNC(__kvm_hyp_init), virt_to_phys(params), &res);
 	WARN_ON(res.a0 != SMCCC_RET_SUCCESS);
 
@@ -1785,19 +1791,19 @@ static int init_hyp_mode(void)
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
2.30.1.766.gb4fecdf3b7-goog

