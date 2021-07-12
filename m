Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20F523C5AB1
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 13:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234922AbhGLKPl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 06:15:41 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:51736 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234843AbhGLKP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 06:15:29 -0400
Received: from localhost.localdomain (unknown [IPv6:2a01:e0a:4cb:a870:f80c:c923:a77f:9641])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 5C1BC1F4210D;
        Mon, 12 Jul 2021 11:12:40 +0100 (BST)
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
To:     joro@8bytes.org, will@kernel.org, heiko@sntech.de
Cc:     iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH v3] iommu/rockchip: Fix physical address decoding
Date:   Mon, 12 Jul 2021 12:12:32 +0200
Message-Id: <20210712101232.318589-1-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Restore bits 39 to 32 at correct position.
It reverses the operation done in rk_dma_addr_dte_v2().

Fixes: c55356c534aa ("iommu: rockchip: Add support for iommu v2")

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
version 3:
 - change commit header to match with IOMMU tree convention

 drivers/iommu/rockchip-iommu.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index 94b9d8e5b9a40..9febfb7f3025b 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -544,12 +544,14 @@ static inline u32 rk_dma_addr_dte(dma_addr_t dt_dma)
 }
 
 #define DT_HI_MASK GENMASK_ULL(39, 32)
+#define DTE_BASE_HI_MASK GENMASK(11, 4)
 #define DT_SHIFT   28
 
 static inline phys_addr_t rk_dte_addr_phys_v2(u32 addr)
 {
-	return (phys_addr_t)(addr & RK_DTE_PT_ADDRESS_MASK) |
-	       ((addr & DT_HI_MASK) << DT_SHIFT);
+	u64 addr64 = addr;
+	return (phys_addr_t)(addr64 & RK_DTE_PT_ADDRESS_MASK) |
+	       ((addr64 & DTE_BASE_HI_MASK) << DT_SHIFT);
 }
 
 static inline u32 rk_dma_addr_dte_v2(dma_addr_t dt_dma)
-- 
2.25.1

