Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51ABA424462
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 19:35:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238977AbhJFRhL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 13:37:11 -0400
Received: from mga07.intel.com ([134.134.136.100]:4781 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238111AbhJFRhF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 13:37:05 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10129"; a="289559508"
X-IronPort-AV: E=Sophos;i="5.85,352,1624345200"; 
   d="scan'208";a="289559508"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2021 10:35:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,352,1624345200"; 
   d="scan'208";a="568255134"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 06 Oct 2021 10:35:09 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id BE3661C8; Wed,  6 Oct 2021 20:35:15 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.com>
Subject: [PATCH v3 3/4] ASoC: Intel: bytcht_es8316: Switch to use gpiod_get_optional()
Date:   Wed,  6 Oct 2021 20:33:48 +0300
Message-Id: <20211006173349.84684-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211006173349.84684-1-andriy.shevchenko@linux.intel.com>
References: <20211006173349.84684-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

First of all, replace indexed API by plain one since we have index 0.
Second, switch to optional variant and drop duplicated code.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.com>
---
 sound/soc/intel/boards/bytcht_es8316.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/sound/soc/intel/boards/bytcht_es8316.c b/sound/soc/intel/boards/bytcht_es8316.c
index 171f3d8c5996..d8dcf63825a6 100644
--- a/sound/soc/intel/boards/bytcht_es8316.c
+++ b/sound/soc/intel/boards/bytcht_es8316.c
@@ -566,16 +566,12 @@ static int snd_byt_cht_es8316_mc_probe(struct platform_device *pdev)
 
 	devm_acpi_dev_add_driver_gpios(codec_dev, byt_cht_es8316_gpios);
 	priv->speaker_en_gpio =
-		gpiod_get_index(codec_dev, "speaker-enable", 0,
-				/* see comment in byt_cht_es8316_resume */
-				GPIOD_OUT_LOW | GPIOD_FLAGS_BIT_NONEXCLUSIVE);
-
+		gpiod_get_optional(codec_dev, "speaker-enable",
+				   /* see comment in byt_cht_es8316_resume() */
+				   GPIOD_OUT_LOW | GPIOD_FLAGS_BIT_NONEXCLUSIVE);
 	if (IS_ERR(priv->speaker_en_gpio)) {
 		ret = PTR_ERR(priv->speaker_en_gpio);
 		switch (ret) {
-		case -ENOENT:
-			priv->speaker_en_gpio = NULL;
-			break;
 		default:
 			dev_err(dev, "get speaker GPIO failed: %d\n", ret);
 			fallthrough;
-- 
2.33.0

