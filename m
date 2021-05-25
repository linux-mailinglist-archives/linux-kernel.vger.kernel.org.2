Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF3038FA64
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 07:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231321AbhEYFzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 01:55:32 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:55963 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231259AbhEYFz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 01:55:27 -0400
X-UUID: c35b3814703c46de9e695d8502608858-20210525
X-UUID: c35b3814703c46de9e695d8502608858-20210525
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <nina-cm.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1301475935; Tue, 25 May 2021 13:53:56 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 25 May 2021 13:53:53 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 25 May 2021 13:53:53 +0800
From:   Nina Wu <nina-cm.wu@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Zhen Lei <thunder.leizhen@huawei.com>,
        Nina Wu <Nina-CM.Wu@mediatek.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <Jackson-kt.Chang@mediatek.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v4 6/7] soc: mediatek: devapc: support mt8192
Date:   Tue, 25 May 2021 13:53:05 +0800
Message-ID: <1621921986-20578-6-git-send-email-nina-cm.wu@mediatek.com>
X-Mailer: git-send-email 2.6.4
In-Reply-To: <1621921986-20578-1-git-send-email-nina-cm.wu@mediatek.com>
References: <1621921986-20578-1-git-send-email-nina-cm.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nina Wu <Nina-CM.Wu@mediatek.com>

Add compatible to support mt8192.

Signed-off-by: Nina Wu <Nina-CM.Wu@mediatek.com>
---
 drivers/soc/mediatek/mtk-devapc.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/soc/mediatek/mtk-devapc.c b/drivers/soc/mediatek/mtk-devapc.c
index bdc8fe9..84dd6a2 100644
--- a/drivers/soc/mediatek/mtk-devapc.c
+++ b/drivers/soc/mediatek/mtk-devapc.c
@@ -265,11 +265,27 @@ static const struct mtk_devapc_data devapc_mt6779 = {
 	.vio_shift_con_offset = 0xF20,
 };
 
+static const struct mtk_devapc_data devapc_mt8192 = {
+	.version = 2,
+	.vio_mask_offset = 0x0,
+	.vio_sta_offset = 0x400,
+	.vio_dbg0_offset = 0x900,
+	.vio_dbg1_offset = 0x904,
+	.vio_dbg2_offset = 0x908,
+	.apc_con_offset = 0xF00,
+	.vio_shift_sta_offset = 0xF20,
+	.vio_shift_sel_offset = 0xF30,
+	.vio_shift_con_offset = 0xF10,
+};
+
 static const struct of_device_id mtk_devapc_dt_match[] = {
 	{
 		.compatible = "mediatek,mt6779-devapc",
 		.data = &devapc_mt6779,
 	}, {
+		.compatible = "mediatek,mt8192-devapc",
+		.data = &devapc_mt8192,
+	}, {
 	},
 };
 
-- 
2.6.4

