Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D8B43FF30E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 20:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346926AbhIBSOj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 14:14:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:45098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346866AbhIBSOi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 14:14:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 075FC6109E;
        Thu,  2 Sep 2021 18:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630606420;
        bh=fgmXveWCM05mSbllKfAaxxlHFe2iMk5xtIxQopJphow=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l1PtFlT2H4GNdOvcM1dANKRnyhtzuXVeLC1RT+AVVdmZwN7szaUM1p6yCqj/yV5GO
         yrDAmt6nHda48xj5MaKQ//bSob8YAqRK5kChyMO+3EDgCzbaWrTYNBk1uNXYiknQKi
         b/Ue1LZG4gNOaLL8hI62aMopH4trFp1J0wjGPWwJQ0Pvq6Nj5H13mEGvHcQ8+arYXt
         JtdG8rPQ4OyNif2EXjktsFZmGabN9rbCVAj0goVsdDhRpKRumGh5FhwlPAhECQAiYD
         bT7AmyzHqJY56kNWCk2cG5BcNsRVqQtacgV9GMK1FuNL3JRGBzqbNY5/mPzPqvymH/
         AeNBjoGWLvBbg==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH for-5.15 v3] ASoC: Intel: boards: Fix CONFIG_SND_SOC_SDW_MOCKUP select
Date:   Thu,  2 Sep 2021 11:12:18 -0700
Message-Id: <20210902181217.2958966-1-nathan@kernel.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210802212409.3207648-1-nathan@kernel.org>
References: <20210802212409.3207648-1-nathan@kernel.org>
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

Selecting a symbol does not account for dependencies. There are three
ways to resolve this:

1. Make CONFIG_SND_SOC_INTEL_SOUNDWIRE_SOF_MACH select
   CONFIG_SND_SOC_SDW_MOCKUP only if CONFIG_EXPERT is set.

2. Make CONFIG_SND_SOC_SDW_MOCKUP's prompt depend on CONFIG_EXPERT so
   that it can be selected by options that only depend on
   CONFIG_SOUNDWIRE but still appear as a prompt to the user when
   CONFIG_EXPERT is set.

3. Make CONFIG_SND_SOC_INTEL_SOUNDWIRE_SOF_MACH imply
   CONFIG_SND_SOC_SDW_MOCKUP, which will select
   CONFIG_SND_SOC_SDW_MOCKUP when its dependencies are enabled but still
   allow the user to disable it.

Go with the third option as it gives the most flexibility while
retaining the original intent of the select.

Fixes: 0ccac3bcf356 ("ASoC: Intel: boards: sof_sdw: add SoundWire mockup codecs for tests")
Suggested-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---

v2 -> v3:

* Rebase on current for-5.15.

* Add Ack tag from Pierre-Louis.

v1 -> v2:

* Switch to imply rather than select ... if ... (Pierre-Louis).

* Reword commit message to explain different solutions rather than
  explain the problem in depth.

 sound/soc/intel/boards/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/Kconfig b/sound/soc/intel/boards/Kconfig
index 046955bf717c..61b71d6c44cf 100644
--- a/sound/soc/intel/boards/Kconfig
+++ b/sound/soc/intel/boards/Kconfig
@@ -602,7 +602,7 @@ config SND_SOC_INTEL_SOUNDWIRE_SOF_MACH
 	select SND_SOC_DMIC
 	select SND_SOC_INTEL_HDA_DSP_COMMON
 	select SND_SOC_INTEL_SOF_MAXIM_COMMON
-	select SND_SOC_SDW_MOCKUP
+	imply SND_SOC_SDW_MOCKUP
 	help
 	  Add support for Intel SoundWire-based platforms connected to
 	  MAX98373, RT700, RT711, RT1308 and RT715

base-commit: 4f89ff026ddbaab49dba993ad2dc757920d0ad49
-- 
2.33.0

