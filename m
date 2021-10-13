Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A83442C58F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 18:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237732AbhJMQBh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 12:01:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237406AbhJMQBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 12:01:15 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8C99C061770
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 08:59:11 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id gs5-20020a056214226500b00382f5609124so2982348qvb.8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 08:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=NDD02US5GbETqBBkcvp2ltSMD53RfkXvi4Mxnfbxyc8=;
        b=T1qbVsJ5h8QTAp1/7WrxvMrgG72eD1aSQQj1BSMPYB1Kenh6Hklh6K8yCZTmndDK42
         u4Y6NVa014WhwUgqqD9CmbygSYVNBaZkM0MN8g7UYT0kUTHH54kjhCEurh3xoN5qYwBo
         ddSTtlaIarhctUtcmQkgKfG1Z9B5fnVxEdlhSrzQjhoOayqJ5st7VQycchZ+5+1bRDiN
         kqcD6cdKLI0G2Cohd+EKqWaBlTYO6NH7oR9jYBU6u0mp5nvRhRsQqIvt2zveBAGm2gW3
         sz7jZ5lZd0cOcFiIBkGj8S5gYYRVvaB97+qO8VnlH+n3idlF4gkw+ygzF2gJ+kyVQItQ
         0ceQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=NDD02US5GbETqBBkcvp2ltSMD53RfkXvi4Mxnfbxyc8=;
        b=O6hUwSy7hocV9exZtFs4HLF5hAWOI3QR4nohEP1WlKP7a2L+XnCuAVVhGIbgycdIrT
         mR+1KRvM1UfVrk073AtPhjPW9ewFdiq6ef2iw5/kg26YGsHlkVg4zVVfC/seeoFS2Qt4
         xPU9a+99aaa6DsJ4Z8QYEeWP7iCelec9ysumXV11Vm1bliqCiIQ8LsjTNTWR44SjW8k+
         Rc4BzhWJRNApunivFmGGxGzskjbIeNJzcfcYJYZVK1zcJkszDsMZ1Fvqo3hHXQOhj/+t
         aiJ9T6HLntGxmZYQmMn+1l0rjgJlPPTqh4aMWJFpYcnn+O4Ug4YOzSv+vGp6E4Vsa9fa
         2JIg==
X-Gm-Message-State: AOAM530FDUjuBBvdd82yQfM3MZdLzZ9Y3eN0KBe+pCyG9kzAq+Ed3bms
        RfUhCqzEnIJUOq+6XWhtIA9xrzwz3W+U
X-Google-Smtp-Source: ABdhPJy+Hh/3VJIHIRnHcU5zrl6PnoHx6rKK0wdWdMKIvuGmVj2OaF9KH+F7ChEdi48qABlrMpoZp8hwR7HW
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:65b5:73d3:1558:b9ae])
 (user=qperret job=sendgmr) by 2002:a05:622a:118b:: with SMTP id
 m11mr81305qtk.67.1634140750968; Wed, 13 Oct 2021 08:59:10 -0700 (PDT)
Date:   Wed, 13 Oct 2021 16:58:31 +0100
In-Reply-To: <20211013155831.943476-1-qperret@google.com>
Message-Id: <20211013155831.943476-17-qperret@google.com>
Mime-Version: 1.0
References: <20211013155831.943476-1-qperret@google.com>
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
Subject: [PATCH 16/16] KVM: arm64: pkvm: Unshare guest structs during teardown
From:   Quentin Perret <qperret@google.com>
To:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Fuad Tabba <tabba@google.com>,
        David Brazdil <dbrazdil@google.com>
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make use of the newly introduced unshare hypercall during guest teardown
to unmap guest-related data structures from the hyp stage-1.

Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/include/asm/kvm_host.h |  2 ++
 arch/arm64/include/asm/kvm_mmu.h  |  1 +
 arch/arm64/kvm/arm.c              |  2 ++
 arch/arm64/kvm/fpsimd.c           | 10 ++++++++--
 arch/arm64/kvm/mmu.c              | 16 ++++++++++++++++
 arch/arm64/kvm/reset.c            | 13 ++++++++++++-
 6 files changed, 41 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index f8be56d5342b..8b61cdcd1b29 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -322,6 +322,8 @@ struct kvm_vcpu_arch {
 
 	struct thread_info *host_thread_info;	/* hyp VA */
 	struct user_fpsimd_state *host_fpsimd_state;	/* hyp VA */
+	struct thread_info *kern_thread_info;
+	struct user_fpsimd_state *kern_fpsimd_state;
 
 	struct {
 		/* {Break,watch}point registers */
diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
index 185d0f62b724..81839e9a8a24 100644
--- a/arch/arm64/include/asm/kvm_mmu.h
+++ b/arch/arm64/include/asm/kvm_mmu.h
@@ -151,6 +151,7 @@ static __always_inline unsigned long __kern_hyp_va(unsigned long v)
 #include <asm/stage2_pgtable.h>
 
 int kvm_share_hyp(void *from, void *to);
+void kvm_unshare_hyp(void *from, void *to);
 int create_hyp_mappings(void *from, void *to, enum kvm_pgtable_prot prot);
 int create_hyp_io_mappings(phys_addr_t phys_addr, size_t size,
 			   void __iomem **kaddr,
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index f2e74635332b..f11c51db6fe6 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -188,6 +188,8 @@ void kvm_arch_destroy_vm(struct kvm *kvm)
 		}
 	}
 	atomic_set(&kvm->online_vcpus, 0);
+
+	kvm_unshare_hyp(kvm, kvm + 1);
 }
 
 int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
