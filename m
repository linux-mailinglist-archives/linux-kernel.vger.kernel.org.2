Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D996834B1A3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 23:00:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbhCZWAG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 18:00:06 -0400
Received: from mga04.intel.com ([192.55.52.120]:61331 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229969AbhCZV7z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 17:59:55 -0400
IronPort-SDR: dm1a2I3fKZ/68L5zE+L1mZVr/Fc4JAYQcUcP1s2lDcLh4UOo6Vt/3HWHa8HvqX+rr6y+YApNkP
 z/zOykTDN7sw==
X-IronPort-AV: E=McAfee;i="6000,8403,9935"; a="188957048"
X-IronPort-AV: E=Sophos;i="5.81,281,1610438400"; 
   d="scan'208";a="188957048"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2021 14:59:54 -0700
IronPort-SDR: Je863sflGveU/77pmbgCmYiQNuc7PUjcdUxpiLAjQaJIPqabbQQaTx5EKNHYVRLp2gvh70oQNi
 Rtltnk7ZomtQ==
X-IronPort-AV: E=Sophos;i="5.81,281,1610438400"; 
   d="scan'208";a="416706667"
Received: from zcmahone-mobl1.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.255.231.203])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2021 14:59:53 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     tiwai@suse.de, broonie@kernel.org, linux-kernel@vger.kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Hui Wang <hui.wang@canonical.com>
Subject: [PATCH 01/17] ASoC: amd: renoir: acp3x-pdm-dma: remove unnecessary assignments
Date:   Fri, 26 Mar 2021 16:59:11 -0500
Message-Id: <20210326215927.936377-2-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210326215927.936377-1-pierre-louis.bossart@linux.intel.com>
References: <20210326215927.936377-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cppcheck warning:

sound/soc/amd/renoir/acp3x-pdm-dma.c:132:17: style: Variable
'pdm_dma_enable' is assigned a value that is never
used. [unreadVariable]
 pdm_dma_enable = 0x00;
                ^
sound/soc/amd/renoir/acp3x-pdm-dma.c:156:18: style: Variable
'pdm_dma_enable' is assigned a value that is never
used. [unreadVariable]
  pdm_dma_enable = 0x00;
                 ^

indeed those values are never used because the timeout is reset.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/amd/renoir/acp3x-pdm-dma.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/amd/renoir/acp3x-pdm-dma.c b/sound/soc/amd/renoir/acp3x-pdm-dma.c
index 7b14d9a81b97..1acd20439399 100644
--- a/sound/soc/amd/renoir/acp3x-pdm-dma.c
+++ b/sound/soc/amd/renoir/acp3x-pdm-dma.c
@@ -129,7 +129,6 @@ static int start_pdm_dma(void __iomem *acp_base)
 	enable_pdm_clock(acp_base);
 	rn_writel(pdm_enable, acp_base + ACP_WOV_PDM_ENABLE);
 	rn_writel(pdm_dma_enable, acp_base + ACP_WOV_PDM_DMA_ENABLE);
-	pdm_dma_enable = 0x00;
 	timeout = 0;
 	while (++timeout < ACP_COUNTER) {
 		pdm_dma_enable = rn_readl(acp_base + ACP_WOV_PDM_DMA_ENABLE);
@@ -153,7 +152,6 @@ static int stop_pdm_dma(void __iomem *acp_base)
 	if (pdm_dma_enable & 0x01) {
 		pdm_dma_enable = 0x02;
 		rn_writel(pdm_dma_enable, acp_base + ACP_WOV_PDM_DMA_ENABLE);
-		pdm_dma_enable = 0x00;
 		timeout = 0;
 		while (++timeout < ACP_COUNTER) {
 			pdm_dma_enable = rn_readl(acp_base +
-- 
2.25.1

