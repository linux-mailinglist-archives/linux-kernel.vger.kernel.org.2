Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F17245CEE0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 22:22:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244412AbhKXVZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 16:25:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232874AbhKXVZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 16:25:28 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D9A4C061574
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 13:22:18 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id u18so6825542wrg.5
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 13:22:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KkTsSIQTgl65Jkq2RbrjmIOlxesXSk6YN9h1ULIzGuo=;
        b=a/+HbgjfC0Xviq8bITaokRT5m8AxPOk5YRgGPtIjhTqCyV0mHnnXD9x5o8QdAPmhvL
         GkmtbZBDsGAeG1eDD/p8IhF7pjGBZdplptRLcaPnLNviqmYG2eWo6W4sHJAHLtoCZzT4
         Z4xc8vtYf9/u9HzTxFPVhGzmnRSkKqvaDqzIDlKsKY3LXOvhssL1RCOEkkY45Dnx/38Q
         POHoc1xVEK/L1Acs4Gn53bN+0uAXcc9iXn0PsSy8rPmh3zdE6cfER8rhl5I+GPmMnvi+
         iLDd6MDNMRkl8CUP9UbeirSLARr/CJmhWGOxeGLfptDnAIrQklRNqtn82Gbs4Ty9MEEr
         DEPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KkTsSIQTgl65Jkq2RbrjmIOlxesXSk6YN9h1ULIzGuo=;
        b=VgTk+kR6aQoaJBW193EpfQ5UII0WW9uU/CeP8j7JlpXVpAJ4zDJEKLGZB+iZhRZWzm
         w+9JsOObPFD1GF3mZjjErzwi8jjoVw1MHZoC2tNbXRF/GlnnWu0yUkaMQRSHHQPOusc8
         BlKPb1UmSyU2j6LNqPprxMT7NxSFQIiVrQgr3yDX25jiEetzPmSOvaZIIFdmZN+3gA72
         viHl1zew6QDnfvTLVloQUi4uRyHBQR/tp5I2dl6KHkSRFK6TigW6+vaOQeOq5PEMnHJk
         5+ZYnTLoP0Ka5Au0r2vkfUcwTgIwOQm93m/HX9QOgJzl2Lo8FggaNRX3M4RpbN9JGbIn
         Swvg==
X-Gm-Message-State: AOAM533HvyxMB+7/fBaC6ZXsANLExShJuIn7i64zPG2u7s6VGVSw8oJw
        vyiHpk8tgYG8IihPDMXvzeA=
X-Google-Smtp-Source: ABdhPJzn4Yi5qwkymBP+9Ssw2nDNuFw2wS/hm5XhbyRb6XKDIQioqPM2bbYzaRaRf/fZCDudlHLcgg==
X-Received: by 2002:adf:a193:: with SMTP id u19mr50196wru.563.1637788936819;
        Wed, 24 Nov 2021 13:22:16 -0800 (PST)
Received: from localhost.localdomain (84-72-105-84.dclient.hispeed.ch. [84.72.105.84])
        by smtp.gmail.com with ESMTPSA id o12sm1466875wrc.85.2021.11.24.13.22.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Nov 2021 13:22:16 -0800 (PST)
From:   Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
To:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Heiko Stuebner <heiko@sntech.de>
Cc:     linux-rockchip@lists.infradead.org, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] ASoC: rockchip: i2s_tdm: Dup static DAI template
Date:   Wed, 24 Nov 2021 22:21:45 +0100
Message-Id: <20211124212146.289133-1-frattaroli.nicolas@gmail.com>
X-Mailer: git-send-email 2.34.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously, the DAI template was used directly, which lead to
fun bugs such as "why is my channels_max changing?" when one
instantiated more than one i2s_tdm IP block in a device tree.

This change makes it so that we instead duplicate the template
struct, and then use that.

