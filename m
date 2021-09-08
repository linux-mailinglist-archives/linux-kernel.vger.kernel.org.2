Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 257A8403E5A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 19:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352469AbhIHRbq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 13:31:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:33398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230091AbhIHRbo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 13:31:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4F18160EBA;
        Wed,  8 Sep 2021 17:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631122236;
        bh=dZyoNTpWYDjbsMLm8FfG+sH9KNIQUkuVJuATAf0rPYc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jmHsHqzsXEpQfgBDool7nzhxdJsYwpg1lXSCp9rpfCbk8lTluBYfE2TFqaKklS965
         MdTeF68cxWBqsOtWaepe/3Ngkh5dnyGFc0dVJ90t0CzENT/l3bO/qy2ccnI5DDARdx
         mZtmgVdZF7c4jGDQT/R4ljCVodKaOkS7tNN/D4wdC6TSseQikErSQS3K4oKDnylyZO
         araZARYK+wqglwPTkkx6nbCRT3ta6NF1W2oP2TVw0Zl+4secs09UnoUI9h6h2Lr65H
         up/YuOE9BJjYS9V73KPDnRQP9EwjEziZBBXF+vgCOuDxZVZr8HGE2ADE0i7bh+Py5k
         bcjg1DmDk5kvw==
From:   Vineet Gupta <vgupta@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup.patel@wdc.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Vineet Gupta <vgupta@kernel.org>,
        Anup Patel <anup@brainfault.org>
Subject: [PATCH v2] riscv: mm: don't advertise 1 num_asid for 0 asid bits
Date:   Wed,  8 Sep 2021 10:30:29 -0700
Message-Id: <20210908173029.1104897-1-vgupta@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <CAAhSdy018QJ2hdqL2BSZXV81-CVbTf_g6chJSHM4UH2EhLUpCA@mail.gmail.com>
References: <CAAhSdy018QJ2hdqL2BSZXV81-CVbTf_g6chJSHM4UH2EhLUpCA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Even if mmu doesn't support ASID, current code calculates @num_asids=1
which is misleading, so avoid setting any asid related variables in such
case.

Also while here, print the number of asid bits discovered even for the
disabled case.

Verified this on Hifive Unmatched.

Reviewed-by: Anup Patel <anup@brainfault.org>
Signed-off-by: Vineet Gupta <vgupta@kernel.org>
---
 arch/riscv/mm/context.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/mm/context.c b/arch/riscv/mm/context.c
index ee3459cb6750..ea54cc0c9106 100644
--- a/arch/riscv/mm/context.c
+++ b/arch/riscv/mm/context.c
@@ -233,8 +233,10 @@ static int __init asids_init(void)
 	local_flush_tlb_all();
 
 	/* Pre-compute ASID details */
-	num_asids = 1 << asid_bits;
-	asid_mask = num_asids - 1;
+	if (asid_bits) {
+		num_asids = 1 << asid_bits;
+		asid_mask = num_asids - 1;
+	}
 
 	/*
 	 * Use ASID allocator only if number of HW ASIDs are
@@ -255,7 +257,7 @@ static int __init asids_init(void)
 		pr_info("ASID allocator using %lu bits (%lu entries)\n",
 			asid_bits, num_asids);
 	} else {
-		pr_info("ASID allocator disabled\n");
+		pr_info("ASID allocator disabled (%lu bits)\n", asid_bits);
 	}
 
 	return 0;
-- 
2.30.2

