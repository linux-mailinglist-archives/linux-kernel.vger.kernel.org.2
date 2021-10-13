Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40EC342C350
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 16:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235509AbhJMOfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 10:35:01 -0400
Received: from mga12.intel.com ([192.55.52.136]:5095 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237030AbhJMOdo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 10:33:44 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10135"; a="207554882"
X-IronPort-AV: E=Sophos;i="5.85,371,1624345200"; 
   d="scan'208";a="207554882"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2021 07:31:25 -0700
X-IronPort-AV: E=Sophos;i="5.85,371,1624345200"; 
   d="scan'208";a="524649589"
Received: from ssafavib-mobl.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.209.164.198])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2021 07:31:23 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org,
        Sameer Pujar <spujar@nvidia.com>,
        Gyeongtaek Lee <gt82.lee@samsung.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shengjiu Wang <shengjiu.wang@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        linuxppc-dev@lists.ozlabs.org (open list:FREESCALE SOC SOUND DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [RFC PATCH v3 10/13] ASoC: fsl: asrc_dma: protect for_each_dpcm_be() loops
Date:   Wed, 13 Oct 2021 09:30:47 -0500
Message-Id: <20211013143050.244444-11-pierre-louis.bossart@linux.intel.com>
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
 sound/soc/fsl/fsl_asrc_dma.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/fsl/fsl_asrc_dma.c b/sound/soc/fsl/fsl_asrc_dma.c
index cd9b36ec0ecb..b67097503836 100644
--- a/sound/soc/fsl/fsl_asrc_dma.c
+++ b/sound/soc/fsl/fsl_asrc_dma.c
@@ -151,6 +151,7 @@ static int fsl_asrc_dma_hw_params(struct snd_soc_component *component,
 	int ret, width;
 
 	/* Fetch the Back-End dma_data from DPCM */
+	snd_soc_dpcm_fe_lock_irq(rtd, stream);
 	for_each_dpcm_be(rtd, stream, dpcm) {
 		struct snd_soc_pcm_runtime *be = dpcm->be;
 		struct snd_pcm_substream *substream_be;
@@ -164,6 +165,7 @@ static int fsl_asrc_dma_hw_params(struct snd_soc_component *component,
 		dev_be = dai->dev;
 		break;
 	}
+	snd_soc_dpcm_fe_unlock_irq(rtd, stream);
 
 	if (!dma_params_be) {
 		dev_err(dev, "failed to get the substream of Back-End\n");
-- 
2.25.1

