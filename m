Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 516A5345D3A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 12:44:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbhCWLoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 07:44:23 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:32995 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbhCWLn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 07:43:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1616499839; x=1648035839;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HUy9SuzJ1x+SoyTBE/9oxiQt7Vd1okainUo64cODfVY=;
  b=vTsw5KiyY58F5iaahNW7GgMyEdTtCqYpWXtQs0Cxm7l2GnwrfndQhkRW
   CAncqjR6J8wkXFDEJ0xc8+ZElJyNp/YmC3o5QVtfA6C7tED55jlapvRlT
   hXs/XYLEt1ICA7E2M1RGCj/2PF8UQ0YNeA6CPWDVdkKoaaDnAv7gM/Zvs
   +MHhLiBPEn/sKnHl2itpuYbvIVyMWDblahPzBBx2ugxidlb7AT3T9rmHK
   VDoQe+9chsT7ma03Pu5zp8JYzOVG/7NM2bngwIaM6KTw2zH+E9WGzT/M0
   dmxFc0on/avKZhRNDbFazEdENjiA8maTkR3itLxYRnP/WOhOk/tEMb5hD
   Q==;
IronPort-SDR: MVAniebYcvsWxLwTvxXjqZa7Y1SrowUrybCZbN1JE+JZylWTioWDMb7DcOp2Tbyw1Lw1Wrb/ls
 HIBgtV84aLofnnTktzSur++2ycD/O6dEoHiFvNYxZw0wKLoG12O9wPwIBlqZS1+Bt6VDA43rmn
 6eiSFNFYFK77CnLOWVt0OgJIwjyb7mPOCokgutRLRmg92XqU4wMCP0jlnyrrtmJDeCRVbeY1uU
 xTMTDadkw5H0wOKdBfscchq+xkJ6mGGgrIQ4dCp7r50TEmp3EvexQyFwb1C35WSsdR5SqxNlib
 EU8=
X-IronPort-AV: E=Sophos;i="5.81,271,1610434800"; 
   d="scan'208";a="111004697"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Mar 2021 04:43:59 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 23 Mar 2021 04:43:58 -0700
Received: from rob-ult-m19940.amer.actel.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Tue, 23 Mar 2021 04:43:55 -0700
From:   Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
To:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
CC:     <perex@perex.cz>, <tiwai@suse.com>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <mirq-linux@rere.qmqm.pl>,
        <gustavoars@kernel.org>,
        Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Subject: [RFC PATCH 3/3] ASoC: soc-pcm: apply BE HW constraint rules
Date:   Tue, 23 Mar 2021 13:43:27 +0200
Message-ID: <20210323114327.3969072-4-codrin.ciubotariu@microchip.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210323114327.3969072-1-codrin.ciubotariu@microchip.com>
References: <20210323114327.3969072-1-codrin.ciubotariu@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Apply the HW constraint rules added by the BE DAIs. The constraint rules
are applied after the fixup is called for the HW parameters. This way, if
the HW parameters do not correspond with the HW capabilities, the
constraint rules will return an error. The mask and the interval
constraints are the same as the ones used for FE. The DAI link
dpcm_merged_* flags are used to check if the FE and BE must share the same
HW parameters.

Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
---
 include/sound/pcm.h     |  2 ++
 sound/core/pcm_native.c | 17 +++++++++++++----
 sound/soc/soc-pcm.c     | 30 ++++++++++++++++++++++++++++++
 3 files changed, 45 insertions(+), 4 deletions(-)

diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index 198d37d04d78..b56a4435439a 100644
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -987,6 +987,8 @@ int snd_pcm_hw_rule_div(struct snd_pcm_hw_params *params,
 			struct snd_pcm_hw_rule *rule);
 
 int snd_pcm_hw_refine(struct snd_pcm_substream *substream, struct snd_pcm_hw_params *params);
+int constrain_params_by_rules(struct snd_pcm_substream *substream,
+			      struct snd_pcm_hw_params *params);
 
 int snd_pcm_hw_constraint_mask64(struct snd_pcm_runtime *runtime, snd_pcm_hw_param_t var,
 				 u_int64_t mask);
diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index d6f14162bce5..2ff6e182c7f5 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -22,6 +22,7 @@
 #include <sound/pcm_params.h>
 #include <sound/timer.h>
 #include <sound/minors.h>
+#include <sound/soc.h>
 #include <linux/uio.h>
 #include <linux/delay.h>
 
