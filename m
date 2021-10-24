Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE0A4387D7
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Oct 2021 11:19:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbhJXJV6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Oct 2021 05:21:58 -0400
Received: from ip-16.mailobj.net ([213.182.54.16]:34006 "EHLO msg-6.mailo.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229463AbhJXJV5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Oct 2021 05:21:57 -0400
X-Greylist: delayed 1212 seconds by postgrey-1.27 at vger.kernel.org; Sun, 24 Oct 2021 05:21:56 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailoo.org; s=mailo;
        t=1635065952; bh=RCjUkYSOBTufvcH0St7d5HLKiAc0Qjgx0NrurafTU/M=;
        h=X-EA-Auth:From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
         References:MIME-Version:Content-Transfer-Encoding;
        b=HpurRtmpx8k5qXH3uOUmgGqWu7m3E3Cq6eytcb0A+UZWFcxyopidxy82R5pQFJPjt
         +8iTTJzKZCxza8J6931bsoOgZ2gVjAKv8d1fpQdmlwyL0Mv8U2dz1tDLRN8CVjUgQv
         dMrEJ7devCSd08qJXRbYY98eLHfdEtjg9+zuLhBY=
Received: by b-2.in.mailobj.net [192.168.90.12] with ESMTP
        via proxy.mailoo.org [213.182.55.207]
        Sun, 24 Oct 2021 10:59:12 +0200 (CEST)
X-EA-Auth: mlm6BBRsf4vU4Lnwuapyvw1aw8ZLxZ3ofzUyhG4kMGIdtbiYSfsZl1/aVQTPta1zWQnOD25CZWOsUTQuvCqk9WBhmHksIv8AVkUfEmri+oc=
From:   Vincent Knecht <vincent.knecht@mailoo.org>
To:     stephan@gerhold.net, lgirdwood@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, perex@perex.cz, tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Vincent Knecht <vincent.knecht@mailoo.org>
Subject: [PATCH v1 4/4] ASoC: codecs: tfa989x: Add support for tfa9897 optional rcv-gpios
Date:   Sun, 24 Oct 2021 10:58:40 +0200
Message-Id: <20211024085840.1536438-5-vincent.knecht@mailoo.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211024085840.1536438-1-vincent.knecht@mailoo.org>
References: <20211024085840.1536438-1-vincent.knecht@mailoo.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some OEM use a GPIO in addition to the tfa9897 RCV bit to
switch between loudspeaker and earpiece/receiver mode.

Add support for the GPIO switching by specifying rcv-gpios in DT.

Signed-off-by: Vincent Knecht <vincent.knecht@mailoo.org>
---
 sound/soc/codecs/tfa989x.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tfa989x.c b/sound/soc/codecs/tfa989x.c
index ada516acefc0..c96e941da1a9 100644
--- a/sound/soc/codecs/tfa989x.c
+++ b/sound/soc/codecs/tfa989x.c
@@ -7,6 +7,7 @@
  * Copyright (C) 2013 Sony Mobile Communications Inc.
  */
 
+#include <linux/gpio/consumer.h>
 #include <linux/i2c.h>
 #include <linux/module.h>
 #include <linux/regmap.h>
@@ -56,6 +57,7 @@ struct tfa989x_rev {
 struct tfa989x {
 	const struct tfa989x_rev *rev;
 	struct regulator *vddd_supply;
+	struct gpio_desc *rcv_gpiod;
 };
 
 static bool tfa989x_writeable_reg(struct device *dev, unsigned int reg)
@@ -103,10 +105,20 @@ static const struct snd_soc_dapm_route tfa989x_dapm_routes[] = {
 	{"Amp Input", "Right", "AIFINR"},
 };
 
+static int tfa989x_put_mode(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct tfa989x *tfa989x = snd_soc_component_get_drvdata(component);
+
+	gpiod_set_value_cansleep(tfa989x->rcv_gpiod, ucontrol->value.enumerated.item[0]);
+
+	return snd_soc_put_enum_double(kcontrol, ucontrol);
+}
+
 static const char * const mode_text[] = { "Speaker", "Receiver" };
 static SOC_ENUM_SINGLE_DECL(mode_enum, TFA989X_I2SREG, TFA989X_I2SREG_RCV, mode_text);
 static const struct snd_kcontrol_new tfa989x_mode_controls[] = {
-	SOC_ENUM("Mode", mode_enum),
+	SOC_ENUM_EXT("Mode", mode_enum, snd_soc_get_enum_double, tfa989x_put_mode),
 };
 
 static int tfa989x_probe(struct snd_soc_component *component)
@@ -305,6 +317,12 @@ static int tfa989x_i2c_probe(struct i2c_client *i2c)
 		return dev_err_probe(dev, PTR_ERR(tfa989x->vddd_supply),
 				     "Failed to get vddd regulator\n");
 
+	if (tfa989x->rev->rev == TFA9897_REVISION) {
+		tfa989x->rcv_gpiod = devm_gpiod_get_optional(dev, "rcv", GPIOD_OUT_LOW);
+		if (IS_ERR(tfa989x->rcv_gpiod))
+			return PTR_ERR(tfa989x->rcv_gpiod);
+	}
+
 	regmap = devm_regmap_init_i2c(i2c, &tfa989x_regmap);
 	if (IS_ERR(regmap))
 		return PTR_ERR(regmap);
-- 
2.31.1



