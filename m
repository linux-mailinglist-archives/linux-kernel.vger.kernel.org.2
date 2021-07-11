Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E3843C3C9B
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jul 2021 14:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232850AbhGKM5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jul 2021 08:57:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:59156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229688AbhGKM5O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jul 2021 08:57:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0F7CC60FEE;
        Sun, 11 Jul 2021 12:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626008068;
        bh=my6KtbMA2urGePFHT50DPUK/PsrXdbu/QUeCM5JBDWI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IYVv63zHOldl6z50f473dJuDd6ZqR8I//5kwrw62HXrVrzwckrwdBkRldDi7AgoEt
         lz15N/dYF5oZZiYxi2CNifN8nULOjlk1U9+Qn4Qzid/28KBbzjI926sHkmfyCrfhyv
         ekCry326l3kjKwEaImD8xm0g7EUR6Pb7uolW4NK+8Yyu5MJy/IYVX3YbrOs2ZnKwFe
         MEug3T15Tx80l/Ntsa1DbN4mblfyJcLJHMhzxNhV1p8YPLOIVGA8Rl6bL5TpWKvITD
         vxe0ebtCbLlkRwNWChVg6B7srKxu0hRa9XGpp0HVrH+HE8WWleZihuLs6pYY0qIYkF
         8+2U1Wh9qDwiQ==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Tomer Tayar <ttayar@habana.ai>
Subject: [PATCH 3/7] habanalabs: fix nullifying of destroyed mmu pgt pool
Date:   Sun, 11 Jul 2021 15:54:14 +0300
Message-Id: <20210711125418.17533-3-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210711125418.17533-1-ogabbay@kernel.org>
References: <20210711125418.17533-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomer Tayar <ttayar@habana.ai>

In case of host-resident MMU, when the page tables pool is destroyed,
its pointer is not nullified correctly.
As a result, on a device fini which happens after a failing reset, the
already destroyed pool is accessed, which leads to a kernel panic.
The patch fixes the setting of the pool pointer to NULL.

Signed-off-by: Tomer Tayar <ttayar@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/mmu/mmu_v1.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/misc/habanalabs/common/mmu/mmu_v1.c b/drivers/misc/habanalabs/common/mmu/mmu_v1.c
index c5e93ff32586..0f536f79dd9c 100644
--- a/drivers/misc/habanalabs/common/mmu/mmu_v1.c
+++ b/drivers/misc/habanalabs/common/mmu/mmu_v1.c
@@ -470,13 +470,13 @@ static void hl_mmu_v1_fini(struct hl_device *hdev)
 	if (!ZERO_OR_NULL_PTR(hdev->mmu_priv.hr.mmu_shadow_hop0)) {
 		kvfree(hdev->mmu_priv.dr.mmu_shadow_hop0);
 		gen_pool_destroy(hdev->mmu_priv.dr.mmu_pgt_pool);
-	}
 
-	/* Make sure that if we arrive here again without init was called we
-	 * won't cause kernel panic. This can happen for example if we fail
-	 * during hard reset code at certain points
-	 */
-	hdev->mmu_priv.dr.mmu_shadow_hop0 = NULL;
+		/* Make sure that if we arrive here again without init was
+		 * called we won't cause kernel panic. This can happen for
+		 * example if we fail during hard reset code at certain points
+		 */
+		hdev->mmu_priv.dr.mmu_shadow_hop0 = NULL;
+	}
 }
 
 /**
-- 
2.25.1

