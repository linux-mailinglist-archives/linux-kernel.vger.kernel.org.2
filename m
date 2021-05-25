Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3932C38FA54
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 07:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbhEYFzL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 01:55:11 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:55450 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231185AbhEYFzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 01:55:09 -0400
X-UUID: e1ecea412c79465d8f63d6b170e7409a-20210525
X-UUID: e1ecea412c79465d8f63d6b170e7409a-20210525
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <nina-cm.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 45104748; Tue, 25 May 2021 13:53:36 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 25 May 2021 13:53:35 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 25 May 2021 13:53:35 +0800
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
Subject: [PATCH v4 3/7] soc: mediatek: devapc: add shared flag to IRQ
Date:   Tue, 25 May 2021 13:53:02 +0800
Message-ID: <1621921986-20578-3-git-send-email-nina-cm.wu@mediatek.com>
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

For new ICs, there are multiple devapc HWs for different subsys.
They all share the same IRQ number.

Signed-off-by: Nina Wu <Nina-CM.Wu@mediatek.com>
---
 drivers/soc/mediatek/mtk-devapc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/mediatek/mtk-devapc.c b/drivers/soc/mediatek/mtk-devapc.c
index 71643d1..6d58a75 100644
--- a/drivers/soc/mediatek/mtk-devapc.c
+++ b/drivers/soc/mediatek/mtk-devapc.c
@@ -281,7 +281,7 @@ static int mtk_devapc_probe(struct platform_device *pdev)
 		return -EINVAL;
 
 	ret = devm_request_irq(&pdev->dev, devapc_irq, devapc_violation_irq,
-			       IRQF_TRIGGER_NONE, "devapc", ctx);
+			       IRQF_TRIGGER_NONE | IRQF_SHARED, "devapc", ctx);
 	if (ret) {
 		clk_disable_unprepare(ctx->infra_clk);
 		return ret;
-- 
2.6.4

