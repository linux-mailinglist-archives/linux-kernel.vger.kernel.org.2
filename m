Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67A5A454E21
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 20:45:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240061AbhKQTsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 14:48:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232079AbhKQTsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 14:48:02 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F18FC061570
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 11:45:03 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id r8so6832506wra.7
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 11:45:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=944R6VkEBj9im8jiA+ivAeCJ/qxWRZNjJgR3j1HHJsI=;
        b=FqUXYaL8OmqBwrutkMC4FUcb8GQLxJQhrs2IZACoWWYJT5i2lMRi84N8GZYnqtuXi/
         5GQmAO+GCAH77andbguKDbha8P1jUGAdx5/Z6BCNar9LMvTDaWQnjRkB+8dom7rZT+oA
         GjvaV4+Q+0fE/0EyxVjzd1/zuRceH9bxbN7a+ZflzoAER51Lmtc9UjHYC7+5tS9uDrwT
         akSqVBxgEfwLCANkL+F4UlMXgGI9PnvZMht7BTc1+tdWs5Tr9pU2DCiPM6vY1bAsCVYG
         qCKYAdMSGQH9tZrJ2QfjikBNQs0czpdfFQU7Rfms7x+qgD5VQdUJBd3+xjVDebuFoqyD
         UWWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=944R6VkEBj9im8jiA+ivAeCJ/qxWRZNjJgR3j1HHJsI=;
        b=6Hw+rhrvjFEPGGyC0fhE7w9YAmFHn0XhSRWql8ztQGUrZzoXFyXVcOIBmm0m2blYwx
         /5MLBv8wP5cNWvm/zjdThxlkkp9Vu6a5lMke/bzumL+0HhhPBKBF0Cq0LdQOMrFojBAF
         d9HvG0nq6iWxvVqqr4CHfbBV4m6yzHmJGXVNVbmfSJtp4/xkTyURAQfvfxJKGALeY1lY
         89luxuwAm8/FpCCqumWKkfPYEJ/9Zml5qbcZDKhSiMIbnrfNQyN5f2K4x37g8b1PO7zX
         0aT86zn+dYJHSiP//mtr2ymS85y2171FZAYs6EwOBJ6M17HJ9GyAbPJYVsEZFTJb/GzZ
         6jbg==
X-Gm-Message-State: AOAM531MWt4uhf+k2wr1gKP084s2EThEP7PsXsKUmfpuzIsitt2ajaCe
        5frPyD+ooHdlwUWIrYDNJV1hurvMAZ/D1Q==
X-Google-Smtp-Source: ABdhPJzk26xdBnc/SuVaoCsMCFhCY+mkLSr/cpJ1B4mSZ/wAFinxM5dmhULQy/yAq6xfFjdSrrSG5w==
X-Received: by 2002:a5d:4563:: with SMTP id a3mr23974817wrc.130.1637178301973;
        Wed, 17 Nov 2021 11:45:01 -0800 (PST)
Received: from kista.localdomain (cpe-86-58-29-253.static.triera.net. [86.58.29.253])
        by smtp.gmail.com with ESMTPSA id g198sm712529wme.23.2021.11.17.11.45.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 11:45:01 -0800 (PST)
From:   Jernej Skrabec <jernej.skrabec@gmail.com>
To:     mripard@kernel.org, wens@csie.org
Cc:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH v2] ASoC: sunxi: sun4i-spdif: Implement IEC958 control
Date:   Wed, 17 Nov 2021 20:44:58 +0100
Message-Id: <20211117194458.2249643-1-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.34.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SPDIF core is capable of sending custom status.

Implement IEC958 control handling.

Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
Changes from v1:
- return 1 if there was a change in sun4i_spdif_set_status()
- added locking for reading and writing status

 sound/soc/sunxi/sun4i-spdif.c | 115 ++++++++++++++++++++++++++++++++++
 1 file changed, 115 insertions(+)

diff --git a/sound/soc/sunxi/sun4i-spdif.c b/sound/soc/sunxi/sun4i-spdif.c
index a10949bf0ca1..17090f43150e 100644
--- a/sound/soc/sunxi/sun4i-spdif.c
+++ b/sound/soc/sunxi/sun4i-spdif.c
@@ -21,6 +21,8 @@
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/reset.h>
+#include <linux/spinlock.h>
+#include <sound/asoundef.h>
 #include <sound/dmaengine_pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
@@ -186,6 +188,7 @@ struct sun4i_spdif_dev {
 	struct regmap *regmap;
 	struct snd_dmaengine_dai_dma_data dma_params_tx;
 	const struct sun4i_spdif_quirks *quirks;
+	spinlock_t lock;
 };
 
 static void sun4i_spdif_configure(struct sun4i_spdif_dev *host)
@@ -385,11 +388,122 @@ static int sun4i_spdif_trigger(struct snd_pcm_substream *substream, int cmd,
 	return ret;
 }
 
