Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2513C362EC4
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 11:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236062AbhDQJHY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Apr 2021 05:07:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:37522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236014AbhDQJHS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Apr 2021 05:07:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E9C8B611C2;
        Sat, 17 Apr 2021 09:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618650412;
        bh=qoUdFQ+01gRu0Eaw0iO1vy2slWYk/C0/38n/8q59CEw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PWz4sKtOBNfsVpzJRhx0sSoh5kZDi9tpCV6c3inuoMgEd4fFADUxUsIVIzLPgGbsm
         8/p0fbEh0XF6ErKMuEtxKGbIxer6x0hDudW6rSSw41+iCx9N2Dij/ZAnhhEf7IyRAN
         MOpJBdwnIOw0Vnl7EIPP1geVxwrgCtBYYOpsuMOdRyUuNPgE4aM8cYg8vuDLytSVoi
         oy99XpBID5oGBjaKdjLD05WHVJkk6uI2iiKI988U/RAMSxqxuNMNX5wJ9P5Z+54XLK
         04yznZYOuXlAZFDLokc5WYhYazrumO9URFl2viwq/KgJjX0RfnfqGSjT+WKJgvLVXo
         ya/7WYuIiC3AQ==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Alon Mizrahi <amizrahi@habana.ai>
Subject: [PATCH 7/7] habanalabs: use mmu cache range invalidation
Date:   Sat, 17 Apr 2021 12:06:38 +0300
Message-Id: <20210417090638.9802-7-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210417090638.9802-1-ogabbay@kernel.org>
References: <20210417090638.9802-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alon Mizrahi <amizrahi@habana.ai>

Use mmu cache range invalidation instead of entire cache invalidation
because it yields better performance.

In GOYA and GAUDI, always use entire cache invalidation because these
ASICs don't support range invalidation.

Signed-off-by: Alon Mizrahi <amizrahi@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/habanalabs.h |  2 +-
 drivers/misc/habanalabs/common/memory.c     |  8 ++--
 drivers/misc/habanalabs/gaudi/gaudi.c       | 49 ++------------------
 drivers/misc/habanalabs/goya/goya.c         | 51 ++-------------------
 4 files changed, 16 insertions(+), 94 deletions(-)

diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 9ee7a583b614..07c2713ba372 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -1035,7 +1035,7 @@ struct hl_asic_funcs {
 	int (*mmu_invalidate_cache)(struct hl_device *hdev, bool is_hard,
 					u32 flags);
 	int (*mmu_invalidate_cache_range)(struct hl_device *hdev, bool is_hard,
-			u32 asid, u64 va, u64 size);
+				u32 flags, u32 asid, u64 va, u64 size);
 	int (*send_heartbeat)(struct hl_device *hdev);
 	void (*set_clock_gating)(struct hl_device *hdev);
 	void (*disable_clock_gating)(struct hl_device *hdev);
diff --git a/drivers/misc/habanalabs/common/memory.c b/drivers/misc/habanalabs/common/memory.c
index 2938cbbafbbc..b92878d76f23 100644
--- a/drivers/misc/habanalabs/common/memory.c
+++ b/drivers/misc/habanalabs/common/memory.c
@@ -1117,7 +1117,8 @@ static int map_device_va(struct hl_ctx *ctx, struct hl_mem_in *args,
 		goto map_err;
 	}
 
-	rc = hdev->asic_funcs->mmu_invalidate_cache(hdev, false, *vm_type);
+	rc = hdev->asic_funcs->mmu_invalidate_cache_range(hdev, false,
+		*vm_type, ctx->asid, ret_vaddr, phys_pg_pack->total_size);
 
 	mutex_unlock(&ctx->mmu_lock);
 
