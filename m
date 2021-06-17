Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A60673AB639
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 16:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233010AbhFQOnD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 10:43:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:48326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230299AbhFQOnC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 10:43:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5CE1B610EA;
        Thu, 17 Jun 2021 14:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623940855;
        bh=bt1YpiMtkcXdekkK/t335lyROgMKJ3Q0LlsS66GZRI8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L7IqyvoSFI3vi2a+VzmclxJFTL6OMuSL9fBAVJP7s/rfYF5naAkccChLlXPTbHjTD
         0HGwtvsA042rJQDoLtAE22TFIvhuvWAD/99luQeNvf7b6LLoPejM1Wq1AdliHb6V1D
         VUpcish0GLUDhjNxdALBwTuk9PzfUJEdLG/GlOJDz9+ZBoAOheZg5oa++9yTUA5pYc
         xqXq4TMNa8xp1XS3tOVlwCSWUTYFaDNxoIbsWaL6f2t0plXaf44IaTpogeYH6ykSIg
         +FmsRnddSiMnCoYtrQKoRyCt/yLzfrzfALdb4xGisyUdZzl9u/AJZoJHSJTbL8Gaxq
         PBsAdXHyxOdQQ==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Zvika Yehudai <zyehudai@habana.ai>
Subject: [PATCH 2/3] habanalabs: fix typo
Date:   Thu, 17 Jun 2021 17:40:47 +0300
Message-Id: <20210617144048.4655-2-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210617144048.4655-1-ogabbay@kernel.org>
References: <20210617144048.4655-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zvika Yehudai <zyehudai@habana.ai>

fix a type in comment

Signed-off-by: Zvika Yehudai <zyehudai@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/habanalabs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index e545574b1d38..f8b7080e0570 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -2119,7 +2119,7 @@ struct hl_mmu_funcs {
  * @kernel_queues: array of hl_hw_queue.
  * @cs_mirror_list: CS mirror list for TDR.
  * @cs_mirror_lock: protects cs_mirror_list.
- * @kernel_cb_mgr: command buffer manager for creating/destroying/handling CGs.
+ * @kernel_cb_mgr: command buffer manager for creating/destroying/handling CBs.
  * @event_queue: event queue for IRQ from CPU-CP.
  * @dma_pool: DMA pool for small allocations.
  * @cpu_accessible_dma_mem: Host <-> CPU-CP shared memory CPU address.
-- 
2.25.1

