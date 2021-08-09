Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35CCA3E48C4
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 17:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235694AbhHIP0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 11:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235707AbhHIPZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 11:25:53 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E560EC0617B9
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 08:25:31 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id h186-20020a37b7c30000b02903b914d9e335so12725120qkf.17
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 08:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=MNGuBytX5NXMQPGh03MXz48l5IrVanSNLiyhXmu6HLc=;
        b=PARTJpvAdy7O5RqWHTAlFxcXu05/69ppZA0ujC1MkD/awV08LT++mW1Ot31gr/o2oE
         L7mInUCVpVyODycSxKTxKYGD7JUtSxBxwDtsTSLz4lX0jlNM2ZmxK+CywSCOB5nMw02q
         yJsSlJNdEe8QcdmwQo5IEqgbCrY9NLZRHKscsVzqrj8H6XZ0z2glBxgii77jHP/IrnNf
         ycRYzjVA6vW1A8kqhst9lDLKuRB3MV7VBWf7GNDsfD6uxVDkw/mErsEmhhp3lPDDd6p1
         8bMcTEPHuzFSiF3VHwnYVS/IR5yd2vUrfefNVmIVJfrlBSdnquN33PGrAdR1ZKp4pfDj
         f1Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=MNGuBytX5NXMQPGh03MXz48l5IrVanSNLiyhXmu6HLc=;
        b=b6NfEvEmkANvULmGCr73Y+U6Ufy9Ft+Ev4fQGocbsbnH7U4G1HiP8SR8c92wiFRMHZ
         oEbka73ZxfqQuiCOxCLWwlXglh7uR4NEMsJVvVLeV3VzPfBkCLhPzIZ+K77lQU1SwKZk
         MBVPh09k+ppDE9TbTvZvWC9A0qaheR8QGHITtlt1tCcZw2m9gGFT1e/jKRaPk1F7Vyfi
         tFq4kZyltv1haoGqIN+02Jhf14PXDkd1TrekSNVL4KsYEJgqcrTEKmaaFqWXpa8MRWVq
         MpyFwF8YJ1s1CSu+rK7mE22sce4nyUklxlZmM46JrHY7eganJoL+lX1LXxlXeGrySfo8
         /RKA==
X-Gm-Message-State: AOAM5313nQOSBdtRvguxBvRmfcyWLI3m8f1E/cX4GLXu4fsomJrFS9i6
        difgT0Isf5+dJXsZr5KYXKBY+OeGay3O
X-Google-Smtp-Source: ABdhPJw4mf35HGX4mhejZnF84rlhADJ8aR2DHNMQwNPUuRpUPyARXjrqqyYC3OYWgsFBlllhXreLHcRP/iXd
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:b0e8:d460:758b:a0ae])
 (user=qperret job=sendgmr) by 2002:a0c:f5c8:: with SMTP id
 q8mr6468132qvm.5.1628522731047; Mon, 09 Aug 2021 08:25:31 -0700 (PDT)
Date:   Mon,  9 Aug 2021 16:24:45 +0100
In-Reply-To: <20210809152448.1810400-1-qperret@google.com>
Message-Id: <20210809152448.1810400-19-qperret@google.com>
Mime-Version: 1.0
References: <20210809152448.1810400-1-qperret@google.com>
X-Mailer: git-send-email 2.32.0.605.g8dce9f2422-goog
Subject: [PATCH v4 18/21] KVM: arm64: Remove __pkvm_mark_hyp
From:   Quentin Perret <qperret@google.com>
To:     maz@kernel.org, james.morse@arm.com, alexandru.elisei@arm.com,
        suzuki.poulose@arm.com, catalin.marinas@arm.com, will@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, ardb@kernel.org, qwandor@google.com,
        tabba@google.com, dbrazdil@google.com, kernel-team@android.com,
        qperret@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we mark memory owned by the hypervisor in the host stage-2
during __pkvm_init(), we no longer need to rely on the host to
explicitly mark the hyp sections later on.

Remove the __pkvm_mark_hyp() hypercall altogether.

Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/include/asm/kvm_asm.h              |  3 +-
 arch/arm64/kvm/arm.c                          | 46 -------------------
 arch/arm64/kvm/hyp/include/nvhe/mem_protect.h |  1 -
 arch/arm64/kvm/hyp/nvhe/hyp-main.c            |  9 ----
 arch/arm64/kvm/hyp/nvhe/mem_protect.c         | 19 --------
 5 files changed, 1 insertion(+), 77 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
index 9f0bf2109be7..432a9ea1f02e 100644
--- a/arch/arm64/include/asm/kvm_asm.h
+++ b/arch/arm64/include/asm/kvm_asm.h
@@ -63,8 +63,7 @@
 #define __KVM_HOST_SMCCC_FUNC___pkvm_create_private_mapping	17
 #define __KVM_HOST_SMCCC_FUNC___pkvm_cpu_set_vector		18
 #define __KVM_HOST_SMCCC_FUNC___pkvm_prot_finalize		19
