Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E45D03EF04E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 18:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbhHQQlu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 12:41:50 -0400
Received: from mga06.intel.com ([134.134.136.31]:38258 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230354AbhHQQlt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 12:41:49 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10079"; a="277170637"
X-IronPort-AV: E=Sophos;i="5.84,329,1620716400"; 
   d="scan'208";a="277170637"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2021 09:41:16 -0700
X-IronPort-AV: E=Sophos;i="5.84,329,1620716400"; 
   d="scan'208";a="449342716"
Received: from aaadelek-mobl3.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.212.12.89])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2021 09:41:14 -0700
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
Subject: [RFC PATCH 1/2] ASoC: soc-pcm: protect BE dailink state changes in trigger
Date:   Tue, 17 Aug 2021 11:40:53 -0500
Message-Id: <20210817164054.250028-2-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210817164054.250028-1-pierre-louis.bossart@linux.intel.com>
References: <20210817164054.250028-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When more than one FE is connected to a BE, e.g. in a mixing use case,
the BE can be triggered multiple times when the FE are opened/started
concurrently. This race condition is problematic in the case of
SoundWire BE dailinks, and this is not desirable in a general
case. The code carefully checks when the BE can be stopped or
hw_free'ed, but the trigger code does not use any mutual exclusion.

Fix by using the same spinlock already used to check FE states, and
set the state before the trigger. In case of errors,  the initial
state will be restored.

This patch does not change how the triggers are handled, it only makes
sure the states are handled in critical sections.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/soc-pcm.c | 103 ++++++++++++++++++++++++++++++++++++--------
 1 file changed, 85 insertions(+), 18 deletions(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 48f71bb81a2f..0717f39d2eec 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -1999,6 +1999,8 @@ int dpcm_be_dai_trigger(struct snd_soc_pcm_runtime *fe, int stream,
 	struct snd_soc_pcm_runtime *be;
 	struct snd_soc_dpcm *dpcm;
 	int ret = 0;
+	unsigned long flags;
+	enum snd_soc_dpcm_state state;
 
 	for_each_dpcm_be(fe, stream, dpcm) {
 		struct snd_pcm_substream *be_substream;
@@ -2015,76 +2017,141 @@ int dpcm_be_dai_trigger(struct snd_soc_pcm_runtime *fe, int stream,
 
 		switch (cmd) {
 		case SNDRV_PCM_TRIGGER_START:
+			spin_lock_irqsave(&fe->card->dpcm_lock, flags);
 			if ((be->dpcm[stream].state != SND_SOC_DPCM_STATE_PREPARE) &&
 			    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_STOP) &&
-			    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_PAUSED))
+			    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_PAUSED)) {
+				spin_unlock_irqrestore(&fe->card->dpcm_lock, flags);
 				continue;
+			}
+			state = be->dpcm[stream].state;
+			be->dpcm[stream].state = SND_SOC_DPCM_STATE_START;
+			spin_unlock_irqrestore(&fe->card->dpcm_lock, flags);
 
 			ret = soc_pcm_trigger(be_substream, cmd);
-			if (ret)
+			if (ret) {
+				spin_lock_irqsave(&fe->card->dpcm_lock, flags);
+				be->dpcm[stream].state = state;
+				spin_unlock_irqrestore(&fe->card->dpcm_lock, flags);
 				goto end;
+			}
 
-			be->dpcm[stream].state = SND_SOC_DPCM_STATE_START;
 			break;
 		case SNDRV_PCM_TRIGGER_RESUME:
-			if ((be->dpcm[stream].state != SND_SOC_DPCM_STATE_SUSPEND))
+			spin_lock_irqsave(&fe->card->dpcm_lock, flags);
+			if (be->dpcm[stream].state != SND_SOC_DPCM_STATE_SUSPEND) {
+				spin_unlock_irqrestore(&fe->card->dpcm_lock, flags);
 				continue;
+			}
+
+			state = be->dpcm[stream].state;
+			be->dpcm[stream].state = SND_SOC_DPCM_STATE_START;
+			spin_unlock_irqrestore(&fe->card->dpcm_lock, flags);
 
 			ret = soc_pcm_trigger(be_substream, cmd);
-			if (ret)
+			if (ret) {
+				spin_lock_irqsave(&fe->card->dpcm_lock, flags);
+				be->dpcm[stream].state = state;
+				spin_unlock_irqrestore(&fe->card->dpcm_lock, flags);
 				goto end;
+			}
 
-			be->dpcm[stream].state = SND_SOC_DPCM_STATE_START;
 			break;
 		case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
-			if ((be->dpcm[stream].state != SND_SOC_DPCM_STATE_PAUSED))
+			spin_lock_irqsave(&fe->card->dpcm_lock, flags);
+			if (be->dpcm[stream].state != SND_SOC_DPCM_STATE_PAUSED) {
+				spin_unlock_irqrestore(&fe->card->dpcm_lock, flags);
 				continue;
+			}
+
+			state = be->dpcm[stream].state;
+			be->dpcm[stream].state = SND_SOC_DPCM_STATE_START;
+			spin_unlock_irqrestore(&fe->card->dpcm_lock, flags);
 
 			ret = soc_pcm_trigger(be_substream, cmd);
-			if (ret)
+			if (ret) {
+				spin_lock_irqsave(&fe->card->dpcm_lock, flags);
+				be->dpcm[stream].state = state;
+				spin_unlock_irqrestore(&fe->card->dpcm_lock, flags);
 				goto end;
+			}
 
-			be->dpcm[stream].state = SND_SOC_DPCM_STATE_START;
 			break;
 		case SNDRV_PCM_TRIGGER_STOP:
+			spin_lock_irqsave(&fe->card->dpcm_lock, flags);
 			if ((be->dpcm[stream].state != SND_SOC_DPCM_STATE_START) &&
-			    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_PAUSED))
+			    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_PAUSED)) {
+				spin_unlock_irqrestore(&fe->card->dpcm_lock, flags);
 				continue;
+			}
+			spin_unlock_irqrestore(&fe->card->dpcm_lock, flags);
 
 			if (!snd_soc_dpcm_can_be_free_stop(fe, be, stream))
 				continue;
 
