Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 926EC42C34F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 16:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237448AbhJMOez (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 10:34:55 -0400
Received: from mga12.intel.com ([192.55.52.136]:5099 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237060AbhJMOdo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 10:33:44 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10135"; a="207554904"
X-IronPort-AV: E=Sophos;i="5.85,371,1624345200"; 
   d="scan'208";a="207554904"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2021 07:31:30 -0700
X-IronPort-AV: E=Sophos;i="5.85,371,1624345200"; 
   d="scan'208";a="524649628"
Received: from ssafavib-mobl.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.209.164.198])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2021 07:31:29 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org,
        Sameer Pujar <spujar@nvidia.com>,
        Gyeongtaek Lee <gt82.lee@samsung.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Bard Liao <bard.liao@intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [RFC PATCH v3 13/13] ASoC: soc-pcm: fix BE handling of PAUSE_RELEASE
Date:   Wed, 13 Oct 2021 09:30:50 -0500
Message-Id: <20211013143050.244444-14-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211013143050.244444-1-pierre-louis.bossart@linux.intel.com>
References: <20211013143050.244444-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A BE connected to more than one FE, e.g. in a mixer case, can go
through the following transitions.

play FE1    -> BE state is START
pause FE1   -> BE state is PAUSED
play FE2    -> BE state is START
stop FE2    -> BE state is STOP (see note [1] below)
release FE1 -> BE state is START
stop FE1    -> BE state is STOP

play FE1    -> BE state is START
pause FE1   -> BE state is PAUSED
play FE2    -> BE state is START
release FE1 -> BE state is START
stop FE2    -> BE state is START
stop FE1    -> BE state is STOP

The existing code for PAUSE_RELEASE only allows for the case where the
BE is paused, which clearly would not work in the sequences above.

Extend the allowed states to restart the BE when PAUSE_RELEASE is
received.

[1] the existing logic does not move the BE state back to PAUSED when
the FE2 is stopped. This patch does not change the logic; it would be
painful to keep a history of changes on the FE side, the state machine
is already rather complicated with transitions based on the last BE
state and the trigger type.

Reported-by: Bard Liao <bard.liao@intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/soc-pcm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 1967980d0f79..88d60d5b60a8 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -2131,7 +2131,9 @@ int dpcm_be_dai_trigger(struct snd_soc_pcm_runtime *fe, int stream,
 			be->dpcm[stream].state = SND_SOC_DPCM_STATE_START;
 			break;
 		case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
-			if ((be->dpcm[stream].state != SND_SOC_DPCM_STATE_PAUSED))
+			if ((be->dpcm[stream].state != SND_SOC_DPCM_STATE_START) &&
+			    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_STOP) &&
+			    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_PAUSED))
 				goto unlock_be;
 
 			be->dpcm[stream].be_start++;
-- 
2.25.1

