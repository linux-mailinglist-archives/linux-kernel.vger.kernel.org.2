Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDB5F41BA18
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 00:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242626AbhI1WUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 18:20:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:38824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242981AbhI1WUG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 18:20:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3652A6134F;
        Tue, 28 Sep 2021 22:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632867506;
        bh=5J0hY9xgoHquzGvQlOV+Av63MmjnlOGF9TMY09r5wos=;
        h=Date:From:To:Cc:Subject:From;
        b=jSwtgiY9ALwoZuiz/OECPEXHzc3u6igBwRmJzenKUw1kaa1Ghok+oOPeCejks9fQ0
         6nGlXJeQAFn9u8GBzntySvne7RNmGNi1/2kJbUK3++P2QTE6f7qWlVur/j/xFnSMLW
         WsABrnrouI3JaFKfJxgywqFsf0indPGsf97gis4e+0k6zkhUPgt6Ztc7o6bl4p9EEg
         k/cZWSKsQFZetYLscriMHKS4t2K820opsTd8dQMCEsh7klKZF5tfFqx7bwKVDosRI8
         YWJ2x6kxWxSkJXqPpth/4xuuUt4uZ5OzQGYTvtUcrK97JlJ93cUo3UDgpr6rumRvma
         vz+2QVCq8esHg==
Date:   Tue, 28 Sep 2021 17:22:29 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] iommu/dma: Use kvcalloc() instead of kvzalloc()
Message-ID: <20210928222229.GA280355@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use 2-factor argument form kvcalloc() instead of kvzalloc().

Link: https://github.com/KSPP/linux/issues/162
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/iommu/dma-iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 896bea04c347..18c6edbe5fbf 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -616,7 +616,7 @@ static struct page **__iommu_dma_alloc_pages(struct device *dev,
 	if (!order_mask)
 		return NULL;
 
-	pages = kvzalloc(count * sizeof(*pages), GFP_KERNEL);
+	pages = kvcalloc(count, sizeof(*pages), GFP_KERNEL);
 	if (!pages)
 		return NULL;
 
-- 
2.27.0

