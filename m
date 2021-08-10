Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 194713E54E4
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 10:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238042AbhHJIMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 04:12:10 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:51958 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S238025AbhHJILJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 04:11:09 -0400
X-UUID: 5b38a538ee4948d3a8ca09b184146a47-20210810
X-UUID: 5b38a538ee4948d3a8ca09b184146a47-20210810
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1917217334; Tue, 10 Aug 2021 16:10:35 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 10 Aug 2021 16:10:33 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 10 Aug 2021 16:10:32 +0800
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
Subject: [PATCH v3 10/13] memory: mtk-smi: mt8195: Add smi support
Date:   Tue, 10 Aug 2021 16:08:56 +0800
Message-ID: <20210810080859.29511-11-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210810080859.29511-1-yong.wu@mediatek.com>
References: <20210810080859.29511-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MT8195 has two smi-common, their IP are the same. Only the larbs that
connect with the smi-common are different. thus the bus_sel are different
for the two smi-common.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
Reviewed-by: Ikjoon Jang <ikjn@chromium.org>
---
 drivers/memory/mtk-smi.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
index a001e41f5074..35853ba980c9 100644
--- a/drivers/memory/mtk-smi.c
+++ b/drivers/memory/mtk-smi.c
@@ -261,6 +261,10 @@ static const struct mtk_smi_larb_gen mtk_smi_larb_mt8192 = {
 	.config_port                = mtk_smi_larb_config_port_gen2_general,
 };
 
+static const struct mtk_smi_larb_gen mtk_smi_larb_mt8195 = {
+	.config_port                = mtk_smi_larb_config_port_gen2_general,
+};
+
 static const struct of_device_id mtk_smi_larb_of_ids[] = {
 	{.compatible = "mediatek,mt2701-smi-larb", .data = &mtk_smi_larb_mt2701},
 	{.compatible = "mediatek,mt2712-smi-larb", .data = &mtk_smi_larb_mt2712},
@@ -269,6 +273,7 @@ static const struct of_device_id mtk_smi_larb_of_ids[] = {
 	{.compatible = "mediatek,mt8173-smi-larb", .data = &mtk_smi_larb_mt8173},
 	{.compatible = "mediatek,mt8183-smi-larb", .data = &mtk_smi_larb_mt8183},
 	{.compatible = "mediatek,mt8192-smi-larb", .data = &mtk_smi_larb_mt8192},
+	{.compatible = "mediatek,mt8195-smi-larb", .data = &mtk_smi_larb_mt8195},
 	{}
 };
 
@@ -443,6 +448,24 @@ static const struct mtk_smi_common_plat mtk_smi_common_mt8192 = {
 		    F_MMU1_LARB(6),
 };
 
+static const struct mtk_smi_common_plat mtk_smi_common_mt8195_vdo = {
+	.type     = MTK_SMI_GEN2,
+	.has_gals = true,
+	.bus_sel  = F_MMU1_LARB(1) | F_MMU1_LARB(3) | F_MMU1_LARB(5) |
+		    F_MMU1_LARB(7),
+};
+
+static const struct mtk_smi_common_plat mtk_smi_common_mt8195_vpp = {
+	.type     = MTK_SMI_GEN2,
+	.has_gals = true,
+	.bus_sel  = F_MMU1_LARB(1) | F_MMU1_LARB(2) | F_MMU1_LARB(7),
+};
+
+static const struct mtk_smi_common_plat mtk_smi_sub_common_mt8195 = {
+	.type     = MTK_SMI_GEN2_SUB_COMM,
+	.has_gals = true,
+};
+
 static const struct of_device_id mtk_smi_common_of_ids[] = {
 	{.compatible = "mediatek,mt2701-smi-common", .data = &mtk_smi_common_gen1},
 	{.compatible = "mediatek,mt2712-smi-common", .data = &mtk_smi_common_gen2},
@@ -451,6 +474,9 @@ static const struct of_device_id mtk_smi_common_of_ids[] = {
 	{.compatible = "mediatek,mt8173-smi-common", .data = &mtk_smi_common_gen2},
 	{.compatible = "mediatek,mt8183-smi-common", .data = &mtk_smi_common_mt8183},
 	{.compatible = "mediatek,mt8192-smi-common", .data = &mtk_smi_common_mt8192},
+	{.compatible = "mediatek,mt8195-smi-common-vdo", .data = &mtk_smi_common_mt8195_vdo},
+	{.compatible = "mediatek,mt8195-smi-common-vpp", .data = &mtk_smi_common_mt8195_vpp},
+	{.compatible = "mediatek,mt8195-smi-sub-common", .data = &mtk_smi_sub_common_mt8195},
 	{}
 };
 
-- 
2.18.0

