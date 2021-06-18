Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10A683ACE4A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 17:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234310AbhFRPKO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 11:10:14 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:63016 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234237AbhFRPKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 11:10:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1624028880; x=1655564880;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WpgZqaJX/+7BSkqSgUw8H/zUIGbOwzMBZkNkKWi6y/E=;
  b=ZAXMLbljW0iA3kv8EFI5ZsGYZcaW8kLi/jCAba9+VWimYi8Rb7E3002W
   oo1tYWWHbQifrJ3pSwbL7KVtBBYuXJS2mELFtXcxCkbZg292c6zqbsKle
   +Way8mOAD1qoL3QPpv8BRuD/jy1khkf/ncyGsTxfiZB0SFE1Sdtt3etJz
   nOvGtQJ10l0wzwKQ3emGSdjw6lR58Ff/VdbMJwFzfO7owZxH8qUTpqHrI
   hKnLB86itQtsi7HQ5IbKMvr1NyH3aLkx1RbGM7vFOmXCcWZzhSsJo9LtW
   W70quj0+r8+GREnBSbaxv1EWc/BI3aNG30KLunpQI405NIz5LIblrSy9s
   g==;
IronPort-SDR: EtHACUtRraKX5sxLg2ztvjKgVg9okxvvn+O/IQyua40UpAUHhr6wD/VZowF5MRGsWLOLqJb8NC
 viCI6hrwBzifgGBOsVW3nJZTw5gLV0vDZqf42fRuWXq/emYnJjmzJPjk9mbEeC8ttOjDNTGrAP
 YZPuSHcbdLqn/cHQvRPX4oB9kYb4yQ5Y1Tt6U3vGYy418lvyuKD+HqoRUlme6OIG3wgiqPfFm7
 NwT/tI8s+lem258t2CvySj0lrW7P3ZWg014mscOypO+NagjWxf1VKsJRw8M4V7Yycs8g/AL/v+
 jhY=
X-IronPort-AV: E=Sophos;i="5.83,284,1616482800"; 
   d="scan'208";a="125835094"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 18 Jun 2021 08:08:00 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 18 Jun 2021 08:08:00 -0700
Received: from rob-ult-m19940.amer.actel.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Fri, 18 Jun 2021 08:07:57 -0700
From:   Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
To:     <alsa-devel@alsa-project.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <broonie@kernel.org>, <perex@perex.cz>, <tiwai@suse.com>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>,
        Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Subject: [PATCH 2/2] ASoC: atmel-i2s: Fix usage of capture and playback at the same time
Date:   Fri, 18 Jun 2021 18:07:41 +0300
Message-ID: <20210618150741.401739-2-codrin.ciubotariu@microchip.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210618150741.401739-1-codrin.ciubotariu@microchip.com>
References: <20210618150741.401739-1-codrin.ciubotariu@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For both capture and playback streams to work at the same time, only the
needed values from a register need to be updated. Also, clocks should be
enabled only when the first stream is started and stopped when there is no
running stream.

Fixes: b543e467d1a9 ("ASoC: atmel-i2s: add driver for the new Atmel I2S controller")
Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
---
 sound/soc/atmel/atmel-i2s.c | 34 ++++++++++++++++++++++++++--------
 1 file changed, 26 insertions(+), 8 deletions(-)

diff --git a/sound/soc/atmel/atmel-i2s.c b/sound/soc/atmel/atmel-i2s.c
index a95002b0cc8e..6b3d9c05eaf2 100644
--- a/sound/soc/atmel/atmel-i2s.c
+++ b/sound/soc/atmel/atmel-i2s.c
@@ -200,6 +200,7 @@ struct atmel_i2s_dev {
 	unsigned int				fmt;
 	const struct atmel_i2s_gck_param	*gck_param;
 	const struct atmel_i2s_caps		*caps;
+	int					clk_use_no;
 };
 
 static irqreturn_t atmel_i2s_interrupt(int irq, void *dev_id)
@@ -321,9 +322,16 @@ static int atmel_i2s_hw_params(struct snd_pcm_substream *substream,
 {
 	struct atmel_i2s_dev *dev = snd_soc_dai_get_drvdata(dai);
 	bool is_playback = (substream->stream == SNDRV_PCM_STREAM_PLAYBACK);
-	unsigned int mr = 0;
+	unsigned int mr = 0, mr_mask;
 	int ret;
 
+	mr_mask = ATMEL_I2SC_MR_FORMAT_MASK | ATMEL_I2SC_MR_MODE_MASK |
+		ATMEL_I2SC_MR_DATALENGTH_MASK;
+	if (is_playback)
+		mr_mask |= ATMEL_I2SC_MR_TXMONO;
+	else
+		mr_mask |= ATMEL_I2SC_MR_RXMONO;
+
 	switch (dev->fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
 	case SND_SOC_DAIFMT_I2S:
 		mr |= ATMEL_I2SC_MR_FORMAT_I2S;
@@ -402,7 +410,7 @@ static int atmel_i2s_hw_params(struct snd_pcm_substream *substream,
 		return -EINVAL;
 	}
 
-	return regmap_write(dev->regmap, ATMEL_I2SC_MR, mr);
+	return regmap_update_bits(dev->regmap, ATMEL_I2SC_MR, mr_mask, mr);
 }
 
 static int atmel_i2s_switch_mck_generator(struct atmel_i2s_dev *dev,
@@ -495,18 +503,28 @@ static int atmel_i2s_trigger(struct snd_pcm_substream *substream, int cmd,
 	is_master = (mr & ATMEL_I2SC_MR_MODE_MASK) == ATMEL_I2SC_MR_MODE_MASTER;
 
 	/* If master starts, enable the audio clock. */
-	if (is_master && mck_enabled)
-		err = atmel_i2s_switch_mck_generator(dev, true);
-	if (err)
-		return err;
+	if (is_master && mck_enabled) {
+		if (!dev->clk_use_no) {
+			err = atmel_i2s_switch_mck_generator(dev, true);
+			if (err)
+				return err;
+		}
+		dev->clk_use_no++;
+	}
 
 	err = regmap_write(dev->regmap, ATMEL_I2SC_CR, cr);
 	if (err)
 		return err;
 
 	/* If master stops, disable the audio clock. */
-	if (is_master && !mck_enabled)
-		err = atmel_i2s_switch_mck_generator(dev, false);
+	if (is_master && !mck_enabled) {
+		if (dev->clk_use_no == 1) {
+			err = atmel_i2s_switch_mck_generator(dev, false);
+			if (err)
+				return err;
+		}
+		dev->clk_use_no--;
+	}
 
 	return err;
 }
-- 
2.30.2

