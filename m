Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFE453E48C8
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 17:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235753AbhHIP0X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 11:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235736AbhHIP0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 11:26:05 -0400
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0C16C0617BA
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 08:25:34 -0700 (PDT)
Received: by mail-wm1-x349.google.com with SMTP id g187-20020a1c20c40000b02902458d430db6so4129285wmg.9
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 08:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=0vnFX0HCkFp8ZLTU0btBJYZAdzWXKCWbI3FuYOfCODA=;
        b=edLLNeSUJUuSeZh6U5LgHuiFbQdxbqRKi/NQ1RSRnsUEn2S/8ryLev1RWgMSfDbltm
         Om9IrwxtxrsFpwCskBaMEJ7xBMB6hChrlzhzMzZ2whQvKh0X0/PsQAyhN2UbcMabEKhJ
         kFITxof5dzgHb27rpT/TUwsw9eujgADfYDSuydpjHXLWRa3f3mUrl1r2tJHF5HcYrnXM
         ZVct81ad5/jrKV4yq33XFH/l0LAM02qWUJwCBxnaoSuNVHOUDowrr9GS0w/R/KbWvIzV
         XsiLCk2wB36vg/uxYgid0GyY+bEKFJ/s794tI7nnae4HsUsaHCOpJbS240pLizQYB85F
         EWrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=0vnFX0HCkFp8ZLTU0btBJYZAdzWXKCWbI3FuYOfCODA=;
        b=pmCnuqJ7120D3PAyv34GZlIO2zs1GfbFGwG2Jfb1KNdIvQVaHMmsCToqpcbOIMxBHP
         IJetsgM7jlaIULjttB8rGlTUpVcOuArkwt0MpFuE6+xcchiNwQF3bSE/356HsHcQjR1J
         t1wfvUeCa2/vDykoXfXUVQHiP0QhPm0DjP4gn4TW2BtLDWBKyc8qD9Ylwlz4sBM+DuNE
         vRHl8eKi7nsqG/1gei9KJhNksSjkleed2yORzSE6neBQB7uvbFeVKq8K0AaFWVAReXpc
         mJvleEa6zgPaA4eWx/pz8pz/oAIgjDIU9fc51hbbDLfBTyi+nJKlko4U/AMb/wi3TOd7
         Mzsw==
X-Gm-Message-State: AOAM530/LZqD6g4RxvLa1ts4U3onD3NQFP3MUwCxFfsmXyXKi9aZmVGU
        A6zx3WP1T+Eq1o+eL3MhKIKJTG0JUr5i
X-Google-Smtp-Source: ABdhPJyIOtnzxP4S0R25oU2iubMhTBhg+aNqUgDs+Hxip8y4Nj2Lxx59WuSTFwfisX1gdgavPWTXBcPgInrK
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:b0e8:d460:758b:a0ae])
 (user=qperret job=sendgmr) by 2002:a7b:cb99:: with SMTP id
 m25mr33616400wmi.90.1628522733253; Mon, 09 Aug 2021 08:25:33 -0700 (PDT)
Date:   Mon,  9 Aug 2021 16:24:46 +0100
In-Reply-To: <20210809152448.1810400-1-qperret@google.com>
Message-Id: <20210809152448.1810400-20-qperret@google.com>
Mime-Version: 1.0
References: <20210809152448.1810400-1-qperret@google.com>
X-Mailer: git-send-email 2.32.0.605.g8dce9f2422-goog
Subject: [PATCH v4 19/21] KVM: arm64: Refactor protected nVHE stage-1 locking
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

Refactor the hypervisor stage-1 locking in nVHE protected mode to expose
a new pkvm_create_mappings_locked() function. This will be used in later
patches to allow walking and changing the hypervisor stage-1 without
releasing the lock.

Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/kvm/hyp/include/nvhe/mm.h |  1 +
 arch/arm64/kvm/hyp/nvhe/mm.c         | 18 ++++++++++++++++--
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/hyp/include/nvhe/mm.h b/arch/arm64/kvm/hyp/include/nvhe/mm.h
index 8ec3a5a7744b..c76d7136ed9b 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/mm.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/mm.h
@@ -23,6 +23,7 @@ int hyp_map_vectors(void);
 int hyp_back_vmemmap(phys_addr_t phys, unsigned long size, phys_addr_t back);
 int pkvm_cpu_set_vector(enum arm64_hyp_spectre_vector slot);
 int pkvm_create_mappings(void *from, void *to, enum kvm_pgtable_prot prot);
+int pkvm_create_mappings_locked(void *from, void *to, enum kvm_pgtable_prot prot);
 int __pkvm_create_mappings(unsigned long start, unsigned long size,
 			   unsigned long phys, enum kvm_pgtable_prot prot);
 unsigned long __pkvm_create_private_mapping(phys_addr_t phys, size_t size,
diff --git a/arch/arm64/kvm/hyp/nvhe/mm.c b/arch/arm64/kvm/hyp/nvhe/mm.c
index a8efdf0f9003..6fbe8e8030f6 100644
--- a/arch/arm64/kvm/hyp/nvhe/mm.c
+++ b/arch/arm64/kvm/hyp/nvhe/mm.c
@@ -67,13 +67,15 @@ unsigned long __pkvm_create_private_mapping(phys_addr_t phys, size_t size,
 	return addr;
 }
 
-int pkvm_create_mappings(void *from, void *to, enum kvm_pgtable_prot prot)
+int pkvm_create_mappings_locked(void *from, void *to, enum kvm_pgtable_prot prot)
 {
 	unsigned long start = (unsigned long)from;
 	unsigned long end = (unsigned long)to;
 	unsigned long virt_addr;
 	phys_addr_t phys;
 
+	hyp_assert_lock_held(&pkvm_pgd_lock);
+
 	start = start & PAGE_MASK;
 	end = PAGE_ALIGN(end);
 
@@ -81,7 +83,8 @@ int pkvm_create_mappings(void *from, void *to, enum kvm_pgtable_prot prot)
 		int err;
 
 		phys = hyp_virt_to_phys((void *)virt_addr);
-		err = __pkvm_create_mappings(virt_addr, PAGE_SIZE, phys, prot);
+		err = kvm_pgtable_hyp_map(&pkvm_pgtable, virt_addr, PAGE_SIZE,
+					  phys, prot);
 		if (err)
 			return err;
 	}
@@ -89,6 +92,17 @@ int pkvm_create_mappings(void *from, void *to, enum kvm_pgtable_prot prot)
 	return 0;
 }
 
+int pkvm_create_mappings(void *from, void *to, enum kvm_pgtable_prot prot)
+{
+	int ret;
+
+	hyp_spin_lock(&pkvm_pgd_lock);
+	ret = pkvm_create_mappings_locked(from, to, prot);
+	hyp_spin_unlock(&pkvm_pgd_lock);
+
+	return ret;
+}
+
 int hyp_back_vmemmap(phys_addr_t phys, unsigned long size, phys_addr_t back)
 {
 	unsigned long start, end;
-- 
2.32.0.605.g8dce9f2422-goog

