Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50B443201E4
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Feb 2021 00:35:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbhBSXfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 18:35:10 -0500
Received: from mga05.intel.com ([192.55.52.43]:58073 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229934AbhBSXfB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 18:35:01 -0500
IronPort-SDR: zFfKTtY/dtUAtjZfNIGej1N5Wu3gXl+2Zl3dLwg3AbyBkM2wNLxy3r433zEm8k5eMB/vnmNTJd
 YXRbV87cqpmw==
X-IronPort-AV: E=McAfee;i="6000,8403,9900"; a="268854851"
X-IronPort-AV: E=Sophos;i="5.81,191,1610438400"; 
   d="scan'208";a="268854851"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2021 15:30:41 -0800
IronPort-SDR: 7J5iSuMxctWjKWA9b/RW/w0Y6U0jE9BtLu2q8n+o//laTJq3NERRJCZ18FAbsXtUH/+bOrFvBY
 TIL2tFRRWQgQ==
X-IronPort-AV: E=Sophos;i="5.81,191,1610438400"; 
   d="scan'208";a="496662875"
Received: from lkwerake-mobl1.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.251.153.34])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2021 15:30:40 -0800
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
Subject: [PATCH 8/9] ASoC: fsl: mpc8610: remove useless assignment
Date:   Fri, 19 Feb 2021 17:29:36 -0600
Message-Id: <20210219232937.6440-9-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210219232937.6440-1-pierre-louis.bossart@linux.intel.com>
References: <20210219232937.6440-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cppcheck warning:

sound/soc/fsl/mpc8610_hpcd.c:333:6: style: Redundant initialization
for 'ret'. The initialized value is overwritten before it is
read. [redundantInitialization]
 ret = fsl_asoc_get_dma_channel(np, "fsl,playback-dma",
     ^
sound/soc/fsl/mpc8610_hpcd.c:193:10: note: ret is initialized
 int ret = -ENODEV;
         ^
sound/soc/fsl/mpc8610_hpcd.c:333:6: note: ret is overwritten
 ret = fsl_asoc_get_dma_channel(np, "fsl,playback-dma",
     ^

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/fsl/mpc8610_hpcd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/fsl/mpc8610_hpcd.c b/sound/soc/fsl/mpc8610_hpcd.c
index eccc833390d4..58b9ca3c4da0 100644
--- a/sound/soc/fsl/mpc8610_hpcd.c
+++ b/sound/soc/fsl/mpc8610_hpcd.c
@@ -190,7 +190,7 @@ static int mpc8610_hpcd_probe(struct platform_device *pdev)
 	struct device_node *codec_np = NULL;
 	struct mpc8610_hpcd_data *machine_data;
 	struct snd_soc_dai_link_component *comp;
-	int ret = -ENODEV;
+	int ret;
 	const char *sprop;
 	const u32 *iprop;
 
-- 
2.25.1

