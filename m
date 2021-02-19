Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9C8A3201E5
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Feb 2021 00:37:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbhBSXgS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 18:36:18 -0500
Received: from mga05.intel.com ([192.55.52.43]:58069 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229577AbhBSXgQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 18:36:16 -0500
IronPort-SDR: 3eERSLMoYjZNw/5poUWEtEsXvI3qNPn89VikPJ/MB7R5fVIFcSW3uw5d/YqE0CdQaXWSdErh29
 wjta0mZsV/Wg==
X-IronPort-AV: E=McAfee;i="6000,8403,9900"; a="268854860"
X-IronPort-AV: E=Sophos;i="5.81,191,1610438400"; 
   d="scan'208";a="268854860"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2021 15:30:43 -0800
IronPort-SDR: dT45sHu2X3+mJ0Y8yJGnJ4gyUitGJ7bd42wGlG7xUAQ8b7qp6h+D1kkACJk3ZwjIO/QBlT1W9r
 83Gsf+AkKRMw==
X-IronPort-AV: E=Sophos;i="5.81,191,1610438400"; 
   d="scan'208";a="496662912"
Received: from lkwerake-mobl1.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.251.153.34])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2021 15:30:42 -0800
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     tiwai@suse.de, broonie@kernel.org, linux-kernel@vger.kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH 9/9] ASoC: fsl: p1022_ds: remove useless assignment
Date:   Fri, 19 Feb 2021 17:29:37 -0600
Message-Id: <20210219232937.6440-10-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210219232937.6440-1-pierre-louis.bossart@linux.intel.com>
References: <20210219232937.6440-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cppcheck warning:

sound/soc/fsl/p1022_ds.c:344:6: style: Redundant initialization for
'ret'. The initialized value is overwritten before it is
read. [redundantInitialization]
 ret = fsl_asoc_get_dma_channel(np, "fsl,playback-dma", &mdata->dai[0],
     ^
sound/soc/fsl/p1022_ds.c:203:10: note: ret is initialized
 int ret = -ENODEV;
         ^
sound/soc/fsl/p1022_ds.c:344:6: note: ret is overwritten
 ret = fsl_asoc_get_dma_channel(np, "fsl,playback-dma", &mdata->dai[0],
     ^

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/fsl/p1022_ds.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/fsl/p1022_ds.c b/sound/soc/fsl/p1022_ds.c
index ac68d2238045..317c767b0099 100644
--- a/sound/soc/fsl/p1022_ds.c
+++ b/sound/soc/fsl/p1022_ds.c
@@ -200,7 +200,7 @@ static int p1022_ds_probe(struct platform_device *pdev)
 	struct device_node *codec_np = NULL;
 	struct machine_data *mdata;
 	struct snd_soc_dai_link_component *comp;
-	int ret = -ENODEV;
+	int ret;
 	const char *sprop;
 	const u32 *iprop;
 
-- 
2.25.1

