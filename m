Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCC5B34B1A5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 23:00:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbhCZWAI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 18:00:08 -0400
Received: from mga04.intel.com ([192.55.52.120]:61331 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230026AbhCZV75 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 17:59:57 -0400
IronPort-SDR: QNDFnL9wfxwVi3cHrW5NkSr6mFet9/Wt/i4A5/pw1y+7F0soUAfXwG9xhWRv4L4Nc6iv0EBVgm
 1vJAk7+X8plg==
X-IronPort-AV: E=McAfee;i="6000,8403,9935"; a="188957060"
X-IronPort-AV: E=Sophos;i="5.81,281,1610438400"; 
   d="scan'208";a="188957060"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2021 14:59:57 -0700
IronPort-SDR: pB408+pzBCoEPBT8sZF5FmcBw4LHKr5AyFUT6dU0vtpWt0fcCZ5siFsPnp18RzUiplSBJx9yZb
 nrgzhMs4AqfA==
X-IronPort-AV: E=Sophos;i="5.81,281,1610438400"; 
   d="scan'208";a="416706683"
Received: from zcmahone-mobl1.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.255.231.203])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2021 14:59:56 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     tiwai@suse.de, broonie@kernel.org, linux-kernel@vger.kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Microchip
        (AT91) SoC support)
Subject: [PATCH 03/17] ASoC: atmel: atmel-i2s: remove useless initialization
Date:   Fri, 26 Mar 2021 16:59:13 -0500
Message-Id: <20210326215927.936377-4-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210326215927.936377-1-pierre-louis.bossart@linux.intel.com>
References: <20210326215927.936377-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cppcheck complains:

sound/soc/atmel/atmel-i2s.c:628:6: style: Redundant initialization for 'err'. The initialized value is overwritten before it is read. [redundantInitialization]
 err = devm_request_irq(&pdev->dev, irq, atmel_i2s_interrupt, 0,
     ^
sound/soc/atmel/atmel-i2s.c:598:10: note: err is initialized
 int err = -ENXIO;
         ^
sound/soc/atmel/atmel-i2s.c:628:6: note: err is overwritten
 err = devm_request_irq(&pdev->dev, irq, atmel_i2s_interrupt, 0,
     ^

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/atmel/atmel-i2s.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/atmel/atmel-i2s.c b/sound/soc/atmel/atmel-i2s.c
index 7c6187e41f2b..584656cc7d3c 100644
--- a/sound/soc/atmel/atmel-i2s.c
+++ b/sound/soc/atmel/atmel-i2s.c
@@ -595,7 +595,7 @@ static int atmel_i2s_probe(struct platform_device *pdev)
 	struct regmap *regmap;
 	void __iomem *base;
 	int irq;
-	int err = -ENXIO;
+	int err;
 	unsigned int pcm_flags = 0;
 	unsigned int version;
 
-- 
2.25.1

