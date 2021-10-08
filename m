Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B9D2426249
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 04:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234511AbhJHCHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 22:07:05 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:50666 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229489AbhJHCHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 22:07:04 -0400
X-UUID: b34e750afe7a415d87d72055cf00aef1-20211008
X-UUID: b34e750afe7a415d87d72055cf00aef1-20211008
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <yongqiang.niu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1662829849; Fri, 08 Oct 2021 10:05:06 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 8 Oct 2021 10:05:04 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 8 Oct 2021 10:05:03 +0800
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
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH v11, 1/2] soc: mediatek: mmsys: add comp OVL_2L2/POSTMASK/RDMA4
Date:   Fri, 8 Oct 2021 10:05:03 +0800
Message-ID: <20211008020504.1678-2-yongqiang.niu@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211008020504.1678-1-yongqiang.niu@mediatek.com>
References: <20211008020504.1678-1-yongqiang.niu@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch add some more ddp component
OVL_2L2 is ovl which include 2 layers overlay
POSTMASK control round corner for display frame
RDMA4 read dma buffer

Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
---
 include/linux/soc/mediatek/mtk-mmsys.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/soc/mediatek/mtk-mmsys.h b/include/linux/soc/mediatek/mtk-mmsys.h
index 2228bf6133da..4bba275e235a 100644
--- a/include/linux/soc/mediatek/mtk-mmsys.h
+++ b/include/linux/soc/mediatek/mtk-mmsys.h
@@ -29,13 +29,16 @@ enum mtk_ddp_comp_id {
 	DDP_COMPONENT_OVL0,
 	DDP_COMPONENT_OVL_2L0,
 	DDP_COMPONENT_OVL_2L1,
+	DDP_COMPONENT_OVL_2L2,
 	DDP_COMPONENT_OVL1,
+	DDP_COMPONENT_POSTMASK0,
 	DDP_COMPONENT_PWM0,
 	DDP_COMPONENT_PWM1,
 	DDP_COMPONENT_PWM2,
 	DDP_COMPONENT_RDMA0,
 	DDP_COMPONENT_RDMA1,
 	DDP_COMPONENT_RDMA2,
+	DDP_COMPONENT_RDMA4,
 	DDP_COMPONENT_UFOE,
 	DDP_COMPONENT_WDMA0,
 	DDP_COMPONENT_WDMA1,
-- 
2.25.1

