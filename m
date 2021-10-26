Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF61B43B531
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 17:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236187AbhJZPOB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 11:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235097AbhJZPNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 11:13:51 -0400
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DFCEC061243
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 08:11:27 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:441:6c1a:bc30:46e])
        by andre.telenet-ops.be with bizsmtp
        id AfBR2600B2hfXWm01fBR8V; Tue, 26 Oct 2021 17:11:25 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1mfO6n-0084pF-BM; Tue, 26 Oct 2021 17:11:25 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1mfO6m-00DLn1-FQ; Tue, 26 Oct 2021 17:11:24 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 3/3] ASoC: amd: acp: SND_SOC_AMD_ACP_COMMON should depend on X86 && PCI
Date:   Tue, 26 Oct 2021 17:11:23 +0200
Message-Id: <30fcedce513186bf89f1f2655b665298250fdc66.1635260849.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1635260849.git.geert+renesas@glider.be>
References: <cover.1635260849.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All configuration symbols for AMD Audio ACP conponents depend on X86 &&
PCI, except for SND_SOC_AMD_ACP_COMMON.  Add a dependency on X86 && PCI
to SND_SOC_AMD_ACP_COMMON, to prevent asking the user about AMD Audio
ACP support when configuring a kernel without X86 or PCI support.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 sound/soc/amd/acp/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/amd/acp/Kconfig b/sound/soc/amd/acp/Kconfig
index 006bd2dc5f0444ec..ba6ec96f0a64993d 100644
--- a/sound/soc/amd/acp/Kconfig
+++ b/sound/soc/amd/acp/Kconfig
@@ -8,6 +8,7 @@
 config SND_SOC_AMD_ACP_COMMON
 	tristate "AMD Audio ACP Common support"
 	select SND_AMD_ACP_CONFIG
+	depends on X86 && PCI
 	help
 	  This option enables common modules for Audio-Coprocessor i.e. ACP
 	  IP block on AMD platforms.
-- 
2.25.1

