Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB51433F13
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 21:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234832AbhJSTRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 15:17:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:40656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233744AbhJSTRL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 15:17:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 87EC26136F;
        Tue, 19 Oct 2021 19:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634670898;
        bh=/znmkFn+1hv2P3Gitl75yKUrCACWkay2CRqRv1A/zkE=;
        h=From:To:Cc:Subject:Date:From;
        b=ltitQs67F5lcd0NsyCr7JXCQz3HfQUheX6dZx0f100TfB6DPwGp9AL+3iEphBNwhJ
         LsUkWdjdSQBnXCcefttZPEMgi/fnGuOvEpmHMwjLatRX/R8AOpcp4VKjyBlsdMLmIX
         uhteC0ayykb9Dy6Mv3pain3D7a4BL1z6tJJjblXu8uLgqyXqKBo1lxgh+2DooGGrED
         sTDBV6jyaWWQIpFK5A0yIfcROO2ug3WSXYhquDcnddVs5VFwjUVrcw6b/ktcOW7dYh
         bmtkgtFxWTdBvRnk9HeTqNWIqFAqsuvG6c3V47en7TfJJHxQoqdj7udyvkSLWwlFfY
         ZNEHLnkkiAWfA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: amd: vangogh: add SPI dependency
Date:   Tue, 19 Oct 2021 21:14:43 +0200
Message-Id: <20211019191453.3047514-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Without CONFIG_SPI, this fails to build:

WARNING: unmet direct dependencies detected for SND_SOC_CS35L41_SPI
  Depends on [n]: SOUND [=m] && !UML && SND [=m] && SND_SOC [=m] && SPI_MASTER [=n]
  Selected by [m]:
  - SND_SOC_AMD_VANGOGH_MACH [=m] && SOUND [=m] && !UML && SND [=m] && SND_SOC [=m] && SND_SOC_AMD_ACP5x [=m] && I2C [=y]
ERROR: modpost: "spi_setup" [sound/soc/codecs/snd-soc-cs35l41-spi.ko] undefined!
ERROR: modpost: "__devm_regmap_init_spi" [sound/soc/codecs/snd-soc-cs35l41-spi.ko] undefined!

Fixes: 96792fdd77cd ("ASoC: amd: enable vangogh platform machine driver build")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/soc/amd/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/amd/Kconfig b/sound/soc/amd/Kconfig
index d91a9399777c..edee2098c82e 100644
--- a/sound/soc/amd/Kconfig
+++ b/sound/soc/amd/Kconfig
@@ -68,7 +68,7 @@ config SND_SOC_AMD_VANGOGH_MACH
 	tristate "AMD Vangogh support for NAU8821 CS35L41"
 	select SND_SOC_NAU8821
 	select SND_SOC_CS35L41_SPI
-	depends on SND_SOC_AMD_ACP5x && I2C
+	depends on SND_SOC_AMD_ACP5x && I2C && SPI
 	help
 	  This option enables machine driver for Vangogh platform
 	  using NAU8821 and CS35L41 codecs.
-- 
2.29.2

