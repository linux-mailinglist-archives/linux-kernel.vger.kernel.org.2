Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50C6D425889
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 18:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242917AbhJGQ7N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 12:59:13 -0400
Received: from mga01.intel.com ([192.55.52.88]:38489 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242890AbhJGQ7K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 12:59:10 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10130"; a="249627994"
X-IronPort-AV: E=Sophos;i="5.85,355,1624345200"; 
   d="scan'208";a="249627994"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2021 09:57:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,355,1624345200"; 
   d="scan'208";a="458862079"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 07 Oct 2021 09:57:12 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id A78E8B7; Thu,  7 Oct 2021 19:57:19 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 1/4] ASoC: Intel: bytcr_rt5640: Get platform data via dev_get_platdata()
Date:   Thu,  7 Oct 2021 19:57:12 +0300
Message-Id: <20211007165715.27463-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211007165715.27463-1-andriy.shevchenko@linux.intel.com>
References: <20211007165715.27463-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Access to platform data via dev_get_platdata() getter to make code cleaner.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 sound/soc/intel/boards/bytcr_rt5640.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index c28abe74816f..43997048a825 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -1495,12 +1495,12 @@ static int snd_byt_rt5640_mc_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	static const char * const map_name[] = { "dmic1", "dmic2", "in1", "in3", "none" };
+	struct snd_soc_acpi_mach *mach = dev_get_platdata(dev);
 	__maybe_unused const char *spk_type;
 	const struct dmi_system_id *dmi_id;
 	const char *headset2_string = "";
 	const char *lineout_string = "";
 	struct byt_rt5640_private *priv;
-	struct snd_soc_acpi_mach *mach;
 	const char *platform_name;
 	struct acpi_device *adev;
 	struct device *codec_dev;
@@ -1517,7 +1517,6 @@ static int snd_byt_rt5640_mc_probe(struct platform_device *pdev)
 
 	/* register the soc card */
 	byt_rt5640_card.dev = &pdev->dev;
-	mach = byt_rt5640_card.dev->platform_data;
 	snd_soc_card_set_drvdata(&byt_rt5640_card, priv);
 
 	/* fix index of codec dai */
-- 
2.33.0

