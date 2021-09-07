Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8E0E402F58
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 22:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346239AbhIGUEJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 16:04:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:59138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230467AbhIGUEH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 16:04:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C859161106;
        Tue,  7 Sep 2021 20:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631044981;
        bh=GHY5U3+0IXVjerpc2D86xOqagWOy0yZ5l0MYkJly+sU=;
        h=From:To:Cc:Subject:Date:From;
        b=VSZqEbIrNDCJTGP2NgiDmbVHwrEH1yz+kRLMwgnx51fVrcMKr5XiXKIuf/bLtOBgo
         QEWBXK2AkQVySrKZShWAJOfQL/z9efWEhm6Fw3xs33BtC+62frShpIUcvuz9uGM/wg
         sW2JYwT6EQak30j/o+xCY4hVg2l1JQjg8G/PQbXc8Tl35t2piE8BubXvWYgBTgyA/K
         c7r4k93UndMXvDF8DeXa3ZLJSPweoOAJEI9AHpSuuMLTFbzn9n8NBMKkWSzTbEPKXg
         VhIkEDXrzp0gph0h4O3PjKTqav3kwyK+A6T9uoI+pk/9i0pw96kZb9a8FsbICLyJZw
         nHLoCntOOutlw==
From:   Vineet Gupta <vgupta@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup.patel@wdc.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Vineet Gupta <vgupta@kernel.org>
Subject: [PATCH] riscv: mm: don't advertise 1 num_asid for 0 asid bits
Date:   Tue,  7 Sep 2021 13:02:54 -0700
Message-Id: <20210907200254.467375-1-vgupta@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Even if mmu doesn't support ASID, current code calculates @num_asids=1
which is misleading, so avoid setting any asid related variables in such
a case.

Also while here, print the number of asid bits discovered even for the
disabled case.

Verified this on Hifive Unmatched.

Signed-off-by: Vineet Gupta <vgupta@kernel.org>
---
 arch/riscv/mm/context.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/mm/context.c b/arch/riscv/mm/context.c
index ee3459cb6750..c8c6f8831a3b 100644
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
+		pr_info("ASID allocator disabled: %lu bits\n", asid_bits);
 	}
 
 	return 0;
-- 
2.30.2

