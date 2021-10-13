Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D87142C354
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 16:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236535AbhJMOeB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 10:34:01 -0400
Received: from mga12.intel.com ([192.55.52.136]:5091 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236841AbhJMOdl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 10:33:41 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10135"; a="207554808"
X-IronPort-AV: E=Sophos;i="5.85,371,1624345200"; 
   d="scan'208";a="207554808"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2021 07:31:07 -0700
X-IronPort-AV: E=Sophos;i="5.85,371,1624345200"; 
   d="scan'208";a="524649465"
Received: from ssafavib-mobl.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.209.164.198])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2021 07:31:05 -0700
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
Subject: [RFC PATCH v3 01/13] ASoC: soc-pcm: remove snd_soc_dpcm_fe_can_update()
Date:   Wed, 13 Oct 2021 09:30:38 -0500
Message-Id: <20211013143050.244444-2-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211013143050.244444-1-pierre-louis.bossart@linux.intel.com>
References: <20211013143050.244444-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function is not used anywhere, including soc-pcm.c

Remove dead code.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 include/sound/soc-dpcm.h | 3 ---
 sound/soc/soc-pcm.c      | 9 ---------
 2 files changed, 12 deletions(-)

diff --git a/include/sound/soc-dpcm.h b/include/sound/soc-dpcm.h
index bc7af90099a8..72d45ad47ee3 100644
--- a/include/sound/soc-dpcm.h
+++ b/include/sound/soc-dpcm.h
@@ -121,9 +121,6 @@ int snd_soc_dpcm_can_be_free_stop(struct snd_soc_pcm_runtime *fe,
 int snd_soc_dpcm_can_be_params(struct snd_soc_pcm_runtime *fe,
 		struct snd_soc_pcm_runtime *be, int stream);
 
-/* is the current PCM operation for this FE ? */
-int snd_soc_dpcm_fe_can_update(struct snd_soc_pcm_runtime *fe, int stream);
-
 /* is the current PCM operation for this BE ? */
 int snd_soc_dpcm_be_can_update(struct snd_soc_pcm_runtime *fe,
 		struct snd_soc_pcm_runtime *be, int stream);
diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 0aa0ae9703d1..2790379015ca 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -2815,15 +2815,6 @@ int soc_new_pcm(struct snd_soc_pcm_runtime *rtd, int num)
 	return ret;
 }
 
-/* is the current PCM operation for this FE ? */
-int snd_soc_dpcm_fe_can_update(struct snd_soc_pcm_runtime *fe, int stream)
-{
-	if (fe->dpcm[stream].runtime_update == SND_SOC_DPCM_UPDATE_FE)
-		return 1;
-	return 0;
-}
-EXPORT_SYMBOL_GPL(snd_soc_dpcm_fe_can_update);
-
 /* is the current PCM operation for this BE ? */
 int snd_soc_dpcm_be_can_update(struct snd_soc_pcm_runtime *fe,
 		struct snd_soc_pcm_runtime *be, int stream)
-- 
2.25.1

