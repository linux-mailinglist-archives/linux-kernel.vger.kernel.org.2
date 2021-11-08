Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7231E447BC1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 09:24:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236630AbhKHI10 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 03:27:26 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:55112 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S235830AbhKHI1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 03:27:24 -0500
X-UUID: 7f2e25ffd2c746c1928d5b134a5e2d14-20211108
X-UUID: 7f2e25ffd2c746c1928d5b134a5e2d14-20211108
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1300905659; Mon, 08 Nov 2021 16:24:37 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Mon, 8 Nov 2021 16:24:36 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkmbs10n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Mon, 8 Nov 2021 16:24:35 +0800
From:   Yong Wu <yong.wu@mediatek.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Krzysztof Kozlowski <krzk@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Tomasz Figa" <tfiga@chromium.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <yong.wu@mediatek.com>,
        <youlin.pei@mediatek.com>, <anan.sun@mediatek.com>,
        <yi.kuo@mediatek.com>, <anthony.huang@mediatek.com>,
        Ikjoon Jang <ikjn@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>
Subject: [PATCH v2] memory: mtk-smi: Fix a null dereference for the ostd
Date:   Mon, 8 Nov 2021 16:24:29 +0800
Message-ID: <20211108082429.15080-1-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We add the ostd setting for mt8195. It introduces a KE for the
previous SoC which doesn't have ostd setting. This is the log:

Unable to handle kernel NULL pointer dereference at virtual address
0000000000000080
...
pc : mtk_smi_larb_config_port_gen2_general+0x64/0x130
lr : mtk_smi_larb_resume+0x54/0x98
...
Call trace:
 mtk_smi_larb_config_port_gen2_general+0x64/0x130
 pm_generic_runtime_resume+0x2c/0x48
 __genpd_runtime_resume+0x30/0xa8
 genpd_runtime_resume+0x94/0x2c8
 __rpm_callback+0x44/0x150
 rpm_callback+0x6c/0x78
 rpm_resume+0x310/0x558
 __pm_runtime_resume+0x3c/0x88

In the code: larbostd = larb->larb_gen->ostd[larb->larbid],
if "larb->larb_gen->ostd" is null, the "larbostd" is the offset(e.g.
0x80 above), it's also a valid value, then accessing "larbostd[i]" in the
"for" loop will cause the KE above. To avoid this issue, initialize
"larbostd" to NULL when the SoC doesn't have ostd setting.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
change note: Reword the commit message to show why it KE. and update the
solution via initializing "larbostd" is NULL explicitly in the non-ostd
case.
---
 drivers/memory/mtk-smi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
index b883dcc0bbfa..e201e5976f34 100644
--- a/drivers/memory/mtk-smi.c
+++ b/drivers/memory/mtk-smi.c
@@ -241,7 +241,7 @@ static void mtk_smi_larb_config_port_gen2_general(struct device *dev)
 {
 	struct mtk_smi_larb *larb = dev_get_drvdata(dev);
 	u32 reg, flags_general = larb->larb_gen->flags_general;
-	const u8 *larbostd = larb->larb_gen->ostd[larb->larbid];
+	const u8 *larbostd = larb->larb_gen->ostd ? larb->larb_gen->ostd[larb->larbid] : NULL;
 	int i;
 
 	if (BIT(larb->larbid) & larb->larb_gen->larb_direct_to_common_mask)
-- 
2.18.0

