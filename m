Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 543813F5BD0
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 12:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235971AbhHXKRY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 06:17:24 -0400
Received: from lucky1.263xmail.com ([211.157.147.133]:47214 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235982AbhHXKRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 06:17:13 -0400
Received: from localhost (unknown [192.168.167.235])
        by lucky1.263xmail.com (Postfix) with ESMTP id 3D297D64C9;
        Tue, 24 Aug 2021 18:16:23 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P32763T139760989173504S1629800174340042_;
        Tue, 24 Aug 2021 18:16:17 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <408f5e1bfbcbb377745547de1a3b4b51>
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
Subject: [PATCH v1 2/4] ASoC: rockchip: spdif: Fix some coding style
Date:   Tue, 24 Aug 2021 18:16:00 +0800
Message-Id: <1629800162-12824-3-git-send-email-sugar.zhang@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1629800162-12824-1-git-send-email-sugar.zhang@rock-chips.com>
References: <1629800162-12824-1-git-send-email-sugar.zhang@rock-chips.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fix some coding style.

Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>
---

 sound/soc/rockchip/rockchip_spdif.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/sound/soc/rockchip/rockchip_spdif.c b/sound/soc/rockchip/rockchip_spdif.c
index 8baa473..92b27b6 100644
--- a/sound/soc/rockchip/rockchip_spdif.c
+++ b/sound/soc/rockchip/rockchip_spdif.c
@@ -103,8 +103,8 @@ static int __maybe_unused rk_spdif_runtime_resume(struct device *dev)
 }
 
 static int rk_spdif_hw_params(struct snd_pcm_substream *substream,
-				  struct snd_pcm_hw_params *params,
-				  struct snd_soc_dai *dai)
+			      struct snd_pcm_hw_params *params,
+			      struct snd_soc_dai *dai)
 {
 	struct rk_spdif_dev *spdif = snd_soc_dai_get_drvdata(dai);
 	unsigned int val = SPDIF_CFGR_HALFWORD_ENABLE;
@@ -137,15 +137,15 @@ static int rk_spdif_hw_params(struct snd_pcm_substream *substream,
 	}
 
 	ret = regmap_update_bits(spdif->regmap, SPDIF_CFGR,
-		SPDIF_CFGR_CLK_DIV_MASK | SPDIF_CFGR_HALFWORD_ENABLE |
-		SDPIF_CFGR_VDW_MASK,
-		val);
+				 SPDIF_CFGR_CLK_DIV_MASK |
+				 SPDIF_CFGR_HALFWORD_ENABLE |
+				 SDPIF_CFGR_VDW_MASK, val);
 
 	return ret;
 }
 
 static int rk_spdif_trigger(struct snd_pcm_substream *substream,
-				int cmd, struct snd_soc_dai *dai)
+			    int cmd, struct snd_soc_dai *dai)
 {
 	struct rk_spdif_dev *spdif = snd_soc_dai_get_drvdata(dai);
 	int ret;
@@ -155,31 +155,31 @@ static int rk_spdif_trigger(struct snd_pcm_substream *substream,
 	case SNDRV_PCM_TRIGGER_RESUME:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
 		ret = regmap_update_bits(spdif->regmap, SPDIF_DMACR,
-				   SPDIF_DMACR_TDE_ENABLE |
-				   SPDIF_DMACR_TDL_MASK,
-				   SPDIF_DMACR_TDE_ENABLE |
-				   SPDIF_DMACR_TDL(16));
+					 SPDIF_DMACR_TDE_ENABLE |
+					 SPDIF_DMACR_TDL_MASK,
+					 SPDIF_DMACR_TDE_ENABLE |
+					 SPDIF_DMACR_TDL(16));
 
 		if (ret != 0)
 			return ret;
 
 		ret = regmap_update_bits(spdif->regmap, SPDIF_XFER,
-				   SPDIF_XFER_TXS_START,
-				   SPDIF_XFER_TXS_START);
+					 SPDIF_XFER_TXS_START,
+					 SPDIF_XFER_TXS_START);
 		break;
 	case SNDRV_PCM_TRIGGER_SUSPEND:
 	case SNDRV_PCM_TRIGGER_STOP:
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
 		ret = regmap_update_bits(spdif->regmap, SPDIF_DMACR,
-				   SPDIF_DMACR_TDE_ENABLE,
-				   SPDIF_DMACR_TDE_DISABLE);
+					 SPDIF_DMACR_TDE_ENABLE,
+					 SPDIF_DMACR_TDE_DISABLE);
 
 		if (ret != 0)
 			return ret;
 
 		ret = regmap_update_bits(spdif->regmap, SPDIF_XFER,
-				   SPDIF_XFER_TXS_START,
-				   SPDIF_XFER_TXS_STOP);
+					 SPDIF_XFER_TXS_START,
+					 SPDIF_XFER_TXS_STOP);
 		break;
 	default:
 		ret = -EINVAL;
@@ -293,7 +293,7 @@ static int rk_spdif_probe(struct platform_device *pdev)
 		grf = syscon_regmap_lookup_by_phandle(np, "rockchip,grf");
 		if (IS_ERR(grf)) {
 			dev_err(&pdev->dev,
-				"rockchip_spdif missing 'rockchip,grf' \n");
+				"rockchip_spdif missing 'rockchip,grf'\n");
 			return PTR_ERR(grf);
 		}
 
-- 
2.7.4



