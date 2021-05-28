Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DABD39415E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 12:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236664AbhE1KxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 06:53:10 -0400
Received: from msg-2.mailo.com ([213.182.54.12]:55416 "EHLO msg-2.mailo.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236543AbhE1KxA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 06:53:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailoo.org; s=mailo;
        t=1622199080; bh=iNxBNW4SSptwhcnpvgl2tbTyOmoi56zJOm9WU01asGI=;
        h=X-EA-Auth:From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
         References:MIME-Version:Content-Transfer-Encoding;
        b=P4AQhR1djESmACH18/d3g73K5J3ldKKGm87I1GuDAYS3ObioRwGV+KwApDIofwlEn
         l6VpAU2Jo92Eni3JffNKTbuRsKeKpFoJtutjZKTqadb3FOvjYwvF4JO/ajND66jCL+
         +44qnyyx212Tj+nZ0KWgmkCHlagfpK3aJHInPKjc=
Received: by 192.168.90.15 [192.168.90.15] with ESMTP
        via proxy.mailoo.org [213.182.55.207]
        Fri, 28 May 2021 12:51:19 +0200 (CEST)
X-EA-Auth: qKy0orTZIIiVMo0/dMQZTXTZ1ji/g72TwrHjujjnoSQ0wvoGfk2lLoGU5PSkvy1IFugCdt7AcjLb6aEvFqXqXtfszauthTo3wbKolVOjGPo=
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
Subject: [PATCH v1 2/4] ASoC: codecs: tfa989x: Add support for tfa9897
Date:   Fri, 28 May 2021 12:50:59 +0200
Message-Id: <20210528105101.508254-2-vincent.knecht@mailoo.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210528105101.508254-1-vincent.knecht@mailoo.org>
References: <20210528105101.508254-1-vincent.knecht@mailoo.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add specific init function to poke needed registers & values for this IC

Signed-off-by: Vincent Knecht <vincent.knecht@mailoo.org>
---
 sound/soc/codecs/tfa989x.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/sound/soc/codecs/tfa989x.c b/sound/soc/codecs/tfa989x.c
index 408e26eee108..6d94865c534b 100644
--- a/sound/soc/codecs/tfa989x.c
+++ b/sound/soc/codecs/tfa989x.c
@@ -44,6 +44,7 @@
 #define TFA989X_CURRENTSENSE4		0x49
 
 #define TFA9895_REVISION		0x12
+#define TFA9897_REVISION		0x97
 
 struct tfa989x_rev {
 	unsigned int rev;
@@ -175,6 +176,29 @@ static const struct tfa989x_rev tfa9895_rev = {
 	.init	= tfa9895_init,
 };
 
+static int tfa9897_init(struct regmap *regmap)
+{
+	int ret;
+
+	/* Reduce slewrate by clearing iddqtestbst to avoid booster damage */
+	ret = regmap_write(regmap, TFA989X_CURRENTSENSE3, 0x0300);
+	if (ret)
+		return ret;
+
+	/* Enable clipping */
+	ret = regmap_clear_bits(regmap, TFA989X_CURRENTSENSE4, 0x1);
+	if (ret)
+		return ret;
+
+	/* Set required TDM configuration */
+	return regmap_write(regmap, 0x14, 0x0);
+}
+
+static const struct tfa989x_rev tfa9897_rev = {
+	.rev	= TFA9897_REVISION,
+	.init	= tfa9897_init,
+};
+
 /*
  * Note: At the moment this driver bypasses the "CoolFlux DSP" built into the
  * TFA989X amplifiers. Unfortunately, there seems to be absolutely
@@ -280,6 +304,7 @@ static int tfa989x_i2c_probe(struct i2c_client *i2c)
 
 static const struct of_device_id tfa989x_of_match[] = {
 	{ .compatible = "nxp,tfa9895", .data = &tfa9895_rev },
+	{ .compatible = "nxp,tfa9897", .data = &tfa9897_rev },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, tfa989x_of_match);
-- 
2.31.1



