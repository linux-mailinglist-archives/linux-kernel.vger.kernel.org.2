Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A6ED388C0D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 12:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346073AbhESKvl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 06:51:41 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:24476 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241368AbhESKvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 06:51:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1621421420; x=1652957420;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PjkM+cZ/rv8qW8Nuka2fZ+EwLgMDKLLm6kzp8U5W9ak=;
  b=H7/RgqjaHS1EBB/j+oQLv+SedmJdnzGS/Ic5/dRGwQzRbw4vJO7FQdFX
   zUdO3yNoRgguAAwqF6bukxmlTpeRJBt6Dz957t2TbrcUW+KPorlLMbm6h
   WieBaJYoQGRzTzyWbI8qpugQZwjaS/HBGqE29RBadmmg4vzm0UqD8ZuM9
   00HtaoYi8j6Z0C7WAvUz1KwBuOLawzsycDjB2a+x31ZLiD4aEYCBMvk+N
   AQ9NWOxeOGg73fp8d7dut3dCI4f0lKmtZN0waWl1Tt4v0HfdvQ1+pXfTg
   TzC3vEihIWY5yzs1SJ3Q8TnSCUl8waKYKFq/au5WnIEGZUkNHGyCprnUA
   g==;
IronPort-SDR: NuJdV+EzIlfX9fQY425aL8VwN0OzpnrZ/UXxXvFaJmu3LqrXiHCk5bAMr7YRqmR1bEB47YlF3M
 JHv6AC2NpeDtro379jk1OFiXYPxdnqNmYcN+hWArURW46QfnRDq84prNr9yPBAP4P6CtAsgaZP
 5mV1m6l0daItZqwFccUhjHr/g5g9hsKBLNKI/JzEpqs7EgzflRVldawu3Vi2Rz6kLKO34Zvwym
 n4xUvAiLHP+AgAvTQGSL1B3BBeN5sTHMMEyfk89Q0N62qmYwa1a1z1gm6HgNz/ZWNyRwGtHKfw
 07I=
X-IronPort-AV: E=Sophos;i="5.82,312,1613458800"; 
   d="scan'208";a="121616328"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 May 2021 03:50:19 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 19 May 2021 03:49:57 -0700
Received: from rob-ult-m19940.amer.actel.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Wed, 19 May 2021 03:49:53 -0700
From:   Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
To:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
CC:     <perex@perex.cz>, <tiwai@suse.com>,
        <pierre-louis.bossart@linux.intel.com>, <broonie@kernel.org>,
        <joe@perches.com>, <lgirdwood@gmail.com>, <lars@metafoo.de>,
        <kuninori.morimoto.gx@renesas.com>, <nicolas.ferre@microchip.com>,
        <Cristian.Birsan@microchip.com>,
        Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Subject: [RFC PATCH 5/6] ASoC: soc-pcm: Create new snd_pcm_runtime for BE DAIs
