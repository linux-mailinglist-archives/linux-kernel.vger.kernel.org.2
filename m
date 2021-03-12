Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09EA6339637
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 19:23:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231789AbhCLSXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 13:23:16 -0500
Received: from mga02.intel.com ([134.134.136.20]:36913 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232253AbhCLSXG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 13:23:06 -0500
IronPort-SDR: 9yEM4Zs5/60D3/DMRHGfiXu8R3LYcBx+WQ+GX5j5WGHLNVA61qkyi4336y6vfRMhAiFGk8aVpL
 sQZF8nnFV1oA==
X-IronPort-AV: E=McAfee;i="6000,8403,9921"; a="175999073"
X-IronPort-AV: E=Sophos;i="5.81,244,1610438400"; 
   d="scan'208";a="175999073"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2021 10:23:06 -0800
IronPort-SDR: dz+4xBIo5L82iNDTeCRE3tKDsS/tPmiFhGcK0H8Hbu73iirH3Xq+mARzzE4qJRL4lpj4kDEPNC
 kDV6h32oMI6w==
X-IronPort-AV: E=Sophos;i="5.81,244,1610438400"; 
   d="scan'208";a="377791892"
Received: from amiteshs-mobl.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.212.37.30])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2021 10:23:05 -0800
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     tiwai@suse.de, broonie@kernel.org, linux-kernel@vger.kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 00/23] ASoC: codecs: remove cppcheck warnings
Date:   Fri, 12 Mar 2021 12:22:23 -0600
Message-Id: <20210312182246.5153-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lots of small fixes in various codec drivers that should have no
functional impact.

Pierre-Louis Bossart (23):
  ASoC: ab8500-codec: remove useless structure
  ASoC: ad1836: remove useless return
  ASoC: adau1977: remove useless return
  ASoC: cros_ec_codec: remove null pointer dereference warning
  ASoC: cx2070x: remove useless assignment
  ASoC: cx2070x: remove duplicate else branch
  ASoC: da7219-aad: remove useless initialization
  ASoC: hdac_hdmi: remove useless initializations
  ASoC: hdac_hdmi: align function arguments
  ASoC: hdmi-codec: remove useless initialization
  ASoC: hdmi-codec: remove unused spk_mask member
  ASoC: max98090: remove useless assignment
  ASoC: mt6358: remove useless initializations
  ASoC: mt6359: remove useless assignment
  ASoC: nau8825: remove useless assignment
  ASoC: pcm1681: remove useless assignment
  ASoC: sigmadsp: align function prototype
  ASoC: sti-sas: remove unused struct members
  ASoC: tas2562: remove useless assignment
  ASoC: tas2562: remove warning on return value
  ASoC: tas2770: remove useless initialization
  ASoC: tlv320dac33: clarify expression
  ASoC: tscs454: remove useless test on PLL disable

 sound/soc/codecs/ab8500-codec.c  |  7 -------
 sound/soc/codecs/ad1836.c        |  2 --
 sound/soc/codecs/adau1977.c      |  2 --
 sound/soc/codecs/cros_ec_codec.c |  2 +-
 sound/soc/codecs/cx2072x.c       | 11 ++++-------
 sound/soc/codecs/da7219-aad.c    |  2 +-
 sound/soc/codecs/hdac_hdmi.c     | 14 +++++++-------
 sound/soc/codecs/hdac_hdmi.h     |  2 +-
 sound/soc/codecs/hdmi-codec.c    |  3 +--
 sound/soc/codecs/max98090.c      |  2 +-
 sound/soc/codecs/mt6358.c        |  4 ++--
 sound/soc/codecs/mt6359.c        |  4 ++--
 sound/soc/codecs/nau8825.c       |  2 +-
 sound/soc/codecs/pcm1681.c       |  2 +-
 sound/soc/codecs/sigmadsp.h      |  2 +-
 sound/soc/codecs/sti-sas.c       |  3 ---
 sound/soc/codecs/tas2562.c       |  3 +--
 sound/soc/codecs/tas2770.c       |  2 +-
 sound/soc/codecs/tlv320dac33.c   |  2 +-
 sound/soc/codecs/tscs454.c       |  7 ++++++-
 20 files changed, 32 insertions(+), 46 deletions(-)

-- 
2.25.1