-#define __KVM_HOST_SMCCC_FUNC___pkvm_mark_hyp			20
-#define __KVM_HOST_SMCCC_FUNC___kvm_adjust_pc			21
+#define __KVM_HOST_SMCCC_FUNC___kvm_adjust_pc			20
 
 #ifndef __ASSEMBLY__
 
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index e9a2b8f27792..2f378482471b 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -1954,57 +1954,11 @@ static void _kvm_host_prot_finalize(void *discard)
 	WARN_ON(kvm_call_hyp_nvhe(__pkvm_prot_finalize));
 }
 
-static inline int pkvm_mark_hyp(phys_addr_t start, phys_addr_t end)
-{
-	return kvm_call_hyp_nvhe(__pkvm_mark_hyp, start, end);
-}
-
-#define pkvm_mark_hyp_section(__section)		\
-	pkvm_mark_hyp(__pa_symbol(__section##_start),	\
-			__pa_symbol(__section##_end))
-
 static int finalize_hyp_mode(void)
 {
-	int cpu, ret;
-
 	if (!is_protected_kvm_enabled())
 		return 0;
 
-	ret = pkvm_mark_hyp_section(__hyp_idmap_text);
-	if (ret)
-		return ret;
-
-	ret = pkvm_mark_hyp_section(__hyp_text);
-	if (ret)
-		return ret;
-
-	ret = pkvm_mark_hyp_section(__hyp_rodata);
-	if (ret)
-		return ret;
-
-	ret = pkvm_mark_hyp_section(__hyp_bss);
-	if (ret)
-		return ret;
-
-	ret = pkvm_mark_hyp(hyp_mem_base, hyp_mem_base + hyp_mem_size);
-	if (ret)
-		return ret;
-
-	for_each_possible_cpu(cpu) {
-		phys_addr_t start = virt_to_phys((void *)kvm_arm_hyp_percpu_base[cpu]);
-		phys_addr_t end = start + (PAGE_SIZE << nvhe_percpu_order());
-
-		ret = pkvm_mark_hyp(start, end);
-		if (ret)
-			return ret;
-
-		start = virt_to_phys((void *)per_cpu(kvm_arm_hyp_stack_page, cpu));
-		end = start + PAGE_SIZE;
-		ret = pkvm_mark_hyp(start, end);
-		if (ret)
-			return ret;
-	}
-
 	/*
 	 * Flip the static key upfront as that may no longer be possible
 	 * once the host stage 2 is installed.
diff --git a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
index 49db0ec5a606..0118527b07b0 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
@@ -49,7 +49,6 @@ extern struct host_kvm host_kvm;
 extern const u8 pkvm_hyp_id;
 
 int __pkvm_prot_finalize(void);
-int __pkvm_mark_hyp(phys_addr_t start, phys_addr_t end);
 
 bool addr_is_memory(phys_addr_t phys);
 int host_stage2_idmap_locked(phys_addr_t addr, u64 size, enum kvm_pgtable_prot prot);
diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-main.c b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
index 1632f001f4ed..7900d5b66ba3 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-main.c
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
@@ -163,14 +163,6 @@ static void handle___pkvm_prot_finalize(struct kvm_cpu_context *host_ctxt)
 {
 	cpu_reg(host_ctxt, 1) = __pkvm_prot_finalize();
 }
-
-static void handle___pkvm_mark_hyp(struct kvm_cpu_context *host_ctxt)
-{
-	DECLARE_REG(phys_addr_t, start, host_ctxt, 1);
-	DECLARE_REG(phys_addr_t, end, host_ctxt, 2);
-
-	cpu_reg(host_ctxt, 1) = __pkvm_mark_hyp(start, end);
-}
 typedef void (*hcall_t)(struct kvm_cpu_context *);
 
 #define HANDLE_FUNC(x)	[__KVM_HOST_SMCCC_FUNC_##x] = (hcall_t)handle_##x
@@ -196,7 +188,6 @@ static const hcall_t host_hcall[] = {
 	HANDLE_FUNC(__pkvm_create_mappings),
 	HANDLE_FUNC(__pkvm_create_private_mapping),
 	HANDLE_FUNC(__pkvm_prot_finalize),
-	HANDLE_FUNC(__pkvm_mark_hyp),
 };
 
 static void handle_host_hcall(struct kvm_cpu_context *host_ctxt)
diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
index cb023d31666e..2991dc6996b9 100644
--- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
+++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
@@ -339,25 +339,6 @@ static int host_stage2_idmap(u64 addr)
 	return ret;
 }
 
-int __pkvm_mark_hyp(phys_addr_t start, phys_addr_t end)
-{
-	int ret;
-
-	/*
-	 * host_stage2_unmap_dev_all() currently relies on MMIO mappings being
-	 * non-persistent, so don't allow changing page ownership in MMIO range.
-	 */
-	if (!range_is_memory(start, end))
-		return -EINVAL;
-
-	hyp_spin_lock(&host_kvm.lock);
-	ret = host_stage2_try(kvm_pgtable_stage2_set_owner, &host_kvm.pgt,
-			      start, end - start, &host_s2_pool, pkvm_hyp_id);
-	hyp_spin_unlock(&host_kvm.lock);
-
-	return ret != -EAGAIN ? ret : 0;
-}
-
 void handle_host_mem_abort(struct kvm_cpu_context *host_ctxt)
 {
 	struct kvm_vcpu_fault_info fault;
-- 
2.32.0.605.g8dce9f2422-goog

