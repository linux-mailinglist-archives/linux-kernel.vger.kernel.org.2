Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0392833A4EA
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Mar 2021 14:02:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235451AbhCNM7h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Mar 2021 08:59:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:47936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235207AbhCNM7U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Mar 2021 08:59:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4CAD264E0C;
        Sun, 14 Mar 2021 12:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615726760;
        bh=AYAHAcUzMYK/EIG2rYcBHJVOEjy/GRB0koG/2khZmgY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tHzOgcDKlDSFO3gHViQBDUQKAH3B59QolzQ0hsJURRgf0NRQk9FP9tgry6klQiTJj
         y8cx6KUWuw50LsUjfC3tLfaTSIw1+T1gt0ZYWHRWsIKQ7Yu2orWsGzoXskrCiyuf8q
         w5TSuuQTAMsLb/uVdbljUMqsfs4sVlox8fMOivXRuE9i3dw133pH0c+9YEoIv9C98d
         sBJYwR8tDAAEYdasd6fXFqsd8vgWe6OGuPOm9P7jm9+YpJKXuxTas++WgBiTGd4YZF
         Y/LwkjWzaISHTZRIDE/q045WKuVa/Kilj8BR2ZxwMi48bfKHO0iLM6QfBJ3j6e25Z3
         ij+ywSNFckjDw==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     farah kassabri <fkassabri@habana.ai>
Subject: [PATCH 3/4] habanalabs: avoid soft lockup bug upon mapping error
Date:   Sun, 14 Mar 2021 14:59:11 +0200
Message-Id: <20210314125912.9306-3-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210314125912.9306-1-ogabbay@kernel.org>
References: <20210314125912.9306-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: farah kassabri <fkassabri@habana.ai>

Add a little sleep between page unmappings in case mapping of
large number of host pages failed, in order to
avoid soft lockup bug during the rollback.

Signed-off-by: farah kassabri <fkassabri@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/memory.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/habanalabs/common/memory.c b/drivers/misc/habanalabs/common/memory.c
index 1b69573369cf..6530fddbbc21 100644
--- a/drivers/misc/habanalabs/common/memory.c
+++ b/drivers/misc/habanalabs/common/memory.c
@@ -857,6 +857,7 @@ static int map_phys_pg_pack(struct hl_ctx *ctx, u64 vaddr,
 	u64 next_vaddr = vaddr, paddr, mapped_pg_cnt = 0, i;
 	u32 page_size = phys_pg_pack->page_size;
 	int rc = 0;
+	bool is_host_addr;
 
 	for (i = 0 ; i < phys_pg_pack->npages ; i++) {
 		paddr = phys_pg_pack->pages[i];
@@ -878,6 +879,8 @@ static int map_phys_pg_pack(struct hl_ctx *ctx, u64 vaddr,
 	return 0;
 
 err:
+	is_host_addr = !hl_is_dram_va(hdev, vaddr);
+
 	next_vaddr = vaddr;
 	for (i = 0 ; i < mapped_pg_cnt ; i++) {
 		if (hl_mmu_unmap_page(ctx, next_vaddr, page_size,
@@ -888,6 +891,17 @@ static int map_phys_pg_pack(struct hl_ctx *ctx, u64 vaddr,
 					phys_pg_pack->pages[i], page_size);
 
 		next_vaddr += page_size;
+
+		/*
+		 * unmapping on Palladium can be really long, so avoid a CPU
+		 * soft lockup bug by sleeping a little between unmapping pages
+		 *
+		 * In addition, on host num of pages could be huge,
+		 * because page size could be 4KB, so when unmapping host
+		 * pages sleep every 32K pages to avoid soft lockup
+		 */
+		if (hdev->pldm || (is_host_addr && (i & 0x7FFF) == 0))
+			usleep_range(50, 200);
 	}
 
 	return rc;
@@ -921,9 +935,9 @@ static void unmap_phys_pg_pack(struct hl_ctx *ctx, u64 vaddr,
 		 * unmapping on Palladium can be really long, so avoid a CPU
 		 * soft lockup bug by sleeping a little between unmapping pages
 		 *
-		 * In addition, when unmapping host memory we pass through
-		 * the Linux kernel to unpin the pages and that takes a long
-		 * time. Therefore, sleep every 32K pages to avoid soft lockup
+		 * In addition, on host num of pages could be huge,
+		 * because page size could be 4KB, so when unmapping host
+		 * pages sleep every 32K pages to avoid soft lockup
 		 */
 		if (hdev->pldm || (is_host_addr && (i & 0x7FFF) == 0))
 			usleep_range(50, 200);
-- 
2.25.1

