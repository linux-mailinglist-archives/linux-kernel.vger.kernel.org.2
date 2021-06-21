Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8312A3AE588
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 11:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbhFUJFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 05:05:16 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:44651 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230269AbhFUJFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 05:05:06 -0400
X-UUID: 9eb5456586224c8d97ea11da24d935af-20210621
X-UUID: 9eb5456586224c8d97ea11da24d935af-20210621
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <kewei.xu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1386062; Mon, 21 Jun 2021 17:02:11 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 21 Jun 2021 17:02:10 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 21 Jun 2021 17:02:09 +0800
From:   <kewei.xu@mediatek.com>
To:     <bbrezillon@kernel.org>
CC:     <matthias.bgg@gmail.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <linux-i3c@lists.infradead.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <leilk.liu@mediatek.com>,
        <qii.wang@mediatek.com>, <liguo.zhang@mediatek.com>,
        <xinping.qian@mediatek.com>, Kewei Xu <kewei.xu@mediatek.com>
Subject: [PATCH V2 3/3] i2c: mediatek: Isolate speed setting via dts for special devices
Date:   Mon, 21 Jun 2021 17:01:54 +0800
Message-ID: <1624266114-21539-4-git-send-email-kewei.xu@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1624266114-21539-1-git-send-email-kewei.xu@mediatek.com>
References: <1624266114-21539-1-git-send-email-kewei.xu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kewei Xu <kewei.xu@mediatek.com>

