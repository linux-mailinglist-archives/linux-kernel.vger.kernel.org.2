Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8122D41DADA
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 15:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350706AbhI3NUl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 09:20:41 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:47680 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1350673AbhI3NUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 09:20:39 -0400
X-UUID: 973fccaee5584a37a98ec9f5f8e239f5-20210930
X-UUID: 973fccaee5584a37a98ec9f5f8e239f5-20210930
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <yongqiang.niu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2121530296; Thu, 30 Sep 2021 21:18:53 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 30 Sep 2021 21:18:51 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkcas07.mediatek.inc
 (172.21.101.84) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 30 Sep
 2021 21:18:51 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 30 Sep 2021 21:18:50 +0800
From:   Yongqiang Niu <yongqiang.niu@mediatek.com>
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "David Airlie" <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
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
Subject: [PATCH v2, 1/1] mailbox: cmdq: add instruction time-out interrupt support
Date:   Thu, 30 Sep 2021 21:18:50 +0800
Message-ID: <20210930131850.21202-2-yongqiang.niu@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210930131850.21202-1-yongqiang.niu@mediatek.com>
References: <20210930131850.21202-1-yongqiang.niu@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add time-out cycle setting to make sure time-out interrupt irq
will happened when instruction time-out for wait and poll

Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
---
 drivers/mailbox/mtk-cmdq-mailbox.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/mailbox/mtk-cmdq-mailbox.c b/drivers/mailbox/mtk-cmdq-mailbox.c
index 64175a893312..197b03222f94 100644
--- a/drivers/mailbox/mtk-cmdq-mailbox.c
+++ b/drivers/mailbox/mtk-cmdq-mailbox.c
@@ -36,6 +36,7 @@
 #define CMDQ_THR_END_ADDR		0x24
 #define CMDQ_THR_WAIT_TOKEN		0x30
 #define CMDQ_THR_PRIORITY		0x40
+#define CMDQ_THR_INSTN_TIMEOUT_CYCLES	0x50
 
 #define GCE_GCTL_VALUE			0x48
 
@@ -54,6 +55,15 @@
 #define CMDQ_JUMP_BY_OFFSET		0x10000000
 #define CMDQ_JUMP_BY_PA			0x10000001
 
+/*
+ * instruction time-out
+ * cycles to issue instruction time-out interrupt for wait and poll instructions
+ * GCE axi_clock 156MHz
+ * 1 cycle = 6.41ns
+ * instruction time out 2^22*2*6.41ns = 53ms
+ */
+#define CMDQ_INSTN_TIMEOUT_CYCLES	22
+
 struct cmdq_thread {
 	struct mbox_chan	*chan;
 	void __iomem		*base;
@@ -376,6 +386,7 @@ static int cmdq_mbox_send_data(struct mbox_chan *chan, void *data)
 		writel((task->pa_base + pkt->cmd_buf_size) >> cmdq->shift_pa,
 		       thread->base + CMDQ_THR_END_ADDR);
 
+		writel(CMDQ_INSTN_TIMEOUT_CYCLES, thread->base + CMDQ_THR_INSTN_TIMEOUT_CYCLES);
 		writel(thread->priority, thread->base + CMDQ_THR_PRIORITY);
 		writel(CMDQ_THR_IRQ_EN, thread->base + CMDQ_THR_IRQ_ENABLE);
 		writel(CMDQ_THR_ENABLED, thread->base + CMDQ_THR_ENABLE_TASK);
-- 
2.25.1

