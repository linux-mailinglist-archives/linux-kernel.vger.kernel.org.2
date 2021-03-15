Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2B6333BEFC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 15:53:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240754AbhCOOwc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 10:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237280AbhCOOg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 10:36:56 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75479C06175F
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 07:36:55 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id p10so3904883qtq.12
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 07:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=i0pLkG5D+F/F8NLhPr732x6o4ZuvHSJGtxcjfsnUkkI=;
        b=V7FRiuBpJbUMsuex0c2ZWimyp0ene/rbr23CTbU1urXbg2Hh0b4JxAyJLHHbZh/Gff
         zqdIqIOof7ISMpQKZIcz9lp6G89xsCiWI3u2Lzc9zjC9YudrOLkMy+hudXgboaucp3Rw
         guKSfOTEy0p9sFUhKcGRqVLuLqwUXj13YvFJbloRtPiFGP+6pvpJzkftjkFxnEmVdbC3
         El81xB6NJv2o65NhMYI50VSQXwMRPV8D4t7u2l/UzS8lKYxiQfQimE9lrGLz3r5p90K8
         +jcIhzUgIOq4E05+pRNAjb44Um3Wo+i0fvGsqaKPn2z0xqhaRxoxasWmjM1BF0dPbtRp
         dVMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=i0pLkG5D+F/F8NLhPr732x6o4ZuvHSJGtxcjfsnUkkI=;
        b=KuQq8gQuCgErxtB9/lSVY2GsU4rDhXikSp6NbvXbLr52nd1F5nzmEJ61GZ03HUSF5b
         2lq4GekGUkm46rIWE1ZUf5m9XQo88zm//kzIV4gKenVWK5ZParbXjzun59Vdv7A26mjC
         U2Wotyn0VPnwiLHVD67w/lnGO5AFiADXN61toKkGxsWMJ6nUYQXZD1zlVv3t7akbtL6t
         Lxyuh9aHg6Ieo1grsY/HmMfzMrdevzpbrKeRYv5ZU7y/cilzJKiz+suZQ0y9/Y4Xlwji
         gOAcIj1uiamKGhAxNljqTqR4ehDtX4LRLXDdXFuN6ETJzjxZML3IWftGXBGFvPeOLsfs
         Cs4w==
X-Gm-Message-State: AOAM533sus9BPLQno44Qc3a8dbxqMYh3qNTQIT7Xun2TRwZz5EvQyIFg
        7k5t47fvRVCe58cbsm7koCf94caGJoz0
X-Google-Smtp-Source: ABdhPJxBBU9Q4YWIvBN8TXm5P1z20Ra6UfQrNb0a8Teo3r4QLY8IEN2hz9G+vQrUHVvOVXQwfmapmOsD44nA
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:10:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:ad4:5144:: with SMTP id
 g4mr25104876qvq.26.1615819014645; Mon, 15 Mar 2021 07:36:54 -0700 (PDT)
Date:   Mon, 15 Mar 2021 14:35:36 +0000
In-Reply-To: <20210315143536.214621-1-qperret@google.com>
Message-Id: <20210315143536.214621-37-qperret@google.com>
Mime-Version: 1.0
References: <20210315143536.214621-1-qperret@google.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH v5 36/36] KVM: arm64: Protect the .hyp sections from the host
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

When KVM runs in nVHE protected mode, use the host stage 2 to unmap the
hypervisor sections by marking them as owned by the hypervisor itself.
The long-term goal is to ensure the EL2 code can remain robust
regardless of the host's state, so this starts by making sure the host
cannot e.g. write to the .hyp sections directly.

Acked-by: Will Deacon <will@kernel.org>
Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/include/asm/kvm_asm.h              |  1 +
 arch/arm64/kvm/arm.c                          | 46 +++++++++++++++++++
 arch/arm64/kvm/hyp/include/nvhe/mem_protect.h |  2 +
 arch/arm64/kvm/hyp/nvhe/hyp-main.c            |  9 ++++
 arch/arm64/kvm/hyp/nvhe/mem_protect.c         | 33 +++++++++++++
 5 files changed, 91 insertions(+)

diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
index b127af02bd45..d468c4b37190 100644
--- a/arch/arm64/include/asm/kvm_asm.h
+++ b/arch/arm64/include/asm/kvm_asm.h
@@ -62,6 +62,7 @@
 #define __KVM_HOST_SMCCC_FUNC___pkvm_create_private_mapping	17
 #define __KVM_HOST_SMCCC_FUNC___pkvm_cpu_set_vector		18
 #define __KVM_HOST_SMCCC_FUNC___pkvm_prot_finalize		19
+#define __KVM_HOST_SMCCC_FUNC___pkvm_mark_hyp			20
 
 #ifndef __ASSEMBLY__
 
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 7e6a81079652..d6baf76d4747 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -1894,11 +1894,57 @@ void _kvm_host_prot_finalize(void *discard)
 	WARN_ON(kvm_call_hyp_nvhe(__pkvm_prot_finalize));
 }
 
