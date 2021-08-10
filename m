Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF3F03E119C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 11:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239858AbhHEJr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 05:47:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:51598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232930AbhHEJrz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 05:47:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 81ABA60F22;
        Thu,  5 Aug 2021 09:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628156861;
        bh=lP9P2emkoqaG3Y9UVECzCsJ31BDk9yKNVY61WSeDVew=;
        h=From:To:Cc:Subject:Date:From;
        b=qiCc98zsym+9rcbvymO2HBrLqBXWGeCZQiv/bDHs1HymgTauy4tD1ze+NpLNlA4XI
         AwbAWnUdbZDEsz0ioo/WGC33LQq5O4tKlqjNvTTZ7ykDOM0JKJm4WU/3BmEqqg9XV6
         EV1Z6xiUhk4vCnWBajzsjkVlNQXKi246rerCwU+tsh8iHLP197BrMEAjAHsQLyeF1U
         DYWTLO5tpXgMbFomOTxfSP70Ki71AugGbv+ViA5VxOHnWCRIgEPHJA29OTU7y+ZPCI
         fzvyQIcTyr9d+tn5pg9hmM/9KrXWzgxHXk+ztwrKuiwPS3jGr6xx5tfYmNABMEZPQc
         lz7MqkJozCyCg==
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     iommu@lists.linux-foundation.org, Will Deacon <will@kernel.org>,
        Claire Chang <tientzu@chromium.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH] of: restricted dma: Don't fail device probe on rmem init failure
Date:   Thu,  5 Aug 2021 10:47:36 +0100
Message-Id: <20210805094736.902-1-will@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If CONFIG_DMA_RESTRICTED_POOL=n then probing a device with a reference
to a "restricted-dma-pool" will fail with a reasonably cryptic error:

  | pci-host-generic: probe of 10000.pci failed with error -22

Print a more helpful message in this case and try to continue probing
the device as we do if the kernel doesn't have the restricted DMA patches
applied or either CONFIG_OF_ADDRESS or CONFIG_HAS_DMA =n.

Cc: Claire Chang <tientzu@chromium.org>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Rob Herring <robh+dt@kernel.org>
Signed-off-by: Will Deacon <will@kernel.org>
---
 drivers/of/address.c    | 8 ++++----
 drivers/of/device.c     | 2 +-
 drivers/of/of_private.h | 8 +++-----
 3 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/of/address.c b/drivers/of/address.c
index 973257434398..f6bf4b423c2a 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -997,7 +997,7 @@ int of_dma_get_range(struct device_node *np, const struct bus_dma_region **map)
 	return ret;
 }
 
-int of_dma_set_restricted_buffer(struct device *dev, struct device_node *np)
+void of_dma_set_restricted_buffer(struct device *dev, struct device_node *np)
 {
 	struct device_node *node, *of_node = dev->of_node;
 	int count, i;
@@ -1022,11 +1022,11 @@ int of_dma_set_restricted_buffer(struct device *dev, struct device_node *np)
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
 #endif /* CONFIG_HAS_DMA */
 
diff --git a/drivers/of/device.c b/drivers/of/device.c
index 2defdca418ec..258a2b099410 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -166,7 +166,7 @@ int of_dma_configure_id(struct device *dev, struct device_node *np,
 	arch_setup_dma_ops(dev, dma_start, size, iommu, coherent);
 
 	if (!iommu)
-		return of_dma_set_restricted_buffer(dev, np);
+		of_dma_set_restricted_buffer(dev, np);
 
 	return 0;
 }
diff --git a/drivers/of/of_private.h b/drivers/of/of_private.h
index f557bd22b0cf..bc883f69496b 100644
--- a/drivers/of/of_private.h
+++ b/drivers/of/of_private.h
@@ -163,18 +163,16 @@ struct bus_dma_region;
 #if defined(CONFIG_OF_ADDRESS) && defined(CONFIG_HAS_DMA)
 int of_dma_get_range(struct device_node *np,
 		const struct bus_dma_region **map);
-int of_dma_set_restricted_buffer(struct device *dev, struct device_node *np);
+void of_dma_set_restricted_buffer(struct device *dev, struct device_node *np);
 #else
 static inline int of_dma_get_range(struct device_node *np,
 		const struct bus_dma_region **map)
 {
 	return -ENODEV;
 }
-static inline int of_dma_set_restricted_buffer(struct device *dev,
-					       struct device_node *np)
+static inline void of_dma_set_restricted_buffer(struct device *dev,
+						struct device_node *np)
 {
-	/* Do nothing, successfully. */
-	return 0;
 }
 #endif
 
-- 
2.32.0.605.g8dce9f2422-goog

