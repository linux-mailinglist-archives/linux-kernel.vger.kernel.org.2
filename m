Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D593042C355
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 16:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237909AbhJMOfF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 10:35:05 -0400
Received: from mga12.intel.com ([192.55.52.136]:5099 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237036AbhJMOdo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 10:33:44 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10135"; a="207554891"
X-IronPort-AV: E=Sophos;i="5.85,371,1624345200"; 
   d="scan'208";a="207554891"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2021 07:31:27 -0700
X-IronPort-AV: E=Sophos;i="5.85,371,1624345200"; 
   d="scan'208";a="524649596"
Received: from ssafavib-mobl.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.209.164.198])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2021 07:31:25 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org,
        Sameer Pujar <spujar@nvidia.com>,
        Gyeongtaek Lee <gt82.lee@samsung.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [RFC PATCH v3 11/13] ASoC: soc-pcm: serialize BE triggers
Date:   Wed, 13 Oct 2021 09:30:48 -0500
Message-Id: <20211013143050.244444-12-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211013143050.244444-1-pierre-louis.bossart@linux.intel.com>
References: <20211013143050.244444-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When more than one FE is connected to a BE, e.g. in a mixing use case,
the BE can be triggered multiple times when the FE are opened/started
concurrently. This race condition is problematic in the case of
SoundWire BE dailinks, and this is not desirable in a general
case.

This patch relies on the existing BE PCM lock, which takes atomicity into
account. The locking model assumes that all interactions start with
the FE, so that there is no deadlock between FE and BE locks.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/soc-pcm.c | 49 +++++++++++++++++++++++++++------------------
 1 file changed, 30 insertions(+), 19 deletions(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 5f2368059e14..d115e9409c14 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -41,6 +41,12 @@ void snd_soc_dpcm_fe_unlock_irq(struct snd_soc_pcm_runtime *fe, int stream)
 }
 EXPORT_SYMBOL_GPL(snd_soc_dpcm_fe_unlock_irq);
 
+#define snd_soc_dpcm_be_lock_irqsave(be, stream, flags) \
+	snd_pcm_stream_lock_irqsave(snd_soc_dpcm_get_substream(be, stream), flags)
+
+#define snd_soc_dpcm_be_unlock_irqrestore(be, stream, flags) \
+	snd_pcm_stream_unlock_irqrestore(snd_soc_dpcm_get_substream(be, stream), flags)
+
 /* can this BE stop and free */
 static int snd_soc_dpcm_can_be_free_stop_locked(struct snd_soc_pcm_runtime *fe,
 						struct snd_soc_pcm_runtime *be, int stream);
@@ -2071,6 +2077,7 @@ int dpcm_be_dai_trigger(struct snd_soc_pcm_runtime *fe, int stream,
 {
 	struct snd_soc_pcm_runtime *be;
 	struct snd_soc_dpcm *dpcm;
+	unsigned long flags;
 	int ret = 0;
 
 	for_each_dpcm_be(fe, stream, dpcm) {
@@ -2086,85 +2093,89 @@ int dpcm_be_dai_trigger(struct snd_soc_pcm_runtime *fe, int stream,
 		dev_dbg(be->dev, "ASoC: trigger BE %s cmd %d\n",
 			be->dai_link->name, cmd);
 
+		snd_soc_dpcm_be_lock_irqsave(be, stream, flags);
 		switch (cmd) {
 		case SNDRV_PCM_TRIGGER_START:
 			if ((be->dpcm[stream].state != SND_SOC_DPCM_STATE_PREPARE) &&
 			    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_STOP) &&
 			    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_PAUSED))
-				continue;
+				goto unlock_be;
 
 			ret = soc_pcm_trigger(be_substream, cmd);
 			if (ret)
-				goto end;
+				goto unlock_be;
 
 			be->dpcm[stream].state = SND_SOC_DPCM_STATE_START;
 			break;
 		case SNDRV_PCM_TRIGGER_RESUME:
 			if ((be->dpcm[stream].state != SND_SOC_DPCM_STATE_SUSPEND))
-				continue;
+				goto unlock_be;
 
 			ret = soc_pcm_trigger(be_substream, cmd);
 			if (ret)
-				goto end;
+				goto unlock_be;
 
 			be->dpcm[stream].state = SND_SOC_DPCM_STATE_START;
 			break;
 		case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
 			if ((be->dpcm[stream].state != SND_SOC_DPCM_STATE_PAUSED))
-				continue;
+				goto unlock_be;
 
 			ret = soc_pcm_trigger(be_substream, cmd);
 			if (ret)
-				goto end;
+				goto unlock_be;
 
 			be->dpcm[stream].state = SND_SOC_DPCM_STATE_START;
 			break;
 		case SNDRV_PCM_TRIGGER_STOP:
 			if ((be->dpcm[stream].state != SND_SOC_DPCM_STATE_START) &&
 			    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_PAUSED))
-				continue;
+				goto unlock_be;
 
 			if (!snd_soc_dpcm_can_be_free_stop_locked(fe, be, stream))
-				continue;
+				goto unlock_be;
 
 			ret = soc_pcm_trigger(be_substream, cmd);
 			if (ret)
-				goto end;
+				goto unlock_be;
 
 			be->dpcm[stream].state = SND_SOC_DPCM_STATE_STOP;
 			break;
 		case SNDRV_PCM_TRIGGER_SUSPEND:
 			if (be->dpcm[stream].state != SND_SOC_DPCM_STATE_START)
-				continue;
+				goto unlock_be;
 
 			if (!snd_soc_dpcm_can_be_free_stop_locked(fe, be, stream))
-				continue;
+				goto unlock_be;
 
 			ret = soc_pcm_trigger(be_substream, cmd);
 			if (ret)
-				goto end;
+				goto unlock_be;
 
 			be->dpcm[stream].state = SND_SOC_DPCM_STATE_SUSPEND;
 			break;
 		case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
 			if (be->dpcm[stream].state != SND_SOC_DPCM_STATE_START)
-				continue;
+				goto unlock_be;
 
 			if (!snd_soc_dpcm_can_be_free_stop_locked(fe, be, stream))
-				continue;
+				goto unlock_be;
 
 			ret = soc_pcm_trigger(be_substream, cmd);
 			if (ret)
-				goto end;
+				goto unlock_be;
 
 			be->dpcm[stream].state = SND_SOC_DPCM_STATE_PAUSED;
 			break;
 		}
+unlock_be:
+		snd_soc_dpcm_be_unlock_irqrestore(be, stream, flags);
+		if (ret < 0) {
+			dev_err(fe->dev, "ASoC: %s() failed at %s (%d)\n",
+				__func__, be->dai_link->name, ret);
+			break;
+		}
 	}
-end:
-	if (ret < 0)
-		dev_err(fe->dev, "ASoC: %s() failed at %s (%d)\n",
-			__func__, be->dai_link->name, ret);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(dpcm_be_dai_trigger);
-- 
2.25.1

