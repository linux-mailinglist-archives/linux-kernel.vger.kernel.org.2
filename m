Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55AB142C34D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 16:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235744AbhJMOeh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 10:34:37 -0400
Received: from mga12.intel.com ([192.55.52.136]:5099 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237023AbhJMOdn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 10:33:43 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10135"; a="207554873"
X-IronPort-AV: E=Sophos;i="5.85,371,1624345200"; 
   d="scan'208";a="207554873"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2021 07:31:23 -0700
X-IronPort-AV: E=Sophos;i="5.85,371,1624345200"; 
   d="scan'208";a="524649580"
Received: from ssafavib-mobl.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.209.164.198])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2021 07:31:21 -0700
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
        Takashi Iwai <tiwai@suse.com>, Joe Perches <joe@perches.com>,
        Mikhail Durnev <mikhail_durnev@mentor.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [RFC PATCH v3 09/13] ASoC: sh: rcar: protect for_each_dpcm_be() loops
Date:   Wed, 13 Oct 2021 09:30:46 -0500
Message-Id: <20211013143050.244444-10-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211013143050.244444-1-pierre-louis.bossart@linux.intel.com>
References: <20211013143050.244444-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Follow the locking model used within soc-pcm.c

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sh/rcar/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index 978bd0406729..ccd5c2d1cdc6 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -1511,6 +1511,7 @@ static int rsnd_hw_params(struct snd_soc_component *component,
 		struct snd_soc_dpcm *dpcm;
 		int stream = substream->stream;
 
+		snd_soc_dpcm_fe_lock_irq(fe, stream);
 		for_each_dpcm_be(fe, stream, dpcm) {
 			struct snd_pcm_hw_params *be_params = &dpcm->hw_params;
 
@@ -1519,6 +1520,7 @@ static int rsnd_hw_params(struct snd_soc_component *component,
 			if (params_rate(hw_params) != params_rate(be_params))
 				io->converted_rate = params_rate(be_params);
 		}
+		snd_soc_dpcm_fe_unlock_irq(fe, stream);
 		if (io->converted_chan)
 			dev_dbg(dev, "convert channels = %d\n", io->converted_chan);
 		if (io->converted_rate) {
-- 
2.25.1

