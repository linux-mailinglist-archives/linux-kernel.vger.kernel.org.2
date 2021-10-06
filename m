Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 693FE424367
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 18:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238660AbhJFQza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 12:55:30 -0400
Received: from mga07.intel.com ([134.134.136.100]:65385 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238827AbhJFQz2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 12:55:28 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10129"; a="289547221"
X-IronPort-AV: E=Sophos;i="5.85,352,1624345200"; 
   d="scan'208";a="289547221"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2021 09:52:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,352,1624345200"; 
   d="scan'208";a="439965080"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 06 Oct 2021 09:52:23 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 56F0F1C8; Wed,  6 Oct 2021 19:52:30 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 2/4] ASoC: Intel: bytcht_es8316: Use temporary variable for struct device
Date:   Wed,  6 Oct 2021 19:52:26 +0300
Message-Id: <20211006165228.1692-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211006165228.1692-1-andriy.shevchenko@linux.intel.com>
References: <20211006165228.1692-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use temporary variable for struct device to make code neater.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Pierre-Louis Bossart <pierre-louis.bossart@linux.com>
---
 sound/soc/intel/boards/bytcht_es8316.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/boards/bytcht_es8316.c b/sound/soc/intel/boards/bytcht_es8316.c
index 4360519fbb0c..171f3d8c5996 100644
--- a/sound/soc/intel/boards/bytcht_es8316.c
+++ b/sound/soc/intel/boards/bytcht_es8316.c
@@ -493,7 +493,7 @@ static int snd_byt_cht_es8316_mc_probe(struct platform_device *pdev)
 		put_device(&adev->dev);
 		byt_cht_es8316_dais[dai_index].codecs->name = codec_name;
 	} else {
-		dev_err(&pdev->dev, "Error cannot find '%s' dev\n", mach->id);
+		dev_err(dev, "Error cannot find '%s' dev\n", mach->id);
 		return -ENXIO;
 	}
 
@@ -596,7 +596,7 @@ static int snd_byt_cht_es8316_mc_probe(struct platform_device *pdev)
 	byt_cht_es8316_card.long_name = long_name;
 #endif
 
-	sof_parent = snd_soc_acpi_sof_parent(&pdev->dev);
+	sof_parent = snd_soc_acpi_sof_parent(dev);
 
 	/* set card and driver name */
 	if (sof_parent) {
-- 
2.33.0

