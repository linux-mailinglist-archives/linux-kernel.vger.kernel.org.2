Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 268233FB412
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 12:48:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236437AbhH3KtL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 06:49:11 -0400
Received: from dnyon.com ([82.223.165.189]:56220 "EHLO dnyon.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236380AbhH3KtJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 06:49:09 -0400
Received: from dnyon.com (45.74.222.87.dynamic.jazztel.es [87.222.74.45])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dnyon.com (Postfix) with ESMTPSA id AB0E24044F;
        Mon, 30 Aug 2021 10:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dnyon.com; s=mail;
        t=1630320493; bh=t0sArD8RpMG3ILMbA97+7fmkKdN7C7bsh9csIcYpttI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E2mfoS8gdyXLMY3r3u7GbvheW78qI8B1nzDUjXmhyEVsryiiC0Ut2aNmCVEmtO9H8
         9JRtwr4Pv+TBI1yW+afpkD5Mk9hYSv27yOW1FKFx67TpfLueJ4w6trEHgDZC3z8UN5
         HKtNoOWxnQYVBREwEPkICzIm5qniIlWFVrWUAXw4J53Snuj0oxBu1E8MZBoQTmx55M
         ESmErt0iP7kZVDWM41eiz9SSKtZqpkPnL5wGVIqteCpz/01oK+ssFA5oQhbMJoHl2O
         sI9yuam5L1We5TKRgHj79dBF22C3224EgYymHieHlSB9k+8I+n+9/bIuwPdl5u0Vci
         Uatywb8bjuQrA==
From:   Alejandro Tafalla <atafalla@dnyon.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        alsa-devel@alsa-project.org
Cc:     Alejandro Tafalla <atafalla@dnyon.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] ASoC: max98927: Handle reset gpio when probing i2c
Date:   Mon, 30 Aug 2021 12:44:23 +0200
Message-Id: <20210830104426.487246-2-atafalla@dnyon.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210830104426.487246-1-atafalla@dnyon.com>
References: <20210830104426.487246-1-atafalla@dnyon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drive the reset gpio if defined in the DTS node.

Signed-off-by: Alejandro Tafalla <atafalla@dnyon.com>
---
 sound/soc/codecs/max98927.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/sound/soc/codecs/max98927.c b/sound/soc/codecs/max98927.c
index 8b206ee77709..84a159de4b26 100644
--- a/sound/soc/codecs/max98927.c
+++ b/sound/soc/codecs/max98927.c
@@ -868,6 +868,7 @@ static int max98927_i2c_probe(struct i2c_client *i2c,
 	int ret = 0, value;
 	int reg = 0;
 	struct max98927_priv *max98927 = NULL;
+	struct gpio_desc *reset_gpio;
 
 	max98927 = devm_kzalloc(&i2c->dev,
 		sizeof(*max98927), GFP_KERNEL);
@@ -898,6 +899,20 @@ static int max98927_i2c_probe(struct i2c_client *i2c,
 		return ret;
 	}
 
+	reset_gpio
+		= devm_gpiod_get_optional(&i2c->dev, "reset", GPIOD_OUT_LOW);
+	if (IS_ERR(reset_gpio)) {
+		ret = PTR_ERR(reset_gpio);
+		return dev_err_probe(&i2c->dev, ret,
+			"failed to request GPIO reset pin");
+	}
+
+	if (reset_gpio) {
+		usleep_range(8000, 10000);
+		gpiod_set_value_cansleep(reset_gpio, 1);
+		usleep_range(1000, 5000);
+	}
+
 	/* Check Revision ID */
 	ret = regmap_read(max98927->regmap,
 		MAX98927_R01FF_REV_ID, &reg);
-- 
2.32.0

