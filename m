Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57CA1415D56
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 13:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240747AbhIWMB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 08:01:26 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:48444 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S240743AbhIWMBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 08:01:14 -0400
X-UUID: aaf29ab9b99145429922d6e102db7e54-20210923
X-UUID: aaf29ab9b99145429922d6e102db7e54-20210923
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1509207466; Thu, 23 Sep 2021 19:59:40 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 23 Sep 2021 19:59:38 +0800
Received: from localhost.localdomain (10.17.3.154) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 23 Sep 2021 19:59:37 +0800
From:   Yong Wu <yong.wu@mediatek.com>
To:     Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Tomasz Figa <tfiga@chromium.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>, <yong.wu@mediatek.com>,
        <youlin.pei@mediatek.com>, <anan.sun@mediatek.com>,
        <chao.hao@mediatek.com>, <yen-chang.chen@mediatek.com>
Subject: [PATCH v3 05/33] iommu/mediatek: Adapt sharing and non-sharing pgtable case
Date:   Thu, 23 Sep 2021 19:58:12 +0800
Message-ID: <20210923115840.17813-6-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210923115840.17813-1-yong.wu@mediatek.com>
References: <20210923115840.17813-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In previous mt2712, Both IOMMUs are MM IOMMU, and they will share pgtable.
However in the latest SoC, another is infra IOMMU, there is no reason to
share pgtable between MM with INFRA IOMMU. This patch manage to
implement the two case(sharing and non-sharing pgtable).

Currently we use for_each_m4u to loop the 2 HWs. Add the list_head into
this macro.
In the sharing pgtable case, the list_head is the global "m4ulist".
In the non-sharing pgtable case, the list_head is hw_list_head which is a
variable in the "data". then for_each_m4u will only loop itself.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 drivers/iommu/mtk_iommu.c | 47 ++++++++++++++++++++++-----------------
 drivers/iommu/mtk_iommu.h |  7 ++++++
 2 files changed, 33 insertions(+), 21 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 5c24e8e10a73..ee10c56e8f96 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -118,6 +118,7 @@
 #define WR_THROT_EN			BIT(6)
 #define HAS_LEGACY_IVRP_PADDR		BIT(7)
 #define IOVA_34_EN			BIT(8)
+#define SHARE_PGTABLE			BIT(9) /* 2 HW share pgtable */
 
 #define MTK_IOMMU_HAS_FLAG(pdata, _x) \
 		((((pdata)->flags) & (_x)) == (_x))
@@ -165,7 +166,7 @@ static int mtk_iommu_hw_init(const struct mtk_iommu_data *data);
 
 static LIST_HEAD(m4ulist);	/* List all the M4U HWs */
 
