Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31374433597
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 14:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235598AbhJSMPc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 08:15:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231236AbhJSMP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 08:15:28 -0400
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AA68C061745
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 05:13:15 -0700 (PDT)
Received: by mail-wr1-x44a.google.com with SMTP id p12-20020adfc38c000000b00160d6a7e293so10046561wrf.18
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 05:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=TYk1LPnI99k/ggVKO8Mj9uEvzzDQ3GdDPOmXLwpCDNI=;
        b=O8yTSrO0Uca5wm5K4vU0ejt4H7paio27+Bqs4+KFIFEGBAiFkCCrrUrGNwkEt/Fefe
         28wzo1Ssyx+9lQZLUUAw2vVund8vhlY/9UwK8rovsHyNg4yw2Rn3gBGVepSL7Eq2w3yF
         hOEEM+UMiw4N/19fDLtDtMDjzcuOLCQZrQwnn8kjya9y0T0dnD7uEF3AAv8UWU/4yrKi
         S6OImPM+oD/vG3KMqhrA+Gyqt8kAYJpzoj+A1WyLb90HutKsJMU8ddw6cAouTDJTBNKC
         PQvZvate6zTr45VFMsJe5Czj+08pSBtCAh4K0m25lr/XPX0osBrElQ5U3Cd9eTV8m49b
         ZmUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=TYk1LPnI99k/ggVKO8Mj9uEvzzDQ3GdDPOmXLwpCDNI=;
        b=6UDsXz5s6ta4C/rfSQxinCaZ6D8cLzjdtGZP05aCJCzzfU8KTdzvGcOHBlNlRG+HN1
         8orhnxD5Ogx+vTMAqrwYtnwOojGsYLSzrFDmtnHDdr4FT6nBdlULgrc/euPJOf8UkZoY
         zJ9SqFzYbOgJ8ssq9vR9scp4xualUcSKfGmtuPVVIg7MLS5DZH3PpZR7bk5InOpBB8kk
         XRZU79HEMXgTQgxlg6mB1PG5zQV2WRcYljK7FmUXVVfQbkMdHAryjZl8zJkU7JAbfDYe
         UGFuC+1fvGsZpg0cfPYbFocbkjOWFZmZxapC2eqPyByWp2pETcZdxTHeVfAwdLp/izOj
         wBwg==
X-Gm-Message-State: AOAM532reNpsne5nhMa6Gp6VSBMQLDC5+DmMXZMxmGafJu+/v+nzJCzp
        9e/6hVy6cLOGRU0XvH7RxqCTl3YZ0iTS
X-Google-Smtp-Source: ABdhPJzFSw1s7wfnFX8qmHfRSKmq59QIp1f27cUPH/WdPiT9CqXbF6yjtS78WRcCH6lpSA4IMEtzt5LuNzVT
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:59ca:401f:83a8:de6d])
 (user=qperret job=sendgmr) by 2002:a1c:2b04:: with SMTP id
 r4mr5781071wmr.48.1634645593915; Tue, 19 Oct 2021 05:13:13 -0700 (PDT)
Date:   Tue, 19 Oct 2021 13:12:52 +0100
In-Reply-To: <20211019121304.2732332-1-qperret@google.com>
Message-Id: <20211019121304.2732332-4-qperret@google.com>
Mime-Version: 1.0
References: <20211019121304.2732332-1-qperret@google.com>
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [PATCH v2 03/15] KVM: arm64: Refcount hyp stage-1 pgtable pages
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
2.33.0.1079.g6e70778dc9-goog