In the commit be5ce0e97cc7 ("i2c: mediatek: Add i2c ac-timing adjust
support"), the I2C timing calculation has been revised to support
ac-timing adjustment, however that will break on some I2C components.
As a result we want to introduce a new setting "default-adjust-timing"
so those components can choose to use the old (default) timing algorithm.

Fixes: be5ce0e97cc7 ("i2c: mediatek: Add i2c ac-timing adjust support")
Signed-off-by: Kewei Xu <kewei.xu@mediatek.com>
---
 drivers/i2c/busses/i2c-mt65xx.c | 77 +++++++++++++++++++++++++++++++++++++----
 1 file changed, 71 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mt65xx.c b/drivers/i2c/busses/i2c-mt65xx.c
index fe3cea7..88dc462 100644
--- a/drivers/i2c/busses/i2c-mt65xx.c
+++ b/drivers/i2c/busses/i2c-mt65xx.c
@@ -65,6 +65,7 @@
 #define I2C_DMA_HARD_RST		0x0002
 #define I2C_DMA_HANDSHAKE_RST		0x0004
 
+#define I2C_DEFAULT_CLK_DIV		5
 #define MAX_SAMPLE_CNT_DIV		8
 #define MAX_STEP_CNT_DIV		64
 #define MAX_CLOCK_DIV			256
@@ -249,6 +250,7 @@ struct mtk_i2c {
 	struct clk *clk_arb;		/* Arbitrator clock for i2c */
 	bool have_pmic;			/* can use i2c pins from PMIC */
 	bool use_push_pull;		/* IO config push-pull mode */
+	bool default_timing_adjust;	/* no timing adjust mode */
 
 	u16 irq_stat;			/* interrupt status */
 	unsigned int clk_src_div;
@@ -526,7 +528,11 @@ static void mtk_i2c_init_hw(struct mtk_i2c *i2c)
 	else
 		ext_conf_val = I2C_FS_START_CON;
 
-	if (i2c->dev_comp->timing_adjust) {
+	if (i2c->default_timing_adjust) {
+		if (i2c->dev_comp->timing_adjust)
+			mtk_i2c_writew(i2c, I2C_DEFAULT_CLK_DIV - 1,
+				       OFFSET_CLOCK_DIV);
+	} else if (i2c->dev_comp->timing_adjust) {
 		ext_conf_val = i2c->ac_timing.ext;
 		mtk_i2c_writew(i2c, i2c->ac_timing.inter_clk_div,
 			       OFFSET_CLOCK_DIV);
@@ -609,7 +615,7 @@ static int mtk_i2c_check_ac_timing(struct mtk_i2c *i2c,
 	unsigned int sample_ns = div_u64(1000000000ULL * (sample_cnt + 1),
 					 clk_src);
 
-	if (!i2c->dev_comp->timing_adjust)
+	if (i2c->default_timing_adjust || !i2c->dev_comp->timing_adjust)
 		return 0;
 
 	if (i2c->dev_comp->ltiming_adjust)
@@ -769,7 +775,63 @@ static int mtk_i2c_calculate_speed(struct mtk_i2c *i2c, unsigned int clk_src,
 	return 0;
 }
 
-static int mtk_i2c_set_speed(struct mtk_i2c *i2c, unsigned int parent_clk)
+static int mtk_i2c_set_speed_default_timing(struct mtk_i2c *i2c, unsigned int parent_clk)
+{
+	unsigned int clk_src;
+	unsigned int step_cnt;
+	unsigned int sample_cnt;
+	unsigned int l_step_cnt;
+	unsigned int l_sample_cnt;
+	unsigned int target_speed;
+	int ret;
+
+	if (i2c->dev_comp->timing_adjust)
+		i2c->clk_src_div *= I2C_DEFAULT_CLK_DIV;
+
+	clk_src = parent_clk / i2c->clk_src_div;
+	target_speed = i2c->speed_hz;
+
+	if (target_speed > I2C_MAX_FAST_MODE_PLUS_FREQ) {
+		/* Set master code speed register */
+		ret = mtk_i2c_calculate_speed(i2c, clk_src, I2C_MAX_FAST_MODE_FREQ,
+					      &l_step_cnt, &l_sample_cnt);
+		if (ret < 0)
+			return ret;
+
+		i2c->timing_reg = (l_sample_cnt << 8) | l_step_cnt;
+
+		/* Set the high speed mode register */
+		ret = mtk_i2c_calculate_speed(i2c, clk_src, target_speed,
+					      &step_cnt, &sample_cnt);
+		if (ret < 0)
+			return ret;
+
+		i2c->high_speed_reg = I2C_TIME_DEFAULT_VALUE |
+			(sample_cnt << 12) | (step_cnt << 8);
+
+		if (i2c->dev_comp->ltiming_adjust)
+			i2c->ltiming_reg = (l_sample_cnt << 6) | l_step_cnt |
+					   (sample_cnt << 12) | (step_cnt << 9);
+	} else {
+		ret = mtk_i2c_calculate_speed(i2c, clk_src, target_speed,
+					      &step_cnt, &sample_cnt);
+		if (ret < 0)
+			return ret;
+
+		i2c->timing_reg = (sample_cnt << 8) | step_cnt;
+
+		/* Disable the high speed transaction */
+		i2c->high_speed_reg = I2C_TIME_CLR_VALUE;
+
+		if (i2c->dev_comp->ltiming_adjust)
+			i2c->ltiming_reg = (sample_cnt << 6) | step_cnt;
+	}
+
+	return 0;
+}
+
+static int mtk_i2c_set_speed_adjust_timing(struct mtk_i2c *i2c,
+					   unsigned int parent_clk)
 {
 	unsigned int clk_src;
 	unsigned int step_cnt;
@@ -1293,8 +1355,8 @@ static int mtk_i2c_parse_dt(struct device_node *np, struct mtk_i2c *i2c)
 	i2c->have_pmic = of_property_read_bool(np, "mediatek,have-pmic");
 	i2c->use_push_pull =
 		of_property_read_bool(np, "mediatek,use-push-pull");
-
-	i2c_parse_fw_timings(i2c->dev, &i2c->timing_info, true);
+	i2c->default_timing_adjust =
+		of_property_read_bool(np, "mediatek,default-timing-adjust");
 
 	return 0;
 }
@@ -1372,7 +1434,10 @@ static int mtk_i2c_probe(struct platform_device *pdev)
 
 	strlcpy(i2c->adap.name, I2C_DRV_NAME, sizeof(i2c->adap.name));
 
-	ret = mtk_i2c_set_speed(i2c, clk_get_rate(clk));
+	if (i2c->default_timing_adjust)
+		ret = mtk_i2c_set_speed_default_timing(i2c, clk_get_rate(clk));
+	else
+		ret = mtk_i2c_set_speed_adjust_timing(i2c, clk_get_rate(clk));
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to set the speed.\n");
 		return -EINVAL;
-- 
1.9.1

