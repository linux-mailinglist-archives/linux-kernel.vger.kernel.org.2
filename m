Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B42163B16E9
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 11:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbhFWJdM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 05:33:12 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:50921 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230028AbhFWJdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 05:33:07 -0400
X-UUID: b7abbf6fe05e4edc858c040d2162eb1d-20210623
X-UUID: b7abbf6fe05e4edc858c040d2162eb1d-20210623
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <yongqiang.niu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 418237550; Wed, 23 Jun 2021 17:30:46 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 23 Jun 2021 17:30:35 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 23 Jun 2021 17:30:34 +0800
From:   Yongqiang Niu <yongqiang.niu@mediatek.com>
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>,
        Fabien Parent <fparent@baylibre.com>,
        Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>
Subject: [PATCH v5, 3/3] mailbox: cmdq: add mt8192 support
Date:   Wed, 23 Jun 2021 17:30:23 +0800
Message-ID: <1624440623-4585-4-git-send-email-yongqiang.niu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1624440623-4585-1-git-send-email-yongqiang.niu@mediatek.com>
References: <1624440623-4585-1-git-send-email-yongqiang.niu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add mt8192 support

Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 drivers/mailbox/mtk-cmdq-mailbox.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/mailbox/mtk-cmdq-mailbox.c b/drivers/mailbox/mtk-cmdq-mailbox.c
index 5665b6e..de4793e 100644
--- a/drivers/mailbox/mtk-cmdq-mailbox.c
+++ b/drivers/mailbox/mtk-cmdq-mailbox.c
@@ -36,6 +36,8 @@
 #define CMDQ_THR_WAIT_TOKEN		0x30
 #define CMDQ_THR_PRIORITY		0x40
 
+#define GCE_GCTL_VALUE			0x48
+
 #define CMDQ_THR_ACTIVE_SLOT_CYCLES	0x3200
 #define CMDQ_THR_ENABLED		0x1
 #define CMDQ_THR_DISABLED		0x0
@@ -76,11 +78,13 @@ struct cmdq {
 	struct clk		*clock;
 	bool			suspended;
 	u8			shift_pa;
+	bool			control_by_sw;
 };
 
 struct gce_plat {
 	u32 thread_nr;
 	u8 shift;
+	bool control_by_sw;
 };
 
 u8 cmdq_get_shift_pa(struct mbox_chan *chan)
@@ -121,6 +125,8 @@ static void cmdq_init(struct cmdq *cmdq)
 	int i;
 
 	WARN_ON(clk_enable(cmdq->clock) < 0);
+	if (cmdq->control_by_sw)
+		writel(0x7, cmdq->base + GCE_GCTL_VALUE);
 	writel(CMDQ_THR_ACTIVE_SLOT_CYCLES, cmdq->base + CMDQ_THR_SLOT_CYCLES);
 	for (i = 0; i <= CMDQ_MAX_EVENT; i++)
 		writel(i, cmdq->base + CMDQ_SYNC_TOKEN_UPDATE);
@@ -536,6 +542,7 @@ static int cmdq_probe(struct platform_device *pdev)
 
 	cmdq->thread_nr = plat_data->thread_nr;
 	cmdq->shift_pa = plat_data->shift;
+	cmdq->control_by_sw = plat_data->control_by_sw;
 	cmdq->irq_mask = GENMASK(cmdq->thread_nr - 1, 0);
 	err = devm_request_irq(dev, cmdq->irq, cmdq_irq_handler, IRQF_SHARED,
 			       "mtk_cmdq", cmdq);
@@ -601,11 +608,14 @@ static int cmdq_probe(struct platform_device *pdev)
 static const struct gce_plat gce_plat_v2 = {.thread_nr = 16};
 static const struct gce_plat gce_plat_v3 = {.thread_nr = 24};
 static const struct gce_plat gce_plat_v4 = {.thread_nr = 24, .shift = 3};
+static const struct gce_plat gce_plat_v5 = {.thread_nr = 24, .shift = 3,
+					    .control_by_sw = true};
 
 static const struct of_device_id cmdq_of_ids[] = {
 	{.compatible = "mediatek,mt8173-gce", .data = (void *)&gce_plat_v2},
 	{.compatible = "mediatek,mt8183-gce", .data = (void *)&gce_plat_v3},
 	{.compatible = "mediatek,mt6779-gce", .data = (void *)&gce_plat_v4},
+	{.compatible = "mediatek,mt8192-gce", .data = (void *)&gce_plat_v5},
 	{}
 };
 
-- 
1.8.1.1.dirty

