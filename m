Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 145C33CCEE5
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 09:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235133AbhGSHzT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 03:55:19 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:46486 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S235071AbhGSHzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 03:55:14 -0400
X-UUID: 4c3ecf37000447c2b17e0d2ce9640b75-20210719
X-UUID: 4c3ecf37000447c2b17e0d2ce9640b75-20210719
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <yongqiang.niu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1834079245; Mon, 19 Jul 2021 15:52:11 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 19 Jul 2021 15:52:09 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 19 Jul 2021 15:52:08 +0800
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
Subject: [PATCH v1] drm/mediatek: add dither 6 setting
Date:   Mon, 19 Jul 2021 15:52:06 +0800
Message-ID: <1626681126-29270-2-git-send-email-yongqiang.niu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1626681126-29270-1-git-send-email-yongqiang.niu@mediatek.com>
References: <1626681126-29270-1-git-send-email-yongqiang.niu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

in the first version dither patch
https://patchwork.kernel.org/project/linux-mediatek/patch/1553667561-25447-13-git-send-email-yongqiang.niu@mediatek.com/
dither 6 setting is included in that patch
bit 1 is lfsr_en( "Enables LFSR-type dithering"), need enable
bit 2 is rdither_en(Enables running order dithering), need disable
in this issue
https://partnerissuetracker.corp.google.com/issues/190643544

dither 6 setting missed in set dither common patch
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c?h=next-20210430&id=a6b7c98afdcad0f149010ae028b24f2d0dc24cdb

Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c | 2 ++
 1 file changed, 2 insertions(+)
 mode change 100644 => 100755 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
old mode 100644
new mode 100755
index 99cbf44..7dd8e05
--- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
@@ -26,6 +26,7 @@
 #define DISP_OD_CFG				0x0020
 #define DISP_OD_SIZE				0x0030
 #define DISP_DITHER_5				0x0114
+#define DISP_DITHER_6				0x0118
 #define DISP_DITHER_7				0x011c
 #define DISP_DITHER_15				0x013c
 #define DISP_DITHER_16				0x0140
@@ -135,6 +136,7 @@ void mtk_dither_set_common(void __iomem *regs, struct cmdq_client_reg *cmdq_reg,
 
 	if (bpc >= MTK_MIN_BPC) {
 		mtk_ddp_write(cmdq_pkt, 0, cmdq_reg, regs, DISP_DITHER_5);
+		mtk_ddp_write(cmdq_pkt, 0x3002, cmdq_reg, regs, DISP_DITHER_6);
 		mtk_ddp_write(cmdq_pkt, 0, cmdq_reg, regs, DISP_DITHER_7);
 		mtk_ddp_write(cmdq_pkt,
 			      DITHER_LSB_ERR_SHIFT_R(MTK_MAX_BPC - bpc) |
-- 
1.8.1.1.dirty

