Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B23B6424BD6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 04:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232415AbhJGCmy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 22:42:54 -0400
Received: from dnyon.com ([82.223.165.189]:43370 "EHLO dnyon.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230249AbhJGCmx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 22:42:53 -0400
Received: from dnyon.com (55.red-81-39-194.dynamicip.rima-tde.net [81.39.194.55])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dnyon.com (Postfix) with ESMTPSA id BD7663FD72;
        Thu,  7 Oct 2021 02:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dnyon.com; s=mail;
        t=1633574439; bh=icffpm45hME51EE2tsK8D8Zf/jIvMI14/Zq8Hnc8Ql4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iMZ12a4PKQyiaBryxw569+aqSrGYUx7TNIfjLyhVtDPjDPcu2KEORbVbx/tkZfyPt
         gMx2HMA+4hsEiIlRT06zdKESp9bpFtXMMtd4gb5AR/DJYnoim52rhtj/tIN3cQqBFT
         O+DaPKKfcA6wa6zs1wfokkkIlHwGZsgRPqbxKxElJUukh+KB5rsodVhk6PVn434gIm
         /wxKdoG9c+CzQ1V5RdNt5BhtaZ9sPVu/t66hM+av0vER/m5/vhX7Ou9BhXpBvuZWGX
         cGxpfinxyEOopYLXX4XslBWcD6noQhdlzt76+uedriZVVUMH0CCIfSSyxZFP5sCkky
         Uyqtr6OUVUQuQ==
From:   Alejandro Tafalla <atafalla@dnyon.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        =?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
        ~postmarketos/upstreaming@lists.sr.ht, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     Alejandro Tafalla <atafalla@dnyon.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, devicetree@vger.kernel.org
Subject: [PATCH v4 1/2] ASoC: max98927: Handle reset gpio when probing i2c
Date:   Thu,  7 Oct 2021 04:38:56 +0200
Message-Id: <d74b12a79ae9ca728d5d9e64c55b3e59e8c0e509.1633572679.git.atafalla@dnyon.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1633572679.git.atafalla@dnyon.com>
References: <cover.1633572679.git.atafalla@dnyon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The max98927 codec on some devices requires pulling a reset gpio before
responding to any i2c command. This commit adds support for it through
an optional reset-gpios property.

Signed-off-by: Alejandro Tafalla <atafalla@dnyon.com>
---
 sound/soc/codecs/max98927.c | 25 +++++++++++++++++++++++++
 sound/soc/codecs/max98927.h |  1 +
 2 files changed, 26 insertions(+)

diff --git a/sound/soc/codecs/max98927.c b/sound/soc/codecs/max98927.c
index 8b206ee77709..5ba5f876eab8 100644
--- a/sound/soc/codecs/max98927.c
+++ b/sound/soc/codecs/max98927.c
@@ -897,6 +897,19 @@ static int max98927_i2c_probe(struct i2c_client *i2c,
 			"Failed to allocate regmap: %d\n", ret);
 		return ret;
 	}
+	
+	max98927->reset_gpio 
+		= devm_gpiod_get_optional(&i2c->dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(max98927->reset_gpio)) {
+		ret = PTR_ERR(max98927->reset_gpio);
+		return dev_err_probe(&i2c->dev, ret, "failed to request GPIO reset pin");
+	}
+
+	if (max98927->reset_gpio) {
+		gpiod_set_value_cansleep(max98927->reset_gpio, 0);
+		/* Wait for i2c port to be ready */
+		usleep_range(5000, 6000);
+	}
 
 	/* Check Revision ID */
 	ret = regmap_read(max98927->regmap,
@@ -921,6 +934,17 @@ static int max98927_i2c_probe(struct i2c_client *i2c,
 	return ret;
 }
 
+static int max98927_i2c_remove(struct i2c_client *i2c)
+{
+	struct max98927_priv *max98927 = i2c_get_clientdata(i2c);
+
+	if (max98927->reset_gpio) {
+		gpiod_set_value_cansleep(max98927->reset_gpio, 1);
+	}
+
+	return 0;
+}
+
 static const struct i2c_device_id max98927_i2c_id[] = {
 	{ "max98927", 0},
 	{ },
@@ -952,6 +976,7 @@ static struct i2c_driver max98927_i2c_driver = {
 		.pm = &max98927_pm,
 	},
 	.probe  = max98927_i2c_probe,
+	.remove = max98927_i2c_remove,
 	.id_table = max98927_i2c_id,
 };
 
diff --git a/sound/soc/codecs/max98927.h b/sound/soc/codecs/max98927.h
index 05f495db914d..13f5066d7419 100644
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
2.33.0

