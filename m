Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0F235AC2B
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 11:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234432AbhDJJMm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 05:12:42 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:37912 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229943AbhDJJMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 05:12:41 -0400
X-UUID: ad36e2de72e04a008e6e87c7d12259dd-20210410
X-UUID: ad36e2de72e04a008e6e87c7d12259dd-20210410
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1507487187; Sat, 10 Apr 2021 17:12:23 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 10 Apr 2021 17:12:22 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 10 Apr 2021 17:12:21 +0800
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
        <acourbot@chromium.org>
Subject: [PATCH v5 03/16] iommu/mediatek: Add device_link between the consumer and the larb devices
Date:   Sat, 10 Apr 2021 17:11:15 +0800
Message-ID: <20210410091128.31823-4-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210410091128.31823-1-yong.wu@mediatek.com>
References: <20210410091128.31823-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MediaTek IOMMU-SMI diagram is like below. all the consumer connect with
smi-larb, then connect with smi-common.

        M4U
         |
    smi-common
         |
  -------------
  |         |    ...
  |         |
larb1     larb2
  |         |
vdec       venc

When the consumer works, it should enable the smi-larb's power which
also need enable the smi-common's power firstly.

Thus, First of all, use the device link connect the consumer and the
smi-larbs. then add device link between the smi-larb and smi-common.

This patch adds device_link between the consumer and the larbs.

When device_link_add, I add the flag DL_FLAG_STATELESS to avoid calling
pm_runtime_xx to keep the original status of clocks. It can avoid two
issues:
1) Display HW show fastlogo abnormally reported in [1]. At the beggining,
all the clocks are enabled before entering kernel, but the clocks for
display HW(always in larb0) will be gated after clk_enable and clk_disable
called from device_link_add(->pm_runtime_resume) and rpm_idle. The clock
operation happened before display driver probe. At that time, the display
HW will be abnormal.

2) A deadlock issue reported in [2]. Use DL_FLAG_STATELESS to skip
pm_runtime_xx to avoid the deadlock.

Corresponding, DL_FLAG_AUTOREMOVE_CONSUMER can't be added, then
device_link_removed should be added explicitly.

[1] https://lore.kernel.org/linux-mediatek/1564213888.22908.4.camel@mhfsdcap03/
[2] https://lore.kernel.org/patchwork/patch/1086569/

Suggested-by: Tomasz Figa <tfiga@chromium.org>
Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 drivers/iommu/mtk_iommu.c    | 22 ++++++++++++++++++++++
 drivers/iommu/mtk_iommu_v1.c | 20 +++++++++++++++++++-
 2 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 7a7b8260d308..cd054bd3f0df 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -571,22 +571,44 @@ static struct iommu_device *mtk_iommu_probe_device(struct device *dev)
 {
 	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 	struct mtk_iommu_data *data;
+	struct device_link *link;
+	struct device *larbdev;
+	unsigned int larbid;
 
 	if (!fwspec || fwspec->ops != &mtk_iommu_ops)
 		return ERR_PTR(-ENODEV); /* Not a iommu client device */
 
 	data = dev_iommu_priv_get(dev);
 
+	/*
+	 * Link the consumer device with the smi-larb device(supplier)
+	 * The device in each a larb is a independent HW. thus only link
+	 * one larb here.
+	 */
+	larbid = MTK_M4U_TO_LARB(fwspec->ids[0]);
+	larbdev = data->larb_imu[larbid].dev;
+	link = device_link_add(dev, larbdev,
+			       DL_FLAG_PM_RUNTIME | DL_FLAG_STATELESS);
+	if (!link)
+		dev_err(dev, "Unable to link %s\n", dev_name(larbdev));
 	return &data->iommu;
 }
 
 static void mtk_iommu_release_device(struct device *dev)
 {
 	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
+	struct mtk_iommu_data *data;
+	struct device *larbdev;
+	unsigned int larbid;
 
 	if (!fwspec || fwspec->ops != &mtk_iommu_ops)
 		return;
 
+	data = dev_iommu_priv_get(dev);
+	larbid = MTK_M4U_TO_LARB(fwspec->ids[0]);
+	larbdev = data->larb_imu[larbid].dev;
+	device_link_remove(dev, larbdev);
+
 	iommu_fwspec_free(dev);
 }
 
diff --git a/drivers/iommu/mtk_iommu_v1.c b/drivers/iommu/mtk_iommu_v1.c
index a82466e4046e..43dbdf692894 100644
--- a/drivers/iommu/mtk_iommu_v1.c
+++ b/drivers/iommu/mtk_iommu_v1.c
@@ -425,7 +425,9 @@ static struct iommu_device *mtk_iommu_probe_device(struct device *dev)
 	struct of_phandle_args iommu_spec;
 	struct of_phandle_iterator it;
 	struct mtk_iommu_data *data;
-	int err;
+	struct device_link *link;
+	struct device *larbdev;
+	int err, larbid;
 
 	of_for_each_phandle(&it, err, dev->of_node, "iommus",
 			"#iommu-cells", -1) {
@@ -447,6 +449,14 @@ static struct iommu_device *mtk_iommu_probe_device(struct device *dev)
 
 	data = dev_iommu_priv_get(dev);
 
+	/* Link the consumer device with the smi-larb device(supplier) */
+	larbid = mt2701_m4u_to_larb(fwspec->ids[0]);
+	larbdev = data->larb_imu[larbid].dev;
+	link = device_link_add(dev, larbdev,
+			       DL_FLAG_PM_RUNTIME | DL_FLAG_STATELESS);
+	if (!link)
+		dev_err(dev, "Unable to link %s\n", dev_name(larbdev));
+
 	return &data->iommu;
 }
 
@@ -467,10 +477,18 @@ static void mtk_iommu_probe_finalize(struct device *dev)
 static void mtk_iommu_release_device(struct device *dev)
 {
 	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
+	struct mtk_iommu_data *data;
+	struct device *larbdev;
+	unsigned int larbid;
 
 	if (!fwspec || fwspec->ops != &mtk_iommu_ops)
 		return;
 
+	data = dev_iommu_priv_get(dev);
+	larbid = mt2701_m4u_to_larb(fwspec->ids[0]);
+	larbdev = data->larb_imu[larbid].dev;
+	device_link_remove(dev, larbdev);
+
 	iommu_fwspec_free(dev);
 }
 
-- 
2.18.0

