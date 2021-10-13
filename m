Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF2E42C341
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 16:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236491AbhJMOeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 10:34:09 -0400
Received: from mga12.intel.com ([192.55.52.136]:5091 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236961AbhJMOdm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 10:33:42 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10135"; a="207554847"
X-IronPort-AV: E=Sophos;i="5.85,371,1624345200"; 
   d="scan'208";a="207554847"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2021 07:31:15 -0700
X-IronPort-AV: E=Sophos;i="5.85,371,1624345200"; 
   d="scan'208";a="524649529"
Received: from ssafavib-mobl.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.209.164.198])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2021 07:31:14 -0700
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
Subject: [RFC PATCH v3 06/13] ASoC: soc-pcm: remove dpcm spin_lock, use PCM stream lock
Date:   Wed, 13 Oct 2021 09:30:43 -0500
Message-Id: <20211013143050.244444-7-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211013143050.244444-1-pierre-louis.bossart@linux.intel.com>
References: <20211013143050.244444-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need for a DPCM-specific lock at the card level, we can
use the FE-specific PCM lock instead. In addition, these PCM locks will
rely on either a spin-lock or a mutex depending on atomicity.

Since the FE PCM lock is already taken during the trigger, new
_locked versions of the helpers snd_soc_dpcm_can_be_free_stop() and
snd_soc_dpcm_check_state() are introduced. Without these changes a
conceptual deadlock happens on TRIGGER_STOP.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 include/sound/soc.h  |  2 --
 sound/soc/soc-core.c |  1 -
 sound/soc/soc-pcm.c  | 55 +++++++++++++++++++++++++++++++++++---------
 3 files changed, 44 insertions(+), 14 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 8e6dd8a257c5..5872a8864f3b 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -893,8 +893,6 @@ struct snd_soc_card {
 	struct mutex pcm_mutex;
 	enum snd_soc_pcm_subclass pcm_subclass;
 
-	spinlock_t dpcm_lock;
-
 	int (*probe)(struct snd_soc_card *card);
 	int (*late_probe)(struct snd_soc_card *card);
 	int (*remove)(struct snd_soc_card *card);
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 80ca260595fd..b029e07ad1e1 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2339,7 +2339,6 @@ int snd_soc_register_card(struct snd_soc_card *card)
 	mutex_init(&card->mutex);
 	mutex_init(&card->dapm_mutex);
 	mutex_init(&card->pcm_mutex);
-	spin_lock_init(&card->dpcm_lock);
 
 	return snd_soc_bind_card(card);
 }
diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index f22bbf95319d..797f0d114c83 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -31,13 +31,13 @@
 
 void snd_soc_dpcm_fe_lock_irq(struct snd_soc_pcm_runtime *fe, int stream)
 {
-	spin_lock_irq(&fe->card->dpcm_lock);
+	snd_pcm_stream_lock_irq(snd_soc_dpcm_get_substream(fe, stream));
 }
 EXPORT_SYMBOL_GPL(snd_soc_dpcm_fe_lock_irq);
 
 void snd_soc_dpcm_fe_unlock_irq(struct snd_soc_pcm_runtime *fe, int stream)
 {
-	spin_unlock_irq(&fe->card->dpcm_lock);
+	snd_pcm_stream_unlock_irq(snd_soc_dpcm_get_substream(fe, stream));
 }
 EXPORT_SYMBOL_GPL(snd_soc_dpcm_fe_unlock_irq);
 
@@ -45,6 +45,9 @@ EXPORT_SYMBOL_GPL(snd_soc_dpcm_fe_unlock_irq);
 static int snd_soc_dpcm_can_be_free_stop(struct snd_soc_pcm_runtime *fe,
 					 struct snd_soc_pcm_runtime *be, int stream);
 
+static int snd_soc_dpcm_can_be_free_stop_locked(struct snd_soc_pcm_runtime *fe,
+						struct snd_soc_pcm_runtime *be, int stream);
+
 /* can this BE perform a hw_params() */
 static int snd_soc_dpcm_can_be_params(struct snd_soc_pcm_runtime *fe,
 				      struct snd_soc_pcm_runtime *be, int stream);
