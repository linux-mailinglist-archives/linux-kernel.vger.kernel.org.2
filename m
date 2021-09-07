Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC2C7402D2A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 18:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345137AbhIGQvC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 12:51:02 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:59927 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234436AbhIGQvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 12:51:02 -0400
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 35FCF22249;
        Tue,  7 Sep 2021 18:49:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1631033394;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qtbtixG5JHqtZFZ2HjiAd4vpDAB1Ne9ev8OLjxPtDn4=;
        b=Tjb6DwRHc7DBgJpWBlsnwJYgXX4C5n2usL8OuyRP53ateKuPGn5AcQlue7fi1l25TJ3vRm
        80Enl9Ie5PTe4FAvQdqtUWkwwQK/8WiNp82Cxn778GLAl6BRy+JGI1T3xi1Uz77klb70Gc
        jlx1+3E5tYDuEzVvlljx4xhs4DJCw4M=
From:   Michael Walle <michael@walle.cc>
To:     Robin Murphy <robin.murphy@arm.com>, etnaviv@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     "Lukas F . Hartmann" <lukas@mntre.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH v2 2/3] drm/etnaviv: fix dma configuration of the virtual device
Date:   Tue,  7 Sep 2021 18:49:44 +0200
Message-Id: <20210907164945.2309815-3-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210907164945.2309815-1-michael@walle.cc>
References: <20210907164945.2309815-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DMA configuration of the virtual device is inherited from the first
actual etnaviv device. Unfortunately, this doesn't work with an IOMMU:

[    5.191008] Failed to set up IOMMU for device (null); retaining platform DMA ops

This is because there is no associated iommu_group with the device. The
group is set in iommu_group_add_device() which is eventually called by
device_add() via the platform bus:
  device_add()
    blocking_notifier_call_chain()
      iommu_bus_notifier()
        iommu_probe_device()
          __iommu_probe_device()
            iommu_group_get_for_dev()
              iommu_group_add_device()

Move of_dma_configure() into the probe function, which is called after
device_add(). Normally, the platform code will already call it itself
if .of_node is set. Unfortunately, this isn't the case here.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 drivers/gpu/drm/etnaviv/etnaviv_drv.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.c b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
index 2509b3e85709..54eb653ca295 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_drv.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
@@ -589,6 +589,7 @@ static int compare_str(struct device *dev, void *data)
 static int etnaviv_pdev_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
+	struct device_node *first_node = NULL;
 	struct component_match *match = NULL;
 
 	if (!dev->platform_data) {
@@ -598,6 +599,9 @@ static int etnaviv_pdev_probe(struct platform_device *pdev)
 			if (!of_device_is_available(core_node))
 				continue;
 
+			if (!first_node)
+				first_node = core_node;
+
 			drm_of_component_match_add(&pdev->dev, &match,
 						   compare_of, core_node);
 		}
@@ -609,6 +613,14 @@ static int etnaviv_pdev_probe(struct platform_device *pdev)
 			component_match_add(dev, &match, compare_str, names[i]);
 	}
 
+	/*
+	 * Apply the same DMA configuration to the virtual etnaviv
+	 * device as the GPU we found. This assumes that all Vivante
+	 * GPUs in the system share the same DMA constraints.
+	 */
+	if (first_node)
+		of_dma_configure(&pdev->dev, first_node, true);
+
 	return component_master_add_with_match(dev, &etnaviv_master_ops, match);
 }
 
@@ -662,13 +674,6 @@ static int __init etnaviv_init(void)
 		pdev->dev.coherent_dma_mask = DMA_BIT_MASK(40);
 		pdev->dev.dma_mask = &pdev->dev.coherent_dma_mask;
 
-		/*
-		 * Apply the same DMA configuration to the virtual etnaviv
-		 * device as the GPU we found. This assumes that all Vivante
-		 * GPUs in the system share the same DMA constraints.
-		 */
-		of_dma_configure(&pdev->dev, np, true);
-
 		ret = platform_device_add(pdev);
 		if (ret) {
 			platform_device_put(pdev);
-- 
2.30.2

