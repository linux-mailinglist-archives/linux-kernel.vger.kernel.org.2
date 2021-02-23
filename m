Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A66232309A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 19:24:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233947AbhBWSWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 13:22:38 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:42503 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233850AbhBWSV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 13:21:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1614104519; x=1645640519;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4kGp25rN986OLP0bFictYfqxryE9sLtl4aZrQGj5oeI=;
  b=HYaTeMoXgpzSnnnhWo2ojWTEhax1Zwo0b2n7B5BZceRVp2TH5UBVlHsH
   wBnX8xX6QILLpGN69SHSGP7sfUd7fx2vgTogVMLOuFPuDnGTWlpvyASkv
   Z0s0+c3i/IO922TcS+2Ye94V2NMT/gEb/2UBy+fCJWXx/sFMi6hDoSWKA
   CHXKV9++fkIVyIGJpqbW0Z6qzNCEhQ+Q/uNbOP6wJ985wrmu4fqjuFODV
   Z9Np3/IoPkC+Jlw7ZDDTx2Cchxnzzg+e4hRuetyqNlegr25CzGuUCikgD
   dwm+oBHOIMbG8yCnQAyeI8VOF2FR/+PV68+DvPVHiFvfQb0QclzQroIUC
   g==;
IronPort-SDR: xNJ1cAdDV7RT/feJnq1zWZLa5DYiimloTe5fxNGtdcR9eNEQJgajEESAsjQt6Pi2iAg4E+qoZ5
 oQ6+zvCf/cujlaZLvyDyeUJnn6S5X7aLD3DMi/vg5KooW3kN5vF48mI6KIeVdliLJxXG306Z0I
 nqliGIegQnUUD57i/aD4fjdPiD+eOn8GR0oRAXagVkEWFjtyX99Mn7+2nZshrC5PLxzk17D2ES
 OLyRdSs+ZnLr2rGlZW3zRYyocPIiOCRd/nGOOoNAfc9v7BMH9OH02nZNspwt7Frz4ZxRHcBGzW
 /Y4=
X-IronPort-AV: E=Sophos;i="5.81,200,1610434800"; 
   d="scan'208";a="116310923"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Feb 2021 11:20:26 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 23 Feb 2021 11:20:22 -0700
Received: from rob-ult-m19940.amer.actel.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Tue, 23 Feb 2021 11:20:19 -0700
From:   Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
To:     <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
        <perex@perex.cz>, <tiwai@suse.com>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>,
        "Codrin Ciubotariu" <codrin.ciubotariu@microchip.com>
Subject: [PATCH 7/7] ASoC: mchp-i2s-mcc: Add FIFOs support
Date:   Tue, 23 Feb 2021 20:19:29 +0200
Message-ID: <20210223181929.444640-8-codrin.ciubotariu@microchip.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210223181929.444640-1-codrin.ciubotariu@microchip.com>
References: <20210223181929.444640-1-codrin.ciubotariu@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I2S-MCC found on SAMA7G5 includes 2 FIFOs (capture and playback). When
FIFOs are enabled, bits I2SMCC_ISRA.TXLRDYx and I2SMCC_ISRA.TXRRDYx must
not be used. Bits I2SMCC_ISRB.TXFFRDY and I2SMCC_ISRB.RXFFRDY must be used
instead.

Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
---
 sound/soc/atmel/mchp-i2s-mcc.c | 76 +++++++++++++++++++++++++---------
 1 file changed, 56 insertions(+), 20 deletions(-)

diff --git a/sound/soc/atmel/mchp-i2s-mcc.c b/sound/soc/atmel/mchp-i2s-mcc.c
index 3d13efb11444..f951fa0f39fd 100644
--- a/sound/soc/atmel/mchp-i2s-mcc.c
+++ b/sound/soc/atmel/mchp-i2s-mcc.c
@@ -176,7 +176,7 @@
  */
 #define MCHP_I2SMCC_MRB_CRAMODE_REGULAR		(1 << 0)
 
-#define MCHP_I2SMCC_MRB_FIFOEN			BIT(1)
+#define MCHP_I2SMCC_MRB_FIFOEN			BIT(4)
 
 #define MCHP_I2SMCC_MRB_DMACHUNK_MASK		GENMASK(9, 8)
 #define MCHP_I2SMCC_MRB_DMACHUNK(no_words) \
