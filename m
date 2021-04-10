Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D50735AC38
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 11:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234552AbhDJJN3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 05:13:29 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:38304 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S234180AbhDJJN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 05:13:27 -0400
X-UUID: 8384d657d78c442a84a8f1b80fb5d853-20210410
X-UUID: 8384d657d78c442a84a8f1b80fb5d853-20210410
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1813379967; Sat, 10 Apr 2021 17:13:11 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 10 Apr 2021 17:13:09 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 10 Apr 2021 17:13:08 +0800
From:   Yong Wu <yong.wu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
CC:     Evan Green <evgreen@chromium.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Will Deacon <will.deacon@arm.com>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <yong.wu@mediatek.com>,
        <youlin.pei@mediatek.com>, Nicolas Boichat <drinkcat@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>, <anan.sun@mediatek.com>,
        <chao.hao@mediatek.com>, <ming-fan.chen@mediatek.com>,
        <yi.kuo@mediatek.com>, <eizan@chromium.org>,
        <acourbot@chromium.org>,
        Minghsiu Tsai <minghsiu.tsai@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>
Subject: [PATCH v5 08/16] media: mtk-mdp: Get rid of mtk_smi_larb_get/put
Date:   Sat, 10 Apr 2021 17:11:20 +0800
Message-ID: <20210410091128.31823-9-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210410091128.31823-1-yong.wu@mediatek.com>
References: <20210410091128.31823-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MediaTek IOMMU has already added the device_link between the consumer
and smi-larb device. If the mdp device call the pm_runtime_get_sync,
the smi-larb's pm_runtime_get_sync also be called automatically.

CC: Minghsiu Tsai <minghsiu.tsai@mediatek.com>
CC: Houlong Wei <houlong.wei@mediatek.com>
Signed-off-by: Yong Wu <yong.wu@mediatek.com>
Reviewed-by: Evan Green <evgreen@chromium.org>
---
 drivers/media/platform/mtk-mdp/mtk_mdp_comp.c | 40 -------------------
 drivers/media/platform/mtk-mdp/mtk_mdp_comp.h |  2 -
 drivers/media/platform/mtk-mdp/mtk_mdp_core.c |  1 -
 3 files changed, 43 deletions(-)

diff --git a/drivers/media/platform/mtk-mdp/mtk_mdp_comp.c b/drivers/media/platform/mtk-mdp/mtk_mdp_comp.c
index b3426a551bea..1e3833f1c9ae 100644
--- a/drivers/media/platform/mtk-mdp/mtk_mdp_comp.c
+++ b/drivers/media/platform/mtk-mdp/mtk_mdp_comp.c
@@ -9,7 +9,6 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_platform.h>
-#include <soc/mediatek/smi.h>
 
 #include "mtk_mdp_comp.h"
 
@@ -18,14 +17,6 @@ void mtk_mdp_comp_clock_on(struct device *dev, struct mtk_mdp_comp *comp)
 {
 	int i, err;
 
-	if (comp->larb_dev) {
-		err = mtk_smi_larb_get(comp->larb_dev);
-		if (err)
-			dev_err(dev,
-				"failed to get larb, err %d. type:%d\n",
-				err, comp->type);
-	}
-
 	for (i = 0; i < ARRAY_SIZE(comp->clk); i++) {
 		if (IS_ERR(comp->clk[i]))
 			continue;
@@ -46,17 +37,12 @@ void mtk_mdp_comp_clock_off(struct device *dev, struct mtk_mdp_comp *comp)
 			continue;
 		clk_disable_unprepare(comp->clk[i]);
 	}
-
-	if (comp->larb_dev)
-		mtk_smi_larb_put(comp->larb_dev);
 }
 
 int mtk_mdp_comp_init(struct device *dev, struct device_node *node,
 		      struct mtk_mdp_comp *comp,
 		      enum mtk_mdp_comp_type comp_type)
 {
-	struct device_node *larb_node;
-	struct platform_device *larb_pdev;
 	int ret;
 	int i;
 
@@ -77,32 +63,6 @@ int mtk_mdp_comp_init(struct device *dev, struct device_node *node,
 			break;
 	}
 
-	/* Only DMA capable components need the LARB property */
-	comp->larb_dev = NULL;
-	if (comp->type != MTK_MDP_RDMA &&
-	    comp->type != MTK_MDP_WDMA &&
-	    comp->type != MTK_MDP_WROT)
-		return 0;
-
-	larb_node = of_parse_phandle(node, "mediatek,larb", 0);
-	if (!larb_node) {
-		dev_err(dev,
-			"Missing mediadek,larb phandle in %pOF node\n", node);
-		ret = -EINVAL;
-		goto put_dev;
-	}
-
-	larb_pdev = of_find_device_by_node(larb_node);
-	if (!larb_pdev) {
-		dev_warn(dev, "Waiting for larb device %pOF\n", larb_node);
-		of_node_put(larb_node);
-		ret = -EPROBE_DEFER;
-		goto put_dev;
-	}
-	of_node_put(larb_node);
-
-	comp->larb_dev = &larb_pdev->dev;
-
 	return 0;
 
 put_dev:
diff --git a/drivers/media/platform/mtk-mdp/mtk_mdp_comp.h b/drivers/media/platform/mtk-mdp/mtk_mdp_comp.h
index 1bf0242cce46..36bc1b8f6222 100644
--- a/drivers/media/platform/mtk-mdp/mtk_mdp_comp.h
+++ b/drivers/media/platform/mtk-mdp/mtk_mdp_comp.h
@@ -27,14 +27,12 @@ enum mtk_mdp_comp_type {
  * @node:	list node to track sibing MDP components
  * @dev_node:	component device node
  * @clk:	clocks required for component
- * @larb_dev:	SMI device required for component
  * @type:	component type
  */
 struct mtk_mdp_comp {
 	struct list_head	node;
 	struct device_node	*dev_node;
 	struct clk		*clk[2];
-	struct device		*larb_dev;
 	enum mtk_mdp_comp_type	type;
 };
 
diff --git a/drivers/media/platform/mtk-mdp/mtk_mdp_core.c b/drivers/media/platform/mtk-mdp/mtk_mdp_core.c
index 976aa1f4829b..70a8eab16863 100644
--- a/drivers/media/platform/mtk-mdp/mtk_mdp_core.c
+++ b/drivers/media/platform/mtk-mdp/mtk_mdp_core.c
@@ -17,7 +17,6 @@
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/workqueue.h>
-#include <soc/mediatek/smi.h>
 
 #include "mtk_mdp_core.h"
 #include "mtk_mdp_m2m.h"
-- 
2.18.0

