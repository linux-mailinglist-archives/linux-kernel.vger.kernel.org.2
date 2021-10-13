Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EC3B42C57F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 17:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236243AbhJMQBH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 12:01:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236142AbhJMQA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 12:00:58 -0400
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3607BC061570
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 08:58:54 -0700 (PDT)
Received: by mail-wr1-x449.google.com with SMTP id d13-20020adfa34d000000b00160aa1cc5f1so2336024wrb.14
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 08:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=AEhoESi+JSkIpPsgLf7KV5M6/nV8qQxTUg3eRSjbv/s=;
        b=NP+XPmDRgtbMk4UIWYD0pQZRkJlQstYb8HVcLmqCidCTYbYQHgdI3Cqdyg2BMtg0E7
         ZxXptk9cPKAKddslAHjToBYwGC6dKSDDr9i8XsvIRpIAqZgNZspy3rXJluomIH6ikRPq
         GMD7xgTJYC+p2iKq4nOwt1vtc3aTDy8Q23TqJt8WOdZ/2LNtMpxarqRE3/Usq/0MBwRm
         F24k7V9pBdz5RsbhTu2S+G4qNUwnwip22wK2jS4gWU/A4VAEAeayNExRA5QBw9pLIcnf
         3MZvLAInURcb+xfCjWAMcRLKWeqYTvvi+usmLYswXOEB2/t+ULFEJXEMzeRdLXCgdOA+
         H7aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=AEhoESi+JSkIpPsgLf7KV5M6/nV8qQxTUg3eRSjbv/s=;
        b=y72qeB0UFs7u0PLt3qlYCbbAhUqIzSTYhMqCrK6fczH4RSPSnSntDU3jRMCUBYd73q
         +mJTN1gEa3/erPXP/yILdRVtArAKhujJudc5ctEUPOrIOaBcjFWeumixPGjlAtYMUmJR
         pg9IvuzJ3liM1XdUuLwP10+JRuBgHS1hb26qq7ysYnBayX1UxCUgT5jK4/lfHqbjH5NT
         RFyDmUf4hkMGVSDt1Zww9OVtRKpYQN9hzjpu10ev42IP3xJVlmB779a3IKODV90crFeT
         WZNqDUvpZRCNWt4qttbzkbU+4tm3uGte1Z+O5400YdYh1JCdYvqvrjAmPzhO8egt6/PH
         2+5g==
X-Gm-Message-State: AOAM533B2CPap0iA8VHTOWfgPpUmGTmEYme3mpgoDQurQDrtIvTZq99Y
        fggmmIgbj5B1duyaVwhC/mwNBAmmNbQR
X-Google-Smtp-Source: ABdhPJypaaFzh/P/CSod5M2Uoyrzi+tFUaTYoQ7iBeHY7wDaUM4H3CebTBes5FVoowLKxoASMH9NbGCZR+8e
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:65b5:73d3:1558:b9ae])
 (user=qperret job=sendgmr) by 2002:a7b:c76e:: with SMTP id
 x14mr13634245wmk.47.1634140732732; Wed, 13 Oct 2021 08:58:52 -0700 (PDT)
Date:   Wed, 13 Oct 2021 16:58:23 +0100
In-Reply-To: <20211013155831.943476-1-qperret@google.com>
Message-Id: <20211013155831.943476-9-qperret@google.com>
Mime-Version: 1.0
References: <20211013155831.943476-1-qperret@google.com>
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
Subject: [PATCH 08/16] KVM: arm64: Fixup hyp stage-1 refcount
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

In nVHE-protected mode, the hyp stage-1 page-table refcount is broken
due to the lack of refcount support in the early allocator. Fix-up the
refcount in the finalize walker, once the 'hyp_vmemmap' is up and running.

Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/kvm/hyp/nvhe/setup.c | 31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/setup.c b/arch/arm64/kvm/hyp/nvhe/setup.c
index 57c27846320f..ad89801dfed7 100644
--- a/arch/arm64/kvm/hyp/nvhe/setup.c
+++ b/arch/arm64/kvm/hyp/nvhe/setup.c
@@ -166,12 +166,22 @@ static int finalize_host_mappings_walker(u64 addr, u64 end, u32 level,
 {
 	enum kvm_pgtable_prot prot;
 	enum pkvm_page_state state;
+	struct kvm_pgtable_mm_ops *mm_ops = arg;
 	kvm_pte_t pte = *ptep;
 	phys_addr_t phys;
 
 	if (!kvm_pte_valid(pte))
 		return 0;
 
+	/*
+	 * Fix-up the refcount for the page-table pages as the early allocator
+	 * was unable to access the hyp_vmemmap and so the buddy allocator has
+	 * initialised the refcount to '1'.
+	 */
+	mm_ops->get_page(ptep);
+	if (flag != KVM_PGTABLE_WALK_LEAF)
+		return 0;
+
 	if (level != (KVM_PGTABLE_MAX_LEVELS - 1))
 		return -EINVAL;
 
@@ -204,7 +214,8 @@ static int finalize_host_mappings(void)
 {
 	struct kvm_pgtable_walker walker = {
 		.cb	= finalize_host_mappings_walker,
-		.flags	= KVM_PGTABLE_WALK_LEAF,
+		.flags	= KVM_PGTABLE_WALK_LEAF | KVM_PGTABLE_WALK_TABLE_POST,
+		.arg	= pkvm_pgtable.mm_ops,
 	};
 
 	return kvm_pgtable_walk(&pkvm_pgtable, 0, BIT(pkvm_pgtable.ia_bits), &walker);
@@ -229,19 +240,19 @@ void __noreturn __pkvm_init_finalise(void)
 	if (ret)
 		goto out;
 
-	ret = finalize_host_mappings();
-	if (ret)
-		goto out;
-
 	pkvm_pgtable_mm_ops = (struct kvm_pgtable_mm_ops) {
-		.zalloc_page = hyp_zalloc_hyp_page,
-		.phys_to_virt = hyp_phys_to_virt,
-		.virt_to_phys = hyp_virt_to_phys,
-		.get_page = hpool_get_page,
-		.put_page = hpool_put_page,
+		.zalloc_page	= hyp_zalloc_hyp_page,
+		.phys_to_virt	= hyp_phys_to_virt,
+		.virt_to_phys	= hyp_virt_to_phys,
+		.get_page	= hpool_get_page,
+		.put_page	= hpool_put_page,
 	};
 	pkvm_pgtable.mm_ops = &pkvm_pgtable_mm_ops;
 
+	ret = finalize_host_mappings();
+	if (ret)
+		goto out;
+
 out:
 	/*
 	 * We tail-called to here from handle___pkvm_init() and will not return,
-- 
2.33.0.882.g93a45727a2-goog

