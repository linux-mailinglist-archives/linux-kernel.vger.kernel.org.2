Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4458A368114
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 15:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236384AbhDVNDN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 09:03:13 -0400
Received: from smtp1.axis.com ([195.60.68.17]:17953 "EHLO smtp1.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236074AbhDVNDM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 09:03:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1619096557;
  x=1650632557;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=yepxJq/a08r2JfRzSHmXMki2GuQi2NGqbDta5ykYrPE=;
  b=kVipVyOdzYovIkDy4YVK4YuWNpjGscrhOI9KyJ6fbUbzRT54vptekTAp
   0V1BUDOmJXgQBsdaDs7G+eERxY0iDfqI+8kcdHoYCofnS7EbYoASWRUlv
   N3YJ/tkV4H3TXsD0SLoNadXftnKwYey4ePc7NhQpqC2NbOtNIGBiCwfDy
   GbgGkuaiKtEjB6R7n2DCRAgqEqc6/VKaMvTZ6XPotwY5h53jCvJfktp5h
   WvQitDoodPSzM5YkuLDXRHtXm30F7p4Kc8CYnrXoomkghHtXk7FJ3MZWR
   f4i+bLkdgT6+st+Fy9RfHlFZRNSRQ/4CgPVih237RZVW+GMJom78VSsDs
   g==;
From:   Niklas Carlsson <Niklas.Carlsson@axis.com>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <kernel@axis.com>, Niklas Carlsson <niklasc@axis.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] ASoC: adau17x1: Avoid overwriting CHPF
Date:   Thu, 22 Apr 2021 15:02:26 +0200
Message-ID: <20210422130226.15201-1-Niklas.Carlsson@axis.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Niklas Carlsson <niklasc@axis.com>

Configuring number of channels per LRCLK frame by using e.g.
snd_soc_dai_set_tdm_slot before configuring DAI format was being
overwritten by the latter due to a regmap_write which would write over
the whole register.

Signed-off-by: Niklas Carlsson <niklasc@axis.com>
---
 sound/soc/codecs/adau17x1.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/adau17x1.c b/sound/soc/codecs/adau17x1.c
index 546ee8178038..8aae7ab74091 100644
--- a/sound/soc/codecs/adau17x1.c
+++ b/sound/soc/codecs/adau17x1.c
@@ -553,6 +553,7 @@ static int adau17x1_set_dai_fmt(struct snd_soc_dai *dai,
 {
 	struct adau *adau = snd_soc_component_get_drvdata(dai->component);
 	unsigned int ctrl0, ctrl1;
+	unsigned int ctrl0_mask;
 	int lrclk_pol;
 
 	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
@@ -612,8 +613,16 @@ static int adau17x1_set_dai_fmt(struct snd_soc_dai *dai,
 	if (lrclk_pol)
 		ctrl0 |= ADAU17X1_SERIAL_PORT0_LRCLK_POL;
 
-	regmap_write(adau->regmap, ADAU17X1_SERIAL_PORT0, ctrl0);
-	regmap_write(adau->regmap, ADAU17X1_SERIAL_PORT1, ctrl1);
+	/* Set the mask to update all relevant bits in ADAU17X1_SERIAL_PORT0 */
+	ctrl0_mask = ADAU17X1_SERIAL_PORT0_MASTER |
+		     ADAU17X1_SERIAL_PORT0_LRCLK_POL |
+		     ADAU17X1_SERIAL_PORT0_BCLK_POL |
+		     ADAU17X1_SERIAL_PORT0_PULSE_MODE;
+
+	regmap_update_bits(adau->regmap, ADAU17X1_SERIAL_PORT0, ctrl0_mask,
+			   ctrl0);
+	regmap_update_bits(adau->regmap, ADAU17X1_SERIAL_PORT1,
+			   ADAU17X1_SERIAL_PORT1_DELAY_MASK, ctrl1);
 
 	adau->dai_fmt = fmt & SND_SOC_DAIFMT_FORMAT_MASK;
 
-- 
2.20.1

