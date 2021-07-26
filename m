Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7BFF3D5694
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 11:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232760AbhGZItI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 04:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233056AbhGZIs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 04:48:58 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A41AFC061757
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 02:29:27 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id m2-20020ac807c20000b0290269bd8044e1so4026522qth.10
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 02:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=HFQLFqYnlTo1lpqJ7D2ypgfrC23LiNE+ZmEwXkcYw0A=;
        b=emynXi8zGe9T2RndgYYOenyBOAtMls9A7ba9xIszaaQomvI/LjgYmTFavbkZgJJOTH
         jtvzzyteKVqko+G94XCfuANCCNBvhNP6T8mqrsBlRt2dIVhBPJQgOhI/dnyTrfGziGRE
         GcgWV2cqwrrCNSKHbUGrT0Hl1O/yQGv0tUrhtwxijYozBbsYTGsDQ6n+LTmNJwhn3cg8
         WcykCVqR8O4yeSvhqiW3Qloa6Dgf7LRz4x2f1knnPA+hmnUz6ZdGf46FMq0Ziiv4b5kW
         v56uzZXpFd2basc8actTQOWCM+4oWAr9MsHdmrPOv0tj9Oqw6eVBoJowa+i4YfgCPyWT
         R30w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=HFQLFqYnlTo1lpqJ7D2ypgfrC23LiNE+ZmEwXkcYw0A=;
        b=iLd8nFNDonuhcT5Fp2CQkCjnl6M7J93Y3Q8bt/CEWw6zIykn9+lGWAP1VDuPcLEOBj
         RL4De82Fc/Nx4N0Yrv9Ec0Ag0soRohYsYoTzzriCX5fGRzcD0x7iCLWi6c+nocR4YAYN
         n5xlVicJ9oLk3V/wa9OHfh3NhOqD+AhJr95YzzWjqBVitV/v3k79kJmOFSa9xCCUHZKs
         Ul5/XqWD3iXL7tlppNP9iuLly44M3V/ipidQaU/DMA0IgTcUHNhpGa1Fl7N78FS4hlsY
         xg16svUVbV7WyXsg9r/cZ/tSAVGVZwnSFhlgc63E1WJcHRRs20FTydZqArG4bA2orK2Q
         YlIw==
X-Gm-Message-State: AOAM53057uAomRL/fOmFRqJQEYkTj43lSdMwdxotKwrm0MT80MchgaNH
        IZMQz+qUgsm1JgL25WmmhwZfVfHxJ8HB
X-Google-Smtp-Source: ABdhPJypoUwsNuwCxy8ymHAKoR1zqHYLDOPbF+TzYxseet5jGrMrBQsRY36QeoNA7Ahvpckl3UlgU5nhuRXS
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:23a0:2f14:433:e6cb])
 (user=qperret job=sendgmr) by 2002:a05:6214:1021:: with SMTP id
 k1mr17176909qvr.4.1627291766710; Mon, 26 Jul 2021 02:29:26 -0700 (PDT)
Date:   Mon, 26 Jul 2021 10:28:56 +0100
In-Reply-To: <20210726092905.2198501-1-qperret@google.com>
Message-Id: <20210726092905.2198501-8-qperret@google.com>
Mime-Version: 1.0
References: <20210726092905.2198501-1-qperret@google.com>
X-Mailer: git-send-email 2.32.0.432.gabb21c7263-goog
Subject: [PATCH v2 07/16] KVM: arm64: Tolerate re-creating hyp mappings to set
 software bits
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

The current hypervisor stage-1 mapping code doesn't allow changing an
existing valid mapping. Relax this condition by allowing changes that
only target software bits, as that will soon be needed to annotate shared
pages.

Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/kvm/hyp/pgtable.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
index b5ca21b44b6a..93cc9de4d46c 100644
--- a/arch/arm64/kvm/hyp/pgtable.c
+++ b/arch/arm64/kvm/hyp/pgtable.c
@@ -375,6 +375,21 @@ static int hyp_set_prot_attr(enum kvm_pgtable_prot prot, kvm_pte_t *ptep)
 	return 0;
 }
 
+static bool hyp_pte_needs_update(kvm_pte_t old, kvm_pte_t new)
+{
+	/*
+	 * Tolerate KVM recreating the exact same mapping, or changing software
+	 * bits if the existing mapping was valid.
+	 */
+	if (old == new)
+		return false;
+
+	if (!kvm_pte_valid(old))
+		return true;
+
+	return !WARN_ON((old ^ new) & ~KVM_PTE_LEAF_ATTR_HI_SW);
+}
+
 static bool hyp_map_walker_try_leaf(u64 addr, u64 end, u32 level,
 				    kvm_pte_t *ptep, struct hyp_map_data *data)
 {
@@ -384,9 +399,8 @@ static bool hyp_map_walker_try_leaf(u64 addr, u64 end, u32 level,
 	if (!kvm_block_mapping_supported(addr, end, phys, level))
 		return false;
 
-	/* Tolerate KVM recreating the exact same mapping */
 	new = kvm_init_valid_leaf_pte(phys, data->attr, level);
-	if (old != new && !WARN_ON(kvm_pte_valid(old)))
+	if (hyp_pte_needs_update(old, new))
 		smp_store_release(ptep, new);
 
 	data->phys += granule;
-- 
2.32.0.432.gabb21c7263-goog

