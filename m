Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9BCB3201E3
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Feb 2021 00:35:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbhBSXfD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 18:35:03 -0500
Received: from mga05.intel.com ([192.55.52.43]:58072 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229913AbhBSXe5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 18:34:57 -0500
IronPort-SDR: fO7HKVxd/0gw3ylmfzfShfkSuycKdtIsT0TUx3XA/sSh+gZcv3Avb5uwNsw5gT0zJevG+bgAYX
 Nk5XAp8wayxg==
X-IronPort-AV: E=McAfee;i="6000,8403,9900"; a="268854850"
X-IronPort-AV: E=Sophos;i="5.81,191,1610438400"; 
   d="scan'208";a="268854850"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2021 15:30:40 -0800
IronPort-SDR: E97+6RVLmSFY7B2BFYjvIXXtCfMqKqZUW0oXdHO8WN6gGLkI0B7R7jrKnJX9hMHKJh4fDfnM+2
 /4ULNxZsfQGg==
X-IronPort-AV: E=Sophos;i="5.81,191,1610438400"; 
   d="scan'208";a="496662850"
Received: from lkwerake-mobl1.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.251.153.34])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2021 15:30:39 -0800
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     tiwai@suse.de, broonie@kernel.org, linux-kernel@vger.kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH 7/9] ASoC: fsl: mpc5200: signed parameter in snprintf format
Date:   Fri, 19 Feb 2021 17:29:35 -0600
Message-Id: <20210219232937.6440-8-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210219232937.6440-1-pierre-louis.bossart@linux.intel.com>
References: <20210219232937.6440-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cppcheck warning:

sound/soc/fsl/mpc5200_dma.c:414:2: warning: %u in format
string (no. 1) requires 'unsigned int' but the argument type is
'signed int'. [invalidPrintfArgType_uint]
 snprintf(psc_dma->name, sizeof psc_dma->name, "PSC%u", psc_dma->id);
 ^

Also fix sizeof use, missing parentheses reported by checkpatch.pl

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/fsl/mpc5200_dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/fsl/mpc5200_dma.c b/sound/soc/fsl/mpc5200_dma.c
index 231984882176..6c65cd858b0b 100644
--- a/sound/soc/fsl/mpc5200_dma.c
+++ b/sound/soc/fsl/mpc5200_dma.c
@@ -411,7 +411,7 @@ int mpc5200_audio_dma_create(struct platform_device *op)
 	psc_dma->dev = &op->dev;
 	psc_dma->playback.psc_dma = psc_dma;
 	psc_dma->capture.psc_dma = psc_dma;
-	snprintf(psc_dma->name, sizeof psc_dma->name, "PSC%u", psc_dma->id);
+	snprintf(psc_dma->name, sizeof(psc_dma->name), "PSC%d", psc_dma->id);
 
 	/* Find the address of the fifo data registers and setup the
 	 * DMA tasks */
-- 
2.25.1

