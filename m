Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAC803DA449
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 15:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237853AbhG2N3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 09:29:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237824AbhG2N3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 09:29:08 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC17FC06179E
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 06:29:04 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id m15-20020a0cbf0f0000b02902e60d75210eso3857158qvi.19
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 06:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=A6q+k/2f/nOWcbFbtJvlk6wu0j4PPp7j4DV+/ij7+Zw=;
        b=U+oEmrVLnRO5V5rONRO0VKkB4yMJ0XwNC+Wadxfk9wVCif0pHoVVmUyACeRqDl5cT8
         iQtuPQbYUIUYzlz/k/h7LrQi6rNfsMDLFZDTD7w1BxGSkHw2M2YPTBdizP8VYY8URChE
         GdIKsr9cTjF9zrFWvoVXioJeyRFqpLWSjXwOIfqsXN6g22j11Xpdy/Rtrec4jMivVFFx
         T9Xg2/+/lnugsqkF2REruk8Zj1inz37KO5rKfbqRo0dfJDJnCc4nWiugczgDYzxcRI6o
         an4yLEw/JNRfUQDFYtsJ3a0nLfJ3RJ5LuT6H38+qCUbAS9I53lQV+mIA26I33QdTRd9j
         asrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=A6q+k/2f/nOWcbFbtJvlk6wu0j4PPp7j4DV+/ij7+Zw=;
        b=oT0BKsb8nNhv7B1Bo67rsq1c/mkUof4Vcg7c/bbyREKqKzraT/6HjQuTuRGcLTwfq3
         y4jE4tNsg38oG2BQy0qr2PJr2AtVJ0i20S+RDxR0o9sTCL+1XkdaLMgaSSmCYFIcp+Tt
         2/yPeGCKC8Tpf/7k8dkKuLUf0MsNdUb2JbGSlG5Ks58+LB6Mp63+c8iGYWpy9w+ettZr
         kSKi2nm9PJZMRWplmU7HCOZhtC2XeEHAxItUVR7UORFhhmRoLh/DB3WfTsoPRZ2KAGTu
         2XmXPdTtJy8mAOdlaXUPZD+77iD3m2LsnGvdGH19NamJqubUmmA1Rsrsd3YLKeK7v3xB
         fXZA==
X-Gm-Message-State: AOAM533ytANonMnde/48upE6EvpXQKAtRZKtN8m7mw0OVYITzS/0BR8f
        3XkW9VTmsaHrQSaqZfRXmgf0d9zYH0qd
X-Google-Smtp-Source: ABdhPJwMN8hM+c5sxer4Dc5eWhx+y84XlkDTVvbjFRmJISZp4KIimDXCzxS3TTTTLggakeATNucSln2y70gM
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:293a:bc89:7514:5218])
 (user=qperret job=sendgmr) by 2002:a05:6214:d1:: with SMTP id
 f17mr5275922qvs.12.1627565343999; Thu, 29 Jul 2021 06:29:03 -0700 (PDT)
Date:   Thu, 29 Jul 2021 14:28:15 +0100
In-Reply-To: <20210729132818.4091769-1-qperret@google.com>
Message-Id: <20210729132818.4091769-19-qperret@google.com>
Mime-Version: 1.0
References: <20210729132818.4091769-1-qperret@google.com>
X-Mailer: git-send-email 2.32.0.432.gabb21c7263-goog
Subject: [PATCH v3 18/21] KVM: arm64: Remove __pkvm_mark_hyp
From:   Quentin Perret <qperret@google.com>
To:     maz@kernel.org, james.morse@arm.com, alexandru.elisei@arm.com,
        suzuki.poulose@arm.com, catalin.marinas@arm.com, will@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, ardb@kernel.org, qwandor@google.com,
        tabba@google.com, dbrazdil@google.com, kernel-team@android.com,
        Quentin Perret <qperret@google.com>
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
index 5968fbbb3514..7ce36fbf5158 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
@@ -49,7 +49,6 @@ extern struct host_kvm host_kvm;
 extern const u8 pkvm_hyp_id;
 
 int __pkvm_prot_finalize(void);
-int __pkvm_mark_hyp(phys_addr_t start, phys_addr_t end);
 
 bool addr_is_memory(phys_addr_t phys);
 int host_stage2_idmap_locked(u64 start, u64 end, enum kvm_pgtable_prot prot);
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
index 4532f3d55a1a..0ccea58df7e0 100644
--- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
+++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
@@ -338,25 +338,6 @@ static int host_stage2_idmap(u64 addr)
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
2.32.0.432.gabb21c7263-goog

