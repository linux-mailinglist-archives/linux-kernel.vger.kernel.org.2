Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B82A34B1A2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 23:00:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbhCZWAF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 18:00:05 -0400
Received: from mga06.intel.com ([134.134.136.31]:42664 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229933AbhCZV7q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 17:59:46 -0400
IronPort-SDR: qkgOAo7/ub2NpfV+I8Au4pEo1qtyrylA77kJVgFmi4/4lGGpf1d6iF2awmgrhCbd7DuOwEJcFW
 T2Mm2D32x71A==
X-IronPort-AV: E=McAfee;i="6000,8403,9935"; a="252577177"
X-IronPort-AV: E=Sophos;i="5.81,281,1610438400"; 
   d="scan'208";a="252577177"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2021 14:59:45 -0700
IronPort-SDR: cvMv4ltXgyHozMqp91iGvXNe2CgxJp9zV41gu6oqhn+hdNgV0W7BgUpFBc2rba+G634N9a7x+n
 M7eW3ftuOfng==
X-IronPort-AV: E=Sophos;i="5.81,281,1610438400"; 
   d="scan'208";a="416706637"
Received: from zcmahone-mobl1.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.255.231.203])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2021 14:59:45 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     tiwai@suse.de, broonie@kernel.org, linux-kernel@vger.kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 00/17] ASoC: remove cppcheck warnings for multiple SOCs
Date:   Fri, 26 Mar 2021 16:59:10 -0500
Message-Id: <20210326215927.936377-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Trivial cleanups to make cppcheck less verbose.

There should be no functionality change, except for the 'sti_uniperif'
patch where an error check was added.

Pierre-Louis Bossart (17):
  ASoC: amd: renoir: acp3x-pdm-dma: remove unnecessary assignments
  ASoC: atmel: fix shadowed variable
  ASoC: atmel: atmel-i2s: remove useless initialization
  ASoC: bcm: cygnus_ssp: remove useless initialization
  ASoC: meson: axg-tdmin: remove useless assignment
  ASoC: meson: axg-tdmout: remove useless assignment
  ASoC: pxa: remove useless assignment
  ASoC: sti: sti_uniperif: add missing error check
  ASoC: sti: uniperif: align function prototypes
  ASoC: stm: stm32_adfsdm: fix snprintf format string
  ASoC: sunxi: sun8i-codec: clarify expression
  ASoC: tegra: tegra20_das: clarify expression
  ASoC: tegra: tegra20_das: align function prototypes
  ASoC: ti: omap-abe-twl6040: remove useless assignment
  ASoC: ti: omap-mcsp: remove duplicate test
  ASoC: ux500: mop500: rename shadowing variable
  ASoC: ux500: mop500: align function prototype

 sound/soc/amd/renoir/acp3x-pdm-dma.c | 2 --
 sound/soc/atmel/atmel-classd.c       | 6 +++---
 sound/soc/atmel/atmel-i2s.c          | 2 +-
 sound/soc/bcm/cygnus-ssp.c           | 2 +-
 sound/soc/meson/axg-tdmin.c          | 2 +-
 sound/soc/meson/axg-tdmout.c         | 2 +-
 sound/soc/pxa/mmp-pcm.c              | 2 +-
 sound/soc/sti/sti_uniperif.c         | 2 ++
 sound/soc/sti/uniperif.h             | 4 ++--
 sound/soc/stm/stm32_adfsdm.c         | 2 +-
 sound/soc/sunxi/sun8i-codec.c        | 2 +-
 sound/soc/tegra/tegra20_das.c        | 8 ++++----
 sound/soc/tegra/tegra20_das.h        | 6 +++---
 sound/soc/ti/omap-abe-twl6040.c      | 2 +-
 sound/soc/ti/omap-mcbsp.c            | 3 +--
 sound/soc/ux500/mop500.c             | 6 +++---
 sound/soc/ux500/mop500_ab8500.h      | 2 +-
 17 files changed, 27 insertions(+), 28 deletions(-)

-- 
2.25.1

