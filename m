Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97A3E4335AC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 14:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235766AbhJSMQG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 08:16:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235648AbhJSMPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 08:15:54 -0400
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A2F7C061774
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 05:13:41 -0700 (PDT)
Received: by mail-wm1-x349.google.com with SMTP id c1-20020a05600c0ac100b00322fcaa2bc7so1075655wmr.4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 05:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=DHnuaOy9p1LD/61fjq4CO1t0/yktzi5R0H6G7O3QKgQ=;
        b=lk3KhNsTMuoV5fphW2OJrEAgxIGGD12sA+tP3VzSZuG0/N9jed9FhMYky4JoMvaFrN
         +x4sMMoqdzzFC43SWfYVVOpAsfikOD+9NnhKBjeye7tX/ZodpmTn/c4ee+4kxccZ51VU
         7va8DyRJN6maWNmNRzWTTREvIK23n/rM0URBAPnlrK0XimQkCduqHwnwewzNrwCLTc8U
         /d2MFLhpRxS6H2KjHdkW96tYBgsNJCHtXcPSgDaHpasRIVddeFfv7qhNkneW+IYJwO5v
         9dWgaGj9LZiK33eYs49Nu3b/ZtrJaznu+sfhEVhtXyx/3MGq2Zqpt9Bl76zcGctcJ6gT
         ycaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=DHnuaOy9p1LD/61fjq4CO1t0/yktzi5R0H6G7O3QKgQ=;
        b=Igw+VZyiAMR3X9bN0yYWmxm5cPI6tMYkwtAevVStj43lE7POuP9UPFosZbgKck1voj
         NM9HkFc8+keIyqMW4iXqTE/mGPAyJreZnUvPKRj4H1QMi2yYDWs5guCfT0q9KOOAsipF
         H1USyA2BN+7neTbndw3Y6AJnWst5UhVcCVa9e7Ju4kBuvp5XlmV9NLTWchp7/IKf+bLI
         mXdF9wlxEGS09EZy0NYiw1VdD7QOV0FiZzbrUvXqQQNYWZ8iK6pL3SpBGqG9X0ufIOcR
         W41ld/Rowg5v9+MghvOIhamRr89trixRLdWRBGetMcuZwb1JF3Bi8exrvSZBrx7pWMDf
         WLpA==
X-Gm-Message-State: AOAM530wwptjj+F1XbEotQAeEVLn4oE/4L8RlGARFlZdbuJMYfmoue6O
        ZBJhEt7naIJhKZWqIxEFGhPSa39C/L2r
X-Google-Smtp-Source: ABdhPJziYoIjlxnulRRJqnFfUHmz1k8SNbs7d5KuqNS+gY2QUofneE5ubXRJhX+TuE7cLXglafWHIUoL6D1m
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:59ca:401f:83a8:de6d])
 (user=qperret job=sendgmr) by 2002:a05:600c:17ca:: with SMTP id
 y10mr5762129wmo.62.1634645619541; Tue, 19 Oct 2021 05:13:39 -0700 (PDT)
Date:   Tue, 19 Oct 2021 13:13:03 +0100
In-Reply-To: <20211019121304.2732332-1-qperret@google.com>
Message-Id: <20211019121304.2732332-15-qperret@google.com>
Mime-Version: 1.0
References: <20211019121304.2732332-1-qperret@google.com>
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [PATCH v2 14/15] KVM: arm64: Expose unshare hypercall to the host
From:   Quentin Perret <qperret@google.com>
To:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Fuad Tabba <tabba@google.com>,
        David Brazdil <dbrazdil@google.com>,
        Andrew Walbran <qwandor@google.com>
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        qperret@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Will Deacon <will@kernel.org>

Introduce an unshare hypercall which can be used to unmap memory from
the hypervisor stage-1 in nVHE protected mode. This will be useful to
update the EL2 ownership state of pages during guest teardown, and
avoids keeping dangling mappings to unreferenced portions of memory.

Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/include/asm/kvm_asm.h              |  1 +
 arch/arm64/kvm/hyp/include/nvhe/mem_protect.h |  1 +
 arch/arm64/kvm/hyp/nvhe/hyp-main.c            |  8 +++++
 arch/arm64/kvm/hyp/nvhe/mem_protect.c         | 33 +++++++++++++++++++
 4 files changed, 43 insertions(+)

diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
index 0167f3702c61..59c55aedb0ae 100644
--- a/arch/arm64/include/asm/kvm_asm.h
+++ b/arch/arm64/include/asm/kvm_asm.h
@@ -63,6 +63,7 @@ enum __kvm_host_smccc_func {
 
 	/* Hypercalls available after pKVM finalisation */
 	__KVM_HOST_SMCCC_FUNC___pkvm_host_share_hyp,
+	__KVM_HOST_SMCCC_FUNC___pkvm_host_unshare_hyp,
 	__KVM_HOST_SMCCC_FUNC___kvm_adjust_pc,
 	__KVM_HOST_SMCCC_FUNC___kvm_vcpu_run,
 	__KVM_HOST_SMCCC_FUNC___kvm_flush_vm_context,
diff --git a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
index 56445586c755..80e99836eac7 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
@@ -55,6 +55,7 @@ extern const u8 pkvm_hyp_id;
 
 int __pkvm_prot_finalize(void);
 int __pkvm_host_share_hyp(u64 pfn);
+int __pkvm_host_unshare_hyp(u64 pfn);
 
 bool addr_is_memory(phys_addr_t phys);
 int host_stage2_idmap_locked(phys_addr_t addr, u64 size, enum kvm_pgtable_prot prot);
diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-main.c b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
index b096bf009144..5e2197db0d32 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-main.c
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
@@ -147,6 +147,13 @@ static void handle___pkvm_host_share_hyp(struct kvm_cpu_context *host_ctxt)
 	cpu_reg(host_ctxt, 1) = __pkvm_host_share_hyp(pfn);
 }
 
+static void handle___pkvm_host_unshare_hyp(struct kvm_cpu_context *host_ctxt)
+{
+	DECLARE_REG(u64, pfn, host_ctxt, 1);
+
+	cpu_reg(host_ctxt, 1) = __pkvm_host_unshare_hyp(pfn);
+}
+
 static void handle___pkvm_create_private_mapping(struct kvm_cpu_context *host_ctxt)
 {
 	DECLARE_REG(phys_addr_t, phys, host_ctxt, 1);
@@ -184,6 +191,7 @@ static const hcall_t host_hcall[] = {
 	HANDLE_FUNC(__pkvm_prot_finalize),
 
 	HANDLE_FUNC(__pkvm_host_share_hyp),
+	HANDLE_FUNC(__pkvm_host_unshare_hyp),
 	HANDLE_FUNC(__kvm_adjust_pc),
 	HANDLE_FUNC(__kvm_vcpu_run),
 	HANDLE_FUNC(__kvm_flush_vm_context),
diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
index 205616c9f107..fc542585a964 100644
--- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
+++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
@@ -757,3 +757,36 @@ int __pkvm_host_share_hyp(u64 pfn)
 
 	return ret;
 }
+
+int __pkvm_host_unshare_hyp(u64 pfn)
+{
+	int ret;
+	u64 host_addr = hyp_pfn_to_phys(pfn);
+	u64 hyp_addr = (u64)__hyp_va(host_addr);
+	struct pkvm_mem_share share = {
+		.tx	= {
+			.nr_pages	= 1,
+			.initiator	= {
+				.id	= PKVM_ID_HOST,
+				.addr	= host_addr,
+				.host	= {
+					.completer_addr = hyp_addr,
+				},
+			},
+			.completer	= {
+				.id	= PKVM_ID_HYP,
+			},
+		},
+		.prot	= PAGE_HYP,
+	};
+
+	host_lock_component();
+	hyp_lock_component();
+
+	ret = do_unshare(&share);
+
+	hyp_unlock_component();
+	host_unlock_component();
+
+	return ret;
+}
-- 
2.33.0.1079.g6e70778dc9-goog

