Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E8523B9124
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 13:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236293AbhGALaD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 07:30:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:37166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236273AbhGAL36 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 07:29:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 37A6161467
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jul 2021 11:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625138847;
        bh=ia/BAJMnk/VZ3ODYcwWFFE3sFihqQovSi2X0QwO/kZg=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=FrFKc6Xyf1WQQrATlsRx3V9Vq1SQoRTCuHXqmN3fqcnUn71P5Xc/2CWB6fbETnWJB
         iFX4K+7+kC1O7tWvLquEWoMHAQvb4c/aGcLqnzDg6+RTi73GyGKbYe2+UvLr9eZdsM
         zNb1y540rjiIjnxZrpD3MeO7f0pQ0LNWIMhQ5ecw3oFK1e6sEYwpO2vHSUVrW9mh0J
         o1MuGUsMETYI03y5E29+YcWyAX/ecyXGW5ZNsw0JVLtfejGjAbljJopVNvrRvlqvu7
         asmgYgcqBI3/Qt6/N+vuPp5AedA8baKIaoGjmifzhcnquAIrYcyEL3KOsr8U7Epjvw
         9PUA+dFIp75WQ==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] habanalabs: user mappings can be 64-bit
Date:   Thu,  1 Jul 2021 14:27:16 +0300
Message-Id: <20210701112717.9540-6-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210701112717.9540-1-ogabbay@kernel.org>
References: <20210701112717.9540-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Increase the size variable in the userptr structure to 64-bit. That
variable describes the size of the memory allocation of the user that
is now being mapped into the device. The mapping can be larger than
4GB, so we need to support it.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/debugfs.c    | 4 ++--
 drivers/misc/habanalabs/common/habanalabs.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/habanalabs/common/debugfs.c b/drivers/misc/habanalabs/common/debugfs.c
index fd44c3b66d3b..77f7c2aa571d 100644
--- a/drivers/misc/habanalabs/common/debugfs.c
+++ b/drivers/misc/habanalabs/common/debugfs.c
@@ -213,7 +213,7 @@ static int userptr_show(struct seq_file *s, void *data)
 			seq_puts(s, "----------------------------------------------------------\n");
 		}
 		seq_printf(s,
-			"    0x%-14llx      %-10u    %-30s\n",
+			"    0x%-14llx      %-10llu    %-30s\n",
 			userptr->addr, userptr->size, dma_dir[userptr->dir]);
 	}
 
@@ -261,7 +261,7 @@ static int vm_show(struct seq_file *s, void *data)
 			if (*vm_type == VM_TYPE_USERPTR) {
 				userptr = hnode->ptr;
 				seq_printf(s,
-					"    0x%-14llx      %-10u\n",
+					"    0x%-14llx      %-10llu\n",
 					hnode->vaddr, userptr->size);
 			} else {
 				phys_pg_pack = hnode->ptr;
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 31fda9e41fe7..5ae95d2abaa6 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -1429,7 +1429,7 @@ struct hl_userptr {
 	enum dma_data_direction dir;
 	struct list_head	debugfs_list;
 	u64			addr;
-	u32			size;
+	u64			size;
 	u8			dma_mapped;
 };
 
-- 
2.25.1

