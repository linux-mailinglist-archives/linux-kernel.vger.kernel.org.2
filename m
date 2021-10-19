Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE57D43359C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 14:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235619AbhJSMPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 08:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235632AbhJSMPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 08:15:37 -0400
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5A46C061768
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 05:13:24 -0700 (PDT)
Received: by mail-wm1-x34a.google.com with SMTP id c5-20020a05600c0ac500b0030dba7cafc9so2492642wmr.5
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 05:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ty9iYiagMI0gH20pET1Xndb3iV+CDb06dji5ebe9K8w=;
        b=SpQpP/yRjdUQxoyHPN7C8cqP88mZaVeLPJ8bNLz3pg1pqcyqLiVJsbc0K2Vjc2jhuQ
         2PGXAA+SI+BFXG8WCVUEkCOMHE+olMIAfl/O7rw9/CpMKQ3ycyZbyiqIcqOGev1xjX0N
         PEgg90LPzx39+XnWldfpg31ucLbcIg1wmtCGmYpSObuVrI1qzD3SzeruVAF1hfcCy/+8
         Ij2iODxEL4liU9qZb81s8tlJZ9rIM548MRcoLUE2LPbZmNK/kzfgWJDQYll1z/vSSj11
         aZZZauk73uQCoiVzVIT69awzlL+qtPyGpzwKXNXuMBJn77bMEeYOM1FBhCrmd0l57ide
         dvEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ty9iYiagMI0gH20pET1Xndb3iV+CDb06dji5ebe9K8w=;
        b=iGVMx8VpbfY8gbSiJYf5vLUVp9n+NIJYj4ZPlUxrgfKueSR8oE2bLBn72emtGtYtcI
         i0BtWgtAYWnP1AZXbdlsDYRYkMiZHCSxkxR6BA0z7Tppi5ffHxR5mgbMPXHuOYU/QL+Q
         VrYsL4Yw4asqc+lJHzZeqFXHzx6meyKcsQ10PcBBURiRUmcfCoo6A68trA5sm4cg1i7P
         UDtp3vzzboCgN44OweJr/WOw1Dn9VljQNwEOqGvXBb17RlaJDHaQtZCg1cNvpMclMdXr
         JvBWv3buFbFNzR4nxzk0cdaKBcXQ2iO7d7lXwBFIW9zp2BOW5bFYXTsfoPO/LN6v4Xfx
         Z8MA==
X-Gm-Message-State: AOAM531VYjjH2VhVYGlleSKYWpio6qiP8lFVXi8NzQ0qhGzBCHBml1Yp
        gc+OVvyNpMHMS7aHaysoSpKwUDvI3+kO
X-Google-Smtp-Source: ABdhPJwYQAu9x65aeAB6QkD0CZV58F2ousV/0NfyOsnnHv4pwVmmNZyY52hWDmpVRmvp0zkLy2sxMRWr0PHi
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:59ca:401f:83a8:de6d])
 (user=qperret job=sendgmr) by 2002:a7b:c442:: with SMTP id
 l2mr5662234wmi.131.1634645603276; Tue, 19 Oct 2021 05:13:23 -0700 (PDT)
Date:   Tue, 19 Oct 2021 13:12:56 +0100
In-Reply-To: <20211019121304.2732332-1-qperret@google.com>
Message-Id: <20211019121304.2732332-8-qperret@google.com>
Mime-Version: 1.0
References: <20211019121304.2732332-1-qperret@google.com>
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [PATCH v2 07/15] KVM: arm64: Introduce kvm_share_hyp()
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

The create_hyp_mappings() function can currently be called at any point
in time. However, its behaviour in protected mode changes widely
depending on when it is being called. Prior to KVM init, it is used to
create the temporary page-table used to bring-up the hypervisor, and
later on it is transparently turned into a 'share' hypercall when the
kernel has lost control over the hypervisor stage-1. In order to prepare
the ground for also unsharing pages with the hypervisor during guest
teardown, introduce a kvm_share_hyp() function to make it clear in which
places a share hypercall should be expected, as we will soon need a
matching unshare hypercall in all those places.

Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/include/asm/kvm_mmu.h |  1 +
 arch/arm64/kvm/arm.c             |  4 ++--
 arch/arm64/kvm/fpsimd.c          |  4 ++--
 arch/arm64/kvm/mmu.c             | 19 +++++++++++++------
 arch/arm64/kvm/reset.c           |  2 +-
 5 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