+			spin_lock_irqsave(&fe->card->dpcm_lock, flags);
+			state = be->dpcm[stream].state;
+			be->dpcm[stream].state = SND_SOC_DPCM_STATE_STOP;
+			spin_unlock_irqrestore(&fe->card->dpcm_lock, flags);
+
 			ret = soc_pcm_trigger(be_substream, cmd);
-			if (ret)
+			if (ret) {
+				spin_lock_irqsave(&fe->card->dpcm_lock, flags);
+				be->dpcm[stream].state = state;
+				spin_unlock_irqrestore(&fe->card->dpcm_lock, flags);
 				goto end;
+			}
 
-			be->dpcm[stream].state = SND_SOC_DPCM_STATE_STOP;
 			break;
 		case SNDRV_PCM_TRIGGER_SUSPEND:
-			if (be->dpcm[stream].state != SND_SOC_DPCM_STATE_START)
+			spin_lock_irqsave(&fe->card->dpcm_lock, flags);
+			if (be->dpcm[stream].state != SND_SOC_DPCM_STATE_START) {
+				spin_unlock_irqrestore(&fe->card->dpcm_lock, flags);
 				continue;
+			}
+			spin_unlock_irqrestore(&fe->card->dpcm_lock, flags);
 
 			if (!snd_soc_dpcm_can_be_free_stop(fe, be, stream))
 				continue;
 
+			spin_lock_irqsave(&fe->card->dpcm_lock, flags);
+			state = be->dpcm[stream].state;
+			be->dpcm[stream].state = SND_SOC_DPCM_STATE_STOP;
+			spin_unlock_irqrestore(&fe->card->dpcm_lock, flags);
+
 			ret = soc_pcm_trigger(be_substream, cmd);
-			if (ret)
+			if (ret) {
+				spin_lock_irqsave(&fe->card->dpcm_lock, flags);
+				be->dpcm[stream].state = state;
+				spin_unlock_irqrestore(&fe->card->dpcm_lock, flags);
 				goto end;
+			}
 
-			be->dpcm[stream].state = SND_SOC_DPCM_STATE_SUSPEND;
 			break;
 		case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
-			if (be->dpcm[stream].state != SND_SOC_DPCM_STATE_START)
+			spin_lock_irqsave(&fe->card->dpcm_lock, flags);
+			if (be->dpcm[stream].state != SND_SOC_DPCM_STATE_START) {
+				spin_unlock_irqrestore(&fe->card->dpcm_lock, flags);
 				continue;
+			}
+			spin_unlock_irqrestore(&fe->card->dpcm_lock, flags);
 
 			if (!snd_soc_dpcm_can_be_free_stop(fe, be, stream))
 				continue;
 
+			spin_lock_irqsave(&fe->card->dpcm_lock, flags);
+			state = be->dpcm[stream].state;
+			be->dpcm[stream].state = SND_SOC_DPCM_STATE_PAUSED;
+			spin_unlock_irqrestore(&fe->card->dpcm_lock, flags);
+
 			ret = soc_pcm_trigger(be_substream, cmd);
-			if (ret)
+			if (ret) {
+				spin_lock_irqsave(&fe->card->dpcm_lock, flags);
+				be->dpcm[stream].state = state;
+				spin_unlock_irqrestore(&fe->card->dpcm_lock, flags);
 				goto end;
+			}
 
-			be->dpcm[stream].state = SND_SOC_DPCM_STATE_PAUSED;
 			break;
 		}
 	}
-- 
2.25.1

