Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C544F3CD2B6
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 12:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236424AbhGSKHm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 06:07:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236735AbhGSKHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 06:07:23 -0400
Received: from mail-ej1-x649.google.com (mail-ej1-x649.google.com [IPv6:2a00:1450:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B7A3C061574
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 02:55:59 -0700 (PDT)
Received: by mail-ej1-x649.google.com with SMTP id t8-20020a1709063e48b0290501cd965554so5226660eji.8
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 03:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=dNi42ehjO4NUi77Uj+cYvrOU4Ks5G49fj0fQYIq6rpI=;
        b=Zo9CxzDhUX2cZC2KYawro8tC3zo0gCGU9bsbwig5j0S3OAyeSDfj6KLCvhewOJXss3
         ScGYWjjud+BfSjX1bw156hEet1J0T/Zqk+5fp1+CJaOunTaub7sgNqmoVkWv4/0g/rzU
         ZYfZpco3hJ67xUtZI9pTg9Vo5ayKvZcYbWYX32i7f9viXdeSPFpPtsmRiydpflNHKvaZ
         xJX3jC/HH6IpfzQrNolC63LcfYbtbE36mpB0gvl0+eobqmpRV69cepN1WIehO6m5AK3p
         /KS5RCENmYr5NttKLDRGsPdS7odJ5r7HBgi/UC8GW3gSGPXH/MBjxAGstC6Bk+7nxeXY
         xpPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=dNi42ehjO4NUi77Uj+cYvrOU4Ks5G49fj0fQYIq6rpI=;
        b=AJVZPDdLIcZw7ho5UZkg0FDcnrdtms+tKK6EL+Lado376aa9rnw7f8DSy6e2YPSVHe
         IWZj8nlH0x4fCAefYt+w5WruJPKP3UKTaPKFdyDDREeBInSfZ5CW+Pp/mx/nuwXzBTtS
         I7aQVcUeB9c2HlhcUlCN20xL5KczIQAZwlkgRT92x27+kS0tkYli0Yr7tQGnS5+9otCj
         OihoYOMNpCGvJEq95saOhfUsLNE87kU/Hl5uKdzGEyKcqbfmui6FGU8yhQWkkCmkKyBA
         Gjzz2mdciS/aUFWYfbiT6NY3KIU6boKqx/I3u8/IlODc5imfY2fKg2Exa48oWJaHUz4A
         sd+w==
X-Gm-Message-State: AOAM532uDJDZZOwipClPl7HSfcx1LkPvM49wqtC/6BuzLgk0CKTqlL2Q
        C/EfTMhJm40C6oCcu/TV3bOqMBLD7Acg
X-Google-Smtp-Source: ABdhPJyAyrN45gMOAlaStcGcdibOpYIOibhoQ9RmoK/yB/n96peiRQ6P/R0p8ef0yM8amQWGs/batNr68Iti
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:1a96:a43f:6c2e:bb5a])
 (user=qperret job=sendgmr) by 2002:a17:906:d8da:: with SMTP id
 re26mr26655364ejb.205.1626691681533; Mon, 19 Jul 2021 03:48:01 -0700 (PDT)
Date:   Mon, 19 Jul 2021 11:47:30 +0100
In-Reply-To: <20210719104735.3681732-1-qperret@google.com>
Message-Id: <20210719104735.3681732-10-qperret@google.com>
Mime-Version: 1.0
References: <20210719104735.3681732-1-qperret@google.com>
X-Mailer: git-send-email 2.32.0.402.g57bb445576-goog
Subject: [PATCH 09/14] KVM: arm64: Mark host bss and rodata section as shared
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

As the hypervisor maps the host's .bss and .rodata sections in its
stage-1, make sure to tag them as shared in hyp and host page-tables.

But since the hypervisor relies on the presence of these mappings, we
cannot let the host in complete control of the memory regions -- it
must not unshare or donate them to another entity for example. To
prevent this, let's transfer the ownership of those ranges to the
hypervisor itself, and share the page back with the host.

Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/kvm/hyp/include/nvhe/mem_protect.h |  1 +
 arch/arm64/kvm/hyp/nvhe/mem_protect.c         |  7 ++-
 arch/arm64/kvm/hyp/nvhe/setup.c               | 52 ++++++++++++++++---
 3 files changed, 51 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
index 9c227d87c36d..b39047463075 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
@@ -23,6 +23,7 @@ extern struct host_kvm host_kvm;
 int __pkvm_prot_finalize(void);
 int __pkvm_mark_hyp(phys_addr_t start, phys_addr_t end);
 
+int host_stage2_idmap_locked(u64 start, u64 end, enum kvm_pgtable_prot prot);
 int kvm_host_prepare_stage2(void *pgt_pool_base);
 void handle_host_mem_abort(struct kvm_cpu_context *host_ctxt);
 
diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
index cdace80d3e28..6f28edf58407 100644
--- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
+++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
@@ -235,6 +235,11 @@ static bool host_stage2_want_pte_cb(u64 addr, u64 end, enum kvm_pgtable_prot pro
 		return prot != KVM_PGTABLE_PROT_RW;
 }
 
+int host_stage2_idmap_locked(u64 start, u64 end, enum kvm_pgtable_prot prot)
+{
+	return host_stage2_try(__host_stage2_idmap, start, end, prot);
+}
+
 static int host_stage2_idmap(u64 addr)
 {
 	enum kvm_pgtable_prot prot = KVM_PGTABLE_PROT_RW;
@@ -250,7 +255,7 @@ static int host_stage2_idmap(u64 addr)
 	if (ret)
 		goto unlock;
 
-	ret = host_stage2_try(__host_stage2_idmap, range.start, range.end, prot);
+	ret = host_stage2_idmap_locked(range.start, range.end, prot);
 unlock:
 	hyp_spin_unlock(&host_kvm.lock);
 
diff --git a/arch/arm64/kvm/hyp/nvhe/setup.c b/arch/arm64/kvm/hyp/nvhe/setup.c
index 0b574d106519..74dce83a6fad 100644
--- a/arch/arm64/kvm/hyp/nvhe/setup.c
+++ b/arch/arm64/kvm/hyp/nvhe/setup.c
@@ -83,10 +83,6 @@ static int recreate_hyp_mappings(phys_addr_t phys, unsigned long size,
 	if (ret)
 		return ret;
 
-	ret = pkvm_create_mappings(__start_rodata, __end_rodata, PAGE_HYP_RO);
-	if (ret)
-		return ret;
-
 	ret = pkvm_create_mappings(__hyp_rodata_start, __hyp_rodata_end, PAGE_HYP_RO);
 	if (ret)
 		return ret;
@@ -95,10 +91,6 @@ static int recreate_hyp_mappings(phys_addr_t phys, unsigned long size,
 	if (ret)
 		return ret;
 
-	ret = pkvm_create_mappings(__hyp_bss_end, __bss_stop, PAGE_HYP_RO);
-	if (ret)
-		return ret;
-
 	ret = pkvm_create_mappings(virt, virt + size, PAGE_HYP);
 	if (ret)
 		return ret;
@@ -117,6 +109,25 @@ static int recreate_hyp_mappings(phys_addr_t phys, unsigned long size,
 			return ret;
 	}
 
+	/*
+	 * Map the host's .bss and .rodata sections RO in the hypervisor, but
+	 * transfer the ownerhsip from the host to the hypervisor itself to
+	 * make sure it can't be donated or shared with another entity.
+	 *
+	 * The ownership transtion requires matching changes in the host
+	 * stage-2. This will done later (see finalize_mappings()) once the
+	 * hyp_vmemmap is addressable.
+	 */
+	ret = pkvm_create_mappings(__start_rodata, __end_rodata,
+				   PAGE_HYP_RO | KVM_PGTABLE_STATE_SHARED);
+	if (ret)
+		return ret;
+
+	ret = pkvm_create_mappings(__hyp_bss_end, __bss_stop,
+				   PAGE_HYP_RO | KVM_PGTABLE_STATE_SHARED);
+	if (ret)
+		return ret;
+
 	return 0;
 }
 
@@ -148,6 +159,27 @@ static void hpool_put_page(void *addr)
 	hyp_put_page(&hpool, addr);
 }
 
+static int finalize_mappings(void)
+{
+	enum kvm_pgtable_prot prot = KVM_PGTABLE_PROT_RWX;
+	int ret;
+
+	/*
+	 * The host's .bss and .rodata sections are now conceptually owned by
+	 * the hypervisor, so mark them as 'borrowed' in the host stage-2. We
+	 * can safely use host_stage2_idmap_locked() at this point since the
+	 * host stage-2 has not been enabled yet.
+	 */
+	prot |= KVM_PGTABLE_STATE_SHARED | KVM_PGTABLE_STATE_BORROWED;
+	ret = host_stage2_idmap_locked(__hyp_pa(__start_rodata),
+				       __hyp_pa(__end_rodata), prot);
+	if (ret)
+		return ret;
+
+	return host_stage2_idmap_locked(__hyp_pa(__hyp_bss_end),
+					__hyp_pa(__bss_stop), prot);
+}
+
 void __noreturn __pkvm_init_finalise(void)
 {
 	struct kvm_host_data *host_data = this_cpu_ptr(&kvm_host_data);
@@ -167,6 +199,10 @@ void __noreturn __pkvm_init_finalise(void)
 	if (ret)
 		goto out;
 
+	ret = finalize_mappings();
+	if (ret)
+		goto out;
+
 	pkvm_pgtable_mm_ops = (struct kvm_pgtable_mm_ops) {
 		.zalloc_page = hyp_zalloc_hyp_page,
 		.phys_to_virt = hyp_phys_to_virt,
-- 
2.32.0.402.g57bb445576-goog

