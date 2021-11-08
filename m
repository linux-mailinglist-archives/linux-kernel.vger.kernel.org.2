Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC6D84498B7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 16:46:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241074AbhKHPt1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 10:49:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236600AbhKHPtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 10:49:25 -0500
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2DF8C061570
        for <linux-kernel@vger.kernel.org>; Mon,  8 Nov 2021 07:46:40 -0800 (PST)
Received: by mail-wr1-x449.google.com with SMTP id h7-20020adfaa87000000b001885269a937so3039342wrc.17
        for <linux-kernel@vger.kernel.org>; Mon, 08 Nov 2021 07:46:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=AKApMG+OBphO2mXMNWEAzsKBITa8c+pAso67pj90vC8=;
        b=tG6WMOy8dE74seq/qZL5tl10JmW8g5oPqehlE/OLFpxU36Ysf7ZW95dwBXeXgmcMF8
         YEWHUhQQOWRykLtNUx2WTgIx8tOmvq9soy+zWO4U29ZLZD7+5I4VvJqbdW+/vmnwr2Yk
         EItavDge61Azr5p7RdHNoJnde9HhafcPYYeub9RMPClQthw6TRcpLY1/asXTnzDBLc2S
         gjUAanJK6ajTf+rC+yFSGDXgHiK0pGx10EvBgimhWb8xAuX55XDt4mQpFt/ixoE4aqS5
         nMqKwSAKLLTPKuKelYGlJmiQ9rtga1sjS0ipfi403/FpDqPaupXIs/M8wJpSQnJwwxRU
         YtIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=AKApMG+OBphO2mXMNWEAzsKBITa8c+pAso67pj90vC8=;
        b=eoCdHIvHmQgBfAJ79fwKl1F3DnVxkMVM86plNe08o+RVfvD67VvFvClsdISWUnyJFX
         LSRgnK2K9mndRqoGQVjQnrsWmV7NMQCd6sqYcZmC1gn5Q9Mdu/otMX5V6jxNwS7Qyy8f
         VegOLf7PaBbVODUnHlgE6XHJX8akmBFvkXz7gv/ag6r0KwsLLuHRPsl+9RFkkzru8QuN
         PxIOEPYmpnZS4fNWZbDbsMC1WRT9bMZNRfgMQCSPCDFyX+zMM2Q/4iqh8p2WXdGlwtE3
         26QaV8nD/GlrqFGjjtkOFo/5A4nZyhn5tZQ+/cmrje3EYa/AVj20RFt0kFsTBJhwXVTo
         QVFQ==
X-Gm-Message-State: AOAM531lSkzWo0B9YQ3pnZsmwVhBKqc+Dfyalj9AwDckquM3QcyDDK81
        J0XfKk9sD4nWdYnL7hAAqbIpdp64Dw/o
X-Google-Smtp-Source: ABdhPJwzJyzbAG53O2weMHNNmNKKDpLhMyRm0Wi+7RXoQ9dLo6WBHGjX8UZ98cpkXILxFN6jSDpOUH0xoW/G
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:909f:3aba:7f9a:3a93])
 (user=qperret job=sendgmr) by 2002:a05:600c:3ba5:: with SMTP id
 n37mr36644382wms.168.1636386399156; Mon, 08 Nov 2021 07:46:39 -0800 (PST)
Date:   Mon,  8 Nov 2021 15:46:32 +0000
Message-Id: <20211108154636.393384-1-qperret@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.0.rc0.344.g81b53c2807-goog
Subject: [PATCH] KVM: arm64: Fix host stage-2 finalization
From:   Quentin Perret <qperret@google.com>
To:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Fuad Tabba <tabba@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org
Cc:     dbrazdil@google.com, qperret@google.com, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We currently walk the hypervisor stage-1 page-table towards the end of
hyp init in nVHE protected mode and adjust the host page ownership
attributes in its stage-2 in order to get a consistent state from both
point of views. The walk is done on the entire hyp VA space, and expects
to only ever find page-level mappings. While this expectation is
reasonable in the half of hyp VA space that maps memory with a fixed
offset (see the loop in pkvm_create_mappings_locked()), it can be
incorrect in the other half where nothing prevents the usage of block
mappings. For instance, on systems where memory is physically aligned at
an address that happens to maps to a PMD aligned VA in the hyp_vmemmap,
kvm_pgtable_hyp_map() will install block mappings when backing the
hyp_vmemmap, which will later cause finalize_host_mappings() to fail.
Furthermore, it should be noted that all pages backing the hyp_vmemmap
are also mapped in the 'fixed offset range' of the hypervisor, which
implies that finalize_host_mappings() will walk both aliases and update
the host stage-2 attributes twice. The order in which this happens is
unpredictable, though, since the hyp VA layout is highly dependent on
the position of the idmap page, hence resulting in a fragile mess at
best.

In order to fix all of this, let's restrict the finalization walk to
only cover memory regions in the 'fixed-offset range' of the hyp VA
space and nothing else. This not only fixes a correctness issue, but
will also result in a slighlty faster hyp initialization overall.

Fixes: 2c50166c62ba ("KVM: arm64: Mark host bss and rodata section as shared")
Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/kvm/hyp/nvhe/setup.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/setup.c b/arch/arm64/kvm/hyp/nvhe/setup.c
index 862c7b514e20..578f71798c2e 100644
--- a/arch/arm64/kvm/hyp/nvhe/setup.c
+++ b/arch/arm64/kvm/hyp/nvhe/setup.c
@@ -178,7 +178,7 @@ static int finalize_host_mappings_walker(u64 addr, u64 end, u32 level,
 
 	phys = kvm_pte_to_phys(pte);
 	if (!addr_is_memory(phys))
-		return 0;
+		return -EINVAL;
 
 	/*
 	 * Adjust the host stage-2 mappings to match the ownership attributes
@@ -207,8 +207,18 @@ static int finalize_host_mappings(void)
 		.cb	= finalize_host_mappings_walker,
 		.flags	= KVM_PGTABLE_WALK_LEAF,
 	};
+	int i, ret;
+
+	for (i = 0; i < hyp_memblock_nr; i++) {
+		struct memblock_region *reg = &hyp_memory[i];
+		u64 start = (u64)hyp_phys_to_virt(reg->base);
+
+		ret = kvm_pgtable_walk(&pkvm_pgtable, start, reg->size, &walker);
+		if (ret)
+			return ret;
+	}
 
-	return kvm_pgtable_walk(&pkvm_pgtable, 0, BIT(pkvm_pgtable.ia_bits), &walker);
+	return 0;
 }
 
 void __noreturn __pkvm_init_finalise(void)
-- 
2.34.0.rc0.344.g81b53c2807-goog

