Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C113143B52E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 17:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235537AbhJZPNw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 11:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232745AbhJZPNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 11:13:51 -0400
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48515C061745
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 08:11:27 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:441:6c1a:bc30:46e])
        by xavier.telenet-ops.be with bizsmtp
        id AfBR260062hfXWm01fBRel; Tue, 26 Oct 2021 17:11:25 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1mfO6m-0084pE-SH; Tue, 26 Oct 2021 17:11:24 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1mfO6m-00DLmu-Ep; Tue, 26 Oct 2021 17:11:24 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 2/3] ASoC: amd: acp: SND_SOC_AMD_{LEGACY_MACH,SOF_MACH} should depend on X86 && PCI && I2C
Date:   Tue, 26 Oct 2021 17:11:22 +0200
Message-Id: <dfb03bd33117e26f3f04ce227bb28095109b3d80.1635260849.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1635260849.git.geert+renesas@glider.be>
References: <cover.1635260849.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If not all of CONFIG_X86, CONFIG_PCI, and CONFIG_I2C are set:

    WARNING: unmet direct dependencies detected for SND_SOC_AMD_MACH_COMMON
      Depends on [n]: SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && X86 && PCI [=y] && I2C [=y]
      Selected by [y]:
      - SND_SOC_AMD_LEGACY_MACH [=y] && SOUND [=y] && !UML && SND [=y] && SND_SOC [=y]
      - SND_SOC_AMD_SOF_MACH [=y] && SOUND [=y] && !UML && SND [=y] && SND_SOC [=y]

As SND_SOC_AMD_MACH_COMMON depends on X86 && PCI && I2C, all symbols
selecting it should depend on X86 && PCI && I2C, too.

Fixes: 9d8a7be88b3365e4 ("ASoC: amd: acp: Add legacy sound card support for Chrome audio")
Fixes: 9f84940f5004e1d2 ("ASoC: amd: acp: Add SOF audio support on Chrome board")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 sound/soc/amd/acp/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/amd/acp/Kconfig b/sound/soc/amd/acp/Kconfig
index ea186cd31ba220ab..006bd2dc5f0444ec 100644
--- a/sound/soc/amd/acp/Kconfig
+++ b/sound/soc/amd/acp/Kconfig
@@ -43,12 +43,14 @@ config SND_SOC_AMD_MACH_COMMON
 config SND_SOC_AMD_LEGACY_MACH
 	tristate "AMD Legacy Machine Driver Support"
 	select SND_SOC_AMD_MACH_COMMON
+	depends on X86 && PCI && I2C
 	help
 	  This option enables legacy sound card support for ACP audio.
 
 config SND_SOC_AMD_SOF_MACH
 	tristate "AMD SOF Machine Driver Support"
 	select SND_SOC_AMD_MACH_COMMON
+	depends on X86 && PCI && I2C
 	help
 	  This option enables SOF sound card support for ACP audio.
 
-- 
2.25.1