Date:   Wed, 19 May 2021 13:48:41 +0300
Message-ID: <20210519104842.977895-6-codrin.ciubotariu@microchip.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210519104842.977895-1-codrin.ciubotariu@microchip.com>
References: <20210519104842.977895-1-codrin.ciubotariu@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The BE DAIs are different than the FE DAIs. They have different HW
capabilities, different HW constraints and different HW parameters. Also,
the buffer used to read/write data from/to user-space to/from FE DAIs has
nothing to do with the BE DAIs. For this reason, this patch creates a new
snd_pcm_runtime for the BE DAIs. The new structure can be used to better
represent the HW capabilities, so the HW parameters are no longer copied
from the FE, but created separately. For BE DAIs that need a buffer to move
the data to/from the FE DAIs (no dev-to-dev DMA capability), the new
snd_pcm_runtime can store the needed parameters to allocate the buffer and
set the DMA transfers.

Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
---
 sound/soc/soc-pcm.c | 126 +++++++++++++++++++++++++++++++-------------
 1 file changed, 90 insertions(+), 36 deletions(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 8659089a87a0..7d95df20541e 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -1134,7 +1134,6 @@ static int dpcm_be_connect(struct snd_soc_pcm_runtime *fe,
 
 	dpcm->be = be;
 	dpcm->fe = fe;
-	be->dpcm[stream].runtime = fe->dpcm[stream].runtime;
 	dpcm->state = SND_SOC_DPCM_LINK_STATE_NEW;
 	spin_lock_irqsave(&fe->card->dpcm_lock, flags);
 	list_add(&dpcm->list_be, &fe->dpcm[stream].be_clients);
@@ -1150,34 +1149,6 @@ static int dpcm_be_connect(struct snd_soc_pcm_runtime *fe,
 	return 1;
 }
 
-/* reparent a BE onto another FE */
-static void dpcm_be_reparent(struct snd_soc_pcm_runtime *fe,
-			struct snd_soc_pcm_runtime *be, int stream)
-{
-	struct snd_soc_dpcm *dpcm;
-	struct snd_pcm_substream *fe_substream, *be_substream;
-
-	/* reparent if BE is connected to other FEs */
-	if (!be->dpcm[stream].users)
-		return;
-
-	be_substream = snd_soc_dpcm_get_substream(be, stream);
-
-	for_each_dpcm_fe(be, stream, dpcm) {
-		if (dpcm->fe == fe)
-			continue;
-
-		dev_dbg(fe->dev, "reparent %s path %s %s %s\n",
-			stream ? "capture" : "playback",
-			dpcm->fe->dai_link->name,
-			stream ? "<-" : "->", dpcm->be->dai_link->name);
-
-		fe_substream = snd_soc_dpcm_get_substream(dpcm->fe, stream);
-		be_substream->runtime = fe_substream->runtime;
-		break;
-	}
-}
-
 /* disconnect a BE and FE */
 void dpcm_be_disconnect(struct snd_soc_pcm_runtime *fe, int stream)
 {
@@ -1196,9 +1167,6 @@ void dpcm_be_disconnect(struct snd_soc_pcm_runtime *fe, int stream)
 			stream ? "capture" : "playback", fe->dai_link->name,
 			stream ? "<-" : "->", dpcm->be->dai_link->name);
 
-		/* BEs still alive need new FE */
-		dpcm_be_reparent(fe, dpcm->be, stream);
-
 		dpcm_remove_debugfs_state(dpcm);
 
 		spin_lock_irqsave(&fe->card->dpcm_lock, flags);
@@ -1468,7 +1436,12 @@ void dpcm_be_dai_stop(struct snd_soc_pcm_runtime *fe, int stream,
 		}
 
 		soc_pcm_close(be_substream);
-		be_substream->runtime = NULL;
+
+		if (be_substream->runtime) {
+			snd_pcm_runtime_free(be_substream->runtime);
+			be_substream->runtime = NULL;
+		}
+
 		be->dpcm[stream].state = SND_SOC_DPCM_STATE_CLOSE;
 	}
 }
@@ -1482,6 +1455,7 @@ int dpcm_be_dai_startup(struct snd_soc_pcm_runtime *fe, int stream)
 	/* only startup BE DAIs that are either sinks or sources to this FE DAI */
 	for_each_dpcm_be(fe, stream, dpcm) {
 		struct snd_pcm_substream *be_substream;
+		struct snd_pcm_runtime *runtime;
 
 		be = dpcm->be;
 		be_substream = snd_soc_dpcm_get_substream(be, stream);
@@ -1514,7 +1488,23 @@ int dpcm_be_dai_startup(struct snd_soc_pcm_runtime *fe, int stream)
 		dev_dbg(be->dev, "ASoC: open %s BE %s\n",
 			stream ? "capture" : "playback", be->dai_link->name);
 
-		be_substream->runtime = be->dpcm[stream].runtime;
+		runtime = snd_pcm_runtime_alloc();
+		if (!runtime) {
+			err = -ENOMEM;
+			goto unwind;
+		}
+
+		be_substream->runtime = runtime;
+
+		/* initialize the BE constraints */
+		err = snd_pcm_hw_constraints_init(be_substream);
+		if (err < 0) {
+			dev_err(be->dev,
+				"dpcm_be_hw_constraints_init failed: %d\n",
+				err);
+			goto unwind;
+		}
+
 		err = soc_pcm_open(be_substream);
 		if (err < 0) {
 			be->dpcm[stream].users--;
@@ -1527,6 +1517,14 @@ int dpcm_be_dai_startup(struct snd_soc_pcm_runtime *fe, int stream)
 			goto unwind;
 		}
 
+		err = snd_pcm_hw_constraints_complete(be_substream);
+		if (err < 0) {
+			dev_err(fe->dev,
+				"snd_pcm_hw_constraints_complete failed: %d\n",
+				err);
+			goto unwind;
+		}
+
 		be->dpcm[stream].state = SND_SOC_DPCM_STATE_OPEN;
 		count++;
 	}
@@ -1897,6 +1895,14 @@ int dpcm_be_dai_hw_params(struct snd_soc_pcm_runtime *fe, int stream)
 		if (ret < 0)
 			goto unwind;
 
