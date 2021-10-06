Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96217424463
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 19:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238111AbhJFRhP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 13:37:15 -0400
Received: from mga01.intel.com ([192.55.52.88]:21963 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238130AbhJFRhN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 13:37:13 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10129"; a="249341611"
X-IronPort-AV: E=Sophos;i="5.85,352,1624345200"; 
   d="scan'208";a="249341611"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2021 10:35:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,352,1624345200"; 
   d="scan'208";a="524337490"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 06 Oct 2021 10:35:08 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 9B10A159; Wed,  6 Oct 2021 20:35:15 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 0/4] ASoC: Intel: bytcht_es8316: few cleanups
Date:   Wed,  6 Oct 2021 20:33:45 +0300
Message-Id: <20211006173349.84684-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The small set of cleanups against bytcht_es8316 board file.

In v3:
- actually added a Pierre's tag (Mark)

In v2:
- added tag (Pierre)
- added commit message to the patch 2 (Joe)

Andy Shevchenko (4):
  ASoC: Intel: bytcht_es8316: Get platform data via dev_get_platdata()
  ASoC: Intel: bytcht_es8316: Use temporary variable for struct device
  ASoC: Intel: bytcht_es8316: Switch to use gpiod_get_optional()
  ASoC: Intel: bytcht_es8316: Utilize dev_err_probe() to avoid log
    saturation

 sound/soc/intel/boards/bytcht_es8316.c | 37 +++++++++-----------------
 1 file changed, 12 insertions(+), 25 deletions(-)

-- 
2.33.0

