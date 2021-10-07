Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C53064258CD
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 19:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243023AbhJGRF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 13:05:58 -0400
Received: from mga01.intel.com ([192.55.52.88]:39494 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242992AbhJGRF4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 13:05:56 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10130"; a="249630160"
X-IronPort-AV: E=Sophos;i="5.85,355,1624345200"; 
   d="scan'208";a="249630160"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2021 10:02:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,355,1624345200"; 
   d="scan'208";a="715241973"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 07 Oct 2021 10:02:45 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 405AB159; Thu,  7 Oct 2021 20:02:52 +0300 (EEST)
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
Subject: [PATCH v2 0/4] ASoC: Intel: bytcr_rt5651: few cleanups
Date:   Thu,  7 Oct 2021 20:02:46 +0300
Message-Id: <20211007170250.27997-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The small set of cleanups against bytcr_rt5651 board file.

In v2:
- added commit message to patch 2 (Joe, Pierre)
- added cover letter (Pierre)
- added Hans to Cc list (Hans)

Andy Shevchenko (4):
  ASoC: Intel: bytcr_rt5651: Get platform data via dev_get_platdata()
  ASoC: Intel: bytcr_rt5651: Use temporary variable for struct device
  ASoC: Intel: bytcr_rt5651: use devm_clk_get_optional() for mclk
  ASoC: Intel: bytcr_rt5651: Utilize dev_err_probe() to avoid log
    saturation

 sound/soc/intel/boards/bytcr_rt5651.c | 118 +++++++++++---------------
 1 file changed, 50 insertions(+), 68 deletions(-)

-- 
2.33.0