+static int sun4i_spdif_info(struct snd_kcontrol *kcontrol,
+			    struct snd_ctl_elem_info *uinfo)
+{
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_IEC958;
+	uinfo->count = 1;
+
+	return 0;
+}
+
+static int sun4i_spdif_get_status_mask(struct snd_kcontrol *kcontrol,
+				       struct snd_ctl_elem_value *ucontrol)
+{
+	u8 *status = ucontrol->value.iec958.status;
+
+	status[0] = 0xff;
+	status[1] = 0xff;
+	status[2] = 0xff;
+	status[3] = 0xff;
+	status[4] = 0xff;
+	status[5] = 0x03;
+
+	return 0;
+}
+
+static int sun4i_spdif_get_status(struct snd_kcontrol *kcontrol,
+				  struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_dai *cpu_dai = snd_kcontrol_chip(kcontrol);
+	struct sun4i_spdif_dev *host = snd_soc_dai_get_drvdata(cpu_dai);
+	u8 *status = ucontrol->value.iec958.status;
+	unsigned long flags;
+	unsigned int reg;
+
+	spin_lock_irqsave(&host->lock, flags);
+
+	regmap_read(host->regmap, SUN4I_SPDIF_TXCHSTA0, &reg);
+
+	status[0] = reg & 0xff;
+	status[1] = (reg >> 8) & 0xff;
+	status[2] = (reg >> 16) & 0xff;
+	status[3] = (reg >> 24) & 0xff;
+
+	regmap_read(host->regmap, SUN4I_SPDIF_TXCHSTA1, &reg);
+
+	status[4] = reg & 0xff;
+	status[5] = (reg >> 8) & 0x3;
+
+	spin_unlock_irqrestore(&host->lock, flags);
+
+	return 0;
+}
+
+static int sun4i_spdif_set_status(struct snd_kcontrol *kcontrol,
+				  struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_dai *cpu_dai = snd_kcontrol_chip(kcontrol);
+	struct sun4i_spdif_dev *host = snd_soc_dai_get_drvdata(cpu_dai);
+	u8 *status = ucontrol->value.iec958.status;
+	unsigned long flags;
+	unsigned int reg;
+	bool chg0, chg1;
+
+	spin_lock_irqsave(&host->lock, flags);
+
+	reg = (u32)status[3] << 24;
+	reg |= (u32)status[2] << 16;
+	reg |= (u32)status[1] << 8;
+	reg |= (u32)status[0];
+
+	regmap_update_bits_check(host->regmap, SUN4I_SPDIF_TXCHSTA0,
+				 GENMASK(31,0), reg, &chg0);
+
+	reg = (u32)status[5] << 8;
+	reg |= (u32)status[4];
+
+	regmap_update_bits_check(host->regmap, SUN4I_SPDIF_TXCHSTA1,
+				 GENMASK(9,0), reg, &chg1);
+
+	reg = SUN4I_SPDIF_TXCFG_CHSTMODE;
+	if (status[0] & IEC958_AES0_NONAUDIO)
+		reg |= SUN4I_SPDIF_TXCFG_NONAUDIO;
+
+	regmap_update_bits(host->regmap, SUN4I_SPDIF_TXCFG,
+			   SUN4I_SPDIF_TXCFG_CHSTMODE |
+			   SUN4I_SPDIF_TXCFG_NONAUDIO, reg);
+
+	spin_unlock_irqrestore(&host->lock, flags);
+
+	return chg0 || chg1;
+}
+
+static struct snd_kcontrol_new sun4i_spdif_controls[] = {
+	{
+		.access = SNDRV_CTL_ELEM_ACCESS_READ,
+		.iface = SNDRV_CTL_ELEM_IFACE_PCM,
+		.name = SNDRV_CTL_NAME_IEC958("", PLAYBACK, MASK),
+		.info = sun4i_spdif_info,
+		.get = sun4i_spdif_get_status_mask
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_PCM,
+		.name = SNDRV_CTL_NAME_IEC958("", PLAYBACK, DEFAULT),
+		.info = sun4i_spdif_info,
+		.get = sun4i_spdif_get_status,
+		.put = sun4i_spdif_set_status
+	}
+};
+
 static int sun4i_spdif_soc_dai_probe(struct snd_soc_dai *dai)
 {
 	struct sun4i_spdif_dev *host = snd_soc_dai_get_drvdata(dai);
 
 	snd_soc_dai_init_dma_data(dai, &host->dma_params_tx, NULL);
+	snd_soc_add_dai_controls(dai, sun4i_spdif_controls,
+				 ARRAY_SIZE(sun4i_spdif_controls));
+
 	return 0;
 }
 
@@ -512,6 +626,7 @@ static int sun4i_spdif_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	host->pdev = pdev;
+	spin_lock_init(&host->lock);
 
 	/* Initialize this copy of the CPU DAI driver structure */
 	memcpy(&host->cpu_dai_drv, &sun4i_spdif_dai, sizeof(sun4i_spdif_dai));
-- 
2.34.0

