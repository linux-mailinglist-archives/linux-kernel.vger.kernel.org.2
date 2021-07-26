Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDF0B3D570A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 12:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233113AbhGZJZS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 05:25:18 -0400
Received: from mga18.intel.com ([134.134.136.126]:48686 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232877AbhGZJZM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 05:25:12 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10056"; a="199438582"
X-IronPort-AV: E=Sophos;i="5.84,270,1620716400"; 
   d="scan'208";a="199438582"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2021 03:05:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,270,1620716400"; 
   d="scan'208";a="579317934"
Received: from brentlu-desk0.itwn.intel.com ([10.5.253.32])
  by fmsmga001.fm.intel.com with ESMTP; 26 Jul 2021 03:05:36 -0700
From:   Brent Lu <brent.lu@intel.com>
To:     alsa-devel@alsa-project.org
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Zou Wei <zou_wei@huawei.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Brent Lu <brent.lu@intel.com>,
        Rander Wang <rander.wang@intel.com>,
        Paul Olaru <paul.olaru@oss.nxp.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: Intel: sof_da7219_mx98360a: fail to initialize soundcard
Date:   Mon, 26 Jul 2021 17:45:25 +0800
Message-Id: <20210726094525.5748-1-brent.lu@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The default codec for speaker amp's DAI Link is max98373 and will be
overwritten in probe function if the board id is sof_da7219_mx98360a.
However, the probe function does not do it because the board id is
changed in earlier commit.

Fixes: 1cc04d195dc2 ("ASoC: Intel: sof_da7219_max98373: shrink platform_id below 20 characters")
Signed-off-by: Brent Lu <brent.lu@intel.com>
---
 sound/soc/intel/boards/sof_da7219_max98373.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/sof_da7219_max98373.c b/sound/soc/intel/boards/sof_da7219_max98373.c
index 896251d742fe..b7b3b0bf994a 100644
--- a/sound/soc/intel/boards/sof_da7219_max98373.c
+++ b/sound/soc/intel/boards/sof_da7219_max98373.c
@@ -404,7 +404,7 @@ static int audio_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	/* By default dais[0] is configured for max98373 */
-	if (!strcmp(pdev->name, "sof_da7219_max98360a")) {
+	if (!strcmp(pdev->name, "sof_da7219_mx98360a")) {
 		dais[0] = (struct snd_soc_dai_link) {
 			.name = "SSP1-Codec",
 			.id = 0,
-- 
2.17.1

