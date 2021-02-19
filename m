Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 890F73201D2
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Feb 2021 00:33:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbhBSXcS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 18:32:18 -0500
Received: from mga05.intel.com ([192.55.52.43]:58072 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229745AbhBSXcP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 18:32:15 -0500
IronPort-SDR: iy6LvBfWBYG0GdwSdElNDYIFz4NACJBw3sC5v0t3X8F0DL5p6WWxW6UdyBZdqUG5ft6qgI9fth
 siIVpmUtcTAw==
X-IronPort-AV: E=McAfee;i="6000,8403,9900"; a="268854799"
X-IronPort-AV: E=Sophos;i="5.81,191,1610438400"; 
   d="scan'208";a="268854799"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2021 15:30:29 -0800
IronPort-SDR: 8FE41/OafuIQFCSt+0a+uAkO9CbLdA63YTZhNlLMzQJZnh7Vm9CM7mMLRhB8/lemN2by4dD4BH
 vkMLe6nUjlKA==
X-IronPort-AV: E=Sophos;i="5.81,191,1610438400"; 
   d="scan'208";a="496662589"
Received: from lkwerake-mobl1.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.251.153.34])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2021 15:30:28 -0800
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
Subject: [PATCH 1/9] ASoC: fsl: fsl_asrc: remove useless assignment
Date:   Fri, 19 Feb 2021 17:29:29 -0600
Message-Id: <20210219232937.6440-2-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210219232937.6440-1-pierre-louis.bossart@linux.intel.com>
References: <20210219232937.6440-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cppcheck warning:

sound/soc/fsl/fsl_asrc.c:613:8: style: Variable 'i' is assigned a
value that is never used. [unreadVariable]
 int i = 0, j = 0;
       ^

The same issue occurs for the 'j' variable.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/fsl/fsl_asrc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
index c325c984d165..63d236ef5c4d 100644
--- a/sound/soc/fsl/fsl_asrc.c
+++ b/sound/soc/fsl/fsl_asrc.c
@@ -610,7 +610,7 @@ static void fsl_asrc_select_clk(struct fsl_asrc_priv *asrc_priv,
 	struct asrc_config *config = pair_priv->config;
 	int rate[2], select_clk[2]; /* Array size 2 means IN and OUT */
 	int clk_rate, clk_index;
-	int i = 0, j = 0;
+	int i, j;
 
 	rate[IN] = in_rate;
 	rate[OUT] = out_rate;
-- 
2.25.1

