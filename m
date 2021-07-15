Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5EF43C9E63
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 14:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234665AbhGOMQQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 08:16:16 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:47854 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S234430AbhGOMQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 08:16:14 -0400
X-UUID: ffe1033cc78943fa92af2fc1e36de5be-20210715
X-UUID: ffe1033cc78943fa92af2fc1e36de5be-20210715
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 321558719; Thu, 15 Jul 2021 20:13:18 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 15 Jul 2021 20:13:16 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 15 Jul 2021 20:13:16 +0800
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
        <anthony.huang@mediatek.com>
Subject: [PATCH v2 06/11] memory: mtk-smi: Add error handle for smi_probe
Date:   Thu, 15 Jul 2021 20:12:04 +0800
Message-ID: <20210715121209.31024-7-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210715121209.31024-1-yong.wu@mediatek.com>
References: <20210715121209.31024-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add error handle while component_add fail.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
It don't have the error handle when v1. it is not a fatal error.
thus don't add fix tags.
---
 drivers/memory/mtk-smi.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
index 6f8e582bace5..e68cbb51dd12 100644
--- a/drivers/memory/mtk-smi.c
+++ b/drivers/memory/mtk-smi.c
@@ -330,7 +330,15 @@ static int mtk_smi_larb_probe(struct platform_device *pdev)
 
 	pm_runtime_enable(dev);
 	platform_set_drvdata(pdev, larb);
-	return component_add(dev, &mtk_smi_larb_component_ops);
+	ret = component_add(dev, &mtk_smi_larb_component_ops);
+	if (ret)
+		goto err_pm_disable;
+	return 0;
+
+err_pm_disable:
+	pm_runtime_disable(dev);
+	device_link_remove(dev, larb->smi_common_dev);
+	return ret;
 }
 
 static int mtk_smi_larb_remove(struct platform_device *pdev)
-- 
2.18.0

