Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE99B32A83D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 18:38:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1580016AbhCBRVr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 12:21:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1448629AbhCBPH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 10:07:59 -0500
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F10EEC0698D4
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 07:01:19 -0800 (PST)
Received: by mail-wr1-x449.google.com with SMTP id b15so9557945wrm.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 07:01:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=8yMjY9nGGdG3kCURKAswxRcBn78w62ceWoknmifn0Fc=;
        b=wSZRd5YyhLGwCBAFIt3Ga6LuNLgf8Fi8I6omo/pvR9foidKTkYk2IXlyNbnBoJFF34
         KbnndPtsrm7ghrq1Wy+pnLcenm1IcfH2XxjeT4mApWic44zxOx6Uq8kuiHrlXdgJl4Ob
         7kvIFN11fUx/ydfa1rpVa59aYAbnaYJGYgu8EHWbQE8o/aBq0LBE4sk9GsmrJKArwKTm
         B9v13xqdO1QuVwjYSH4t8Co9vDG9yCdw3TgpxYoQOjPkvVUJ6coXDKrHjKWL0v6UXTK4
         qAr08axgDfhr9fJ3I0sIV4a/PFg0+4MF3lvC4K7GocSYm3sV7IWq6xwjI/diP+ESwcs+
         64IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=8yMjY9nGGdG3kCURKAswxRcBn78w62ceWoknmifn0Fc=;
        b=rjJTPGt1ootr+j61000BHHEgJmpm+UzgCoPp15BeARbiiKJdlRW9aa0NmnucCyq9qj
         aZKbJkjSCuBGIKfdAYwTbIwT/0CajoerrWxofjPwaA3c2SEfWKwOk/eVL1upOTPg95cu
         NGSISz/TVQKeTnbuargMA+bKVVxcAoHux+lwMCpW5lIoyoa0bGER4f38ahOzobYtdrsK
         9zYh+MB4FpXXLPnGKXsVlH6FaOsnE706gXpSWiE6e3VptOzcvkRuFDzM2qaZEE3ThahC
         KEUL4Lm41RzvJiULGyhQ/+9ElaxxDEakjN0Xucz4n+rOsnetkvOCtZARDhwAOxYJ45ae
         WFdA==
X-Gm-Message-State: AOAM533R7QNa3MaIT0AK5DWLWeOwPB0gH72WswDymPGHHLyGDaEjLCcg
        6fYlAPKV2yVQgtLKo+racFyKDErSXLaR
X-Google-Smtp-Source: ABdhPJxYQIjUkt2RSBck3HRxMcW3YX2laHG5V0FLpOXHWWygCA8hezD7vfJS55sNzIbZYYijKQfyTK90llcS
Sender: "qperret via sendgmr" <qperret@r2d2-qp.c.googlers.com>
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:adf:f3cc:: with SMTP id
 g12mr13345460wrp.118.1614697278738; Tue, 02 Mar 2021 07:01:18 -0800 (PST)
Date:   Tue,  2 Mar 2021 15:00:02 +0000
In-Reply-To: <20210302150002.3685113-1-qperret@google.com>
Message-Id: <20210302150002.3685113-33-qperret@google.com>
Mime-Version: 1.0
References: <20210302150002.3685113-1-qperret@google.com>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [PATCH v3 32/32] KVM: arm64: Protect the .hyp sections from the host
From:   Quentin Perret <qperret@google.com>
To:     catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
        james.morse@arm.com, julien.thierry.kdev@gmail.com,
        suzuki.poulose@arm.com
Cc:     android-kvm@google.com, linux-kernel@vger.kernel.org,
        kernel-team@android.com, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org, tabba@google.com,
        mark.rutland@arm.com, dbrazdil@google.com, mate.toth-pal@arm.com,
        seanjc@google.com, qperret@google.com, robh+dt@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When KVM runs in nVHE protected mode, use the host stage 2 to unmap the
hypervisor sections. The long-term goal is to ensure the EL2 code can
remain robust regardless of the host's state, so this starts by making
sure the host cannot e.g. write to the .hyp sections directly.

Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/include/asm/kvm_asm.h              |  1 +
 arch/arm64/kvm/arm.c                          | 46 +++++++++++++++++++
 arch/arm64/kvm/hyp/include/nvhe/mem_protect.h |  2 +
 arch/arm64/kvm/hyp/nvhe/hyp-main.c            |  9 ++++
 arch/arm64/kvm/hyp/nvhe/mem_protect.c         | 22 +++++++++
 5 files changed, 80 insertions(+)

diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
index b127af02bd45..9accf5350858 100644
--- a/arch/arm64/include/asm/kvm_asm.h
+++ b/arch/arm64/include/asm/kvm_asm.h
@@ -62,6 +62,7 @@
 #define __KVM_HOST_SMCCC_FUNC___pkvm_create_private_mapping	17
 #define __KVM_HOST_SMCCC_FUNC___pkvm_cpu_set_vector		18
 #define __KVM_HOST_SMCCC_FUNC___pkvm_prot_finalize		19
