Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05399424460
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 19:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238424AbhJFRhI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 13:37:08 -0400
Received: from mga07.intel.com ([134.134.136.100]:4781 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231175AbhJFRhE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 13:37:04 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10129"; a="289559507"
X-IronPort-AV: E=Sophos;i="5.85,352,1624345200"; 
   d="scan'208";a="289559507"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2021 10:35:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,352,1624345200"; 
   d="scan'208";a="657073962"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 06 Oct 2021 10:35:09 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id A8DDB56; Wed,  6 Oct 2021 20:35:15 +0300 (EEST)
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
Subject: [PATCH v3 1/4] ASoC: Intel: bytcht_es8316: Get platform data via dev_get_platdata()
Date:   Wed,  6 Oct 2021 20:33:46 +0300
Message-Id: <20211006173349.84684-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211006173349.84684-1-andriy.shevchenko@linux.intel.com>
References: <20211006173349.84684-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Access to platform data via dev_get_platdata() getter to make code cleaner.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.com>
---
 sound/soc/intel/boards/bytcht_es8316.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/soc/intel/boards/bytcht_es8316.c b/sound/soc/intel/boards/bytcht_es8316.c
index 1bb9b8e7bcc7..4360519fbb0c 100644
--- a/sound/soc/intel/boards/bytcht_es8316.c
+++ b/sound/soc/intel/boards/bytcht_es8316.c
@@ -456,12 +456,12 @@ static const struct dmi_system_id byt_cht_es8316_quirk_table[] = {
 
 static int snd_byt_cht_es8316_mc_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	static const char * const mic_name[] = { "in1", "in2" };
+	struct snd_soc_acpi_mach *mach = dev_get_platdata(dev);
 	struct property_entry props[MAX_NO_PROPS] = {};
 	struct byt_cht_es8316_private *priv;
 	const struct dmi_system_id *dmi_id;
-	struct device *dev = &pdev->dev;
-	struct snd_soc_acpi_mach *mach;
 	struct fwnode_handle *fwnode;
 	const char *platform_name;
 	struct acpi_device *adev;
@@ -476,7 +476,6 @@ static int snd_byt_cht_es8316_mc_probe(struct platform_device *pdev)
 	if (!priv)
 		return -ENOMEM;
 
-	mach = dev->platform_data;
 	/* fix index of codec dai */
 	for (i = 0; i < ARRAY_SIZE(byt_cht_es8316_dais); i++) {
 		if (!strcmp(byt_cht_es8316_dais[i].codecs->name,
-- 
2.33.0

