Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39DC239CBFC
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 03:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbhFFBDI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Jun 2021 21:03:08 -0400
Received: from mga03.intel.com ([134.134.136.65]:35393 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230025AbhFFBDG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jun 2021 21:03:06 -0400
IronPort-SDR: ZAYlGQeYPl0/GPVcYoNtAM7flg3GF32m2+cQnQlfJ/1oMXinif/DoKF/mdj6sR0fqxqpmvKIF7
 1hJN6VjkZarQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10006"; a="204494372"
X-IronPort-AV: E=Sophos;i="5.83,252,1616482800"; 
   d="scan'208";a="204494372"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2021 18:01:16 -0700
IronPort-SDR: 8gAI/qrO6aPqbZyaDWytxL5LkckqlbCZJl4rgQ68lj1xViPc1LkcG6gXqRmxAWG5JwBuW0ASAm
 5jY24llwIKzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,252,1616482800"; 
   d="scan'208";a="412724626"
Received: from brentlu-desk0.itwn.intel.com ([10.5.253.32])
  by fmsmga007.fm.intel.com with ESMTP; 05 Jun 2021 18:01:12 -0700
From:   Brent Lu <brent.lu@intel.com>
To:     alsa-devel@alsa-project.org
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Brent Lu <brent.lu@intel.com>,
        Rander Wang <rander.wang@intel.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Dharageswari R <dharageswari.r@intel.com>,
        Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Naveen Manohar <naveen.m@intel.com>,
        Yong Zhi <yong.zhi@intel.com>,
        Vamshi Krishna Gopal <vamshi.krishna.gopal@intel.com>,
        Fred Oh <fred.oh@linux.intel.com>,
        Tzung-Bi Shih <tzungbi@google.com>
Subject: [PATCH 0/4] Support CS42L42 on JSL platform
Date:   Sun,  6 Jun 2021 08:40:58 +0800
Message-Id: <20210606004102.26190-1-brent.lu@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series consists four patches. Patch 1 adds dai sequence support
for cml/jsl/tgl platforms which is different from the sequence on glk
platform. Patch 2 adds max98360a support to the maxim-common module.
Patch 3 adds driver data for jsl_cs4242_mx98360a which supports
cs42l42 and max98360a running on jsl boards. Patch 4 refactor the
sof_rt5682 to use the max98360 code in the maxim-common module.


Brent Lu (4):
  ASoC: Intel: sof_cs42l42: support JSL DAI link sequence
  ASoC: Intel: maxim-common: support max98360a
  ASoC: intel: sof_cs42l42: add support for jsl_cs4242_mx98360a
  ASoC: Intel: sof_rt5682: code refactor for max98360a

 sound/soc/intel/boards/sof_cs42l42.c          | 340 ++++++++++++------
 sound/soc/intel/boards/sof_maxim_common.c     |  17 +-
 sound/soc/intel/boards/sof_maxim_common.h     |   4 +-
 sound/soc/intel/boards/sof_rt5682.c           |  52 +--
 .../intel/common/soc-acpi-intel-jsl-match.c   |   8 +
 5 files changed, 254 insertions(+), 167 deletions(-)

-- 
2.17.1

