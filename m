Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83EA13A7B2D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 11:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231532AbhFOJws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 05:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231374AbhFOJwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 05:52:46 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B90FC061574
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 02:50:42 -0700 (PDT)
Received: from localhost (dslb-084-062-104-230.084.062.pools.vodafone-ip.de [84.62.104.230])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: ch@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id B9400826AA;
        Tue, 15 Jun 2021 11:50:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1623750637;
        bh=JCWe2Pppm54xIbq3MRVedz6t/yAOYnrWI/3oKnXOGhw=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=zLt7bq3hJ7+bB/4f6Kr64VKtk39m+q6KDJD6hItaQJpB4piprrOnfwnxsu5oWFzdb
         951Yb7DUrEtfXueIjm93SWGH+tunvlbyX9PNp1fEk+x31EmJi/5t33lRrgQQgC9LG4
         7cJrTMk0n7Hpc2X91YIQdmazyko2jx5W2LG1Y8WP3SwJ725NgnownyWHvEqYi8fwT9
         nOH6DCxfnATcxZ9RFiRcCFiYfXQ+xBOHlvUR/Q0vEQDNgtXnlke2VHnPSOwSedtv2r
         8LTWrb7jOrl2J5FF6dMERRmSBg/0nDHjIw44JHIl2O5AEiqInnl6h4VPLUsIEoQW3C
         3VJCXBiU3PTZA==
From:   Claudius Heine <ch@denx.de>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        Marek Vasut <marex@denx.de>, Claudius Heine <ch@denx.de>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Sia Jee Heng <jee.heng.sia@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Michael Sit Wei Hong <michael.wei.hong.sit@intel.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Annaliese McDermond <nh6z@nh6z.net>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/3] ASoC: tlv320aic32x4: prepare driver for different device variants
Date:   Tue, 15 Jun 2021 11:49:30 +0200
Message-Id: <20210615094933.3076392-2-ch@denx.de>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210615094933.3076392-1-ch@denx.de>
References: <20210615094933.3076392-1-ch@denx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.2 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With this change it will be possible to add different code paths for
similar devices.

Signed-off-by: Claudius Heine <ch@denx.de>
---
 sound/soc/codecs/tlv320aic32x4-i2c.c | 20 ++++++++++++++++----
 sound/soc/codecs/tlv320aic32x4-spi.c | 23 +++++++++++++++++++----
 sound/soc/codecs/tlv320aic32x4.c     |  3 +++
 sound/soc/codecs/tlv320aic32x4.h     |  5 +++++
 4 files changed, 43 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic32x4-i2c.c b/sound/soc/codecs/tlv320aic32x4-i2c.c
index 6d54cbf70a0b..247fb1e13674 100644
--- a/sound/soc/codecs/tlv320aic32x4-i2c.c
+++ b/sound/soc/codecs/tlv320aic32x4-i2c.c
@@ -16,6 +16,8 @@
 
 #include "tlv320aic32x4.h"
 
