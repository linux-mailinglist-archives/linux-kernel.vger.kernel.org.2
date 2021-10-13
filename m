Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04B1B42C344
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 16:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236097AbhJMOeU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 10:34:20 -0400
Received: from mga12.intel.com ([192.55.52.136]:5099 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236847AbhJMOdm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 10:33:42 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10135"; a="207554817"
X-IronPort-AV: E=Sophos;i="5.85,371,1624345200"; 
   d="scan'208";a="207554817"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2021 07:31:08 -0700
X-IronPort-AV: E=Sophos;i="5.85,371,1624345200"; 
   d="scan'208";a="524649490"
Received: from ssafavib-mobl.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.209.164.198])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2021 07:31:07 -0700
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
Subject: [RFC PATCH v3 02/13] ASoC: soc-pcm: don't export local functions, use static
Date:   Wed, 13 Oct 2021 09:30:39 -0500
Message-Id: <20211013143050.244444-3-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211013143050.244444-1-pierre-louis.bossart@linux.intel.com>
References: <20211013143050.244444-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No one uses the following functions outside of soc-pcm.c

snd_soc_dpcm_can_be_free_stop()
snd_soc_dpcm_can_be_params()
snd_soc_dpcm_be_can_update()

In preparation for locking changes, move them to static functions and
remove the EXPORT_SYMBOL_GPL()

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 include/sound/soc-dpcm.h | 12 ------------
 sound/soc/soc-pcm.c      | 21 +++++++++++++++------
 2 files changed, 15 insertions(+), 18 deletions(-)

diff --git a/include/sound/soc-dpcm.h b/include/sound/soc-dpcm.h
index 72d45ad47ee3..9c00118603e7 100644
--- a/include/sound/soc-dpcm.h
+++ b/include/sound/soc-dpcm.h
@@ -113,18 +113,6 @@ struct snd_soc_dpcm_runtime {
 #define for_each_dpcm_be_rollback(fe, stream, _dpcm)			\
 	list_for_each_entry_continue_reverse(_dpcm, &(fe)->dpcm[stream].be_clients, list_be)
 
-/* can this BE stop and free */
-int snd_soc_dpcm_can_be_free_stop(struct snd_soc_pcm_runtime *fe,
-		struct snd_soc_pcm_runtime *be, int stream);
-
-/* can this BE perform a hw_params() */
-int snd_soc_dpcm_can_be_params(struct snd_soc_pcm_runtime *fe,
-		struct snd_soc_pcm_runtime *be, int stream);
-
-/* is the current PCM operation for this BE ? */
-int snd_soc_dpcm_be_can_update(struct snd_soc_pcm_runtime *fe,
-		struct snd_soc_pcm_runtime *be, int stream);
-
 /* get the substream for this BE */
 struct snd_pcm_substream *
 	snd_soc_dpcm_get_substream(struct snd_soc_pcm_runtime *be, int stream);
diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 2790379015ca..d428a8815d39 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -29,6 +29,18 @@
 
 #define DPCM_MAX_BE_USERS	8
 
+/* can this BE stop and free */
+static int snd_soc_dpcm_can_be_free_stop(struct snd_soc_pcm_runtime *fe,
+					 struct snd_soc_pcm_runtime *be, int stream);
+
+/* can this BE perform a hw_params() */
+static int snd_soc_dpcm_can_be_params(struct snd_soc_pcm_runtime *fe,
+				      struct snd_soc_pcm_runtime *be, int stream);
+
+/* is the current PCM operation for this BE ? */
+static int snd_soc_dpcm_be_can_update(struct snd_soc_pcm_runtime *fe,
+				      struct snd_soc_pcm_runtime *be, int stream);
+
 static inline const char *soc_cpu_dai_name(struct snd_soc_pcm_runtime *rtd)
 {
 	return (rtd)->num_cpus == 1 ? asoc_rtd_to_cpu(rtd, 0)->name : "multicpu";
@@ -2816,7 +2828,7 @@ int soc_new_pcm(struct snd_soc_pcm_runtime *rtd, int num)
 }
 
 /* is the current PCM operation for this BE ? */
-int snd_soc_dpcm_be_can_update(struct snd_soc_pcm_runtime *fe,
+static int snd_soc_dpcm_be_can_update(struct snd_soc_pcm_runtime *fe,
 		struct snd_soc_pcm_runtime *be, int stream)
 {
 	if ((fe->dpcm[stream].runtime_update == SND_SOC_DPCM_UPDATE_FE) ||
@@ -2825,7 +2837,6 @@ int snd_soc_dpcm_be_can_update(struct snd_soc_pcm_runtime *fe,
 		return 1;
 	return 0;
 }
-EXPORT_SYMBOL_GPL(snd_soc_dpcm_be_can_update);
 
 /* get the substream for this BE */
 struct snd_pcm_substream *
@@ -2871,7 +2882,7 @@ static int snd_soc_dpcm_check_state(struct snd_soc_pcm_runtime *fe,
  * We can only hw_free, stop, pause or suspend a BE DAI if any of it's FE
  * are not running, paused or suspended for the specified stream direction.
  */
-int snd_soc_dpcm_can_be_free_stop(struct snd_soc_pcm_runtime *fe,
+static int snd_soc_dpcm_can_be_free_stop(struct snd_soc_pcm_runtime *fe,
 		struct snd_soc_pcm_runtime *be, int stream)
 {
 	const enum snd_soc_dpcm_state state[] = {
@@ -2882,13 +2893,12 @@ int snd_soc_dpcm_can_be_free_stop(struct snd_soc_pcm_runtime *fe,
 
 	return snd_soc_dpcm_check_state(fe, be, stream, state, ARRAY_SIZE(state));
 }
-EXPORT_SYMBOL_GPL(snd_soc_dpcm_can_be_free_stop);
 
 /*
  * We can only change hw params a BE DAI if any of it's FE are not prepared,
  * running, paused or suspended for the specified stream direction.
  */
-int snd_soc_dpcm_can_be_params(struct snd_soc_pcm_runtime *fe,
+static int snd_soc_dpcm_can_be_params(struct snd_soc_pcm_runtime *fe,
 		struct snd_soc_pcm_runtime *be, int stream)
 {
 	const enum snd_soc_dpcm_state state[] = {
@@ -2900,4 +2910,3 @@ int snd_soc_dpcm_can_be_params(struct snd_soc_pcm_runtime *fe,
 
 	return snd_soc_dpcm_check_state(fe, be, stream, state, ARRAY_SIZE(state));
 }
-EXPORT_SYMBOL_GPL(snd_soc_dpcm_can_be_params);
-- 
2.25.1

