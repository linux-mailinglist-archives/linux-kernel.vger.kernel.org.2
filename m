Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 597AB45CEBE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 22:07:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242975AbhKXVKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 16:10:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234102AbhKXVKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 16:10:35 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 250DDC061574
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 13:07:25 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id j3so6811104wrp.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 13:07:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d0JcHrS7rw6PdBZ7/HfgOLWu1/etSoOgbibJUUNb29U=;
        b=IvaqaftGqGnaQmJOuJxs+JXXu84+4qZwObmBV1wM5y7nSK2aIDqKGuTYxsjPaheCih
         ISODKxDugG3uazJWeJLCEMHB+RRpRUxI1T2W3uB41tKolO0Sp4NVA4PpCkjLIqUVMqw4
         QY5cOFWQQSZsv5tN4Ean7QsGu4KS7nu9xAU2OPj1oghbwEpu8Za3cEM6ItVEeulu0Z40
         NfMt2uVWM0vxu5VxwXgEmzcc8HD2fdvOZTuPv08j9t7rf1K70Y35IxUZ87ECx1OH5UhK
         QX77dcsjSnSse++WXfoycLTnUj6yl6XUifHFrC6gTSXiBPKnkYGvKH3gbs7B2KUTCjaT
         w74A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d0JcHrS7rw6PdBZ7/HfgOLWu1/etSoOgbibJUUNb29U=;
        b=k4rf5RBfqIi0ibRlxmqEg3Cxt7ewVLBbL46uTffOIgRBn2C49gyr1aGgXzBnmaz0So
         U+GwRzVw8jx0b7RU8vrtyZca8TXBJ+v2bkhuWovWDWmjHXE04QMpfmVQpxI1rpQoeHx2
         ELzV0yYjKVVYFAfXkTpo63cnlLVg4TiIZa7AP26QQjMr7H2ogX8oWCsF+iEiciAjpqCp
         uKYVicNwXTf2o32Wh9ZD78JApvVfFE/b1FIoU45DIEOcnjFMrBEcyD+JnDtWtGRv5adl
         5huDVMzDgBlbDw0CCG59yFYnLI1Sq/rYW1L16733ySPEjmjNg+KxyQZ/7NYDNnFnMUar
         Xznw==
X-Gm-Message-State: AOAM533EnMbFrDQXEI2dpC6gGXl1t3YX/QdIDeheF5ZHuLxc3jV09r/Y
        P/XfkHAE01cbtLCF08q3CPZ6HyT2W8Q=
X-Google-Smtp-Source: ABdhPJz+Ekiy9CMWyUTEC6BHBxlgNLP061y7vlYho7gG71cQT7b6wRZULUlzffYP12V3cXPPwJHlSg==
X-Received: by 2002:a5d:45c4:: with SMTP id b4mr34041wrs.222.1637788043676;
        Wed, 24 Nov 2021 13:07:23 -0800 (PST)
Received: from localhost.localdomain (84-72-105-84.dclient.hispeed.ch. [84.72.105.84])
        by smtp.gmail.com with ESMTPSA id p8sm906195wrx.25.2021.11.24.13.07.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Nov 2021 13:07:23 -0800 (PST)
From:   Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
To:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Heiko Stuebner <heiko@sntech.de>
Cc:     linux-rockchip@lists.infradead.org, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: rockchip: i2s_tdm: Dup static DAI template
Date:   Wed, 24 Nov 2021 22:06:55 +0100
Message-Id: <20211124210655.288108-1-frattaroli.nicolas@gmail.com>
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
 sound/soc/rockchip/rockchip_i2s_tdm.c | 42 +++++++++++++++------------
 1 file changed, 24 insertions(+), 18 deletions(-)

diff --git a/sound/soc/rockchip/rockchip_i2s_tdm.c b/sound/soc/rockchip/rockchip_i2s_tdm.c
index 17b9b287853a..e9ddbbf4563e 100644
--- a/sound/soc/rockchip/rockchip_i2s_tdm.c
+++ b/sound/soc/rockchip/rockchip_i2s_tdm.c
@@ -1312,22 +1312,17 @@ static const struct of_device_id rockchip_i2s_tdm_match[] = {
 
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
-		       SNDRV_PCM_FMTBIT_S20_3LE | SNDRV_PCM_FMTBIT_S24_LE |
-		       SNDRV_PCM_FMTBIT_S32_LE);
+	SNDRV_PCM_FMTBIT_S20_3LE | SNDRV_PCM_FMTBIT_S24_LE |
+	SNDRV_PCM_FMTBIT_S32_LE);
 	struct device_node *node = i2s_tdm->dev->of_node;
 
 	of_property_for_each_string(node, "dma-names", dma_names, dma_name) {
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

