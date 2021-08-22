Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D322A3F3ECC
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Aug 2021 11:04:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232775AbhHVJFV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Aug 2021 05:05:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:47482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231147AbhHVJFU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Aug 2021 05:05:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 59D7B61250;
        Sun, 22 Aug 2021 09:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629623080;
        bh=DOBqiB1G8c7H0dYwOZIxrp5X2w7QbH40W11gbM9HK6M=;
        h=From:To:Cc:Subject:Date:From;
        b=fwx267EZCwOvPYaP+8ltW2hSABX64kDuD04Fy/Zyu7fSg7i6D4TDB7ctA0oE9DWXi
         uL8B6XnrURq83/Dgmn41KMRVeL5VK1DezS7TsL8F6W9yKq+13PVHpBhR1CXwx1hWlo
         nQypYRHCDnhAB4HmN7wB9cfJlr7FwWIa7sqmxk6O8lJwJB+7rDaPkG8QXNO24lo0dg
         ah4MfAmHqm6NS5hiEo3GvSkDoUHQAXhv3nCftWNLbMfqpYS4hN7G6I96fiI1374CJ4
         o3EGcPLa6KH7OwJ1VSSLRrYYV5OQTGgwZw+IPDJCXKMiAxwfg5rcL7cCD44hFpItRq
         qfZkDMAmbn8Ng==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     farah kassabri <fkassabri@habana.ai>
Subject: [PATCH] habanalabs: cannot sleep while holding spinlock
Date:   Sun, 22 Aug 2021 12:04:34 +0300
Message-Id: <20210822090434.16589-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: farah kassabri <fkassabri@habana.ai>

Fix 2 areas in the code where it's possible the code will
go to sleep while holding a spinlock.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: farah kassabri <fkassabri@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/command_buffer.c | 2 --
 drivers/misc/habanalabs/common/memory.c         | 2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/misc/habanalabs/common/command_buffer.c b/drivers/misc/habanalabs/common/command_buffer.c
index 58afefcd74f3..8132a84698d5 100644
--- a/drivers/misc/habanalabs/common/command_buffer.c
+++ b/drivers/misc/habanalabs/common/command_buffer.c
@@ -314,8 +314,6 @@ int hl_cb_create(struct hl_device *hdev, struct hl_cb_mgr *mgr,
 
 	spin_lock(&mgr->cb_lock);
 	rc = idr_alloc(&mgr->cb_handles, cb, 1, 0, GFP_ATOMIC);
-	if (rc < 0)
-		rc = idr_alloc(&mgr->cb_handles, cb, 1, 0, GFP_KERNEL);
 	spin_unlock(&mgr->cb_lock);
 
 	if (rc < 0) {
diff --git a/drivers/misc/habanalabs/common/memory.c b/drivers/misc/habanalabs/common/memory.c
index 72954abf20fe..8cf5437c0390 100644
--- a/drivers/misc/habanalabs/common/memory.c
+++ b/drivers/misc/habanalabs/common/memory.c
@@ -126,7 +126,7 @@ static int alloc_device_memory(struct hl_ctx *ctx, struct hl_mem_in *args,
 
 	spin_lock(&vm->idr_lock);
 	handle = idr_alloc(&vm->phys_pg_pack_handles, phys_pg_pack, 1, 0,
-				GFP_KERNEL);
+				GFP_ATOMIC);
 	spin_unlock(&vm->idr_lock);
 
 	if (handle < 0) {
-- 
2.17.1

