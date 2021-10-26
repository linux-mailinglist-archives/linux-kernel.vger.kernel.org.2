Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 860FF43B530
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 17:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236565AbhJZPNz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 11:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234890AbhJZPNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 11:13:51 -0400
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A835C061767
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 08:11:27 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:441:6c1a:bc30:46e])
        by xavier.telenet-ops.be with bizsmtp
        id AfBR260072hfXWm01fBRem; Tue, 26 Oct 2021 17:11:25 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1mfO6m-0084pD-Sj; Tue, 26 Oct 2021 17:11:24 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1mfO6m-00DLmn-E0; Tue, 26 Oct 2021 17:11:24 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 1/3] ASoC: amd: acp: Wrap AMD Audio ACP components in SND_SOC_AMD_ACP_COMMON
Date:   Tue, 26 Oct 2021 17:11:21 +0200
Message-Id: <53d1d63bed1865293e6f5085ead21cdbb068fb15.1635260849.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1635260849.git.geert+renesas@glider.be>
References: <cover.1635260849.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The build only descends into sound/soc/amd/acp/ if
CONFIG_SND_SOC_AMD_ACP_COMMON=y.  Hence all later config symbols should
depend on SND_SOC_AMD_ACP_COMMON, to prevent asking the user about
config symbols for driver code that won't be build anyway.

Fixes: 623621a9f9e1a2f4 ("ASoC: amd: Add common framework to support I2S on ACP SOC")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 sound/soc/amd/acp/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/amd/acp/Kconfig b/sound/soc/amd/acp/Kconfig
index 98ec18791d35ff3a..ea186cd31ba220ab 100644
--- a/sound/soc/amd/acp/Kconfig
+++ b/sound/soc/amd/acp/Kconfig
@@ -12,6 +12,8 @@ config SND_SOC_AMD_ACP_COMMON
 	  This option enables common modules for Audio-Coprocessor i.e. ACP
 	  IP block on AMD platforms.
 
+if SND_SOC_AMD_ACP_COMMON
+
 config SND_SOC_AMD_ACP_I2S
 	tristate
 
@@ -49,3 +51,5 @@ config SND_SOC_AMD_SOF_MACH
 	select SND_SOC_AMD_MACH_COMMON
 	help
 	  This option enables SOF sound card support for ACP audio.
+
+endif # SND_SOC_AMD_ACP_COMMON
-- 
2.25.1

