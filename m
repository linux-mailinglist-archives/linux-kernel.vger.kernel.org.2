Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C3AE3201E1
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Feb 2021 00:35:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbhBSXeY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 18:34:24 -0500
Received: from mga05.intel.com ([192.55.52.43]:58073 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229862AbhBSXdi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 18:33:38 -0500
IronPort-SDR: TJpWw2OGEW+COU+UDieBa2nf1u2gK44/c//pRCTqSvew/O3hp5rRVE1S1AiEfnhsUXS4qy87u7
 rMtGt51qCp0g==
X-IronPort-AV: E=McAfee;i="6000,8403,9900"; a="268854825"
X-IronPort-AV: E=Sophos;i="5.81,191,1610438400"; 
   d="scan'208";a="268854825"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2021 15:30:36 -0800
IronPort-SDR: VyoqTH3drO05WzEFz7pFbR0O3B2W8LfcnKCPAG7mL61X+hE273j4sLw9TwIZFwrHBTG9qBZHEI
 Dzaopj3D/9Sg==
X-IronPort-AV: E=Sophos;i="5.81,191,1610438400"; 
   d="scan'208";a="496662737"
Received: from lkwerake-mobl1.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.251.153.34])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2021 15:30:34 -0800
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
Subject: [PATCH 5/9] ASoC: fsl: fsl_ssi: remove unnecessary tests
Date:   Fri, 19 Feb 2021 17:29:33 -0600
Message-Id: <20210219232937.6440-6-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210219232937.6440-1-pierre-louis.bossart@linux.intel.com>
References: <20210219232937.6440-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cppcheck warnings:

sound/soc/fsl/fsl_ssi.c:767:34: style: Condition 'div2' is always
false [knownConditionTrueFalse]
 stccr = SSI_SxCCR_PM(pm + 1) | (div2 ? SSI_SxCCR_DIV2 : 0) |
                                 ^
sound/soc/fsl/fsl_ssi.c:722:9: note: Assignment 'div2=0', assigned value is 0
 div2 = 0;
        ^
sound/soc/fsl/fsl_ssi.c:767:34: note: Condition 'div2' is always false
 stccr = SSI_SxCCR_PM(pm + 1) | (div2 ? SSI_SxCCR_DIV2 : 0) |
                                 ^
sound/soc/fsl/fsl_ssi.c:768:4: style: Condition 'psr' is always false
[knownConditionTrueFalse]
  (psr ? SSI_SxCCR_PSR : 0);
   ^
sound/soc/fsl/fsl_ssi.c:721:8: note: Assignment 'psr=0', assigned
value is 0
 psr = 0;
       ^
sound/soc/fsl/fsl_ssi.c:768:4: note: Condition 'psr' is always false
  (psr ? SSI_SxCCR_PSR : 0);
   ^

Upon further analysis, the variables 'div2' and 'psr' are set to zero
and never modified. All the tests can be removed.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/fsl/fsl_ssi.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 57811743c294..c57d0428c0a3 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -747,7 +747,7 @@ static int fsl_ssi_set_bclk(struct snd_pcm_substream *substream,
 		sub *= 100000;
 		do_div(sub, freq);
 
-		if (sub < savesub && !(i == 0 && psr == 0 && div2 == 0)) {
+		if (sub < savesub && !(i == 0)) {
 			baudrate = tmprate;
 			savesub = sub;
 			pm = i;
@@ -764,8 +764,7 @@ static int fsl_ssi_set_bclk(struct snd_pcm_substream *substream,
 		return -EINVAL;
 	}
 
-	stccr = SSI_SxCCR_PM(pm + 1) | (div2 ? SSI_SxCCR_DIV2 : 0) |
-		(psr ? SSI_SxCCR_PSR : 0);
+	stccr = SSI_SxCCR_PM(pm + 1);
 	mask = SSI_SxCCR_PM_MASK | SSI_SxCCR_DIV2 | SSI_SxCCR_PSR;
 
 	/* STCCR is used for RX in synchronous mode */
-- 
2.25.1

