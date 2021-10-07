Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 553ED425882
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 18:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242862AbhJGQ6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 12:58:39 -0400
Received: from mga17.intel.com ([192.55.52.151]:30957 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232229AbhJGQ6i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 12:58:38 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10130"; a="207116357"
X-IronPort-AV: E=Sophos;i="5.85,355,1624345200"; 
   d="scan'208";a="207116357"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2021 09:45:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,355,1624345200"; 
   d="scan'208";a="524733189"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 07 Oct 2021 09:45:22 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 98BFB159; Thu,  7 Oct 2021 19:45:29 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v4 0/4] ASoC: Intel: bytcht_es8316: few cleanups
Date:   Thu,  7 Oct 2021 19:45:19 +0300
Message-Id: <20211007164523.27094-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The small set of cleanups against bytcht_es8316 board file.

In v4:
- fixed Pierre's email (Pierre)
- added Hans to the Cc list

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

