Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1D1F3E48C3
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 17:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235625AbhHIP0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 11:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235685AbhHIPZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 11:25:52 -0400
Received: from mail-ej1-x64a.google.com (mail-ej1-x64a.google.com [IPv6:2a00:1450:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 551FCC0617A5
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 08:25:30 -0700 (PDT)
Received: by mail-ej1-x64a.google.com with SMTP id qf6-20020a1709077f06b029057e66b6665aso4669862ejc.18
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 08:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=dKAdWq+um7+5WCTr7spdVMqonShc4XNlQTBou41SonA=;
        b=X5MaIqpMDpsgElSyO+XEpl5K8TmNOlWy9iyRmNdtwE3HyEvHRuU55AsAcW15E0tQE+
         jA7MindYid7mLIBWyt24HUfu2l9pN2kywv5tYtKGVJmJSXG3gEPe8HQuJ1uE3t82jb2R
         R6I208HaQXPyBO8Gljjafvuzdzjrx0AwC2KgLjl1Or4B38Z2ft0Z6BYxVAt6gyfpwqgX
         w/kusFQ9wey4B0Z5v7QvjKeXWm8jUbg0/0P+Q1bns7OQUUAjlTXjCQ02a2bo96MuFmHS
         bWb4AiP60ALuRjZ7a9zAqWfFUrcREzLPOMvxQHN87KICnFZF4oBK0KjWIxyjZ+LcJyBH
         yhMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=dKAdWq+um7+5WCTr7spdVMqonShc4XNlQTBou41SonA=;
        b=XJkZXbT7L5n6ylEvJNvQAZSnWPJPXBkB1wT91C25xOClyRvY5FSEFusbXqItMtH0/9
         vEgUlqMyVSWE5H55ULuJ+M3yqFDfIWGd87uvS/HTG3y0FI6a6CySGm3pFMi43yld7rJW
         IKWzXC0z9xEc8XXkO2mo5+aJPYU70JD/rifNmKQibmiNsbeMijVBN5owf7tWgJXDK0cO
         38eHeTNog2VsmBrc52SglLeH/q4uHkV0dXRg77U/jqzv2zFV5urT0YcXhHXAQYdLve0Z
         WE8qvOg9Y3bfT/FBkjZo/hyK/3oHIFw5WxAgjOg/3GMaTmpavB7cYpu9hT1YCyEgiCP0
         Tr4w==
X-Gm-Message-State: AOAM532j2PWO5sJCNDzXxQeNv9trjnaNR8fN0zD5YpG9qcoNCcoZCoco
        CsrlKQzYYQ/5WCgqI2VMQEX4DFb62LOw
X-Google-Smtp-Source: ABdhPJzPp9qFi5jNPXGgwRFOFgI/f0ff/7l9UlxcQ8qnZH4O21lc+UlEQ/M6EMuoSsJAxxc6uAUQfLyq71O/
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:b0e8:d460:758b:a0ae])
 (user=qperret job=sendgmr) by 2002:aa7:cd9a:: with SMTP id
 x26mr30279924edv.26.1628522728841; Mon, 09 Aug 2021 08:25:28 -0700 (PDT)
Date:   Mon,  9 Aug 2021 16:24:44 +0100
In-Reply-To: <20210809152448.1810400-1-qperret@google.com>
Message-Id: <20210809152448.1810400-18-qperret@google.com>
Mime-Version: 1.0
References: <20210809152448.1810400-1-qperret@google.com>
X-Mailer: git-send-email 2.32.0.605.g8dce9f2422-goog
Subject: [PATCH v4 17/21] KVM: arm64: Mark host bss and rodata section as shared
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

As the hypervisor maps the host's .bss and .rodata sections in its
stage-1, make sure to tag them as shared in hyp and host page-tables.

But since the hypervisor relies on the presence of these mappings, we
cannot let the host in complete control of the memory regions -- it
must not unshare or donate them to another entity for example. To
prevent this, let's transfer the ownership of those ranges to the
hypervisor itself, and share the pages back with the host.

Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/kvm/hyp/nvhe/setup.c | 82 +++++++++++++++++++++++++++++----
 1 file changed, 74 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/setup.c b/arch/arm64/kvm/hyp/nvhe/setup.c
