Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B4D4350F38
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 08:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233538AbhDAGlA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 02:41:00 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:49169 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S233513AbhDAGkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 02:40:33 -0400
X-UUID: b6187f31c8b5475b9d71140e010e6792-20210401
X-UUID: b6187f31c8b5475b9d71140e010e6792-20210401
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <nina-cm.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 484400245; Thu, 01 Apr 2021 14:40:30 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 1 Apr 2021 14:40:28 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 1 Apr 2021 14:40:29 +0800
From:   Nina Wu <nina-cm.wu@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Nina Wu <Nina-CM.Wu@mediatek.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Neal Liu <neal.liu@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <Jackson-kt.Chang@mediatek.com>
Subject: [PATCH v2 6/6] soc: mediatek: devapc: support mt8192
Date:   Thu, 1 Apr 2021 14:38:07 +0800
Message-ID: <1617259087-5502-6-git-send-email-nina-cm.wu@mediatek.com>
X-Mailer: git-send-email 2.6.4
In-Reply-To: <1617259087-5502-1-git-send-email-nina-cm.wu@mediatek.com>
References: <1617259087-5502-1-git-send-email-nina-cm.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: EBA15B3D3A41FD19CDF67EE541EC17DFB527CD8A22555DDCB36B0413C99423022000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nina Wu <Nina-CM.Wu@mediatek.com>

Add compatible to support mt8192.

Signed-off-by: Nina Wu <Nina-CM.Wu@mediatek.com>
---
 drivers/soc/mediatek/mtk-devapc.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/soc/mediatek/mtk-devapc.c b/drivers/soc/mediatek/mtk-devapc.c
index af55c01..a5c15b5 100644
--- a/drivers/soc/mediatek/mtk-devapc.c
+++ b/drivers/soc/mediatek/mtk-devapc.c
@@ -251,11 +251,26 @@ static const struct mtk_devapc_data devapc_mt6779 = {
 	.vio_shift_con_offset = 0xF20,
 };
 
+static const struct mtk_devapc_data devapc_mt8192 = {
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

