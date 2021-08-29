Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA4F3FAD64
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Aug 2021 19:23:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235845AbhH2RI2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Aug 2021 13:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231183AbhH2RIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Aug 2021 13:08:24 -0400
Received: from dnyon.com (unknown [IPv6:2001:ba0:1800:12f::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D9C6C061575;
        Sun, 29 Aug 2021 10:07:32 -0700 (PDT)
Received: from dnyon.com (45.74.222.87.dynamic.jazztel.es [87.222.74.45])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dnyon.com (Postfix) with ESMTPSA id C29BC4044F;
        Sun, 29 Aug 2021 17:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dnyon.com; s=mail;
        t=1630256851; bh=5QaN/XpQgIgjf/BOnDZmch+mx9yG/wxC151DFF3SAUw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MrLu3+qxwhyaRPX9mSVtQxPmegsKs/jpGx1YZ0agQiYw9gcOJUvW71vdfIPyK59t1
         ulXVPPP/U+IKLGf/rET7tVINIajX2pjkxIH3N0WYwCAebDRJ8bNn+F/zj+dBce2/Wz
         tk7DREGoMnMNUrNflfVXor7z3oYpWHIrPGnneGAZD7F2+YdzIEv9y0TckG1jkUAeUs
         jTCUtIfcTcR03xmisZw37opixzo2BYjFtju2HbLxxeDeHHGrJpvXD24t7NSPI6nBSE
         PVz7zNhXk0DEzP26wGNSTCywQj/gxEDs0vT4tcYyTXDaQ/NGigry+8EdVWp4l/xIqH
         w8fPt9qtQbDVw==
From:   Alejandro Tafalla <atafalla@dnyon.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
Cc:     Alejandro Tafalla <atafalla@dnyon.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH RESEND 1/2] ASoC: max98927: Handle reset gpio when probing i2c
Date:   Sun, 29 Aug 2021 19:00:16 +0200
Message-Id: <20210829170019.384632-2-atafalla@dnyon.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210829170019.384632-1-atafalla@dnyon.com>
References: <20210829170019.384632-1-atafalla@dnyon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drive the reset gpio if defined in the DTS node.

Signed-off-by: Alejandro Tafalla <atafalla@dnyon.com>
---
 sound/soc/codecs/max98927.c | 16 ++++++++++++++++
 sound/soc/codecs/max98927.h |  1 +
 2 files changed, 17 insertions(+)

diff --git a/sound/soc/codecs/max98927.c b/sound/soc/codecs/max98927.c
index 8b206ee77709..dacf64c4cdf7 100644
--- a/sound/soc/codecs/max98927.c
+++ b/sound/soc/codecs/max98927.c
@@ -898,6 +898,22 @@ static int max98927_i2c_probe(struct i2c_client *i2c,
 		return ret;
 	}
 
+	max98927->reset_gpio
+		= devm_gpiod_get_optional(&i2c->dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(max98927->reset_gpio)) {
+		ret = PTR_ERR(max98927->reset_gpio);
+		dev_err(&i2c->dev,
+			"Failed to request GPIO reset pin, error %d\n", ret);
+		return ret;
+	}
+
+	if (max98927->reset_gpio) {
+		gpiod_set_value_cansleep(max98927->reset_gpio, 0);
+		usleep_range(5, 10)
+		gpiod_set_value_cansleep(max98927->reset_gpio, 1);
+		usleep_range(1, 5)
+	}
+
 	/* Check Revision ID */
 	ret = regmap_read(max98927->regmap,
 		MAX98927_R01FF_REV_ID, &reg);
diff --git a/sound/soc/codecs/max98927.h b/sound/soc/codecs/max98927.h
index 05f495db914d..5c04bf38e24a 100644
--- a/sound/soc/codecs/max98927.h
+++ b/sound/soc/codecs/max98927.h
@@ -255,6 +255,7 @@ struct max98927_priv {
 	struct regmap *regmap;
 	struct snd_soc_component *component;
 	struct max98927_pdata *pdata;
+	struct gpio_desc *reset_gpio;
 	unsigned int spk_gain;
 	unsigned int sysclk;
 	unsigned int v_l_slot;
-- 
2.32.0

