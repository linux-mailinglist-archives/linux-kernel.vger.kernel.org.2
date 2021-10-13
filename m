Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B934E42C57E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 17:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236719AbhJMQBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 12:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235925AbhJMQA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 12:00:56 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FA18C061764
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 08:58:52 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id l27-20020a05620a211b00b0045fbe374e2dso947402qkl.10
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 08:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ztuYYF9Onc0ZIjngTVEp2z77n51MjY0wGMZOLwDTwhY=;
        b=GVq5GFcw/0eVvulNbba6ktlvmE8YFALwpDIhCJ2/vsiC21sLdLoc9O7Xq36D1lJ5lf
         ZQpif0gOuVc4Y1gCrCxInx9Dy5dbafYfdL55owb7iUdw+pbGb6j7FjBOyhKrHNDwIkvj
         IUagiUdDR+zKO/Ac9HpWerSCBqwNR3R74jb/oiqdXP39kp5RokKJ70PgYiZ7br199OT/
         fxtAXX/51HuCFEYze6DhFLzMABWI4+IwL8WM23aFrRth8DgCQnF6HKbnFhSTNuYZOayb
         PcC6MbtcinQD4fvigVVSdsAf5MhLy6ddmj2xBzYeMb40ITQkrfyGcy+2NPXD9hI6eXPQ
         nvgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ztuYYF9Onc0ZIjngTVEp2z77n51MjY0wGMZOLwDTwhY=;
        b=GtPwFmAIdYyKGABZfg0LL722VQpcjPBMLsn52heeLWQrYoGYr6PD71s9EwkqCskEjn
         9AShWl+x9hUZXmSEI4+mWRBcYoEX8MKJndAh7EEl1flPvP1wyVKewwcg7cWuWgHFnjAT
         fdhyEn2hpc3uoT2z7is3RXb8sHnudGZnmM2z2fih1z0pu9JTHUGGe1EF36IXUsV3AG97
         rP9GM0Bdt3R6eve1ueiS0m2+iPeOCxJxwDDB7Wp3Em4Y1p+VAM23OxbH6Ih9dZW11tAs
         2w8x1/B1FMXfhjathW3L7JvTgMYyFVoLEHRFf0fqDja54iuyLcAHgX4GnrfB2FGQqk/b
         Dfyw==
X-Gm-Message-State: AOAM532ugUUwHtxjSAGNfSQ5ys7JuEOP56Sz0lgST69cC3yrPQE2ZjiI
        Zt4D+59MjcPUDo1iYN1+0nrlYli/mvUe
X-Google-Smtp-Source: ABdhPJxp1hUAJxs/riqQe2cYJzZaiMjwH6ehh74ltN5CiIrrR1/FVufG6S8GAC+vFxwjhGJSaTXJSPc9xIJG
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:65b5:73d3:1558:b9ae])
 (user=qperret job=sendgmr) by 2002:a05:622a:13c6:: with SMTP id
 p6mr65288qtk.165.1634140730556; Wed, 13 Oct 2021 08:58:50 -0700 (PDT)
Date:   Wed, 13 Oct 2021 16:58:22 +0100
In-Reply-To: <20211013155831.943476-1-qperret@google.com>
Message-Id: <20211013155831.943476-8-qperret@google.com>
Mime-Version: 1.0
References: <20211013155831.943476-1-qperret@google.com>
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
Subject: [PATCH 07/16] KVM: arm64: Refcount hyp stage-1 pgtable pages
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

To prepare the ground for allowing hyp stage-1 mappings to be removed at
run-time, update the KVM page-table code to maintain a correct refcount
using the ->{get,put}_page() function callbacks.

Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/kvm/hyp/pgtable.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
index f8ceebe4982e..768a58835153 100644
--- a/arch/arm64/kvm/hyp/pgtable.c
+++ b/arch/arm64/kvm/hyp/pgtable.c
@@ -408,8 +408,10 @@ static bool hyp_map_walker_try_leaf(u64 addr, u64 end, u32 level,
 		return false;
 
 	new = kvm_init_valid_leaf_pte(phys, data->attr, level);
-	if (hyp_pte_needs_update(old, new))
+	if (hyp_pte_needs_update(old, new)) {
 		smp_store_release(ptep, new);
+		data->mm_ops->get_page(ptep);
+	}
 
 	data->phys += granule;
 	return true;
@@ -433,6 +435,7 @@ static int hyp_map_walker(u64 addr, u64 end, u32 level, kvm_pte_t *ptep,
 		return -ENOMEM;
 
 	kvm_set_table_pte(ptep, childp, mm_ops);
+	mm_ops->get_page(ptep);
 	return 0;
 }
 
@@ -482,8 +485,16 @@ static int hyp_free_walker(u64 addr, u64 end, u32 level, kvm_pte_t *ptep,
 			   enum kvm_pgtable_walk_flags flag, void * const arg)
 {
 	struct kvm_pgtable_mm_ops *mm_ops = arg;
+	kvm_pte_t pte = *ptep;
+
+	if (!kvm_pte_valid(pte))
+		return 0;
+
+	mm_ops->put_page(ptep);
+
+	if (kvm_pte_table(pte, level))
+		mm_ops->put_page(kvm_pte_follow(pte, mm_ops));
 
-	mm_ops->put_page((void *)kvm_pte_follow(*ptep, mm_ops));
 	return 0;
 }
 
@@ -491,7 +502,7 @@ void kvm_pgtable_hyp_destroy(struct kvm_pgtable *pgt)
 {
 	struct kvm_pgtable_walker walker = {
 		.cb	= hyp_free_walker,
-		.flags	= KVM_PGTABLE_WALK_TABLE_POST,
+		.flags	= KVM_PGTABLE_WALK_LEAF | KVM_PGTABLE_WALK_TABLE_POST,
 		.arg	= pgt->mm_ops,
 	};
 
-- 
2.33.0.882.g93a45727a2-goog

