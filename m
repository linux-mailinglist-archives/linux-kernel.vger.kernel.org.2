Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEF8840AB8A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 12:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231578AbhINKVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 06:21:01 -0400
Received: from mga18.intel.com ([134.134.136.126]:48821 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229968AbhINKUw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 06:20:52 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10106"; a="209044045"
X-IronPort-AV: E=Sophos;i="5.85,292,1624345200"; 
   d="scan'208";a="209044045"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2021 03:19:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,292,1624345200"; 
   d="scan'208";a="543895824"
Received: from brentlu-brix.itwn.intel.com ([10.5.253.10])
  by FMSMGA003.fm.intel.com with ESMTP; 14 Sep 2021 03:19:24 -0700
From:   Brent Lu <brent.lu@intel.com>
To:     alsa-devel@alsa-project.org
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Brent Lu <brent.lu@intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Yong Zhi <yong.zhi@intel.com>,
        Vamshi Krishna Gopal <vamshi.krishna.gopal@intel.com>,
        Tzung-Bi Shih <tzungbi@google.com>,
        Rander Wang <rander.wang@intel.com>,
        Paul Olaru <paul.olaru@oss.nxp.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] Support ALC5682I-VS codec
Date:   Tue, 14 Sep 2021 18:18:43 +0800
Message-Id: <20210914101847.778688-1-brent.lu@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support the ALC5682I-VS codec in Intel's rt5682 machine driver with
three board configurations.

Brent Lu (4):
  ASoC: Intel: sof_rt5682: support ALC5682I-VS codec
  ASoC: intel: sof_rt5682: support jsl_rt5682s_rt1015p board
  ASoC: intel: sof_rt5682: support jsl_rt5682s_rt1015 board
  ASoC: intel: sof_rt5682: support jsl_rt5682s_mx98360a board

 sound/soc/intel/boards/Kconfig                |   1 +
 sound/soc/intel/boards/sof_rt5682.c           | 105 +++++++++++++++---
 .../intel/common/soc-acpi-intel-jsl-match.c   |  24 ++++
 3 files changed, 112 insertions(+), 18 deletions(-)

-- 
2.25.1

