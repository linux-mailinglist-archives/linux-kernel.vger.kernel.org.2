Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 022813F48F1
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 12:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234865AbhHWKuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 06:50:20 -0400
Received: from lucky1.263xmail.com ([211.157.147.132]:58450 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236305AbhHWKuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 06:50:18 -0400
Received: from localhost (unknown [192.168.167.235])
        by lucky1.263xmail.com (Postfix) with ESMTP id ED1D8FB5D6;
        Mon, 23 Aug 2021 18:49:33 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P32763T139760957703936S1629715760494266_;
        Mon, 23 Aug 2021 18:49:24 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <b1f5bd6aea80e45f51986b9e794aa7a3>
X-RL-SENDER: sugar.zhang@rock-chips.com
X-SENDER: zxg@rock-chips.com
X-LOGIN-NAME: sugar.zhang@rock-chips.com
X-FST-TO: broonie@kernel.org
X-RCPT-COUNT: 10
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
From:   Sugar Zhang <sugar.zhang@rock-chips.com>
To:     broonie@kernel.org, heiko@sntech.de
Cc:     linux-rockchip@lists.infradead.org,
        Sugar Zhang <sugar.zhang@rock-chips.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 01/15] ASoC: rockchip: i2s: Add support for set bclk ratio
Date:   Mon, 23 Aug 2021 18:48:15 +0800
Message-Id: <1629715710-21137-2-git-send-email-sugar.zhang@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1629715710-21137-1-git-send-email-sugar.zhang@rock-chips.com>
References: <1629715710-21137-1-git-send-email-sugar.zhang@rock-chips.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for set bclk ratio from machine driver.

Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>
---

 sound/soc/rockchip/rockchip_i2s.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/sound/soc/rockchip/rockchip_i2s.c b/sound/soc/rockchip/rockchip_i2s.c
index c7dc350..c9d5c52 100644
--- a/sound/soc/rockchip/rockchip_i2s.c
+++ b/sound/soc/rockchip/rockchip_i2s.c
@@ -49,6 +49,7 @@ struct rk_i2s_dev {
 	bool rx_start;
 	bool is_master_mode;
 	const struct rk_i2s_pins *pins;
+	unsigned int bclk_ratio;
 };
 
 static int i2s_runtime_suspend(struct device *dev)
@@ -278,7 +279,7 @@ static int rockchip_i2s_hw_params(struct snd_pcm_substream *substream,
 
 	if (i2s->is_master_mode) {
 		mclk_rate = clk_get_rate(i2s->mclk);
-		bclk_rate = 2 * 32 * params_rate(params);
+		bclk_rate = i2s->bclk_ratio * params_rate(params);
 		if (bclk_rate == 0 || mclk_rate % bclk_rate)
 			return -EINVAL;
 
@@ -413,6 +414,16 @@ static int rockchip_i2s_trigger(struct snd_pcm_substream *substream,
 	return ret;
 }
 
+static int rockchip_i2s_set_bclk_ratio(struct snd_soc_dai *dai,
+				       unsigned int ratio)
+{
+	struct rk_i2s_dev *i2s = to_info(dai);
+
+	i2s->bclk_ratio = ratio;
+
+	return 0;
+}
+
 static int rockchip_i2s_set_sysclk(struct snd_soc_dai *cpu_dai, int clk_id,
 				   unsigned int freq, int dir)
 {
@@ -441,6 +452,7 @@ static int rockchip_i2s_dai_probe(struct snd_soc_dai *dai)
 
 static const struct snd_soc_dai_ops rockchip_i2s_dai_ops = {
 	.hw_params = rockchip_i2s_hw_params,
+	.set_bclk_ratio	= rockchip_i2s_set_bclk_ratio,
 	.set_sysclk = rockchip_i2s_set_sysclk,
 	.set_fmt = rockchip_i2s_set_fmt,
 	.trigger = rockchip_i2s_trigger,
@@ -638,6 +650,8 @@ static int rockchip_i2s_probe(struct platform_device *pdev)
 	i2s->capture_dma_data.addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
 	i2s->capture_dma_data.maxburst = 4;
 
+	i2s->bclk_ratio = 64;
+
 	dev_set_drvdata(&pdev->dev, i2s);
 
 	pm_runtime_enable(&pdev->dev);
-- 
2.7.4



