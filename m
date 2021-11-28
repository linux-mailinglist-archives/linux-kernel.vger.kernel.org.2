Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F3CA46076C
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Nov 2021 17:17:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358443AbhK1QUe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 11:20:34 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:35838 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358291AbhK1QS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 11:18:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BF7CBB80D2A
        for <linux-kernel@vger.kernel.org>; Sun, 28 Nov 2021 16:15:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE6C0C53FCB;
        Sun, 28 Nov 2021 16:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638116110;
        bh=vTJ+kJ0LGa5qNHZ7RxBihZ2BrKTUuELoQ0am/1I/pr8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XUD1f05OrZVzW97bOm57rVyEfy9CMsa+dt4IKu9VjDT1F5196D0uL2tpWobOF6Xiu
         scu5CWliDRO9tBEROkm5Sg9vUW60EdSVH4iKBrobqW5++i43tGryjRAAMcv8zC1Q2C
         mzzMkylnpa17YCfNMO58pMzuq5hjhvB/teHsz/dl7xXNYsRTvAAHLSyKqrO4U8vFr0
         YwcWNwpPYJIb1Bo4hOUsFHFpIu6YerwShemGLGr+LTj3W9hV/1NMxVkXbhYc5pzH3Y
         r9G94g4E6jJKG8zuQdEFp1Wt5YNvtVTidVTnHKmpX2li0TLOsqRzeRJAigG4E/XtX7
         zzoMSbWIsOYDA==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup.patel@wdc.com>,
        Atish Patra <atishp@atishpatra.org>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvm-riscv@lists.infradead.org
Subject: [PATCH 5/5] riscv: head: remove useless __PAGE_ALIGNED_BSS and .balign
Date:   Mon, 29 Nov 2021 00:07:41 +0800
Message-Id: <20211128160741.2122-6-jszhang@kernel.org>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211128160741.2122-1-jszhang@kernel.org>
References: <20211128160741.2122-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After commit 83e7b8769a08 ("RISC-V: move empty_zero_page definition to
C and export it"), the empty_zero_page has been moved outside head.S,
the __PAGE_ALIGNED_BSS and .balign LoCs are useless, clean up them.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 arch/riscv/kernel/head.S | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
index 3ce95f8783bd..c128a32c2ed3 100644
--- a/arch/riscv/kernel/head.S
+++ b/arch/riscv/kernel/head.S
@@ -447,7 +447,3 @@ ENTRY(reset_regs)
 	ret
 END(reset_regs)
 #endif /* CONFIG_RISCV_M_MODE */
-
-__PAGE_ALIGNED_BSS
-	/* Empty zero page */
-	.balign PAGE_SIZE
-- 
2.34.0

