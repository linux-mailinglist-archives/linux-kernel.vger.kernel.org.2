Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C1653E54E0
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 10:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238114AbhHJILu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 04:11:50 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:51442 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S238027AbhHJILJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 04:11:09 -0400
X-UUID: e28db6c3784f4f078437a7abe004c196-20210810
X-UUID: e28db6c3784f4f078437a7abe004c196-20210810
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1184281761; Tue, 10 Aug 2021 16:10:21 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 10 Aug 2021 16:10:20 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 10 Aug 2021 16:10:19 +0800
From:   Yong Wu <yong.wu@mediatek.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Krzysztof Kozlowski <krzk@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Tomasz Figa <tfiga@chromium.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <yong.wu@mediatek.com>,
        <youlin.pei@mediatek.com>, <anan.sun@mediatek.com>,
        <ming-fan.chen@mediatek.com>, <yi.kuo@mediatek.com>,
        <anthony.huang@mediatek.com>, Ikjoon Jang <ikjn@chromium.org>
Subject: [PATCH v3 08/13] memory: mtk-smi: Add clocks for smi-sub-common
Date:   Tue, 10 Aug 2021 16:08:54 +0800
Message-ID: <20210810080859.29511-9-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210810080859.29511-1-yong.wu@mediatek.com>
References: <20210810080859.29511-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SMI sub common only have one output port. thus it has only one gals
clocks(gals0). then, smi-sub-common require the three clocks(apb/smi/gals0)
in has_gals case.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 drivers/memory/mtk-smi.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
index 5c2bd5795cfd..58d9f7667490 100644
--- a/drivers/memory/mtk-smi.c
+++ b/drivers/memory/mtk-smi.c
@@ -74,10 +74,12 @@ static const char * const mtk_smi_larb_clks[] = {"apb", "smi", "gals"};
 
 /*
  * common: Require these four clocks in has_gals case. Otherwise, only apb/smi are required.
+ * sub common: Require apb/smi/gals0 clocks in has_gals case. Otherwise, only apb/smi are required.
  */
 static const char * const mtk_smi_common_clks[] = {"apb", "smi", "gals0", "gals1"};
 #define MTK_SMI_COM_REQ_CLK_NR		2
 #define MTK_SMI_COM_GALS_REQ_CLK_NR	MTK_SMI_CLK_NR_MAX
+#define MTK_SMI_SUB_COM_GALS_REQ_CLK_NR 3
 
 struct mtk_smi_common_plat {
 	enum mtk_smi_type	type;
@@ -467,8 +469,12 @@ static int mtk_smi_common_probe(struct platform_device *pdev)
 	common->dev = dev;
 	common->plat = of_device_get_match_data(dev);
 
-	if (common->plat->has_gals)
-		clk_required = MTK_SMI_COM_GALS_REQ_CLK_NR;
+	if (common->plat->has_gals) {
+		if (common->plat->type == MTK_SMI_GEN2)
+			clk_required = MTK_SMI_COM_GALS_REQ_CLK_NR;
+		else if (common->plat->type == MTK_SMI_GEN2_SUB_COMM)
+			clk_required = MTK_SMI_SUB_COM_GALS_REQ_CLK_NR;
+	}
 	ret = mtk_smi_dts_clk_init(dev, common, mtk_smi_common_clks, clk_required, 0);
 	if (ret)
 		return ret;
-- 
2.18.0

