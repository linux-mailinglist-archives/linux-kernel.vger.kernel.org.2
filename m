Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A0073EF04F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 18:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbhHQQlv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 12:41:51 -0400
Received: from mga06.intel.com ([134.134.136.31]:38258 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229991AbhHQQlu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 12:41:50 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10079"; a="277170639"
X-IronPort-AV: E=Sophos;i="5.84,329,1620716400"; 
   d="scan'208";a="277170639"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2021 09:41:16 -0700
X-IronPort-AV: E=Sophos;i="5.84,329,1620716400"; 
   d="scan'208";a="449342732"
Received: from aaadelek-mobl3.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.212.12.89])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2021 09:41:15 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org,
        liam.r.girdwood@linux.intel.com,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [RFC PATCH 2/2] ASoC: soc-pcm: test refcount before triggering
Date:   Tue, 17 Aug 2021 11:40:54 -0500
Message-Id: <20210817164054.250028-3-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210817164054.250028-1-pierre-louis.bossart@linux.intel.com>
References: <20210817164054.250028-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On start/pause_release/resume, when more than one FE is connected to
the same BE, it's possible that the trigger is sent more than
once. This is not desirable, we only want to trigger a BE once, which
is straightforward to implement with a refcount.

For stop/pause/suspend, the problem is more complicated: the check
implemented in snd_soc_dpcm_can_be_free_stop() may fail due to a
conceptual deadlock when we trigger the BE before the FE. In this
case, the FE states have not yet changed, so there are corner cases
where the TRIGGER_STOP is never sent - the dual case of start where
multiple triggers might be sent.

This patch suggests an unconditional trigger in all cases, without
checking the FE states, using a refcount protected by a spinlock.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 include/sound/soc-dpcm.h |  2 ++
 sound/soc/soc-pcm.c      | 46 ++++++++++++++++++++++++++++++++++++----
 2 files changed, 44 insertions(+), 4 deletions(-)

diff --git a/include/sound/soc-dpcm.h b/include/sound/soc-dpcm.h
index e296a3949b18..6cc751002da7 100644
--- a/include/sound/soc-dpcm.h
+++ b/include/sound/soc-dpcm.h
@@ -101,6 +101,8 @@ struct snd_soc_dpcm_runtime {
 	enum snd_soc_dpcm_state state;
 
 	int trigger_pending; /* trigger cmd + 1 if pending, 0 if not */
+
+	int be_start; /* refcount protected by dpcm_lock */
 };
 
 #define for_each_dpcm_fe(be, stream, _dpcm)				\
diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 0717f39d2eec..b2440f2f9bf5 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -1534,7 +1534,7 @@ int dpcm_be_dai_startup(struct snd_soc_pcm_runtime *fe, int stream)
 			be->dpcm[stream].state = SND_SOC_DPCM_STATE_CLOSE;
 			goto unwind;
 		}
-
+		be->dpcm[stream].be_start = 0;
 		be->dpcm[stream].state = SND_SOC_DPCM_STATE_OPEN;
 		count++;
 	}