+static const struct of_device_id aic32x4_of_id[];
+
 static int aic32x4_i2c_probe(struct i2c_client *i2c,
 			     const struct i2c_device_id *id)
 {
@@ -27,6 +29,16 @@ static int aic32x4_i2c_probe(struct i2c_client *i2c,
 	config.val_bits = 8;
 
 	regmap = devm_regmap_init_i2c(i2c, &config);
+
+	if (i2c->dev.of_node) {
+		const struct of_device_id *oid;
+
+		oid = of_match_node(aic32x4_of_id, i2c->dev.of_node);
+		dev_set_drvdata(&i2c->dev, (void *)oid->data);
+	} else if (id) {
+		dev_set_drvdata(&i2c->dev, (void *)id->driver_data);
+	}
+
 	return aic32x4_probe(&i2c->dev, regmap);
 }
 
@@ -36,15 +48,15 @@ static int aic32x4_i2c_remove(struct i2c_client *i2c)
 }
 
 static const struct i2c_device_id aic32x4_i2c_id[] = {
-	{ "tlv320aic32x4", 0 },
-	{ "tlv320aic32x6", 1 },
+	{ "tlv320aic32x4", (kernel_ulong_t)AIC32X4_TYPE_AIC32X4 },
+	{ "tlv320aic32x6", (kernel_ulong_t)AIC32X4_TYPE_AIC32X6 },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(i2c, aic32x4_i2c_id);
 
 static const struct of_device_id aic32x4_of_id[] = {
-	{ .compatible = "ti,tlv320aic32x4", },
-	{ .compatible = "ti,tlv320aic32x6", },
+	{ .compatible = "ti,tlv320aic32x4", .data = (void *)AIC32X4_TYPE_AIC32X4 },
+	{ .compatible = "ti,tlv320aic32x6", .data = (void *)AIC32X4_TYPE_AIC32X6 },
 	{ /* senitel */ }
 };
 MODULE_DEVICE_TABLE(of, aic32x4_of_id);
diff --git a/sound/soc/codecs/tlv320aic32x4-spi.c b/sound/soc/codecs/tlv320aic32x4-spi.c
index a22e7700bfc8..e81c72958a82 100644
--- a/sound/soc/codecs/tlv320aic32x4-spi.c
+++ b/sound/soc/codecs/tlv320aic32x4-spi.c
@@ -16,6 +16,8 @@
 
 #include "tlv320aic32x4.h"
 
+static const struct of_device_id aic32x4_of_id[];
+
 static int aic32x4_spi_probe(struct spi_device *spi)
 {
 	struct regmap *regmap;
@@ -28,6 +30,19 @@ static int aic32x4_spi_probe(struct spi_device *spi)
 	config.read_flag_mask = 0x01;
 
 	regmap = devm_regmap_init_spi(spi, &config);
+
+	if (spi->dev.of_node) {
+		const struct of_device_id *oid;
+
+		oid = of_match_node(aic32x4_of_id, spi->dev.of_node);
+		dev_set_drvdata(&spi->dev, (void *)oid->data);
+	} else {
+		const struct spi_device_id *id_entry;
+
+		id_entry = spi_get_device_id(spi);
+		dev_set_drvdata(&spi->dev, (void *)id_entry->driver_data);
+	}
+
 	return aic32x4_probe(&spi->dev, regmap);
 }
 
@@ -37,15 +52,15 @@ static int aic32x4_spi_remove(struct spi_device *spi)
 }
 
 static const struct spi_device_id aic32x4_spi_id[] = {
-	{ "tlv320aic32x4", 0 },
-	{ "tlv320aic32x6", 1 },
+	{ "tlv320aic32x4", (kernel_ulong_t)AIC32X4_TYPE_AIC32X4 },
+	{ "tlv320aic32x6", (kernel_ulong_t)AIC32X4_TYPE_AIC32X6 },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(spi, aic32x4_spi_id);
 
 static const struct of_device_id aic32x4_of_id[] = {
-	{ .compatible = "ti,tlv320aic32x4", },
-	{ .compatible = "ti,tlv320aic32x6", },
+	{ .compatible = "ti,tlv320aic32x4", .data = (void *)AIC32X4_TYPE_AIC32X4 },
+	{ .compatible = "ti,tlv320aic32x6", .data = (void *)AIC32X4_TYPE_AIC32X6 },
 	{ /* senitel */ }
 };
 MODULE_DEVICE_TABLE(of, aic32x4_of_id);
diff --git a/sound/soc/codecs/tlv320aic32x4.c b/sound/soc/codecs/tlv320aic32x4.c
index b689f26fc4be..70a1574fb72a 100644
--- a/sound/soc/codecs/tlv320aic32x4.c
+++ b/sound/soc/codecs/tlv320aic32x4.c
@@ -48,6 +48,7 @@ struct aic32x4_priv {
 
 	struct aic32x4_setup_data *setup;
 	struct device *dev;
+	enum aic32x4_type type;
 };
 
 static int aic32x4_reset_adc(struct snd_soc_dapm_widget *w,
@@ -1198,6 +1199,8 @@ int aic32x4_probe(struct device *dev, struct regmap *regmap)
 		return -ENOMEM;
 
 	aic32x4->dev = dev;
+	aic32x4->type = (enum aic32x4_type)dev_get_drvdata(dev);
+
 	dev_set_drvdata(dev, aic32x4);
 
 	if (pdata) {
diff --git a/sound/soc/codecs/tlv320aic32x4.h b/sound/soc/codecs/tlv320aic32x4.h
index 7550122e9f8a..8a18dbec76a6 100644
--- a/sound/soc/codecs/tlv320aic32x4.h
+++ b/sound/soc/codecs/tlv320aic32x4.h
@@ -10,6 +10,11 @@
 struct device;
 struct regmap_config;
 
+enum aic32x4_type {
+	AIC32X4_TYPE_AIC32X4 = 0,
+	AIC32X4_TYPE_AIC32X6,
+};
+
 extern const struct regmap_config aic32x4_regmap_config;
 int aic32x4_probe(struct device *dev, struct regmap *regmap);
 int aic32x4_remove(struct device *dev);
-- 
2.32.0

