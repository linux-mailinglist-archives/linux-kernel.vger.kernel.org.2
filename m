Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2929A35AC34
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 11:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234515AbhDJJNI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 05:13:08 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:33948 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S234505AbhDJJNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 05:13:07 -0400
X-UUID: cf59c8aed67043eca87ede87532db235-20210410
X-UUID: cf59c8aed67043eca87ede87532db235-20210410
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1297043596; Sat, 10 Apr 2021 17:12:51 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 10 Apr 2021 17:12:49 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 10 Apr 2021 17:12:48 +0800
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
        <acourbot@chromium.org>, Rick Chang <rick.chang@mediatek.com>,
        Xia Jiang <xia.jiang@mediatek.com>
Subject: [PATCH v5 06/16] media: mtk-jpeg: Get rid of mtk_smi_larb_get/put
Date:   Sat, 10 Apr 2021 17:11:18 +0800
Message-ID: <20210410091128.31823-7-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210410091128.31823-1-yong.wu@mediatek.com>
References: <20210410091128.31823-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MediaTek IOMMU has already added device_link between the consumer
and smi-larb device. If the jpg device call the pm_runtime_get_sync,
the smi-larb's pm_runtime_get_sync also be called automatically.

CC: Rick Chang <rick.chang@mediatek.com>
CC: Xia Jiang <xia.jiang@mediatek.com>
Signed-off-by: Yong Wu <yong.wu@mediatek.com>
Reviewed-by: Evan Green <evgreen@chromium.org>
Acked-by: Rick Chang <rick.chang@mediatek.com>
---
 .../media/platform/mtk-jpeg/mtk_jpeg_core.c   | 30 +------------------
 .../media/platform/mtk-jpeg/mtk_jpeg_core.h   |  2 --
 2 files changed, 1 insertion(+), 31 deletions(-)

diff --git a/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c b/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c
index a89c7b206eef..a47832a1b316 100644
--- a/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c
+++ b/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c
@@ -22,7 +22,6 @@
 #include <media/v4l2-ioctl.h>
 #include <media/videobuf2-core.h>
 #include <media/videobuf2-dma-contig.h>
-#include <soc/mediatek/smi.h>
 
 #include "mtk_jpeg_enc_hw.h"
 #include "mtk_jpeg_dec_hw.h"
@@ -1055,10 +1054,6 @@ static void mtk_jpeg_clk_on(struct mtk_jpeg_dev *jpeg)
 {
 	int ret;
 
-	ret = mtk_smi_larb_get(jpeg->larb);
-	if (ret)
-		dev_err(jpeg->dev, "mtk_smi_larb_get larbvdec fail %d\n", ret);
-
 	ret = clk_bulk_prepare_enable(jpeg->variant->num_clks,
 				      jpeg->variant->clks);
 	if (ret)
@@ -1069,7 +1064,6 @@ static void mtk_jpeg_clk_off(struct mtk_jpeg_dev *jpeg)
 {
 	clk_bulk_disable_unprepare(jpeg->variant->num_clks,
 				   jpeg->variant->clks);
-	mtk_smi_larb_put(jpeg->larb);
 }
 
 static irqreturn_t mtk_jpeg_enc_done(struct mtk_jpeg_dev *jpeg)
@@ -1286,27 +1280,12 @@ static struct clk_bulk_data mtk_jpeg_clocks[] = {
 
 static int mtk_jpeg_clk_init(struct mtk_jpeg_dev *jpeg)
 {
-	struct device_node *node;
-	struct platform_device *pdev;
 	int ret;
 
-	node = of_parse_phandle(jpeg->dev->of_node, "mediatek,larb", 0);
-	if (!node)
-		return -EINVAL;
-	pdev = of_find_device_by_node(node);
-	if (WARN_ON(!pdev)) {
-		of_node_put(node);
-		return -EINVAL;
-	}
-	of_node_put(node);
-
-	jpeg->larb = &pdev->dev;
-
 	ret = devm_clk_bulk_get(jpeg->dev, jpeg->variant->num_clks,
 				jpeg->variant->clks);
 	if (ret) {
-		dev_err(&pdev->dev, "failed to get jpeg clock:%d\n", ret);
-		put_device(&pdev->dev);
+		dev_err(jpeg->dev, "failed to get jpeg clock:%d\n", ret);
 		return ret;
 	}
 
@@ -1333,11 +1312,6 @@ static void mtk_jpeg_job_timeout_work(struct work_struct *work)
 	v4l2_m2m_job_finish(jpeg->m2m_dev, ctx->fh.m2m_ctx);
 }
 
-static inline void mtk_jpeg_clk_release(struct mtk_jpeg_dev *jpeg)
-{
-	put_device(jpeg->larb);
-}
-
 static int mtk_jpeg_probe(struct platform_device *pdev)
 {
 	struct mtk_jpeg_dev *jpeg;
@@ -1442,7 +1416,6 @@ static int mtk_jpeg_probe(struct platform_device *pdev)
 	v4l2_device_unregister(&jpeg->v4l2_dev);
 
 err_dev_register:
-	mtk_jpeg_clk_release(jpeg);
 
 err_clk_init:
 
@@ -1460,7 +1433,6 @@ static int mtk_jpeg_remove(struct platform_device *pdev)
 	video_device_release(jpeg->vdev);
 	v4l2_m2m_release(jpeg->m2m_dev);
 	v4l2_device_unregister(&jpeg->v4l2_dev);
-	mtk_jpeg_clk_release(jpeg);
 
 	return 0;
 }
diff --git a/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.h b/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.h
index 68e634f02e00..6e558e97a2d8 100644
--- a/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.h
+++ b/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.h
@@ -85,7 +85,6 @@ struct mtk_jpeg_variant {
  * @alloc_ctx:		videobuf2 memory allocator's context
  * @vdev:		video device node for jpeg mem2mem mode
  * @reg_base:		JPEG registers mapping
- * @larb:		SMI device
  * @job_timeout_work:	IRQ timeout structure
  * @variant:		driver variant to be used
  */
@@ -99,7 +98,6 @@ struct mtk_jpeg_dev {
 	void			*alloc_ctx;
 	struct video_device	*vdev;
 	void __iomem		*reg_base;
-	struct device		*larb;
 	struct delayed_work job_timeout_work;
 	const struct mtk_jpeg_variant *variant;
 };
-- 
2.18.0

