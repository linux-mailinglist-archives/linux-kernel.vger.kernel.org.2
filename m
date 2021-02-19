Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0531D3201D3
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Feb 2021 00:33:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbhBSXcU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 18:32:20 -0500
Received: from mga05.intel.com ([192.55.52.43]:58073 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229755AbhBSXcR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 18:32:17 -0500
IronPort-SDR: DLC6qMdI8H04qq7rjWrZ86GmIT+ljWLORorXZsmVlhMiJdKC97DZ9Ssp/jPHCJp9oj3BQDpwmB
 UDPEtEeYM9bQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9900"; a="268854804"
X-IronPort-AV: E=Sophos;i="5.81,191,1610438400"; 
   d="scan'208";a="268854804"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2021 15:30:31 -0800
IronPort-SDR: 7fuqsnI5d1rCvsuQB4y1W5hbfpKOGWCfTShDcjfpVFCd5QXr4Iz+Qk/IQP3w6Hz/3gQt/vBW90
 NOgGQyVei+hg==
X-IronPort-AV: E=Sophos;i="5.81,191,1610438400"; 
   d="scan'208";a="496662632"
Received: from lkwerake-mobl1.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.251.153.34])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2021 15:30:30 -0800
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     tiwai@suse.de, broonie@kernel.org, linux-kernel@vger.kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Timur Tabi <timur@kernel.org>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shengjiu Wang <shengjiu.wang@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        linuxppc-dev@lists.ozlabs.org (open list:FREESCALE SOC SOUND DRIVERS)
Subject: [PATCH 2/9] ASoC: fsl: fsl_dma: remove unused variable
Date:   Fri, 19 Feb 2021 17:29:30 -0600
Message-Id: <20210219232937.6440-3-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210219232937.6440-1-pierre-louis.bossart@linux.intel.com>
References: <20210219232937.6440-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cppcheck warning:

sound/soc/fsl/fsl_dma.c:411:10: style: Variable 'channel' is assigned
a value that is never used. [unreadVariable]

 channel = substream->stream == SNDRV_PCM_STREAM_PLAYBACK ? 0 : 1;
         ^

Removing this line shows the variable isn't needed any longer so
remove declaration as well.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/fsl/fsl_dma.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/sound/soc/fsl/fsl_dma.c b/sound/soc/fsl/fsl_dma.c
index e0c39c5f4854..84bd8a5356eb 100644
--- a/sound/soc/fsl/fsl_dma.c
+++ b/sound/soc/fsl/fsl_dma.c
@@ -392,7 +392,6 @@ static int fsl_dma_open(struct snd_soc_component *component,
 	dma_addr_t ld_buf_phys;
 	u64 temp_link;  	/* Pointer to next link descriptor */
 	u32 mr;
-	unsigned int channel;
 	int ret = 0;
 	unsigned int i;
 
@@ -408,8 +407,6 @@ static int fsl_dma_open(struct snd_soc_component *component,
 		return ret;
 	}
 
-	channel = substream->stream == SNDRV_PCM_STREAM_PLAYBACK ? 0 : 1;
-
 	if (dma->assigned) {
 		dev_err(dev, "dma channel already assigned\n");
 		return -EBUSY;
-- 
2.25.1