@@ -1261,8 +1262,9 @@ static int unmap_device_va(struct hl_ctx *ctx, struct hl_mem_in *args,
 	 * at the loop end rather than for each iteration
 	 */
 	if (!ctx_free)
-		rc = hdev->asic_funcs->mmu_invalidate_cache(hdev, true,
-								*vm_type);
+		rc = hdev->asic_funcs->mmu_invalidate_cache_range(hdev, true,
+				*vm_type, ctx->asid, vaddr,
+				phys_pg_pack->total_size);
 
 	mutex_unlock(&ctx->mmu_lock);
 
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 45c40549ded4..1d5930578e07 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -7863,52 +7863,13 @@ static int gaudi_mmu_invalidate_cache(struct hl_device *hdev, bool is_hard,
 }
 
 static int gaudi_mmu_invalidate_cache_range(struct hl_device *hdev,
-				bool is_hard, u32 asid, u64 va, u64 size)
+						bool is_hard, u32 flags,
+						u32 asid, u64 va, u64 size)
 {
-	struct gaudi_device *gaudi = hdev->asic_specific;
-	u32 status, timeout_usec;
-	u32 inv_data;
-	u32 pi;
-	int rc;
-
-	if (!(gaudi->hw_cap_initialized & HW_CAP_MMU) ||
-		hdev->hard_reset_pending)
-		return 0;
-
-	if (hdev->pldm)
-		timeout_usec = GAUDI_PLDM_MMU_TIMEOUT_USEC;
-	else
-		timeout_usec = MMU_CONFIG_TIMEOUT_USEC;
-
-	/*
-	 * TODO: currently invalidate entire L0 & L1 as in regular hard
-	 * invalidation. Need to apply invalidation of specific cache
-	 * lines with mask of ASID & VA & size.
-	 * Note that L1 with be flushed entirely in any case.
+	/* Treat as invalidate all because there is no range invalidation
+	 * in Gaudi
 	 */
-
-	/* L0 & L1 invalidation */
-	inv_data = RREG32(mmSTLB_CACHE_INV);
-	/* PI is 8 bit */
-	pi = ((inv_data & STLB_CACHE_INV_PRODUCER_INDEX_MASK) + 1) & 0xFF;
-	WREG32(mmSTLB_CACHE_INV,
-		(inv_data & STLB_CACHE_INV_INDEX_MASK_MASK) | pi);
-
-	rc = hl_poll_timeout(
-		hdev,
-		mmSTLB_INV_CONSUMER_INDEX,
-		status,
-		status == pi,
-		1000,
-		timeout_usec);
-
-	if (rc) {
-		dev_err_ratelimited(hdev->dev,
-					"MMU cache invalidation timeout\n");
-		hl_device_reset(hdev, HL_RESET_HARD);
-	}
-
-	return rc;
+	return hdev->asic_funcs->mmu_invalidate_cache(hdev, is_hard, flags);
 }
 
 static int gaudi_mmu_update_asid_hop0_addr(struct hl_device *hdev,
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index d554304b6868..678fbbc6521b 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -5178,54 +5178,13 @@ static int goya_mmu_invalidate_cache(struct hl_device *hdev, bool is_hard,
 }
 
 static int goya_mmu_invalidate_cache_range(struct hl_device *hdev,
-				bool is_hard, u32 asid, u64 va, u64 size)
+						bool is_hard, u32 flags,
+						u32 asid, u64 va, u64 size)
 {
-	struct goya_device *goya = hdev->asic_specific;
-	u32 status, timeout_usec, inv_data, pi;
-	int rc;
-
-	if (!(goya->hw_cap_initialized & HW_CAP_MMU) ||
-		hdev->hard_reset_pending)
-		return 0;
-
-	/* no need in L1 only invalidation in Goya */
-	if (!is_hard)
-		return 0;
-
-	if (hdev->pldm)
-		timeout_usec = GOYA_PLDM_MMU_TIMEOUT_USEC;
-	else
-		timeout_usec = MMU_CONFIG_TIMEOUT_USEC;
-
-	/*
-	 * TODO: currently invalidate entire L0 & L1 as in regular hard
-	 * invalidation. Need to apply invalidation of specific cache lines with
-	 * mask of ASID & VA & size.
-	 * Note that L1 with be flushed entirely in any case.
+	/* Treat as invalidate all because there is no range invalidation
+	 * in Goya
 	 */
-
-	/* L0 & L1 invalidation */
-	inv_data = RREG32(mmSTLB_CACHE_INV);
-	/* PI is 8 bit */
-	pi = ((inv_data & STLB_CACHE_INV_PRODUCER_INDEX_MASK) + 1) & 0xFF;
-	WREG32(mmSTLB_CACHE_INV,
-			(inv_data & STLB_CACHE_INV_INDEX_MASK_MASK) | pi);
-
-	rc = hl_poll_timeout(
-		hdev,
-		mmSTLB_INV_CONSUMER_INDEX,
-		status,
-		status == pi,
-		1000,
-		timeout_usec);
-
-	if (rc) {
-		dev_err_ratelimited(hdev->dev,
-					"MMU cache invalidation timeout\n");
-		hl_device_reset(hdev, HL_RESET_HARD);
-	}
-
-	return rc;
+	return hdev->asic_funcs->mmu_invalidate_cache(hdev, is_hard, flags);
 }
 
 int goya_send_heartbeat(struct hl_device *hdev)
-- 
2.25.1