@@ -230,6 +230,7 @@ static const struct regmap_config mchp_i2s_mcc_regmap_config = {
 
 struct mchp_i2s_mcc_soc_data {
 	unsigned int	data_pin_pair_num;
+	bool		has_fifo;
 };
 
 struct mchp_i2s_mcc_dev {
@@ -257,7 +258,7 @@ struct mchp_i2s_mcc_dev {
 static irqreturn_t mchp_i2s_mcc_interrupt(int irq, void *dev_id)
 {
 	struct mchp_i2s_mcc_dev *dev = dev_id;
-	u32 sra, imra, srb, imrb, pendinga, pendingb, idra = 0;
+	u32 sra, imra, srb, imrb, pendinga, pendingb, idra = 0, idrb = 0;
 	irqreturn_t ret = IRQ_NONE;
 
 	regmap_read(dev->regmap, MCHP_I2SMCC_IMRA, &imra);
@@ -275,24 +276,36 @@ static irqreturn_t mchp_i2s_mcc_interrupt(int irq, void *dev_id)
 	 * Tx/Rx ready interrupts are enabled when stopping only, to assure
 	 * availability and to disable clocks if necessary
 	 */
-	idra |= pendinga & (MCHP_I2SMCC_INT_TXRDY_MASK(dev->channels) |
-			    MCHP_I2SMCC_INT_RXRDY_MASK(dev->channels));
-	if (idra)
+	if (dev->soc->has_fifo) {
+		idrb |= pendingb & (MCHP_I2SMCC_INT_TXFFRDY |
+				    MCHP_I2SMCC_INT_RXFFRDY);
+	} else {
+		idra |= pendinga & (MCHP_I2SMCC_INT_TXRDY_MASK(dev->channels) |
+				    MCHP_I2SMCC_INT_RXRDY_MASK(dev->channels));
+	}
+	if (idra || idrb)
 		ret = IRQ_HANDLED;
 
-	if ((imra & MCHP_I2SMCC_INT_TXRDY_MASK(dev->channels)) &&
-	    (imra & MCHP_I2SMCC_INT_TXRDY_MASK(dev->channels)) ==
-	    (idra & MCHP_I2SMCC_INT_TXRDY_MASK(dev->channels))) {
+	if ((!dev->soc->has_fifo &&
+	     (imra & MCHP_I2SMCC_INT_TXRDY_MASK(dev->channels)) &&
+	     (imra & MCHP_I2SMCC_INT_TXRDY_MASK(dev->channels)) ==
+	     (idra & MCHP_I2SMCC_INT_TXRDY_MASK(dev->channels))) ||
+	    (dev->soc->has_fifo && imrb & MCHP_I2SMCC_INT_TXFFRDY)) {
 		dev->tx_rdy = 1;
 		wake_up_interruptible(&dev->wq_txrdy);
 	}
-	if ((imra & MCHP_I2SMCC_INT_RXRDY_MASK(dev->channels)) &&
-	    (imra & MCHP_I2SMCC_INT_RXRDY_MASK(dev->channels)) ==
-	    (idra & MCHP_I2SMCC_INT_RXRDY_MASK(dev->channels))) {
+	if ((!dev->soc->has_fifo &&
+	     (imra & MCHP_I2SMCC_INT_RXRDY_MASK(dev->channels)) &&
+	     (imra & MCHP_I2SMCC_INT_RXRDY_MASK(dev->channels)) ==
+	     (idra & MCHP_I2SMCC_INT_RXRDY_MASK(dev->channels))) ||
+	    (dev->soc->has_fifo && imrb & MCHP_I2SMCC_INT_RXFFRDY)) {
 		dev->rx_rdy = 1;
 		wake_up_interruptible(&dev->wq_rxrdy);
 	}
-	regmap_write(dev->regmap, MCHP_I2SMCC_IDRA, idra);
+	if (dev->soc->has_fifo)
+		regmap_write(dev->regmap, MCHP_I2SMCC_IDRB, idrb);
+	else
+		regmap_write(dev->regmap, MCHP_I2SMCC_IDRA, idra);
 
 	return ret;
 }
@@ -664,6 +677,10 @@ static int mchp_i2s_mcc_hw_params(struct snd_pcm_substream *substream,
 		}
 	}
 
+	/* enable FIFO if available */
+	if (dev->soc->has_fifo)
+		mrb |= MCHP_I2SMCC_MRB_FIFOEN;
+
 	/*
 	 * If we are already running, the wanted setup must be
 	 * the same with the one that's currently ongoing
@@ -726,8 +743,13 @@ static int mchp_i2s_mcc_hw_free(struct snd_pcm_substream *substream,
 		if (err == 0) {
 			dev_warn_once(dev->dev,
 				      "Timeout waiting for Tx ready\n");
-			regmap_write(dev->regmap, MCHP_I2SMCC_IDRA,
-				     MCHP_I2SMCC_INT_TXRDY_MASK(dev->channels));
+			if (dev->soc->has_fifo)
+				regmap_write(dev->regmap, MCHP_I2SMCC_IDRB,
+					     MCHP_I2SMCC_INT_TXFFRDY);
+			else
+				regmap_write(dev->regmap, MCHP_I2SMCC_IDRA,
+					     MCHP_I2SMCC_INT_TXRDY_MASK(dev->channels));
+
 			dev->tx_rdy = 1;
 		}
 	} else {
@@ -737,8 +759,12 @@ static int mchp_i2s_mcc_hw_free(struct snd_pcm_substream *substream,
 		if (err == 0) {
 			dev_warn_once(dev->dev,
 				      "Timeout waiting for Rx ready\n");
-			regmap_write(dev->regmap, MCHP_I2SMCC_IDRA,
-				     MCHP_I2SMCC_INT_RXRDY_MASK(dev->channels));
+			if (dev->soc->has_fifo)
+				regmap_write(dev->regmap, MCHP_I2SMCC_IDRB,
+					     MCHP_I2SMCC_INT_RXFFRDY);
+			else
+				regmap_write(dev->regmap, MCHP_I2SMCC_IDRA,
+					     MCHP_I2SMCC_INT_RXRDY_MASK(dev->channels));
 			dev->rx_rdy = 1;
 		}
 	}
@@ -765,7 +791,7 @@ static int mchp_i2s_mcc_trigger(struct snd_pcm_substream *substream, int cmd,
 	struct mchp_i2s_mcc_dev *dev = snd_soc_dai_get_drvdata(dai);
 	bool is_playback = (substream->stream == SNDRV_PCM_STREAM_PLAYBACK);
 	u32 cr = 0;
-	u32 iera = 0;
+	u32 iera = 0, ierb = 0;
 	u32 sr;
 	int err;
 
@@ -789,7 +815,10 @@ static int mchp_i2s_mcc_trigger(struct snd_pcm_substream *substream, int cmd,
 			 * Enable Tx Ready interrupts on all channels
 			 * to assure all data is sent
 			 */
-			iera = MCHP_I2SMCC_INT_TXRDY_MASK(dev->channels);
+			if (dev->soc->has_fifo)
+				ierb = MCHP_I2SMCC_INT_TXFFRDY;
+			else
+				iera = MCHP_I2SMCC_INT_TXRDY_MASK(dev->channels);
 		} else if (!is_playback && (sr & MCHP_I2SMCC_SR_RXEN)) {
 			cr = MCHP_I2SMCC_CR_RXDIS;
 			dev->rx_rdy = 0;
@@ -797,7 +826,10 @@ static int mchp_i2s_mcc_trigger(struct snd_pcm_substream *substream, int cmd,
 			 * Enable Rx Ready interrupts on all channels
 			 * to assure all data is received
 			 */
-			iera = MCHP_I2SMCC_INT_RXRDY_MASK(dev->channels);
+			if (dev->soc->has_fifo)
+				ierb = MCHP_I2SMCC_INT_RXFFRDY;
+			else
+				iera = MCHP_I2SMCC_INT_RXRDY_MASK(dev->channels);
 		}
 		break;
 	default:
@@ -815,7 +847,10 @@ static int mchp_i2s_mcc_trigger(struct snd_pcm_substream *substream, int cmd,
 		}
 	}
 
-	regmap_write(dev->regmap, MCHP_I2SMCC_IERA, iera);
+	if (dev->soc->has_fifo)
+		regmap_write(dev->regmap, MCHP_I2SMCC_IERB, ierb);
+	else
+		regmap_write(dev->regmap, MCHP_I2SMCC_IERA, iera);
 	regmap_write(dev->regmap, MCHP_I2SMCC_CR, cr);
 
 	return 0;
@@ -903,6 +938,7 @@ static struct mchp_i2s_mcc_soc_data mchp_i2s_mcc_sam9x60 = {
 
 static struct mchp_i2s_mcc_soc_data mchp_i2s_mcc_sama7g5 = {
 	.data_pin_pair_num = 4,
+	.has_fifo = true,
 };
 
 static const struct of_device_id mchp_i2s_mcc_dt_ids[] = {
-- 
2.27.0

