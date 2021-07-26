Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A61623D56A1
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 11:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233337AbhGZIte (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 04:49:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233155AbhGZItP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 04:49:15 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64912C061760
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 02:29:43 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id p14-20020a05620a22eeb02903b94aaa0909so8450450qki.15
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 02:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=6dY3W9X/AGxD9r1RRTSS9yD4t5RoHsE1QSE3BCqo+aE=;
        b=Ww9dZYatKjMjIjIW2ylBqljvFXMjm0aQtmZZd32Hr/KhiQqtTftNNfU69HEOr0lDbm
         zKee/K1VB/L+wtlEDRN5rVkSG/delJAR7PejN/gdK8Jfu8lQAw3AbAugd/GC3GoKPdRM
         kLKaIWP/+D4QBdboQQ3q/eARC/T+BaNDzFr77y3qvaXSJzgq2aV2CNkWnUuT5eK7E1vI
         iPbtNmIcBPgzr/nU52DfK1/CvEFwtQ0pEtbAe48HgEUDcRebZvoACysb+/jnYB2DPFmN
         wGmU9dDogUx6Isrlkg+YCz3jySICBEXb7IY5wYtN7RAnqe7ILDgtZZJ2mLrbRgZcpEVn
         WuNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=6dY3W9X/AGxD9r1RRTSS9yD4t5RoHsE1QSE3BCqo+aE=;
        b=FSQrdeezOGkWYxJONf+sj4CJR2JGGgZ9/Kx/hHRC3x2CFHF6uGWzZ88cJ/kckvXSUZ
         XlXLDu9Iu5+n/dIlR7F6tFdAMHuUVSBorjzUOWNDtJnldbkrXBDiFmc/W6x+n40rMbo0
         bzwm6HgNFpA15Lscd/LIxEokIC6vzbG55aW80fuzzwRzd54Cuq6TAv+Nm3PjWXiQeghd
         n1U1rk6XIVKvFJAzEZGgUfPE+KAk8hIbalUt98Gfvo3kDkx2VdaYIEgunCD0nHgARL9n
         bcOu6+nmOfGujQXRK2smR4ggV9DYXaFsqdUn23pHRBG3+HZfrw0eyqGmtDFCud+Z53+j
         bW6g==
X-Gm-Message-State: AOAM5337TenAedX0ZRklS/2exU/xS95K9FA47O9+g8FGJw6C0U+5RUuO
        oEhNCYJdcP8HjBJ0eR/H1BIBOaNZu166
X-Google-Smtp-Source: ABdhPJxja1z3cl1S4eHZsbLWfOgzNw9V3DmMjl7MkdDjMfOUrn37i6l0Vcan0CxmYEphVI3A4P6qPR4TuQL7
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:23a0:2f14:433:e6cb])
 (user=qperret job=sendgmr) by 2002:a05:6214:e83:: with SMTP id
 hf3mr17024207qvb.19.1627291782528; Mon, 26 Jul 2021 02:29:42 -0700 (PDT)
Date:   Mon, 26 Jul 2021 10:29:03 +0100
In-Reply-To: <20210726092905.2198501-1-qperret@google.com>
Message-Id: <20210726092905.2198501-15-qperret@google.com>
Mime-Version: 1.0
References: <20210726092905.2198501-1-qperret@google.com>
X-Mailer: git-send-email 2.32.0.432.gabb21c7263-goog
Subject: [PATCH v2 14/16] KVM: arm64: Refactor protected nVHE stage-1 locking
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

Refactor the hypervisor stage-1 locking in nVHE protected mode to expose
a new pkvm_create_mappings_locked() function. This will be used in later
patches to allow walking and changing the hypervisor stage-1 without
releasing the lock.

Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/kvm/hyp/include/nvhe/mm.h |  1 +
 arch/arm64/kvm/hyp/nvhe/mm.c         | 17 +++++++++++++++--
 2 files changed, 16 insertions(+), 2 deletions(-)

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
index a8efdf0f9003..256cbe5c0dca 100644
--- a/arch/arm64/kvm/hyp/nvhe/mm.c
+++ b/arch/arm64/kvm/hyp/nvhe/mm.c
@@ -67,7 +67,8 @@ unsigned long __pkvm_create_private_mapping(phys_addr_t phys, size_t size,
 	return addr;
 }
 
-int pkvm_create_mappings(void *from, void *to, enum kvm_pgtable_prot prot)
+/* Must be called with the pkvm_pgd_lock held */
+int pkvm_create_mappings_locked(void *from, void *to, enum kvm_pgtable_prot prot)
 {
 	unsigned long start = (unsigned long)from;
 	unsigned long end = (unsigned long)to;
@@ -81,7 +82,8 @@ int pkvm_create_mappings(void *from, void *to, enum kvm_pgtable_prot prot)
 		int err;
 
 		phys = hyp_virt_to_phys((void *)virt_addr);
-		err = __pkvm_create_mappings(virt_addr, PAGE_SIZE, phys, prot);
+		err = kvm_pgtable_hyp_map(&pkvm_pgtable, virt_addr, PAGE_SIZE,
+					  phys, prot);
 		if (err)
 			return err;
 	}
@@ -89,6 +91,17 @@ int pkvm_create_mappings(void *from, void *to, enum kvm_pgtable_prot prot)
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
2.32.0.432.gabb21c7263-goog

