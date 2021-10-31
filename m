Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90CB04410EF
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Oct 2021 22:10:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbhJaVNO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Oct 2021 17:13:14 -0400
Received: from msg-1.mailo.com ([213.182.54.11]:53022 "EHLO msg-1.mailo.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229946AbhJaVNM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Oct 2021 17:13:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailoo.org; s=mailo;
        t=1635714614; bh=5M2J6VLtolkff8vbL1cmeU25yPVsQnA4hle2/XFfcb4=;
        h=X-EA-Auth:From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
         References:MIME-Version:Content-Transfer-Encoding;
        b=ksglUMhlfW/6R1rCq5s/sNSSDMVQiW1A6cgKo8vTmzABYpO5PJOU/HLr2iVV8cN6M
         I0+QykUU/9pTks3sUCyxOmpTsUJf6SXOqp2nVY2RbOnFB3szi/pnRECXXBS2SQtU8m
         Vu3BGO+Jq1WBeKhYGMxhPJEtud290n6982Itd7jE=
Received: by b-6.in.mailobj.net [192.168.90.16] with ESMTP
        via proxy.mailoo.org [213.182.55.207]
        Sun, 31 Oct 2021 22:10:14 +0100 (CET)
X-EA-Auth: gZo/ybajlv073f448wFjPx4WQIIaL02CzThx5GBwARSXnxDwCW7LmmdLvTSg00uCynT4RpDnULaV49m5odBlDHk+qSdLmCea/QRcIWb3kUc=
From:   Vincent Knecht <vincent.knecht@mailoo.org>
To:     stephan@gerhold.net, lgirdwood@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, perex@perex.cz, tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Vincent Knecht <vincent.knecht@mailoo.org>
Subject: [PATCH 2/2] ASoC: codecs: tfa989x: Add support for tfa9897 optional rcv-gpios
Date:   Sun, 31 Oct 2021 22:09:56 +0100
Message-Id: <20211031210956.812101-3-vincent.knecht@mailoo.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211031210956.812101-1-vincent.knecht@mailoo.org>
References: <20211031210956.812101-1-vincent.knecht@mailoo.org>
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
index eb2a7870148d..dc86852752c5 100644
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
@@ -99,10 +101,20 @@ static const struct snd_soc_dapm_route tfa989x_dapm_routes[] = {
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
@@ -301,6 +313,12 @@ static int tfa989x_i2c_probe(struct i2c_client *i2c)
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



