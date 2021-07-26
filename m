Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB553D52E5
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 07:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231707AbhGZFCc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 01:02:32 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:5207 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbhGZFCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 01:02:31 -0400
Received: (Authenticated sender: alex@ghiti.fr)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 35CB2240002;
        Mon, 26 Jul 2021 05:42:56 +0000 (UTC)
From:   Alexandre Ghiti <alex@ghiti.fr>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Alexandre Ghiti <alex@ghiti.fr>
Subject: [PATCH -fixes] riscv: Fix comment regarding kernel mapping overlapping with IS_ERR_VALUE
Date:   Mon, 26 Jul 2021 07:42:54 +0200
Message-Id: <20210726054254.21801-1-alex@ghiti.fr>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current comment states that we check if the 64-bit kernel mapping
overlaps with the last 4K of the address space that is reserved to
error values in create_kernel_page_table, which is not the case since it
is done in setup_vm. But anyway, remove the reference to any function
and simply note that in 64-bit kernel, the check should be done as soon
as the kernel mapping base address is known.

Fixes: db6b84a368b4 ("riscv: Make sure the kernel mapping does not
overlap with IS_ERR_VALUE")
Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
---
 arch/riscv/mm/init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index a14bf3910eec..79a2e02924e4 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -191,7 +191,7 @@ static void __init setup_bootmem(void)
 	 * if end of dram is equal to maximum addressable memory.  For 64-bit
 	 * kernel, this problem can't happen here as the end of the virtual
 	 * address space is occupied by the kernel mapping then this check must
-	 * be done in create_kernel_page_table.
+	 * be done as soon as the kernel mapping base address is determined.
 	 */
 	max_mapped_addr = __pa(~(ulong)0);
 	if (max_mapped_addr == (dram_end - 1))
-- 
2.30.2

