Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97FE83ED781
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 15:35:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237675AbhHPNeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 09:34:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:49828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239387AbhHPN06 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 09:26:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 61404632BE;
        Mon, 16 Aug 2021 13:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629120386;
        bh=77Qk2RGPl8adrRUvGjCdFbgEWfKIq77VmbOlU67gcKA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kOZp7YvJwiUnyQ2uWHujW/TdXZsZdU+eO0rBMbz4Hmtox3/wVdJ3f89rv8spkr7Nc
         CBnFBeYbk5FWObWJT0vbQsIE7Zr1v9QSJFCgNMf4xqndqWwcHqQR6mc3k16JArXrxV
         7AYftRTO+aT4W3F4vQGYRkKBZVJ+dI+dhhuZOwt24d1vXcgp2Mur5DHf4ND7SslKRD
         4QBUgnbouSWL6yH/H5+XSnAh1CN6NHoqiV6TxRiUxxB1nsd5d0t0qpATP5IjP+b9jM
         +cdYCqUo+XmvPzJ99JzlYyHeHCpK8QIbY99JFohDrD66r1kAJLVmvnkKYEvx5OG0Jo
         zgETEeXn+GwYQ==
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     iommu@lists.linux-foundation.org, Will Deacon <will@kernel.org>,
        Claire Chang <tientzu@chromium.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH v2 2/2] of: restricted dma: Don't fail device probe on rmem init failure
Date:   Mon, 16 Aug 2021 14:26:17 +0100
Message-Id: <20210816132618.11707-3-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210816132618.11707-1-will@kernel.org>
References: <20210816132618.11707-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If CONFIG_DMA_RESTRICTED_POOL=n then probing a device with a reference
to a "restricted-dma-pool" will fail with a reasonably cryptic error:

  | pci-host-generic: probe of 10000.pci failed with error -22

Rework of_dma_set_restricted_buffer() so that it does not cause probing
failure and instead either returns early if CONFIG_DMA_RESTRICTED_POOL=n
or emits a diagnostic if the reserved DMA pool fails to initialise.

Cc: Claire Chang <tientzu@chromium.org>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Will Deacon <will@kernel.org>
---
 drivers/of/device.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/of/device.c b/drivers/of/device.c
index 089c5b4b97fb..5b043ee30824 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -53,12 +53,15 @@ int of_device_add(struct platform_device *ofdev)
 	return device_add(&ofdev->dev);
 }
 
-static int
+static void
 of_dma_set_restricted_buffer(struct device *dev, struct device_node *np)
 {
 	struct device_node *node, *of_node = dev->of_node;
 	int count, i;
 
+	if (!IS_ENABLED(CONFIG_DMA_RESTRICTED_POOL))
+		return;
+
 	count = of_property_count_elems_of_size(of_node, "memory-region",
 						sizeof(u32));
 	/*
@@ -79,11 +82,11 @@ of_dma_set_restricted_buffer(struct device *dev, struct device_node *np)
 		 */
 		if (of_device_is_compatible(node, "restricted-dma-pool") &&
 		    of_device_is_available(node))
-			return of_reserved_mem_device_init_by_idx(dev, of_node,
-								  i);
+			break;
 	}
 
-	return 0;
+	if (i != count && of_reserved_mem_device_init_by_idx(dev, of_node, i))
+		dev_warn(dev, "failed to initialise \"restricted-dma-pool\" memory node\n");
 }
 
 /**
@@ -200,7 +203,7 @@ int of_dma_configure_id(struct device *dev, struct device_node *np,
 	arch_setup_dma_ops(dev, dma_start, size, iommu, coherent);
 
 	if (!iommu)
-		return of_dma_set_restricted_buffer(dev, np);
+		of_dma_set_restricted_buffer(dev, np);
 
 	return 0;
 }
-- 
2.33.0.rc1.237.g0d66db33f3-goog

