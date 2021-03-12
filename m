Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0FD33837D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 03:20:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231596AbhCLCTf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 21:19:35 -0500
Received: from mail-m17635.qiye.163.com ([59.111.176.35]:45248 "EHLO
        mail-m17635.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231245AbhCLCTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 21:19:20 -0500
Received: from vivo-HP-ProDesk-680-G4-PCI-MT.vivo.xyz (unknown [58.251.74.231])
        by mail-m17635.qiye.163.com (Hmail) with ESMTPA id E11D740018F;
        Fri, 12 Mar 2021 10:19:16 +0800 (CST)
From:   Wang Qing <wangqing@vivo.com>
To:     Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc:     Wang Qing <wangqing@vivo.com>
Subject: [PATCH] include: fix inconsistent indenting in dma_alloc_coherent()
Date:   Fri, 12 Mar 2021 10:19:12 +0800
Message-Id: <1615515552-1432-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZSUtDGU8ZGU9PGkIeVkpNSk5OSk5OTkxJS0lVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKTFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PDo6Igw6Qj8TNQIpDzEDE0o1
        MTNPCiNVSlVKTUpOTkpOTk5DT01LVTMWGhIXVQwaFRwKEhUcOw0SDRRVGBQWRVlXWRILWUFZTkNV
        SU5KVUxPVUlISllXWQgBWUFKTk5ONwY+
X-HM-Tid: 0a78243b1cfad991kuwse11d740018f
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix inconsistent indenting in dma_alloc_coherent()

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 include/linux/dma-mapping.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index fbfa3f5..6e4d513
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -401,7 +401,6 @@ static inline void dma_sync_sgtable_for_device(struct device *dev,
 static inline void *dma_alloc_coherent(struct device *dev, size_t size,
 		dma_addr_t *dma_handle, gfp_t gfp)
 {
-
 	return dma_alloc_attrs(dev, size, dma_handle, gfp,
 			(gfp & __GFP_NOWARN) ? DMA_ATTR_NO_WARN : 0);
 }
-- 
2.7.4

