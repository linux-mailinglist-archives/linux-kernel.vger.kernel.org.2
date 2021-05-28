Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67BCC394161
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 12:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236690AbhE1KxR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 06:53:17 -0400
Received: from msg-1.mailo.com ([213.182.54.11]:36210 "EHLO msg-1.mailo.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236573AbhE1KxA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 06:53:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailoo.org; s=mailo;
        t=1622199081; bh=etQv4148XiNjFlFCkrHITfinHD/7B2v2acgKy9+MWrU=;
        h=X-EA-Auth:From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
         References:MIME-Version:Content-Transfer-Encoding;
        b=lpZkfxeyJ8p+JHJHogUWEhQVPFdv4A7yOmPfBLK/AXpjbGGBVin+qXJ1gtj+VkbP+
         Nmyme5Y+qXca/cmmmN8LyGg2IBZYXexfP/vj9x+VA4YP0V3t5W4nGAh1fFH+nT009j
         zBFLJu/VzJyil3zWNowUkgYZE4u3mcqf5JZy+Ym8=
Received: by 192.168.90.15 [192.168.90.15] with ESMTP
        via proxy.mailoo.org [213.182.55.207]
        Fri, 28 May 2021 12:51:21 +0200 (CEST)
X-EA-Auth: bZWbzNMKnaVnjmJ2JWIbsTfsgap0MJP1+XsFBIJF2qthYKxGEPDAuxPbQeIE6hwUSnRHZx8rrrqqnnMDVkcimd5rcYdH9yuYln+A7KOuCX0=
From:   Vincent Knecht <vincent.knecht@mailoo.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Vincent Knecht <vincent.knecht@mailoo.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 4/4] ASoC: codecs: tfa989x: Add support for optional vddd-supply
Date:   Fri, 28 May 2021 12:51:01 +0200
Message-Id: <20210528105101.508254-4-vincent.knecht@mailoo.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210528105101.508254-1-vincent.knecht@mailoo.org>
References: <20210528105101.508254-1-vincent.knecht@mailoo.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow specifying Vddd regulator/supply to be enabled on I2C probing.

Signed-off-by: Vincent Knecht <vincent.knecht@mailoo.org>
---
 sound/soc/codecs/tfa989x.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/sound/soc/codecs/tfa989x.c b/sound/soc/codecs/tfa989x.c
index 6d94865c534b..643b45188b6f 100644
--- a/sound/soc/codecs/tfa989x.c
+++ b/sound/soc/codecs/tfa989x.c
@@ -10,6 +10,7 @@
 #include <linux/i2c.h>
 #include <linux/module.h>
 #include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
 #include <sound/soc.h>
 
 #define TFA989X_STATUSREG		0x00
@@ -51,6 +52,10 @@ struct tfa989x_rev {
 	int (*init)(struct regmap *regmap);
 };
 
+struct tfa989x {
+	struct regulator *vddd_supply;
+};
+
 static bool tfa989x_writeable_reg(struct device *dev, unsigned int reg)
 {
 	return reg > TFA989X_REVISIONNUMBER;
@@ -242,10 +247,18 @@ static int tfa989x_dsp_bypass(struct regmap *regmap)
 				 BIT(TFA989X_SYS_CTRL_AMPC));
 }
 
+static void tfa989x_regulator_disable(void *data)
+{
+	struct tfa989x *tfa989x = data;
+
+	regulator_disable(tfa989x->vddd_supply);
+}
+
 static int tfa989x_i2c_probe(struct i2c_client *i2c)
 {
 	struct device *dev = &i2c->dev;
 	const struct tfa989x_rev *rev;
+	struct tfa989x *tfa989x;
 	struct regmap *regmap;
 	unsigned int val;
 	int ret;
@@ -256,10 +269,31 @@ static int tfa989x_i2c_probe(struct i2c_client *i2c)
 		return -ENODEV;
 	}
 
+	tfa989x = devm_kzalloc(dev, sizeof(*tfa989x), GFP_KERNEL);
+	if (!tfa989x)
+		return -ENOMEM;
+
+	i2c_set_clientdata(i2c, tfa989x);
+
+	tfa989x->vddd_supply = devm_regulator_get(dev, "vddd");
+	if (IS_ERR(tfa989x->vddd_supply))
+		return dev_err_probe(dev, PTR_ERR(tfa989x->vddd_supply),
+				     "Failed to get vddd regulator\n");
+
 	regmap = devm_regmap_init_i2c(i2c, &tfa989x_regmap);
 	if (IS_ERR(regmap))
 		return PTR_ERR(regmap);
 
+	ret = regulator_enable(tfa989x->vddd_supply);
+	if (ret) {
+		dev_err(dev, "Failed to enable vddd regulator: %d\n", ret);
+		return ret;
+	}
+
+	ret = devm_add_action_or_reset(dev, tfa989x_regulator_disable, tfa989x);
+	if (ret)
+		return ret;
+
 	/* Bypass regcache for reset and init sequence */
 	regcache_cache_bypass(regmap, true);
 
-- 
2.31.1



