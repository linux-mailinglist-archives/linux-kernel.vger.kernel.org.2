Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC08447219
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Nov 2021 08:57:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235193AbhKGH7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Nov 2021 02:59:39 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:42910 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S235036AbhKGH7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Nov 2021 02:59:36 -0500
X-UUID: b74d92ca6377482a85b95290f46a6fc7-20211107
X-UUID: b74d92ca6377482a85b95290f46a6fc7-20211107
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 140865798; Sun, 07 Nov 2021 15:56:51 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Sun, 7 Nov 2021 15:56:50 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkmbs10n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Sun, 7 Nov 2021 15:56:49 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        Eddie Hung <eddie.hung@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Yz Wu <yz.wu@mediatek.com>
Subject: [PATCH 3/6] nvmem: mtk-efuse: support minimum one byte access stride and granularity
Date:   Sun, 7 Nov 2021 15:56:43 +0800
Message-ID: <20211107075646.4366-3-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211107075646.4366-1-chunfeng.yun@mediatek.com>
References: <20211107075646.4366-1-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to support nvmem bits property, should support minimum 1 byte
read stride and minimum 1 byte read granularity at the same time.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/nvmem/mtk-efuse.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/nvmem/mtk-efuse.c b/drivers/nvmem/mtk-efuse.c
index 6a537d959f14..e9a375dd84af 100644
--- a/drivers/nvmem/mtk-efuse.c
+++ b/drivers/nvmem/mtk-efuse.c
@@ -19,11 +19,12 @@ static int mtk_reg_read(void *context,
 			unsigned int reg, void *_val, size_t bytes)
 {
 	struct mtk_efuse_priv *priv = context;
-	u32 *val = _val;
-	int i = 0, words = bytes / 4;
+	void __iomem *addr = priv->base + reg;
+	u8 *val = _val;
+	int i;
 
-	while (words--)
-		*val++ = readl(priv->base + reg + (i++ * 4));
+	for (i = 0; i < bytes; i++, val++)
+		*val = readb(addr + i);
 
 	return 0;
 }
@@ -45,8 +46,8 @@ static int mtk_efuse_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->base))
 		return PTR_ERR(priv->base);
 
-	econfig.stride = 4;
-	econfig.word_size = 4;
+	econfig.stride = 1;
+	econfig.word_size = 1;
 	econfig.reg_read = mtk_reg_read;
 	econfig.size = resource_size(res);
 	econfig.priv = priv;
-- 
2.18.0

