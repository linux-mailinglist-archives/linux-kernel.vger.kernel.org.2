Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED3545B42B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 07:05:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231373AbhKXGIl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 01:08:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:45318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229926AbhKXGIi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 01:08:38 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id CFF9460F5D;
        Wed, 24 Nov 2021 06:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637733928;
        bh=/HbIf68YRKbhDZe5rHyxTQRnyZBZEnswWOQLwFovXW0=;
        h=From:To:Cc:Subject:Date:From;
        b=khivtZLGQQs8U72VVKoiEYN0lS0NNBU95NQO93UA+Ajjb8zG4UQHLMQFy2bof7woh
         1YL5viroYHJgmpfqha9kEJ3Ov9yLiqueSWBPNuba1lhVCRtCFG9DQDkey99fnBYNY/
         Jf8MDr1Azi/TjLjBeCGS0MUoX6W+lAXlLw9an4EwcApCdmZ6uHfWYiGfz2Bl+9xHJm
         7Au7Z8GAuciFdMmh/6eLnbDwtdgwEkTd6fqiG7BcM6HD/2V9PVcVYCU43dTE8XfH6P
         ScvPwO0jOqk0dXFQ7KzEFMxlR1+vQAAX4XT7r4V6CWiR+BO1n6mhzhmZZjATneqylU
         uMTjTKCBEFVTQ==
From:   guoren@kernel.org
To:     guoren@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>,
        Alexandre Ghiti <alex@ghiti.fr>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <Atish.Patra@wdc.com>
Subject: [PATCH] riscv: Fixup one-page wasting
Date:   Wed, 24 Nov 2021 14:05:21 +0800
Message-Id: <20211124060521.614015-1-guoren@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

For small memory systems(Allwinner D1s/F133), one page size memory
cannot be ignored.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Cc: Alexandre Ghiti <alex@ghiti.fr>
Cc: Anup Patel <anup@brainfault.org>
Cc: Atish Patra <Atish.Patra@wdc.com>
---
 arch/riscv/mm/init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 24b2b8044602..097bb3bc4020 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -241,9 +241,9 @@ unsigned long riscv_pfn_base __ro_after_init;
 EXPORT_SYMBOL(riscv_pfn_base);
 
 pgd_t swapper_pg_dir[PTRS_PER_PGD] __page_aligned_bss;
-pgd_t trampoline_pg_dir[PTRS_PER_PGD] __page_aligned_bss;
 static pte_t fixmap_pte[PTRS_PER_PTE] __page_aligned_bss;
 
+pgd_t trampoline_pg_dir[PTRS_PER_PGD] __initdata __aligned(PAGE_SIZE);
 pgd_t early_pg_dir[PTRS_PER_PGD] __initdata __aligned(PAGE_SIZE);
 static pmd_t __maybe_unused early_dtb_pmd[PTRS_PER_PMD] __initdata __aligned(PAGE_SIZE);
 
-- 
2.25.1

