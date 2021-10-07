Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D84942594C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 19:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233719AbhJGRY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 13:24:28 -0400
Received: from mga14.intel.com ([192.55.52.115]:8233 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241253AbhJGRYZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 13:24:25 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10130"; a="226606856"
X-IronPort-AV: E=Sophos;i="5.85,355,1624345200"; 
   d="scan'208";a="226606856"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2021 10:02:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,355,1624345200"; 
   d="scan'208";a="657461405"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 07 Oct 2021 10:02:45 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 4D685B7; Thu,  7 Oct 2021 20:02:52 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 1/4] ASoC: Intel: bytcr_rt5651: Get platform data via dev_get_platdata()
Date:   Thu,  7 Oct 2021 20:02:47 +0300
Message-Id: <20211007170250.27997-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211007170250.27997-1-andriy.shevchenko@linux.intel.com>
References: <20211007170250.27997-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Access to platform data via dev_get_platdata() getter to make code cleaner.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 sound/soc/intel/boards/bytcr_rt5651.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/soc/intel/boards/bytcr_rt5651.c b/sound/soc/intel/boards/bytcr_rt5651.c
index 00c347b52863..2335cca17cc8 100644
--- a/sound/soc/intel/boards/bytcr_rt5651.c
+++ b/sound/soc/intel/boards/bytcr_rt5651.c
@@ -894,9 +894,10 @@ struct acpi_chan_package {   /* ACPICA seems to require 64 bit integers */
 
 static int snd_byt_rt5651_mc_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	static const char * const mic_name[] = { "dmic", "in1", "in2", "in12" };
+	struct snd_soc_acpi_mach *mach = dev_get_platdata(dev);
 	struct byt_rt5651_private *priv;
-	struct snd_soc_acpi_mach *mach;
 	const char *platform_name;
 	struct acpi_device *adev;
 	struct device *codec_dev;
@@ -912,8 +913,6 @@ static int snd_byt_rt5651_mc_probe(struct platform_device *pdev)
 
 	/* register the soc card */
 	byt_rt5651_card.dev = &pdev->dev;
-
-	mach = byt_rt5651_card.dev->platform_data;
 	snd_soc_card_set_drvdata(&byt_rt5651_card, priv);
 
 	/* fix index of codec dai */
-- 
2.33.0