index 02d378887743..185d0f62b724 100644
--- a/arch/arm64/include/asm/kvm_mmu.h
+++ b/arch/arm64/include/asm/kvm_mmu.h
@@ -150,6 +150,7 @@ static __always_inline unsigned long __kern_hyp_va(unsigned long v)
 #include <asm/kvm_pgtable.h>
 #include <asm/stage2_pgtable.h>
 
+int kvm_share_hyp(void *from, void *to);
 int create_hyp_mappings(void *from, void *to, enum kvm_pgtable_prot prot);
 int create_hyp_io_mappings(phys_addr_t phys_addr, size_t size,
 			   void __iomem **kaddr,
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index e1cc3f8560e7..5312d5a2ef69 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -146,7 +146,7 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 	if (ret)
 		return ret;
 
-	ret = create_hyp_mappings(kvm, kvm + 1, PAGE_HYP);
+	ret = kvm_share_hyp(kvm, kvm + 1);
 	if (ret)
 		goto out_free_stage2_pgd;
 
@@ -343,7 +343,7 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
 	if (err)
 		return err;
 
-	return create_hyp_mappings(vcpu, vcpu + 1, PAGE_HYP);
+	return kvm_share_hyp(vcpu, vcpu + 1);
 }
 
 void kvm_arch_vcpu_postcreate(struct kvm_vcpu *vcpu)
diff --git a/arch/arm64/kvm/fpsimd.c b/arch/arm64/kvm/fpsimd.c
index 62c0d78da7be..2fe1128d9f3d 100644
--- a/arch/arm64/kvm/fpsimd.c
+++ b/arch/arm64/kvm/fpsimd.c
@@ -35,11 +35,11 @@ int kvm_arch_vcpu_run_map_fp(struct kvm_vcpu *vcpu)
 	 * Make sure the host task thread flags and fpsimd state are
 	 * visible to hyp:
 	 */
-	ret = create_hyp_mappings(ti, ti + 1, PAGE_HYP);
+	ret = kvm_share_hyp(ti, ti + 1);
 	if (ret)
 		goto error;
 
-	ret = create_hyp_mappings(fpsimd, fpsimd + 1, PAGE_HYP);
+	ret = kvm_share_hyp(fpsimd, fpsimd + 1);
 	if (ret)
 		goto error;
 
diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index 0019b2309f70..0cc4b295e525 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -299,6 +299,17 @@ static int pkvm_share_hyp(phys_addr_t start, phys_addr_t end)
 	return 0;
 }
 
+int kvm_share_hyp(void *from, void *to)
+{
+	if (is_kernel_in_hyp_mode())
+		return 0;
+
+	if (kvm_host_owns_hyp_mappings())
+		return create_hyp_mappings(from, to, PAGE_HYP);
+
+	return pkvm_share_hyp(kvm_kaddr_to_phys(from), kvm_kaddr_to_phys(to));
+}
+
 /**
  * create_hyp_mappings - duplicate a kernel virtual address range in Hyp mode
  * @from:	The virtual kernel start address of the range
@@ -319,12 +330,8 @@ int create_hyp_mappings(void *from, void *to, enum kvm_pgtable_prot prot)
 	if (is_kernel_in_hyp_mode())
 		return 0;
 
-	if (!kvm_host_owns_hyp_mappings()) {
-		if (WARN_ON(prot != PAGE_HYP))
-			return -EPERM;
-		return pkvm_share_hyp(kvm_kaddr_to_phys(from),
-				      kvm_kaddr_to_phys(to));
-	}
+	if (!kvm_host_owns_hyp_mappings())
+		return -EPERM;
 
 	start = start & PAGE_MASK;
 	end = PAGE_ALIGN(end);
diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
index 59e4c6e819e9..cf781ec9212a 100644
--- a/arch/arm64/kvm/reset.c
+++ b/arch/arm64/kvm/reset.c
@@ -113,7 +113,7 @@ static int kvm_vcpu_finalize_sve(struct kvm_vcpu *vcpu)
 	if (!buf)
 		return -ENOMEM;
 
-	ret = create_hyp_mappings(buf, buf + reg_sz, PAGE_HYP);
+	ret = kvm_share_hyp(buf, buf + reg_sz);
 	if (ret) {
 		kfree(buf);
 		return ret;
-- 
2.33.0.1079.g6e70778dc9-goog

