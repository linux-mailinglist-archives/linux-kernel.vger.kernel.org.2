Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21A3D34E9B2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 15:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbhC3N5Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 09:57:16 -0400
Received: from mail-m17635.qiye.163.com ([59.111.176.35]:47938 "EHLO
        mail-m17635.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231701AbhC3N4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 09:56:50 -0400
Received: from ubuntu.localdomain (unknown [36.152.145.182])
        by mail-m17635.qiye.163.com (Hmail) with ESMTPA id CF2F4400267;
        Tue, 30 Mar 2021 21:56:47 +0800 (CST)
From:   zhouchuangao <zhouchuangao@vivo.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atish.patra@wdc.com>,
        Anup Patel <anup.patel@wdc.com>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Zong Li <zong.li@sifive.com>,
        Nick Kossifidis <mick@ics.forth.gr>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     zhouchuangao <zhouchuangao@vivo.com>
Subject: [PATCH] riscv/mm: Use BUG_ON instead of if condition followed by BUG.
Date:   Tue, 30 Mar 2021 06:56:26 -0700
Message-Id: <1617112588-7750-1-git-send-email-zhouchuangao@vivo.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZGUxMThpKH0xCGU5IVkpNSkxKSklNS0NJT05VEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKTFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MiI6Ehw5Vj8cQzcqKxpRAio9
        OR4aCT1VSlVKTUpMSkpJTUtDTkhIVTMWGhIXVQETFA4YEw4aFRwaFDsNEg0UVRgUFkVZV1kSC1lB
        WUhNVUpOSVVKT05VSkNJWVdZCAFZQUlKSU43Bg++
X-HM-Tid: 0a78836c2db0d991kuwscf2f4400267
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BUG_ON() uses unlikely in if(), which can be optimized at compile time.

Signed-off-by: zhouchuangao <zhouchuangao@vivo.com>
---
 arch/riscv/mm/init.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 067583a..a7fa5e2 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -213,8 +213,8 @@ static phys_addr_t alloc_pte_late(uintptr_t va)
 	unsigned long vaddr;
 
 	vaddr = __get_free_page(GFP_KERNEL);
-	if (!vaddr || !pgtable_pte_page_ctor(virt_to_page(vaddr)))
-		BUG();
+	BUG_ON(!vaddr || !pgtable_pte_page_ctor(virt_to_page(vaddr)));
+
 	return __pa(vaddr);
 }
 
-- 
2.7.4

