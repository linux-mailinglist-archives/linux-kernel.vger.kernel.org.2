Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1487433CBBA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 04:14:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234218AbhCPDNh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 23:13:37 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:49030 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232221AbhCPDN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 23:13:28 -0400
X-UUID: 505cec3068e3476b8f9b450fcecfaa30-20210316
X-UUID: 505cec3068e3476b8f9b450fcecfaa30-20210316
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2021609023; Tue, 16 Mar 2021 11:13:25 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 16 Mar 2021 11:13:24 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 16 Mar 2021 11:13:23 +0800
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     <chunkuang.hu@kernel.org>, <matthias.bgg@gmail.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>,
        Jitao Shi <jitao.shi@mediatek.com>
Subject: [v4,2/2] drm/mediatek: mtk_dpi: Add dpi config for mt8192
Date:   Tue, 16 Mar 2021 11:12:58 +0800
Message-ID: <1615864378-21754-3-git-send-email-rex-bc.chen@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1615864378-21754-1-git-send-email-rex-bc.chen@mediatek.com>
References: <1615864378-21754-1-git-send-email-rex-bc.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add mtk_dpi config setting and compatible for MT8192

Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_dpi.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediatek/mtk_dpi.c
index e1945d4bd7c4..f3896e2d22ca 100644
--- a/drivers/gpu/drm/mediatek/mtk_dpi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
@@ -698,6 +698,12 @@ static const struct mtk_dpi_conf mt8183_conf = {
 	.max_clock_khz = 100000,
 };
 
+static const struct mtk_dpi_conf mt8192_conf = {
+	.cal_factor = mt8183_calculate_factor,
+	.reg_h_fre_con = 0xe0,
+	.max_clock_khz = 150000,
+};
+
 static int mtk_dpi_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -818,6 +824,9 @@ static const struct of_device_id mtk_dpi_of_ids[] = {
 	{ .compatible = "mediatek,mt8183-dpi",
 	  .data = &mt8183_conf,
 	},
+	{ .compatible = "mediatek,mt8192-dpi",
+	  .data = &mt8192_conf,
+	},
 	{ },
 };
 
-- 
2.18.0

