Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A421B43DADF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 07:51:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbhJ1Fxc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 01:53:32 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:33612 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229586AbhJ1Fxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 01:53:31 -0400
X-UUID: 40e1470920704bad80456c6b63ae08c7-20211028
X-UUID: 40e1470920704bad80456c6b63ae08c7-20211028
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1816670345; Thu, 28 Oct 2021 13:51:00 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 28 Oct 2021 13:50:59 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkmbs10n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Thu, 28 Oct 2021 13:50:58 +0800
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
        Ikjoon Jang <ikjn@chromium.org>
Subject: [PATCH] memory: mtk-smi: Fix a null dereference for the ostd
Date:   Thu, 28 Oct 2021 13:50:56 +0800
Message-ID: <20211028055056.26378-1-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We add the ostd setting for mt8195. It introduces a abort for the
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
if "larb->larb_gen->ostd" is null, the "larbostd" is the offset, it is
also a valid value, thus, use the larb->larb_gen->ostd as the condition
inside the "for" loop.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
Hi Krzysztof,
Could you help review and conside this as a fix for the mt8195 patchset?
The mt8195 patchset are not in mainline, thus, I don't know its sha-id,
and don't add Fixes tag.
Thanks
---
 drivers/memory/mtk-smi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
index b883dcc0bbfa..0262a59a2d6e 100644
--- a/drivers/memory/mtk-smi.c
+++ b/drivers/memory/mtk-smi.c
@@ -257,7 +257,7 @@ static void mtk_smi_larb_config_port_gen2_general(struct device *dev)
 	if (MTK_SMI_CAPS(flags_general, MTK_SMI_FLAG_SW_FLAG))
 		writel_relaxed(SMI_LARB_SW_FLAG_1, larb->base + SMI_LARB_SW_FLAG);
 
-	for (i = 0; i < SMI_LARB_PORT_NR_MAX && larbostd && !!larbostd[i]; i++)
+	for (i = 0; i < SMI_LARB_PORT_NR_MAX && larb->larb_gen->ostd && !!larbostd[i]; i++)
 		writel_relaxed(larbostd[i], larb->base + SMI_LARB_OSTDL_PORTx(i));
 
 	for_each_set_bit(i, (unsigned long *)larb->mmu, 32) {
-- 
2.18.0