index 0b574d106519..57c27846320f 100644
--- a/arch/arm64/kvm/hyp/nvhe/setup.c
+++ b/arch/arm64/kvm/hyp/nvhe/setup.c
@@ -58,6 +58,7 @@ static int recreate_hyp_mappings(phys_addr_t phys, unsigned long size,
 {
 	void *start, *end, *virt = hyp_phys_to_virt(phys);
 	unsigned long pgt_size = hyp_s1_pgtable_pages() << PAGE_SHIFT;
+	enum kvm_pgtable_prot prot;
 	int ret, i;
 
 	/* Recreate the hyp page-table using the early page allocator */
@@ -83,10 +84,6 @@ static int recreate_hyp_mappings(phys_addr_t phys, unsigned long size,
 	if (ret)
 		return ret;
 
-	ret = pkvm_create_mappings(__start_rodata, __end_rodata, PAGE_HYP_RO);
-	if (ret)
-		return ret;
-
 	ret = pkvm_create_mappings(__hyp_rodata_start, __hyp_rodata_end, PAGE_HYP_RO);
 	if (ret)
 		return ret;
@@ -95,10 +92,6 @@ static int recreate_hyp_mappings(phys_addr_t phys, unsigned long size,
 	if (ret)
 		return ret;
 
-	ret = pkvm_create_mappings(__hyp_bss_end, __bss_stop, PAGE_HYP_RO);
-	if (ret)
-		return ret;
-
 	ret = pkvm_create_mappings(virt, virt + size, PAGE_HYP);
 	if (ret)
 		return ret;
@@ -117,6 +110,24 @@ static int recreate_hyp_mappings(phys_addr_t phys, unsigned long size,
 			return ret;
 	}
 
+	/*
+	 * Map the host's .bss and .rodata sections RO in the hypervisor, but
+	 * transfer the ownership from the host to the hypervisor itself to
+	 * make sure it can't be donated or shared with another entity.
+	 *
+	 * The ownership transition requires matching changes in the host
+	 * stage-2. This will be done later (see finalize_host_mappings()) once
+	 * the hyp_vmemmap is addressable.
+	 */
+	prot = pkvm_mkstate(PAGE_HYP_RO, PKVM_PAGE_SHARED_OWNED);
+	ret = pkvm_create_mappings(__start_rodata, __end_rodata, prot);
+	if (ret)
+		return ret;
+
+	ret = pkvm_create_mappings(__hyp_bss_end, __bss_stop, prot);
+	if (ret)
+		return ret;
+
 	return 0;
 }
 
@@ -148,6 +159,57 @@ static void hpool_put_page(void *addr)
 	hyp_put_page(&hpool, addr);
 }
 
+static int finalize_host_mappings_walker(u64 addr, u64 end, u32 level,
+					 kvm_pte_t *ptep,
+					 enum kvm_pgtable_walk_flags flag,
+					 void * const arg)
+{
+	enum kvm_pgtable_prot prot;
+	enum pkvm_page_state state;
+	kvm_pte_t pte = *ptep;
+	phys_addr_t phys;
+
+	if (!kvm_pte_valid(pte))
+		return 0;
+
+	if (level != (KVM_PGTABLE_MAX_LEVELS - 1))
+		return -EINVAL;
+
+	phys = kvm_pte_to_phys(pte);
+	if (!addr_is_memory(phys))
+		return 0;
+
+	/*
+	 * Adjust the host stage-2 mappings to match the ownership attributes
+	 * configured in the hypervisor stage-1.
+	 */
+	state = pkvm_getstate(kvm_pgtable_hyp_pte_prot(pte));
+	switch (state) {
+	case PKVM_PAGE_OWNED:
+		return host_stage2_set_owner_locked(phys, PAGE_SIZE, pkvm_hyp_id);
+	case PKVM_PAGE_SHARED_OWNED:
+		prot = pkvm_mkstate(PKVM_HOST_MEM_PROT, PKVM_PAGE_SHARED_BORROWED);
+		break;
+	case PKVM_PAGE_SHARED_BORROWED:
+		prot = pkvm_mkstate(PKVM_HOST_MEM_PROT, PKVM_PAGE_SHARED_OWNED);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return host_stage2_idmap_locked(phys, PAGE_SIZE, prot);
+}
+
+static int finalize_host_mappings(void)
+{
+	struct kvm_pgtable_walker walker = {
+		.cb	= finalize_host_mappings_walker,
+		.flags	= KVM_PGTABLE_WALK_LEAF,
+	};
+
+	return kvm_pgtable_walk(&pkvm_pgtable, 0, BIT(pkvm_pgtable.ia_bits), &walker);
+}
+
 void __noreturn __pkvm_init_finalise(void)
 {
 	struct kvm_host_data *host_data = this_cpu_ptr(&kvm_host_data);
@@ -167,6 +229,10 @@ void __noreturn __pkvm_init_finalise(void)
 	if (ret)
 		goto out;
 
+	ret = finalize_host_mappings();
+	if (ret)
+		goto out;
+
 	pkvm_pgtable_mm_ops = (struct kvm_pgtable_mm_ops) {
 		.zalloc_page = hyp_zalloc_hyp_page,
 		.phys_to_virt = hyp_phys_to_virt,
-- 
2.32.0.605.g8dce9f2422-goog

