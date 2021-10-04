Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D136421A57
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 00:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236977AbhJDW5J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 18:57:09 -0400
Received: from mga07.intel.com ([134.134.136.100]:62906 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233501AbhJDW5H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 18:57:07 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10127"; a="289117032"
X-IronPort-AV: E=Sophos;i="5.85,347,1624345200"; 
   d="scan'208";a="289117032"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2021 15:55:01 -0700
X-IronPort-AV: E=Sophos;i="5.85,347,1624345200"; 
   d="scan'208";a="559011855"
Received: from ksgonzal-mobl.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.209.181.38])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2021 15:54:59 -0700
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
Subject: [RFC PATCH v2 1/5] ASoC: soc-pcm: remove snd_soc_dpcm_fe_can_update()
Date:   Mon,  4 Oct 2021 17:54:37 -0500
Message-Id: <20211004225441.233375-2-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211004225441.233375-1-pierre-louis.bossart@linux.intel.com>
References: <20211004225441.233375-1-pierre-louis.bossart@linux.intel.com>
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
index fc1854e3e43f..17476e3219ea 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -2805,15 +2805,6 @@ int soc_new_pcm(struct snd_soc_pcm_runtime *rtd, int num)
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

