Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BDB83F04FA
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 15:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237916AbhHRNk0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 09:40:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:40752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237100AbhHRNkE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 09:40:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 87047610A6;
        Wed, 18 Aug 2021 13:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629293969;
        bh=TPqhk6X3mttnbv1PY+ZjY8Ft4/VHjvzPkxDqF/OjYrw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sJ0RHsrGLA7zlqX6Pq4vv9FKCpJq7KjQ9uuaK3/9s2jnNsX5k3g/0EfZV+dqbzEZU
         ecVMfrapb4fu637IhchPVggIukaMPRCQ7l77jBhMPrt08+b5aMvu0aWCT83S1A0+WA
         PzOjpvqeIBiOB/PqKSJqGR6x2/+ONO14uYawezes58/nwoP5Rh6wqO8k+3VgIJ1j26
         nhCIZHT7WXZgbOCuc9HYVTyd19NW5MupSaW9hu+TVQf7GdSz5PcV+86v+YFbgxXLhE
         3OE6u4qqoxZzIHGq/CGy/WfRfw376qSXYgV25xX1YT1/dWRJbk7SuBwRbWcaVQzCaZ
         HhjYgpw8d+pRQ==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Yuri Nudelman <ynudelman@habana.ai>
Subject: [PATCH 03/16] habanalabs: save pid per userptr
Date:   Wed, 18 Aug 2021 16:39:09 +0300
Message-Id: <20210818133922.63637-3-ogabbay@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210818133922.63637-1-ogabbay@kernel.org>
References: <20210818133922.63637-1-ogabbay@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yuri Nudelman <ynudelman@habana.ai>

Currently userptr endpoint in debugfs prints out virtual addresses
in the user process memory space, without specifying their owner process
ID. User space virtual address is meaningless without knowing the owner
process.

Signed-off-by: Yuri Nudelman <ynudelman@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/debugfs.c    | 8 ++++----
 drivers/misc/habanalabs/common/habanalabs.h | 2 ++
 drivers/misc/habanalabs/common/memory.c     | 1 +
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/habanalabs/common/debugfs.c b/drivers/misc/habanalabs/common/debugfs.c
index 2c587af28f9b..264424c96959 100644
--- a/drivers/misc/habanalabs/common/debugfs.c
+++ b/drivers/misc/habanalabs/common/debugfs.c
@@ -209,12 +209,12 @@ static int userptr_show(struct seq_file *s, void *data)
 		if (first) {
 			first = false;
 			seq_puts(s, "\n");
-			seq_puts(s, " user virtual address     size             dma dir\n");
+			seq_puts(s, " pid      user virtual address     size             dma dir\n");
 			seq_puts(s, "----------------------------------------------------------\n");
 		}
-		seq_printf(s,
-			"    0x%-14llx      %-10llu    %-30s\n",
-			userptr->addr, userptr->size, dma_dir[userptr->dir]);
+		seq_printf(s, " %-7d  0x%-14llx      %-10llu    %-30s\n",
+				userptr->pid, userptr->addr, userptr->size,
+				dma_dir[userptr->dir]);
 	}
 
 	spin_unlock(&dev_entry->userptr_spinlock);
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index d40778eccb14..b950b5140610 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -1452,6 +1452,7 @@ struct hl_ctx_mgr {
  * @sgt: pointer to the scatter-gather table that holds the pages.
  * @dir: for DMA unmapping, the direction must be supplied, so save it.
  * @debugfs_list: node in debugfs list of command submissions.
+ * @pid: the pid of the user process owning the memory
  * @addr: user-space virtual address of the start of the memory area.
  * @size: size of the memory area to pin & map.
  * @dma_mapped: true if the SG was mapped to DMA addresses, false otherwise.
@@ -1464,6 +1465,7 @@ struct hl_userptr {
 	struct sg_table		*sgt;
 	enum dma_data_direction dir;
 	struct list_head	debugfs_list;
+	pid_t			pid;
 	u64			addr;
 	u64			size;
 	u8			dma_mapped;
diff --git a/drivers/misc/habanalabs/common/memory.c b/drivers/misc/habanalabs/common/memory.c
index a75207611b9b..2f990d185cfd 100644
--- a/drivers/misc/habanalabs/common/memory.c
+++ b/drivers/misc/habanalabs/common/memory.c
@@ -2276,6 +2276,7 @@ int hl_pin_host_memory(struct hl_device *hdev, u64 addr, u64 size,
 		return -EINVAL;
 	}
 
+	userptr->pid = current->pid;
 	userptr->sgt = kzalloc(sizeof(*userptr->sgt), GFP_KERNEL);
 	if (!userptr->sgt)
 		return -ENOMEM;
-- 
2.17.1

