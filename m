Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89E674387DE
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Oct 2021 11:20:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbhJXJW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Oct 2021 05:22:58 -0400
Received: from ip-16.mailobj.net ([213.182.54.16]:34100 "EHLO msg-6.mailo.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229463AbhJXJW5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Oct 2021 05:22:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailoo.org; s=mailo;
        t=1635065951; bh=UsYGPwyUR6rljrYgCshe8HFuD2dx3Qg+R04I/dhbySw=;
        h=X-EA-Auth:From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
         References:MIME-Version:Content-Transfer-Encoding;
        b=E8CXmNf1YxV4W+CCeqjsS/aSCk38mfI/ouTlHwbGFxnDL++ssXXDW1l4s2SYbfwZk
         2eFCnaaYEZDb0e5/Z35ex9KbZyXPayDJ6ogomovhdBc5lygsZG3MnbY2ZXwzsIzE95
         pYKdi1SlNlUX875MWzDIx+XqqjlaU5Omr8SN1IHU=
Received: by b-2.in.mailobj.net [192.168.90.12] with ESMTP
        via proxy.mailoo.org [213.182.55.207]
        Sun, 24 Oct 2021 10:59:11 +0200 (CEST)
X-EA-Auth: UF79fHtwxkvAUPQnZA3RXBsFH51zrfZh1/aGmotlBjJFSYKRJjunb2Enxxg1c8Mg56Ky3elF6OU4RwGu8/zJDU0QKSztv8BXJ84nRto9aug=
From:   Vincent Knecht <vincent.knecht@mailoo.org>
To:     stephan@gerhold.net, lgirdwood@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, perex@perex.cz, tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Vincent Knecht <vincent.knecht@mailoo.org>
Subject: [PATCH v1 2/4] ASoC: codecs: tfa989x: Add support for tfa9897 RCV bit
Date:   Sun, 24 Oct 2021 10:58:38 +0200
Message-Id: <20211024085840.1536438-3-vincent.knecht@mailoo.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211024085840.1536438-1-vincent.knecht@mailoo.org>
References: <20211024085840.1536438-1-vincent.knecht@mailoo.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TFA9897 has an internal 'rcv' switch so that it can manage both
loudspeaker and earpiece modes with the same physical speaker.

Signed-off-by: Vincent Knecht <vincent.knecht@mailoo.org>
---
 sound/soc/codecs/tfa989x.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/sound/soc/codecs/tfa989x.c b/sound/soc/codecs/tfa989x.c
index 1ae47d4f1ca7..ada516acefc0 100644
--- a/sound/soc/codecs/tfa989x.c
+++ b/sound/soc/codecs/tfa989x.c
@@ -19,6 +19,7 @@
 #define TFA989X_REVISIONNUMBER		0x03
 #define TFA989X_REVISIONNUMBER_REV_MSK	GENMASK(7, 0)	/* device revision */
 #define TFA989X_I2SREG			0x04
+#define TFA989X_I2SREG_RCV		2	/* receiver mode */
 #define TFA989X_I2SREG_CHSA		6	/* amplifier input select */
 #define TFA989X_I2SREG_CHSA_MSK		GENMASK(7, 6)
 #define TFA989X_I2SREG_I2SSR		12	/* sample rate */
@@ -53,6 +54,7 @@ struct tfa989x_rev {
 };
 
 struct tfa989x {
+	const struct tfa989x_rev *rev;
 	struct regulator *vddd_supply;
 };
 
@@ -101,7 +103,25 @@ static const struct snd_soc_dapm_route tfa989x_dapm_routes[] = {
 	{"Amp Input", "Right", "AIFINR"},
 };
 
+static const char * const mode_text[] = { "Speaker", "Receiver" };
+static SOC_ENUM_SINGLE_DECL(mode_enum, TFA989X_I2SREG, TFA989X_I2SREG_RCV, mode_text);
+static const struct snd_kcontrol_new tfa989x_mode_controls[] = {
+	SOC_ENUM("Mode", mode_enum),
+};
+
+static int tfa989x_probe(struct snd_soc_component *component)
+{
+	struct tfa989x *tfa989x = snd_soc_component_get_drvdata(component);
+
+	if (tfa989x->rev->rev == TFA9897_REVISION)
+		return snd_soc_add_component_controls(component, tfa989x_mode_controls,
+						      ARRAY_SIZE(tfa989x_mode_controls));
+
+	return 0;
+}
+
 static const struct snd_soc_component_driver tfa989x_component = {
+	.probe			= tfa989x_probe,
 	.dapm_widgets		= tfa989x_dapm_widgets,
 	.num_dapm_widgets	= ARRAY_SIZE(tfa989x_dapm_widgets),
 	.dapm_routes		= tfa989x_dapm_routes,
@@ -277,6 +297,7 @@ static int tfa989x_i2c_probe(struct i2c_client *i2c)
 	if (!tfa989x)
 		return -ENOMEM;
 
+	tfa989x->rev = rev;
 	i2c_set_clientdata(i2c, tfa989x);
 
 	tfa989x->vddd_supply = devm_regulator_get(dev, "vddd");
-- 
2.31.1



