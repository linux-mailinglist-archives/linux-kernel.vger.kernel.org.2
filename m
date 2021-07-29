Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B263C3DA454
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 15:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238075AbhG2NaP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 09:30:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237360AbhG2N3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 09:29:10 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06E2EC0613C1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 06:29:07 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id cb3-20020ad456230000b02903319321d1e3so3918512qvb.14
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 06:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=PD2lJrK2uUAJidILwsX5pR8ZyvNUyZDv1OnaXJdJLhM=;
        b=mUuZZtK9nPtQzaSeRR1efvqBrUoJ0pqBZlk3FM19wBDIbLOvb8fBAK1zLHnHmRvgG4
         9+m8SNZemfJ5wjNL0ad4SiPyjYjEBlLoS8Tyn4uwj2sswKXw+5b34Cpk+2cNl0zxU9i2
         hb1UtR4PqkuvDCfrkQgC0MmfZumGrmMdvx63kJ33dQX7N17wUy5Vt6SMNZbQpHP5yLox
         bd8gesl5DHYmN7n9sV5lvWk1BJ0SWoWsa969E0R98/3453gA3Yw8Lno5XA7wFKvbI4kS
         Ku3g9VDc96QVgpM4vZGdkPZ0QH5KCfDWuAHB2CAaVZfb6Aalj1LyRfmpbi6Z8uylubmZ
         KXnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=PD2lJrK2uUAJidILwsX5pR8ZyvNUyZDv1OnaXJdJLhM=;
        b=toKL9NN5djkQhlqjRGOtydApi88fysXBmsDcD+SDSn5yyDpcZgjKGwnoh39/pRo6sB
         n+IPHZeQhiswSQLJ1k5BtH17dF0tQlr8sQKczJRlCqfACxlacUwcaVqQbcmyfcWNT3wl
         eZSMUlVAx2zLhScP9kt4UgiNz15zRczxP9dBqQLncbN/2Xpmcgvcx9tEY96bXizmNeN9
         kPSBf3PVgfyuxaVCNNaJiQBxLxRnHbkJPA88gVVeH0dtAJDZ3J2dGII2Kp80raTEY8Rq
         J3dDE/qHastRuXX1Qttly4qPgBLW7LEhFRRJwjgshxjzf+3g2rD/qH4C5L/vFv2/n+1z
         4d3g==
X-Gm-Message-State: AOAM53255Set3cJ/83KAaDB69qYp/hHUSXTU0kLZxcCEd02phZcB87U5
        NuQ04sT5WF2EA1rCCVcffx9REHDoomML
X-Google-Smtp-Source: ABdhPJz10hpfq0SGJNMP70xRlPb0dobUvsFM7yqmK2aN+qLJctMkUjDYhRjEE2aZ3LvI5a9WzZnTi+0sHxt+
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:293a:bc89:7514:5218])
 (user=qperret job=sendgmr) by 2002:a05:6214:10e6:: with SMTP id
 q6mr4966976qvt.11.1627565346131; Thu, 29 Jul 2021 06:29:06 -0700 (PDT)
Date:   Thu, 29 Jul 2021 14:28:16 +0100
In-Reply-To: <20210729132818.4091769-1-qperret@google.com>
Message-Id: <20210729132818.4091769-20-qperret@google.com>
Mime-Version: 1.0
References: <20210729132818.4091769-1-qperret@google.com>
X-Mailer: git-send-email 2.32.0.432.gabb21c7263-goog
Subject: [PATCH v3 19/21] KVM: arm64: Refactor protected nVHE stage-1 locking
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
2.32.0.432.gabb21c7263-goog

