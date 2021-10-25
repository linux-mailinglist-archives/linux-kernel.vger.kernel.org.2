Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A80243966C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 14:36:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233149AbhJYMjE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 08:39:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:42422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233048AbhJYMjD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 08:39:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5A63660240;
        Mon, 25 Oct 2021 12:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635165401;
        bh=IE+tCg4W9FCCTZTtI5JC7KM/NHBHd1SR7Ij4dSme+pk=;
        h=From:To:Cc:Subject:Date:From;
        b=KQTsWKOhSoJsd53I8b5fbyM9h3KFz+KLtQLU5ZHI/Cn/oMGRP7yUJf1+J8y6Is9sX
         P4pcwnJ/swbYWWGW0PHWkhXBepXVB4qOFa5Kk/gmOpNYlP/9jIbrqv61aN+ItoImQU
         wQmMO94sPT1zQrHDq3V6zhA+8JZs27AuXbjf77Q9/Bn8Ah8IVmG/GeWyPnog+wXntt
         OMwdBAHK3lmDcj85ZBsKBk1HNHptpLxVCjPaLT+ilPInYxwRDQLXnkOATGOAeD7Jio
         eBfzkERYJljANN6SQZ/Vfb123QymiAGOzogxaqnOnxtaJ+3V0FlCPpfmFPkTLmYeLT
         WcCw17Nf3wqHg==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Yuri Nudelman <ynudelman@habana.ai>
Subject: [PATCH 1/4] habanalabs: print va_range in vm node debugfs
Date:   Mon, 25 Oct 2021 15:36:33 +0300
Message-Id: <20211025123636.2842618-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yuri Nudelman <ynudelman@habana.ai>

VA range info could assist in debugging VA allocation bugs.

Signed-off-by: Yuri Nudelman <ynudelman@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/debugfs.c | 25 ++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/misc/habanalabs/common/debugfs.c b/drivers/misc/habanalabs/common/debugfs.c
index 1f2a3dc6c4e2..a239c5679f95 100644
--- a/drivers/misc/habanalabs/common/debugfs.c
+++ b/drivers/misc/habanalabs/common/debugfs.c
@@ -235,6 +235,8 @@ static int vm_show(struct seq_file *s, void *data)
 	struct hl_vm_hash_node *hnode;
 	struct hl_userptr *userptr;
 	struct hl_vm_phys_pg_pack *phys_pg_pack = NULL;
+	struct hl_va_range *va_range;
+	struct hl_vm_va_block *va_block;
 	enum vm_type *vm_type;
 	bool once = true;
 	u64 j;
@@ -314,6 +316,29 @@ static int vm_show(struct seq_file *s, void *data)
 
 	spin_unlock(&dev_entry->ctx_mem_hash_spinlock);
 
+	mutex_lock(&dev_entry->hdev->fpriv_list_lock);
+	ctx = dev_entry->hdev->compute_ctx;
+	if (ctx)
+		hl_ctx_get(dev_entry->hdev, ctx);
+	mutex_unlock(&dev_entry->hdev->fpriv_list_lock);
+	if (ctx) {
+		seq_puts(s, "\nVA ranges:\n\n");
+		for (i = HL_VA_RANGE_TYPE_HOST ; i < HL_VA_RANGE_TYPE_MAX ; ++i) {
+			va_range = ctx->va_range[i];
+			seq_printf(s, "   va_range %d\n", i);
+			seq_puts(s, "---------------------\n");
+			mutex_lock(&va_range->lock);
+			list_for_each_entry(va_block, &va_range->list, node) {
+				seq_printf(s, "%#16llx - %#16llx (%#llx)\n",
+					   va_block->start, va_block->end,
+					   va_block->size);
+			}
+			mutex_unlock(&va_range->lock);
+			seq_puts(s, "\n");
+		}
+		hl_ctx_put(ctx);
+	}
+
 	if (!once)
 		seq_puts(s, "\n");
 
-- 
2.25.1

