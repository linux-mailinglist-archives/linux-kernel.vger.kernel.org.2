Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7636D3DDFD3
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 21:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbhHBTFp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 15:05:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:43216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231314AbhHBTFn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 15:05:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 430A3610FE;
        Mon,  2 Aug 2021 19:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627931134;
        bh=hkaaGUj6LD92fLf2eKN3+HpYv9SsLiKngPrIRD0KtlM=;
        h=From:To:Cc:Subject:Date:From;
        b=BZpOPWEXpoS4JqwJKBQ3WW6TKoUs/O6B6fl0X2XqIDOPhRAIczQ2sRhOjDSi+TUpZ
         UJwoRdWOn4u58xoJdyE6wk57hHHSuFCrZ9Qwd0RvcD75fcBO4KixsiDiBKR4PGNRoy
         d8ts/TqUVVkHMaPyKnZRDXZkj7ajNFBo4S4tm+Ls63YwceeGSJ1dLT5c+6CZqD5lRq
         K+E01boePl76Fie14FgcUnD12fGdZ9LKDqCuX2tHSjA0s9OlwlYp3WHfML1h2BcbY3
         6x/elMge61OQoubmsLtlaiTCfKyv17WzALhkWVY+Mtg5MjBlUGMYs/tP0UJvVYfNA5
         3cVxMw4iOSCDA==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH] ASoC: Intel: boards: Fix CONFIG_SND_SOC_SDW_MOCKUP select
Date:   Mon,  2 Aug 2021 12:03:52 -0700
Message-Id: <20210802190351.3201677-1-nathan@kernel.org>
X-Mailer: git-send-email 2.32.0.264.g75ae10bc75
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_SND_SOC_INTEL_SOUNDWIRE_SOF_MACH is enabled without
CONFIG_EXPERT, there is a Kconfig warning about unmet dependencies:

WARNING: unmet direct dependencies detected for SND_SOC_SDW_MOCKUP
  Depends on [n]: SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] &&
EXPERT [=n] && SOUNDWIRE [=y]
  Selected by [y]:
  - SND_SOC_INTEL_SOUNDWIRE_SOF_MACH [=y] && ...

Selecting a symbol does not account for dependencies so if symbol A
selects symbol B which depends on symbol C, symbol B or its select of
symbol A should depend on symbol C as well.

Make the CONFIG_SND_SOC_SDW_MOCKUP select in
CONFIG_SND_SOC_INTEL_SOUNDWIRE_SOF_MACH depend on CONFIG_EXPERT as the
help text for CONFIG_SND_SOC_SDW_MOCKUP indicates it is intended to be a
development option.

Fixes: 0ccac3bcf356 ("ASoC: Intel: boards: sof_sdw: add SoundWire mockup codecs for tests")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---

An alternative here is if CONFIG_SND_SOC_INTEL_SOUNDWIRE_SOF_MACH wants
to unconditionally select CONFIG_SND_SOC_SDW_MOCKUP, the "depends on
EXPERT" can be moved to the prompt (tristate "..." if EXPERT). I am
happy to send a new patch if that is what is desired.

 sound/soc/intel/boards/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/Kconfig b/sound/soc/intel/boards/Kconfig
index 046955bf717c..8284c46d7435 100644
--- a/sound/soc/intel/boards/Kconfig
+++ b/sound/soc/intel/boards/Kconfig
@@ -602,7 +602,7 @@ config SND_SOC_INTEL_SOUNDWIRE_SOF_MACH
 	select SND_SOC_DMIC
 	select SND_SOC_INTEL_HDA_DSP_COMMON
 	select SND_SOC_INTEL_SOF_MAXIM_COMMON
-	select SND_SOC_SDW_MOCKUP
+	select SND_SOC_SDW_MOCKUP if EXPERT
 	help
 	  Add support for Intel SoundWire-based platforms connected to
 	  MAX98373, RT700, RT711, RT1308 and RT715

base-commit: 170c0d7460fc4aa522995ae4096b5a442f50a1fc
-- 
2.32.0.264.g75ae10bc75