+#define __KVM_HOST_SMCCC_FUNC___pkvm_host_unmap			20
 
 #ifndef __ASSEMBLY__
 
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index a31c56bc55b3..73c26d206542 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -1894,11 +1894,57 @@ void _kvm_host_prot_finalize(void *discard)
 	WARN_ON(kvm_call_hyp_nvhe(__pkvm_prot_finalize));
 }
 
+static inline int pkvm_host_unmap(phys_addr_t start, phys_addr_t end)
+{
+	return kvm_call_hyp_nvhe(__pkvm_host_unmap, start, end);
+}
+
+#define pkvm_host_unmap_section(__section)		\
+	pkvm_host_unmap(__pa_symbol(__section##_start),	\
+			__pa_symbol(__section##_end))
+
 static int finalize_hyp_mode(void)
 {
+	int cpu, ret;
+
 	if (!is_protected_kvm_enabled())
 		return 0;
 
+	ret = pkvm_host_unmap_section(__hyp_idmap_text);
+	if (ret)
+		return ret;
+
+	ret = pkvm_host_unmap_section(__hyp_text);
+	if (ret)
+		return ret;
+
+	ret = pkvm_host_unmap_section(__hyp_rodata);
+	if (ret)
+		return ret;
+
+	ret = pkvm_host_unmap_section(__hyp_bss);
+	if (ret)
+		return ret;
+
+	ret = pkvm_host_unmap(hyp_mem_base, hyp_mem_base + hyp_mem_size);
+	if (ret)
+		return ret;
+
+	for_each_possible_cpu(cpu) {
+		phys_addr_t start = virt_to_phys((void *)kvm_arm_hyp_percpu_base[cpu]);
+		phys_addr_t end = start + (PAGE_SIZE << nvhe_percpu_order());
+
+		ret = pkvm_host_unmap(start, end);
+		if (ret)
+			return ret;
+
+		start = virt_to_phys((void *)per_cpu(kvm_arm_hyp_stack_page, cpu));
+		end = start + PAGE_SIZE;
+		ret = pkvm_host_unmap(start, end);
+		if (ret)
+			return ret;
+	}
+
 	/*
 	 * Flip the static key upfront as that may no longer be possible
 	 * once the host stage 2 is installed.
diff --git a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
index d293cb328cc4..39890d4f1dc8 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
@@ -21,6 +21,8 @@ struct host_kvm {
 extern struct host_kvm host_kvm;
 
 int __pkvm_prot_finalize(void);
+int __pkvm_host_unmap(phys_addr_t start, phys_addr_t end);
+
 int kvm_host_prepare_stage2(void *mem_pgt_pool, void *dev_pgt_pool);
 void handle_host_mem_abort(struct kvm_cpu_context *host_ctxt);
 
diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-main.c b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
index f47028d3fd0a..2069136fdaec 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-main.c
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
@@ -156,6 +156,14 @@ static void handle___pkvm_prot_finalize(struct kvm_cpu_context *host_ctxt)
 {
 	cpu_reg(host_ctxt, 1) = __pkvm_prot_finalize();
 }
+
+static void handle___pkvm_host_unmap(struct kvm_cpu_context *host_ctxt)
+{
+	DECLARE_REG(phys_addr_t, start, host_ctxt, 1);
+	DECLARE_REG(phys_addr_t, end, host_ctxt, 2);
+
+	cpu_reg(host_ctxt, 1) = __pkvm_host_unmap(start, end);
+}
 typedef void (*hcall_t)(struct kvm_cpu_context *);
 
 #define HANDLE_FUNC(x)	[__KVM_HOST_SMCCC_FUNC_##x] = (hcall_t)handle_##x
@@ -180,6 +188,7 @@ static const hcall_t host_hcall[] = {
 	HANDLE_FUNC(__pkvm_create_mappings),
 	HANDLE_FUNC(__pkvm_create_private_mapping),
 	HANDLE_FUNC(__pkvm_prot_finalize),
+	HANDLE_FUNC(__pkvm_host_unmap),
 };
 
 static void handle_host_hcall(struct kvm_cpu_context *host_ctxt)
diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
index 2252ad1a8945..ed480facdc88 100644
--- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
+++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
@@ -196,6 +196,28 @@ static int host_stage2_idmap(u64 addr)
 	return ret;
 }
 
+int __pkvm_host_unmap(phys_addr_t start, phys_addr_t end)
+{
+	struct kvm_mem_range r1, r2;
+	int ret;
+
+	/*
+	 * host_stage2_unmap_dev_all() currently relies on MMIO mappings being
+	 * non-persistent, so don't allow PROT_NONE in MMIO range.
+	 */
+	if (!find_mem_range(start, &r1) || !find_mem_range(end, &r2))
+		return -EINVAL;
+	if (r1.start != r2.start)
+		return -EINVAL;
+
+	hyp_spin_lock(&host_kvm.lock);
+	ret = kvm_pgtable_stage2_map(&host_kvm.pgt, start, end - start, start,
+				     KVM_PGTABLE_PROT_NONE, &host_s2_mem);
+	hyp_spin_unlock(&host_kvm.lock);
+
+	return ret;
+}
+
 void handle_host_mem_abort(struct kvm_cpu_context *host_ctxt)
 {
 	struct kvm_vcpu_fault_info fault;
-- 
2.30.1.766.gb4fecdf3b7-goog