diff --git a/arch/arm64/kvm/fpsimd.c b/arch/arm64/kvm/fpsimd.c
index 2fe1128d9f3d..67059daf4d26 100644
--- a/arch/arm64/kvm/fpsimd.c
+++ b/arch/arm64/kvm/fpsimd.c
@@ -28,23 +28,29 @@ int kvm_arch_vcpu_run_map_fp(struct kvm_vcpu *vcpu)
 {
 	int ret;
 
-	struct thread_info *ti = &current->thread_info;
-	struct user_fpsimd_state *fpsimd = &current->thread.uw.fpsimd_state;
+	struct thread_info *ti = vcpu->arch.kern_thread_info;
+	struct user_fpsimd_state *fpsimd = vcpu->arch.kern_fpsimd_state;
 
 	/*
 	 * Make sure the host task thread flags and fpsimd state are
 	 * visible to hyp:
 	 */
+	kvm_unshare_hyp(ti, ti + 1);
+	ti = &current->thread_info;
 	ret = kvm_share_hyp(ti, ti + 1);
 	if (ret)
 		goto error;
 
+	kvm_unshare_hyp(fpsimd, fpsimd + 1);
+	fpsimd = &current->thread.uw.fpsimd_state;
 	ret = kvm_share_hyp(fpsimd, fpsimd + 1);
 	if (ret)
 		goto error;
 
 	vcpu->arch.host_thread_info = kern_hyp_va(ti);
 	vcpu->arch.host_fpsimd_state = kern_hyp_va(fpsimd);
+	vcpu->arch.kern_thread_info = ti;
+	vcpu->arch.kern_fpsimd_state = fpsimd;
 error:
 	return ret;
 }
diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index bc9865a8c988..f01b0e49e262 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -300,6 +300,22 @@ int kvm_share_hyp(void *from, void *to)
 				 nr_pages);
 }
 
+void kvm_unshare_hyp(void *from, void *to)
+{
+	phys_addr_t start, end;
+	u64 nr_pages;
+
+	if (is_kernel_in_hyp_mode() || kvm_host_owns_hyp_mappings() || !from)
+		return;
+
+	start = ALIGN_DOWN(kvm_kaddr_to_phys(from), PAGE_SIZE);
+	end = PAGE_ALIGN(kvm_kaddr_to_phys(to));
+	nr_pages = (end - start) >> PAGE_SHIFT;
+
+	WARN_ON(kvm_call_hyp_nvhe(__pkvm_host_unshare_hyp, __phys_to_pfn(start),
+				  nr_pages));
+}
+
 /**
  * create_hyp_mappings - duplicate a kernel virtual address range in Hyp mode
  * @from:	The virtual kernel start address of the range
diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
index 5ce36b0a3343..e3e9c9e1f1c8 100644
--- a/arch/arm64/kvm/reset.c
+++ b/arch/arm64/kvm/reset.c
@@ -141,7 +141,18 @@ bool kvm_arm_vcpu_is_finalized(struct kvm_vcpu *vcpu)
 
 void kvm_arm_vcpu_destroy(struct kvm_vcpu *vcpu)
 {
-	kfree(vcpu->arch.sve_state);
+	struct user_fpsimd_state *fpsimd = vcpu->arch.kern_fpsimd_state;
+	struct thread_info *ti = vcpu->arch.kern_thread_info;
+	void *sve_state = vcpu->arch.sve_state;
+
+	kvm_unshare_hyp(vcpu, vcpu + 1);
+	if (ti)
+		kvm_unshare_hyp(ti, ti + 1);
+	if (fpsimd)
+		kvm_unshare_hyp(fpsimd, fpsimd + 1);
+	if (sve_state && vcpu->arch.has_run_once)
+		kvm_unshare_hyp(sve_state, sve_state + vcpu_sve_state_size(vcpu));
+	kfree(sve_state);
 }
 
 static void kvm_vcpu_reset_sve(struct kvm_vcpu *vcpu)
-- 
2.33.0.882.g93a45727a2-goog