+static inline int pkvm_mark_hyp(phys_addr_t start, phys_addr_t end)
+{
+	return kvm_call_hyp_nvhe(__pkvm_mark_hyp, start, end);
+}
+
+#define pkvm_mark_hyp_section(__section)		\
+	pkvm_mark_hyp(__pa_symbol(__section##_start),	\
+			__pa_symbol(__section##_end))
+
 static int finalize_hyp_mode(void)
 {
+	int cpu, ret;
+
 	if (!is_protected_kvm_enabled())
 		return 0;
 
+	ret = pkvm_mark_hyp_section(__hyp_idmap_text);
+	if (ret)
+		return ret;
+
+	ret = pkvm_mark_hyp_section(__hyp_text);
+	if (ret)
+		return ret;
+
+	ret = pkvm_mark_hyp_section(__hyp_rodata);
+	if (ret)
+		return ret;
+
+	ret = pkvm_mark_hyp_section(__hyp_bss);
+	if (ret)
+		return ret;
+
+	ret = pkvm_mark_hyp(hyp_mem_base, hyp_mem_base + hyp_mem_size);
+	if (ret)
+		return ret;
+
+	for_each_possible_cpu(cpu) {
+		phys_addr_t start = virt_to_phys((void *)kvm_arm_hyp_percpu_base[cpu]);
+		phys_addr_t end = start + (PAGE_SIZE << nvhe_percpu_order());
+
+		ret = pkvm_mark_hyp(start, end);
+		if (ret)
+			return ret;
+
+		start = virt_to_phys((void *)per_cpu(kvm_arm_hyp_stack_page, cpu));
+		end = start + PAGE_SIZE;
+		ret = pkvm_mark_hyp(start, end);
+		if (ret)
+			return ret;
+	}
+
 	/*
 	 * Flip the static key upfront as that may no longer be possible
 	 * once the host stage 2 is installed.
diff --git a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
index d293cb328cc4..42d81ec739fa 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
@@ -21,6 +21,8 @@ struct host_kvm {
 extern struct host_kvm host_kvm;
 
 int __pkvm_prot_finalize(void);
+int __pkvm_mark_hyp(phys_addr_t start, phys_addr_t end);
+
 int kvm_host_prepare_stage2(void *mem_pgt_pool, void *dev_pgt_pool);
 void handle_host_mem_abort(struct kvm_cpu_context *host_ctxt);
 
diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-main.c b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
index f47028d3fd0a..3df33d4de4a1 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-main.c
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
@@ -156,6 +156,14 @@ static void handle___pkvm_prot_finalize(struct kvm_cpu_context *host_ctxt)
 {
 	cpu_reg(host_ctxt, 1) = __pkvm_prot_finalize();
 }
+
+static void handle___pkvm_mark_hyp(struct kvm_cpu_context *host_ctxt)
+{
+	DECLARE_REG(phys_addr_t, start, host_ctxt, 1);
+	DECLARE_REG(phys_addr_t, end, host_ctxt, 2);
+
+	cpu_reg(host_ctxt, 1) = __pkvm_mark_hyp(start, end);
+}
 typedef void (*hcall_t)(struct kvm_cpu_context *);
 
 #define HANDLE_FUNC(x)	[__KVM_HOST_SMCCC_FUNC_##x] = (hcall_t)handle_##x
@@ -180,6 +188,7 @@ static const hcall_t host_hcall[] = {
 	HANDLE_FUNC(__pkvm_create_mappings),
 	HANDLE_FUNC(__pkvm_create_private_mapping),
 	HANDLE_FUNC(__pkvm_prot_finalize),
+	HANDLE_FUNC(__pkvm_mark_hyp),
 };
 
 static void handle_host_hcall(struct kvm_cpu_context *host_ctxt)
diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
index 5c88a325e6fc..dd03252b9574 100644
--- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
+++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
@@ -25,6 +25,8 @@ struct host_kvm host_kvm;
 struct hyp_pool host_s2_mem;
 struct hyp_pool host_s2_dev;
 
+static const u8 pkvm_hyp_id = 1;
+
 static void *host_s2_zalloc_pages_exact(size_t size)
 {
 	return hyp_alloc_pages(&host_s2_mem, get_order(size));
@@ -182,6 +184,18 @@ static bool find_mem_range(phys_addr_t addr, struct kvm_mem_range *range)
 	return false;
 }
 
+static bool range_is_memory(u64 start, u64 end)
+{
+	struct kvm_mem_range r1, r2;
+
+	if (!find_mem_range(start, &r1) || !find_mem_range(end, &r2))
+		return false;
+	if (r1.start != r2.start)
+		return false;
+
+	return true;
+}
+
 static inline int __host_stage2_idmap(u64 start, u64 end,
 				      enum kvm_pgtable_prot prot,
 				      struct hyp_pool *pool)
@@ -229,6 +243,25 @@ static int host_stage2_idmap(u64 addr)
 	return ret;
 }
 
+int __pkvm_mark_hyp(phys_addr_t start, phys_addr_t end)
+{
+	int ret;
+
+	/*
+	 * host_stage2_unmap_dev_all() currently relies on MMIO mappings being
+	 * non-persistent, so don't allow changing page ownership in MMIO range.
+	 */
+	if (!range_is_memory(start, end))
+		return -EINVAL;
+
+	hyp_spin_lock(&host_kvm.lock);
+	ret = kvm_pgtable_stage2_set_owner(&host_kvm.pgt, start, end - start,
+					   &host_s2_mem, pkvm_hyp_id);
+	hyp_spin_unlock(&host_kvm.lock);
+
+	return ret != -EAGAIN ? ret : 0;
+}
+
 void handle_host_mem_abort(struct kvm_cpu_context *host_ctxt)
 {
 	struct kvm_vcpu_fault_info fault;
-- 
2.31.0.rc2.261.g7f71774620-goog