Fixes: 081068fd6414 ("ASoC: rockchip: add support for i2s-tdm controller")
Signed-off-by: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
---
 sound/soc/rockchip/rockchip_i2s_tdm.c | 38 ++++++++++++++++-----------
 1 file changed, 22 insertions(+), 16 deletions(-)

diff --git a/sound/soc/rockchip/rockchip_i2s_tdm.c b/sound/soc/rockchip/rockchip_i2s_tdm.c
index 17b9b287853a..4328c10ea830 100644
--- a/sound/soc/rockchip/rockchip_i2s_tdm.c
+++ b/sound/soc/rockchip/rockchip_i2s_tdm.c
@@ -1312,17 +1312,12 @@ static const struct of_device_id rockchip_i2s_tdm_match[] = {
 
 static struct snd_soc_dai_driver i2s_tdm_dai = {
 	.probe = rockchip_i2s_tdm_dai_probe,
-	.playback = {
-		.stream_name  = "Playback",
-	},
-	.capture = {
-		.stream_name  = "Capture",
-	},
 	.ops = &rockchip_i2s_tdm_dai_ops,
 };
 
-static void rockchip_i2s_tdm_init_dai(struct rk_i2s_tdm_dev *i2s_tdm)
+static int rockchip_i2s_tdm_init_dai(struct rk_i2s_tdm_dev *i2s_tdm)
 {
+	struct snd_soc_dai_driver *dai;
 	struct property *dma_names;
 	const char *dma_name;
 	u64 formats = (SNDRV_PCM_FMTBIT_S8 | SNDRV_PCM_FMTBIT_S16_LE |
@@ -1337,19 +1332,28 @@ static void rockchip_i2s_tdm_init_dai(struct rk_i2s_tdm_dev *i2s_tdm)
 			i2s_tdm->has_capture = true;
 	}
 
+	dai = devm_kmemdup(i2s_tdm->dev, &i2s_tdm_dai,
+			   sizeof(*dai), GFP_KERNEL);
+	if (!dai)
+		return -ENOMEM;
+
 	if (i2s_tdm->has_playback) {
-		i2s_tdm_dai.playback.channels_min = 2;
-		i2s_tdm_dai.playback.channels_max = 8;
-		i2s_tdm_dai.playback.rates = SNDRV_PCM_RATE_8000_192000;
-		i2s_tdm_dai.playback.formats = formats;
+		dai->playback.stream_name  = "Playback";
+		dai->playback.channels_min = 2;
+		dai->playback.channels_max = 8;
+		dai->playback.rates = SNDRV_PCM_RATE_8000_192000;
+		dai->playback.formats = formats;
 	}
 
 	if (i2s_tdm->has_capture) {
-		i2s_tdm_dai.capture.channels_min = 2;
-		i2s_tdm_dai.capture.channels_max = 8;
-		i2s_tdm_dai.capture.rates = SNDRV_PCM_RATE_8000_192000;
-		i2s_tdm_dai.capture.formats = formats;
+		dai->capture.stream_name  = "Capture";
+		dai->capture.channels_min = 2;
+		dai->capture.channels_max = 8;
+		dai->capture.rates = SNDRV_PCM_RATE_8000_192000;
+		dai->capture.formats = formats;
 	}
+
+	return 0;
 }
 
 static int rockchip_i2s_tdm_path_check(struct rk_i2s_tdm_dev *i2s_tdm,
@@ -1541,7 +1545,9 @@ static int rockchip_i2s_tdm_probe(struct platform_device *pdev)
 	spin_lock_init(&i2s_tdm->lock);
 	i2s_tdm->soc_data = (struct rk_i2s_soc_data *)of_id->data;
 
-	rockchip_i2s_tdm_init_dai(i2s_tdm);
+	ret = rockchip_i2s_tdm_init_dai(i2s_tdm);
+	if (ret)
+		return ret;
 
 	i2s_tdm->frame_width = 64;
 
-- 
2.34.0

