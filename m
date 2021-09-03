Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CEA23FF8B9
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 03:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347275AbhICBwl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 21:52:41 -0400
Received: from dnyon.com ([82.223.165.189]:56352 "EHLO dnyon.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347102AbhICBwi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 21:52:38 -0400
Received: from dnyon.com (55.red-81-39-194.dynamicip.rima-tde.net [81.39.194.55])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dnyon.com (Postfix) with ESMTPSA id 226654047F;
        Fri,  3 Sep 2021 01:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dnyon.com; s=mail;
        t=1630633898; bh=h8jZ+0CBNopo91U3FFEaSigGAKw61IO8NvubUHlFF6w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L7pcZjDZ4a3zBAXT2M7gWtbl9CTBBucpUflyxeNF719MV2IagQpzHXi+z2nfpVgpd
         1YxBg5JPfT2h9e+i7cImTLxIS+DIxS+CNOD3i9wBQYeE4XmqyoGitimCzh/p+VNj+x
         Hz0hORYrNJ0qewf0G/SYmjYJ6WaP0JFdO4WUeDGFj0RvsCV6hXYXJI9bLI6+WlDg/5
         q71VShLMuIWzRFyT5VrZnKHa/D/Pc0ihVpsfj42/5Ox0IXmSVrYlI9IcD0S0n/vZS9
         RAdUsWZhF02FMe0T8f8aeFILPCmEV03dXuaQi0MX6gILCtPCobCFmC+I1PwEpTS7sI
         G5ms8uljFvUkA==
From:   Alejandro <atafalla@dnyon.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Alejandro Tafalla <atafalla@dnyon.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] ASoC: max98927: Handle reset gpio when probing i2c
Date:   Fri,  3 Sep 2021 03:49:50 +0200
Message-Id: <04a18f4115539752429da55fb857834cea0944e5.1630632805.git.atafalla@dnyon.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1630632805.git.atafalla@dnyon.com>
References: <cover.1630632805.git.atafalla@dnyon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alejandro Tafalla <atafalla@dnyon.com>

Drive the reset gpio if defined in the DTS node.

Signed-off-by: Alejandro Tafalla <atafalla@dnyon.com>
---
 sound/soc/codecs/max98927.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/sound/soc/codecs/max98927.c b/sound/soc/codecs/max98927.c
index 8b206ee77709..daf06b503433 100644
--- a/sound/soc/codecs/max98927.c
+++ b/sound/soc/codecs/max98927.c
@@ -868,6 +868,7 @@ static int max98927_i2c_probe(struct i2c_client *i2c,
 	int ret = 0, value;
 	int reg = 0;
 	struct max98927_priv *max98927 = NULL;
+	struct gpio_desc *reset_gpio;
 
 	max98927 = devm_kzalloc(&i2c->dev,
 		sizeof(*max98927), GFP_KERNEL);
@@ -898,6 +899,19 @@ static int max98927_i2c_probe(struct i2c_client *i2c,
 		return ret;
 	}
 
+	reset_gpio
+		= devm_gpiod_get_optional(&i2c->dev, "reset", GPIOD_OUT_LOW);
+	if (IS_ERR(reset_gpio)) {
+		ret = PTR_ERR(reset_gpio);
+		return dev_err_probe(&i2c->dev, ret, "failed to request GPIO reset pin");
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
2.33.0