@@ -2001,6 +2001,7 @@ int dpcm_be_dai_trigger(struct snd_soc_pcm_runtime *fe, int stream,
 	int ret = 0;
 	unsigned long flags;
 	enum snd_soc_dpcm_state state;
+	bool do_trigger;
 
 	for_each_dpcm_be(fe, stream, dpcm) {
 		struct snd_pcm_substream *be_substream;
@@ -2015,6 +2016,7 @@ int dpcm_be_dai_trigger(struct snd_soc_pcm_runtime *fe, int stream,
 		dev_dbg(be->dev, "ASoC: trigger BE %s cmd %d\n",
 			be->dai_link->name, cmd);
 
+		do_trigger = false;
 		switch (cmd) {
 		case SNDRV_PCM_TRIGGER_START:
 			spin_lock_irqsave(&fe->card->dpcm_lock, flags);
@@ -2025,13 +2027,20 @@ int dpcm_be_dai_trigger(struct snd_soc_pcm_runtime *fe, int stream,
 				continue;
 			}
 			state = be->dpcm[stream].state;
+			if (be->dpcm[stream].be_start == 0)
+				do_trigger = true;
+			be->dpcm[stream].be_start++;
 			be->dpcm[stream].state = SND_SOC_DPCM_STATE_START;
 			spin_unlock_irqrestore(&fe->card->dpcm_lock, flags);
 
+			if (!do_trigger)
+				continue;
+
 			ret = soc_pcm_trigger(be_substream, cmd);
 			if (ret) {
 				spin_lock_irqsave(&fe->card->dpcm_lock, flags);
 				be->dpcm[stream].state = state;
+				be->dpcm[stream].be_start--;
 				spin_unlock_irqrestore(&fe->card->dpcm_lock, flags);
 				goto end;
 			}
@@ -2045,13 +2054,20 @@ int dpcm_be_dai_trigger(struct snd_soc_pcm_runtime *fe, int stream,
 			}
 
 			state = be->dpcm[stream].state;
+			if (be->dpcm[stream].be_start == 0)
+				do_trigger = true;
+			be->dpcm[stream].be_start++;
 			be->dpcm[stream].state = SND_SOC_DPCM_STATE_START;
 			spin_unlock_irqrestore(&fe->card->dpcm_lock, flags);
 
+			if (!do_trigger)
+				continue;
+
 			ret = soc_pcm_trigger(be_substream, cmd);
 			if (ret) {
 				spin_lock_irqsave(&fe->card->dpcm_lock, flags);
 				be->dpcm[stream].state = state;
+				be->dpcm[stream].be_start--;
 				spin_unlock_irqrestore(&fe->card->dpcm_lock, flags);
 				goto end;
 			}
@@ -2065,13 +2081,20 @@ int dpcm_be_dai_trigger(struct snd_soc_pcm_runtime *fe, int stream,
 			}
 
 			state = be->dpcm[stream].state;
+			if (be->dpcm[stream].be_start == 0)
+				do_trigger = true;
+			be->dpcm[stream].be_start++;
 			be->dpcm[stream].state = SND_SOC_DPCM_STATE_START;
 			spin_unlock_irqrestore(&fe->card->dpcm_lock, flags);
 
+			if (!do_trigger)
+				continue;
+
 			ret = soc_pcm_trigger(be_substream, cmd);
 			if (ret) {
 				spin_lock_irqsave(&fe->card->dpcm_lock, flags);
 				be->dpcm[stream].state = state;
+				be->dpcm[stream].be_start--;
 				spin_unlock_irqrestore(&fe->card->dpcm_lock, flags);
 				goto end;
 			}
@@ -2084,9 +2107,15 @@ int dpcm_be_dai_trigger(struct snd_soc_pcm_runtime *fe, int stream,
 				spin_unlock_irqrestore(&fe->card->dpcm_lock, flags);
 				continue;
 			}
+			if ((be->dpcm[stream].state == SND_SOC_DPCM_STATE_START &&
+			     be->dpcm[stream].be_start == 1) ||
+			    (be->dpcm[stream].state == SND_SOC_DPCM_STATE_PAUSED &&
+			     be->dpcm[stream].be_start == 0))
+				do_trigger = true;
+			be->dpcm[stream].be_start--;
 			spin_unlock_irqrestore(&fe->card->dpcm_lock, flags);
 
-			if (!snd_soc_dpcm_can_be_free_stop(fe, be, stream))
+			if (!do_trigger)
 				continue;
 
 			spin_lock_irqsave(&fe->card->dpcm_lock, flags);
@@ -2098,6 +2127,7 @@ int dpcm_be_dai_trigger(struct snd_soc_pcm_runtime *fe, int stream,
 			if (ret) {
 				spin_lock_irqsave(&fe->card->dpcm_lock, flags);
 				be->dpcm[stream].state = state;
+				be->dpcm[stream].be_start++;
 				spin_unlock_irqrestore(&fe->card->dpcm_lock, flags);
 				goto end;
 			}
@@ -2109,9 +2139,12 @@ int dpcm_be_dai_trigger(struct snd_soc_pcm_runtime *fe, int stream,
 				spin_unlock_irqrestore(&fe->card->dpcm_lock, flags);
 				continue;
 			}
+			if (be->dpcm[stream].be_start == 1)
+				do_trigger = true;
+			be->dpcm[stream].be_start--;
 			spin_unlock_irqrestore(&fe->card->dpcm_lock, flags);
 
-			if (!snd_soc_dpcm_can_be_free_stop(fe, be, stream))
+			if (!do_trigger)
 				continue;
 
 			spin_lock_irqsave(&fe->card->dpcm_lock, flags);
@@ -2123,6 +2156,7 @@ int dpcm_be_dai_trigger(struct snd_soc_pcm_runtime *fe, int stream,
 			if (ret) {
 				spin_lock_irqsave(&fe->card->dpcm_lock, flags);
 				be->dpcm[stream].state = state;
+				be->dpcm[stream].be_start++;
 				spin_unlock_irqrestore(&fe->card->dpcm_lock, flags);
 				goto end;
 			}
@@ -2134,9 +2168,12 @@ int dpcm_be_dai_trigger(struct snd_soc_pcm_runtime *fe, int stream,
 				spin_unlock_irqrestore(&fe->card->dpcm_lock, flags);
 				continue;
 			}
+			if (be->dpcm[stream].be_start == 1)
+				do_trigger = true;
+			be->dpcm[stream].be_start--;
 			spin_unlock_irqrestore(&fe->card->dpcm_lock, flags);
 
-			if (!snd_soc_dpcm_can_be_free_stop(fe, be, stream))
+			if (!do_trigger)
 				continue;
 
 			spin_lock_irqsave(&fe->card->dpcm_lock, flags);
@@ -2148,6 +2185,7 @@ int dpcm_be_dai_trigger(struct snd_soc_pcm_runtime *fe, int stream,
 			if (ret) {
 				spin_lock_irqsave(&fe->card->dpcm_lock, flags);
 				be->dpcm[stream].state = state;
+				be->dpcm[stream].be_start++;
 				spin_unlock_irqrestore(&fe->card->dpcm_lock, flags);
 				goto end;
 			}
-- 
2.25.1