@@ -326,11 +327,10 @@ static int constrain_interval_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static int constrain_params_by_rules(struct snd_pcm_substream *substream,
-				     struct snd_pcm_hw_params *params)
+int constrain_params_by_rules(struct snd_pcm_substream *substream,
+			      struct snd_pcm_hw_params *params)
 {
-	struct snd_pcm_hw_constraints *constrs =
-					&substream->runtime->hw_constraints;
+	struct snd_pcm_hw_constraints *constrs;
 	unsigned int k;
 	unsigned int *rstamps;
 	unsigned int vstamps[SNDRV_PCM_HW_PARAM_LAST_INTERVAL + 1];
@@ -342,6 +342,14 @@ static int constrain_params_by_rules(struct snd_pcm_substream *substream,
 	bool again;
 	int changed, err = 0;
 
+	if (substream->pcm->internal) {
+		struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
+
+		constrs = &rtd->dpcm[substream->stream].hw_constraints;
+	} else {
+		constrs = &substream->runtime->hw_constraints;
+	}
+
 	/*
 	 * Each application of rule has own sequence number.
 	 *
@@ -446,6 +454,7 @@ static int constrain_params_by_rules(struct snd_pcm_substream *substream,
 	kfree(rstamps);
 	return err;
 }
+EXPORT_SYMBOL(constrain_params_by_rules);
 
 static int fixup_unreferenced_params(struct snd_pcm_substream *substream,
 				     struct snd_pcm_hw_params *params)
diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index dae246918e0d..5bd71d48c0de 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -1934,11 +1934,25 @@ int dpcm_be_dai_hw_params(struct snd_soc_pcm_runtime *fe, int stream)
 		memcpy(&dpcm->hw_params, &fe->dpcm[stream].hw_params,
 				sizeof(struct snd_pcm_hw_params));
 
+		/* copy FE mask and interval constraints */
+		memcpy(&be->dpcm[stream].hw_constraints.masks,
+		       &be_substream->runtime->hw_constraints.masks,
+		       sizeof(be_substream->runtime->hw_constraints.masks));
+		memcpy(&be->dpcm[stream].hw_constraints.intervals,
+		       &be_substream->runtime->hw_constraints.intervals,
+		       sizeof(be_substream->runtime->hw_constraints.intervals));
+
 		/* perform any hw_params fixups */
 		ret = snd_soc_link_be_hw_params_fixup(be, &dpcm->hw_params);
 		if (ret < 0)
 			goto unwind;
 
+		/* apply constrain rules */
+		dpcm->hw_params.rmask = ~0U;
+		ret = constrain_params_by_rules(be_substream, &dpcm->hw_params);
+		if (ret < 0)
+			goto unwind;
+
 		/* copy the fixed-up hw params for BE dai */
 		memcpy(&be->dpcm[stream].hw_params, &dpcm->hw_params,
 		       sizeof(struct snd_pcm_hw_params));
@@ -2002,6 +2016,22 @@ static int dpcm_fe_dai_hw_params(struct snd_pcm_substream *substream,
 
 	memcpy(&fe->dpcm[stream].hw_params, params,
 			sizeof(struct snd_pcm_hw_params));
+	if (!fe->dai_link->dpcm_merged_format) {
+		snd_mask_any(hw_param_mask(&fe->dpcm[stream].hw_params,
+					   SNDRV_PCM_HW_PARAM_FORMAT));
+		snd_interval_any(hw_param_interval(&fe->dpcm[stream].hw_params,
+						   SNDRV_PCM_HW_PARAM_SAMPLE_BITS));
+		snd_interval_any(hw_param_interval(&fe->dpcm[stream].hw_params,
+						   SNDRV_PCM_HW_PARAM_FRAME_BITS));
+	}
+	if (!fe->dai_link->dpcm_merged_chan) {
+		snd_interval_any(hw_param_interval(&fe->dpcm[stream].hw_params,
+						   SNDRV_PCM_HW_PARAM_CHANNELS));
+	}
+	if (!fe->dai_link->dpcm_merged_rate) {
+		snd_interval_any(hw_param_interval(&fe->dpcm[stream].hw_params,
+						   SNDRV_PCM_HW_PARAM_RATE));
+	}
 	ret = dpcm_be_dai_hw_params(fe, stream);
 	if (ret < 0)
 		goto out;
-- 
2.27.0