@@ -2101,7 +2104,7 @@ int dpcm_be_dai_trigger(struct snd_soc_pcm_runtime *fe, int stream,
 			    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_PAUSED))
 				continue;
 
-			if (!snd_soc_dpcm_can_be_free_stop(fe, be, stream))
+			if (!snd_soc_dpcm_can_be_free_stop_locked(fe, be, stream))
 				continue;
 
 			ret = soc_pcm_trigger(be_substream, cmd);
@@ -2114,7 +2117,7 @@ int dpcm_be_dai_trigger(struct snd_soc_pcm_runtime *fe, int stream,
 			if (be->dpcm[stream].state != SND_SOC_DPCM_STATE_START)
 				continue;
 
-			if (!snd_soc_dpcm_can_be_free_stop(fe, be, stream))
+			if (!snd_soc_dpcm_can_be_free_stop_locked(fe, be, stream))
 				continue;
 
 			ret = soc_pcm_trigger(be_substream, cmd);
@@ -2127,7 +2130,7 @@ int dpcm_be_dai_trigger(struct snd_soc_pcm_runtime *fe, int stream,
 			if (be->dpcm[stream].state != SND_SOC_DPCM_STATE_START)
 				continue;
 
-			if (!snd_soc_dpcm_can_be_free_stop(fe, be, stream))
+			if (!snd_soc_dpcm_can_be_free_stop_locked(fe, be, stream))
 				continue;
 
 			ret = soc_pcm_trigger(be_substream, cmd);
@@ -2873,18 +2876,17 @@ struct snd_pcm_substream *
 }
 EXPORT_SYMBOL_GPL(snd_soc_dpcm_get_substream);
 
-static int snd_soc_dpcm_check_state(struct snd_soc_pcm_runtime *fe,
-				    struct snd_soc_pcm_runtime *be,
-				    int stream,
-				    const enum snd_soc_dpcm_state *states,
-				    int num_states)
+static int snd_soc_dpcm_check_state_locked(struct snd_soc_pcm_runtime *fe,
+					   struct snd_soc_pcm_runtime *be,
+					   int stream,
+					   const enum snd_soc_dpcm_state *states,
+					   int num_states)
 {
 	struct snd_soc_dpcm *dpcm;
 	int state;
 	int ret = 1;
 	int i;
 
-	snd_soc_dpcm_fe_lock_irq(fe, stream);
 	for_each_dpcm_fe(be, stream, dpcm) {
 
 		if (dpcm->fe == fe)
@@ -2898,12 +2900,43 @@ static int snd_soc_dpcm_check_state(struct snd_soc_pcm_runtime *fe,
 			}
 		}
 	}
+
+	/* it's safe to do this BE DAI */
+	return ret;
+}
+
+static int snd_soc_dpcm_check_state(struct snd_soc_pcm_runtime *fe,
+				    struct snd_soc_pcm_runtime *be,
+				    int stream,
+				    const enum snd_soc_dpcm_state *states,
+				    int num_states)
+{
+	int ret;
+
+	snd_soc_dpcm_fe_lock_irq(fe, stream);
+	ret = snd_soc_dpcm_check_state_locked(fe, be, stream, states, num_states);
 	snd_soc_dpcm_fe_unlock_irq(fe, stream);
 
 	/* it's safe to do this BE DAI */
 	return ret;
 }
 
+/*
+ * We can only hw_free, stop, pause or suspend a BE DAI if any of it's FE
+ * are not running, paused or suspended for the specified stream direction.
+ */
+static int snd_soc_dpcm_can_be_free_stop_locked(struct snd_soc_pcm_runtime *fe,
+		struct snd_soc_pcm_runtime *be, int stream)
+{
+	const enum snd_soc_dpcm_state state[] = {
+		SND_SOC_DPCM_STATE_START,
+		SND_SOC_DPCM_STATE_PAUSED,
+		SND_SOC_DPCM_STATE_SUSPEND,
+	};
+
+	return snd_soc_dpcm_check_state_locked(fe, be, stream, state, ARRAY_SIZE(state));
+}
+
 /*
  * We can only hw_free, stop, pause or suspend a BE DAI if any of it's FE
  * are not running, paused or suspended for the specified stream direction.
-- 
2.25.1