-#define for_each_m4u(data)	list_for_each_entry(data, &m4ulist, list)
+#define for_each_m4u(data, head)  list_for_each_entry(data, head, list)
 
 struct mtk_iommu_iova_region {
 	dma_addr_t		iova_base;
@@ -186,21 +187,10 @@ static const struct mtk_iommu_iova_region mt8192_multi_dom[] = {
 	#endif
 };
 
-/*
- * There may be 1 or 2 M4U HWs, But we always expect they are in the same domain
- * for the performance.
- *
- * Here always return the mtk_iommu_data of the first probed M4U where the
- * iommu domain information is recorded.
- */
-static struct mtk_iommu_data *mtk_iommu_get_m4u_data(void)
+/* If 2 M4U share a domain(use the same hwlist), Put the corresponding info in first data.*/
+static struct mtk_iommu_data *mtk_iommu_get_frst_data(struct list_head *hwlist)
 {
-	struct mtk_iommu_data *data;
-
-	for_each_m4u(data)
-		return data;
-
-	return NULL;
+	return list_first_entry(hwlist, struct mtk_iommu_data, list);
 }
 
 static struct mtk_iommu_domain *to_mtk_domain(struct iommu_domain *dom)
@@ -210,7 +200,9 @@ static struct mtk_iommu_domain *to_mtk_domain(struct iommu_domain *dom)
 
 static void mtk_iommu_tlb_flush_all(struct mtk_iommu_data *data)
 {
-	for_each_m4u(data) {
+	struct list_head *head = data->hw_list;
+
+	for_each_m4u(data, head) {
 		if (pm_runtime_get_if_in_use(data->dev) <= 0)
 			continue;
 
@@ -227,12 +219,13 @@ static void mtk_iommu_tlb_flush_range_sync(unsigned long iova, size_t size,
 					   size_t granule,
 					   struct mtk_iommu_data *data)
 {
+	struct list_head *head = data->hw_list;
 	bool has_pm = !!data->dev->pm_domain;
 	unsigned long flags;
 	int ret;
 	u32 tmp;
 
-	for_each_m4u(data) {
+	for_each_m4u(data, head) {
 		if (has_pm) {
 			if (pm_runtime_get_if_in_use(data->dev) <= 0)
 				continue;
@@ -453,6 +446,7 @@ static int mtk_iommu_attach_device(struct iommu_domain *domain,
 {
 	struct mtk_iommu_data *data = dev_iommu_priv_get(dev), *frstdata;
 	struct mtk_iommu_domain *dom = to_mtk_domain(domain);
+	struct list_head *hw_list = data->hw_list;
 	struct device *m4udev = data->dev;
 	int ret, domid;
 
@@ -462,7 +456,7 @@ static int mtk_iommu_attach_device(struct iommu_domain *domain,
 
 	if (!dom->data) {
 		/* Data is in the frstdata in sharing pgtable case. */
-		frstdata = mtk_iommu_get_m4u_data();
+		frstdata = mtk_iommu_get_frst_data(hw_list);
 
 		if (mtk_iommu_domain_finalise(dom, frstdata, domid))
 			return -ENODEV;
@@ -584,10 +578,12 @@ static void mtk_iommu_release_device(struct device *dev)
 
 static struct iommu_group *mtk_iommu_device_group(struct device *dev)
 {
-	struct mtk_iommu_data *data = mtk_iommu_get_m4u_data();
+	struct mtk_iommu_data *c_data = dev_iommu_priv_get(dev), *data;
+	struct list_head *hw_list = c_data->hw_list;
 	struct iommu_group *group;
 	int domid;
 
+	data = mtk_iommu_get_frst_data(hw_list);
 	if (!data)
 		return ERR_PTR(-ENODEV);
 
@@ -888,7 +884,15 @@ static int mtk_iommu_probe(struct platform_device *pdev)
 		goto out_sysfs_remove;
 
 	spin_lock_init(&data->tlb_lock);
-	list_add_tail(&data->list, &m4ulist);
+
+	if (MTK_IOMMU_HAS_FLAG(data->plat_data, SHARE_PGTABLE)) {
+		list_add_tail(&data->list, data->plat_data->hw_list);
+		data->hw_list = data->plat_data->hw_list;
+	} else {
+		INIT_LIST_HEAD(&data->hw_list_head);
+		list_add_tail(&data->list, &data->hw_list_head);
+		data->hw_list = &data->hw_list_head;
+	}
 
 	if (!iommu_present(&platform_bus_type)) {
 		ret = bus_set_iommu(&platform_bus_type, &mtk_iommu_ops);
@@ -991,7 +995,8 @@ static const struct dev_pm_ops mtk_iommu_pm_ops = {
 
 static const struct mtk_iommu_plat_data mt2712_data = {
 	.m4u_plat     = M4U_MT2712,
-	.flags        = HAS_4GB_MODE | HAS_BCLK | HAS_VLD_PA_RNG,
+	.flags        = HAS_4GB_MODE | HAS_BCLK | HAS_VLD_PA_RNG | SHARE_PGTABLE,
+	.hw_list      = &m4ulist,
 	.inv_sel_reg  = REG_MMU_INV_SEL_GEN1,
 	.iova_region  = single_domain,
 	.iova_region_nr = ARRAY_SIZE(single_domain),
diff --git a/drivers/iommu/mtk_iommu.h b/drivers/iommu/mtk_iommu.h
index f81fa8862ed0..027a42396557 100644
--- a/drivers/iommu/mtk_iommu.h
+++ b/drivers/iommu/mtk_iommu.h
@@ -55,6 +55,7 @@ struct mtk_iommu_plat_data {
 	u32                 flags;
 	u32                 inv_sel_reg;
 
+	struct list_head			*hw_list;
 	unsigned int				iova_region_nr;
 	const struct mtk_iommu_iova_region	*iova_region;
 	unsigned char       larbid_remap[MTK_LARB_COM_MAX][MTK_LARB_SUBCOM_MAX];
@@ -80,6 +81,12 @@ struct mtk_iommu_data {
 
 	struct dma_iommu_mapping	*mapping; /* For mtk_iommu_v1.c */
 
+	/*
+	 * In the sharing pgtable case, list data->list to the global list like m4ulist.
+	 * In the non-sharing pgtable case, list data->list to the itself hw_list_head.
+	 */
+	struct list_head		*hw_list;
+	struct list_head		hw_list_head;
 	struct list_head		list;
 	struct mtk_smi_larb_iommu	larb_imu[MTK_LARB_NR_MAX];
 };
-- 
2.18.0

