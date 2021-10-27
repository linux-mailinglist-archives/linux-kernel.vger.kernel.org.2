Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE5943C4FF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 10:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239245AbhJ0I0c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 04:26:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:50226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237200AbhJ0I02 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 04:26:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1D15C61073;
        Wed, 27 Oct 2021 08:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635323043;
        bh=kWIOhYrTxqoTvouRepas2OKBvKfTPbZbrCIYHvdOjWg=;
        h=From:To:Cc:Subject:Date:From;
        b=GZaa9T7Q7NhB7hGwsy0V4Ul9Prcqgxiz+bGj3tF9S6KzSWvc6wlUr1KahH09Spj4V
         T/oUPrADHk8gV4xXLLm/j+BV2Gh9IdXtsh8kigyi19gw7DTQ5v22+syKyFeT0SDX2u
         hwztaQh4XivqaV17XBk40+/w+mt9/Tj13B/aM6z9MmByOJ/TlO0wxPMzKGCMGIifCw
         TfKV4MW6oKzZRbnjcIHJtExDUuCybJ2b3F0IGKAVRskvaENVJw/fvSpfi9unluLMs2
         v/ZAAQA/7mVpJ/NhWkpuRdoM40ETdjmJTImqCK9+C44xgXr4yvZ/uWkXwOc7ptYK4C
         7+zndrpNhTypg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: amd: acp: fix Kconfig dependencies
Date:   Wed, 27 Oct 2021 10:23:46 +0200
Message-Id: <20211027082359.52248-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The CONFIG_SND_SOC_AMD_MACH_COMMON has some dependencies that
are not checked by the symbols that select it:

WARNING: unmet direct dependencies detected for SND_SOC_AMD_MACH_COMMON
  Depends on [n]: SOUND [=y] && !UML && SND [=m] && SND_SOC [=m] && X86 && PCI [=y] && I2C [=n]
  Selected by [m]:
  - SND_SOC_AMD_LEGACY_MACH [=m] && SOUND [=y] && !UML && SND [=m] && SND_SOC [=m]
  - SND_SOC_AMD_SOF_MACH [=m] && SOUND [=y] && !UML && SND [=m] && SND_SOC [=m]

WARNING: unmet direct dependencies detected for SND_SOC_AMD_MACH_COMMON
  Depends on [n]: SOUND [=m] && !UML && SND [=m] && SND_SOC [=m] && X86 && PCI [=n] && I2C [=m]
  Selected by [m]:
  - SND_SOC_AMD_LEGACY_MACH [=m] && SOUND [=m] && !UML && SND [=m] && SND_SOC [=m]

Make this more consistent by adding the same checks everywhere.

Fixes: 9d8a7be88b33 ("ASoC: amd: acp: Add legacy sound card support for Chrome audio")
Fixes: 9f84940f5004 ("ASoC: amd: acp: Add SOF audio support on Chrome board")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/soc/amd/acp/Kconfig | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/amd/acp/Kconfig b/sound/soc/amd/acp/Kconfig
index 98ec18791d35..737135357ee2 100644
--- a/sound/soc/amd/acp/Kconfig
+++ b/sound/soc/amd/acp/Kconfig
@@ -28,24 +28,26 @@ config SND_AMD_ASOC_RENOIR
 
 config SND_SOC_AMD_MACH_COMMON
 	tristate
+	depends on X86 && PCI && I2C
 	select CLK_FIXED_FCH
 	select SND_SOC_RT5682_I2C
 	select SND_SOC_DMIC
 	select SND_SOC_RT1019
 	select SND_SOC_MAX98357A
 	select SND_SOC_RT5682S
-	depends on X86 && PCI && I2C
 	help
 	  This option enables common Machine driver module for ACP.
 
 config SND_SOC_AMD_LEGACY_MACH
 	tristate "AMD Legacy Machine Driver Support"
+	depends on X86 && PCI && I2C
 	select SND_SOC_AMD_MACH_COMMON
 	help
 	  This option enables legacy sound card support for ACP audio.
 
 config SND_SOC_AMD_SOF_MACH
 	tristate "AMD SOF Machine Driver Support"
+	depends on X86 && PCI && I2C
 	select SND_SOC_AMD_MACH_COMMON
 	help
 	  This option enables SOF sound card support for ACP audio.
-- 
2.29.2