+		/* apply constrains */
+		dpcm->hw_params.rmask = ~0U;
+		ret = snd_pcm_hw_refine(be_substream, &dpcm->hw_params);
+		if (ret < 0) {
+			dev_err(fe->dev, "failed to refine hw parameters: %d\n", ret);
+			goto unwind;
+		}
+
 		/* copy the fixed-up hw params for BE dai */
 		memcpy(&be->dpcm[stream].hw_params, &dpcm->hw_params,
 		       sizeof(struct snd_pcm_hw_params));
@@ -1918,6 +1924,7 @@ int dpcm_be_dai_hw_params(struct snd_soc_pcm_runtime *fe, int stream)
 			goto unwind;
 
 		be->dpcm[stream].state = SND_SOC_DPCM_STATE_HW_PARAMS;
+		snd_pcm_runtime_set(be_substream, &dpcm->hw_params);
 	}
 	return 0;
 
@@ -1949,17 +1956,64 @@ int dpcm_be_dai_hw_params(struct snd_soc_pcm_runtime *fe, int stream)
 	return ret;
 }
 
+static int dpcm_be_dai_hw_params_init(struct snd_soc_pcm_runtime *fe, int stream)
+{
+	struct snd_pcm_hw_params *params = &fe->dpcm[stream].hw_params;
+	int k;
+
+	for (k = SNDRV_PCM_HW_PARAM_FIRST_MASK;
+	     k <= SNDRV_PCM_HW_PARAM_LAST_MASK; k++)
+		snd_mask_any(hw_param_mask(params, k));
+
+	for (k = SNDRV_PCM_HW_PARAM_FIRST_INTERVAL;
+	     k <= SNDRV_PCM_HW_PARAM_LAST_INTERVAL; k++)
+		snd_interval_any(hw_param_interval(params, k));
+
+	return 0;
+}
+
 static int dpcm_fe_dai_hw_params(struct snd_pcm_substream *substream,
 				 struct snd_pcm_hw_params *params)
 {
 	struct snd_soc_pcm_runtime *fe = asoc_substream_to_rtd(substream);
 	int ret, stream = substream->stream;
+	struct snd_interval *t, *dpcm_t;
 
 	mutex_lock_nested(&fe->card->mutex, SND_SOC_CARD_CLASS_RUNTIME);
 	dpcm_set_fe_update_state(fe, stream, SND_SOC_DPCM_UPDATE_FE);
 
-	memcpy(&fe->dpcm[stream].hw_params, params,
-			sizeof(struct snd_pcm_hw_params));
+	/* initialize the BE HW params */
+	dpcm_be_dai_hw_params_init(fe, stream);
+
+	/* FIXME: a very low period time will make the CPU take too many
+	 * interrupts, which might end up not having enough time to actually
+	 * fill the buffer(s); for now, the BE min period time will be half of
+	 * the FE min period time
+	 */
+	t = hw_param_interval(params, SNDRV_PCM_HW_PARAM_PERIOD_TIME);
+	dpcm_t = hw_param_interval(&fe->dpcm[stream].hw_params,
+				   SNDRV_PCM_HW_PARAM_PERIOD_TIME);
+	dpcm_t->min = t->min / 2;
+
+	if (fe->dai_link->dpcm_merged_format) {
+		memcpy(hw_param_interval(&fe->dpcm[stream].hw_params,
+					 SNDRV_PCM_HW_PARAM_FORMAT),
+		       hw_param_interval(params, SNDRV_PCM_HW_PARAM_FORMAT),
+		       sizeof(struct snd_interval));
+	}
+	if (fe->dai_link->dpcm_merged_chan) {
+		memcpy(hw_param_interval(&fe->dpcm[stream].hw_params,
+					 SNDRV_PCM_HW_PARAM_CHANNELS),
+		       hw_param_interval(params, SNDRV_PCM_HW_PARAM_CHANNELS),
+		       sizeof(struct snd_interval));
+	}
+	if (fe->dai_link->dpcm_merged_rate) {
+		memcpy(hw_param_interval(&fe->dpcm[stream].hw_params,
+					 SNDRV_PCM_HW_PARAM_RATE),
+		       hw_param_interval(params, SNDRV_PCM_HW_PARAM_RATE),
+		       sizeof(struct snd_interval));
+	}
+
 	ret = dpcm_be_dai_hw_params(fe, stream);
 	if (ret < 0)
 		goto out;
-- 
2.27.0

