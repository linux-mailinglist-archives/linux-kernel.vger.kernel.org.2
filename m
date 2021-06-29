Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 201283B6C3A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 03:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231789AbhF2Buh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 21:50:37 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:43922 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231404AbhF2Bu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 21:50:29 -0400
X-UUID: 4b8d795882d94e85a1977564b40edc4c-20210629
X-UUID: 4b8d795882d94e85a1977564b40edc4c-20210629
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <trevor.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1094891874; Tue, 29 Jun 2021 09:47:59 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 29 Jun 2021 09:47:51 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 29 Jun 2021 09:47:51 +0800
From:   Trevor Wu <trevor.wu@mediatek.com>
To:     <broonie@kernel.org>, <tiwai@suse.com>, <robh+dt@kernel.org>,
        <matthias.bgg@gmail.com>
CC:     <trevor.wu@mediatek.com>, <alsa-devel@alsa-project.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <bicycle.tsai@mediatek.com>, <jiaxin.yu@mediatek.com>,
        <cychiang@google.com>, <aaronyu@google.com>
Subject: [PATCH v2 1/8] ASoC: mediatek: mt8195: update mediatek common driver
Date:   Tue, 29 Jun 2021 09:47:29 +0800
Message-ID: <20210629014736.31153-2-trevor.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210629014736.31153-1-trevor.wu@mediatek.com>
References: <20210629014736.31153-1-trevor.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update mediatek common driver to support MT8195

Signed-off-by: Trevor Wu <trevor.wu@mediatek.com>
Reported-by: kernel test robot <lkp@intel.com>
---
 sound/soc/mediatek/common/mtk-afe-fe-dai.c | 22 +++++++++++++++++++---
 sound/soc/mediatek/common/mtk-base-afe.h   | 10 ++++++++--
 2 files changed, 27 insertions(+), 5 deletions(-)

diff --git a/sound/soc/mediatek/common/mtk-afe-fe-dai.c b/sound/soc/mediatek/common/mtk-afe-fe-dai.c
index 3cb2adf420bb..baaa5881b1d4 100644
--- a/sound/soc/mediatek/common/mtk-afe-fe-dai.c
+++ b/sound/soc/mediatek/common/mtk-afe-fe-dai.c
@@ -139,7 +139,7 @@ int mtk_afe_fe_hw_params(struct snd_pcm_substream *substream,
 		substream->runtime->dma_area,
 		substream->runtime->dma_bytes);
 
-	memset_io(substream->runtime->dma_area, 0,
+	memset_io((void __force __iomem *)substream->runtime->dma_area, 0,
 		  substream->runtime->dma_bytes);
 
 	/* set addr */
@@ -433,11 +433,20 @@ int mtk_memif_set_addr(struct mtk_base_afe *afe, int id,
 				 phys_buf_addr_upper_32);
 	}
 
-	/* set MSB to 33-bit */
-	if (memif->data->msb_reg >= 0)
+	/*
+	 * set MSB to 33-bit, for memif address
+	 * only for memif base address, if msb_end_reg exists
+	 */
+	if (memif->data->msb_reg)
 		mtk_regmap_update_bits(afe->regmap, memif->data->msb_reg,
 				       1, msb_at_bit33, memif->data->msb_shift);
 
+	/* set MSB to 33-bit, for memif end address */
+	if (memif->data->msb_end_reg)
+		mtk_regmap_update_bits(afe->regmap, memif->data->msb_end_reg,
+				       1, msb_at_bit33,
+				       memif->data->msb_end_shift);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(mtk_memif_set_addr);
@@ -464,6 +473,13 @@ int mtk_memif_set_channel(struct mtk_base_afe *afe,
 	else
 		mono = (channel == 1) ? 1 : 0;
 
+	/* for specific configuration of memif mono mode */
+	if (memif->data->int_odd_flag_reg)
+		mtk_regmap_update_bits(afe->regmap,
+				       memif->data->int_odd_flag_reg,
+				       1, mono,
+				       memif->data->int_odd_flag_shift);
+
 	return mtk_regmap_update_bits(afe->regmap, memif->data->mono_reg,
 				      1, mono, memif->data->mono_shift);
 }
diff --git a/sound/soc/mediatek/common/mtk-base-afe.h b/sound/soc/mediatek/common/mtk-base-afe.h
index a6f68c68581c..ef83e78c22a8 100644
--- a/sound/soc/mediatek/common/mtk-base-afe.h
+++ b/sound/soc/mediatek/common/mtk-base-afe.h
@@ -29,6 +29,8 @@ struct mtk_base_memif_data {
 	int quad_ch_reg;
 	int quad_ch_mask;
 	int quad_ch_shift;
+	int int_odd_flag_reg;
+	int int_odd_flag_shift;
 	int enable_reg;
 	int enable_shift;
 	int hd_reg;
@@ -37,10 +39,13 @@ struct mtk_base_memif_data {
 	int hd_align_mshift;
 	int msb_reg;
 	int msb_shift;
-	int msb2_reg;
-	int msb2_shift;
+	int msb_end_reg;
+	int msb_end_shift;
 	int agent_disable_reg;
 	int agent_disable_shift;
+	int ch_num_reg;
+	int ch_num_shift;
+	int ch_num_maskbit;
 	/* playback memif only */
 	int pbuf_reg;
 	int pbuf_mask;
@@ -62,6 +67,7 @@ struct mtk_base_irq_data {
 	int irq_en_shift;
 	int irq_clr_reg;
 	int irq_clr_shift;
+	int irq_status_shift;
 };
 
 struct device;
-- 
2.18.0

