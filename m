Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7005447E99
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 12:11:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236992AbhKHLOY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 06:14:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:50930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236176AbhKHLOW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 06:14:22 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3D44C61360;
        Mon,  8 Nov 2021 11:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636369898;
        bh=7jjDd9CBG4/LM9amMERhrdw6zgQgalfZow+o2TL+xNc=;
        h=From:To:Cc:Subject:Date:From;
        b=ZEAOGc3d4l/towaigTVgofn/UkzylCCIJ+PhIFhCQ3xphTcn1FlajJ0XOeScD0Fyw
         lXNNInOyttPKnW/iVWxjcocDkiwdM9pPv8xJABz1ksoLMlF6g6mGC3pXaiwnEwc1UT
         zmQKV6b66LgBfc+T6dk77dvV1HuvKeCFo5m6AckiAWLzCwz8kOOQs1m24DcXr/5SRF
         XR9WkoJP/sNM0Lm9MRAkpV7knrwo/6ygiH7IZrlZSobStZgOOaYS2rF6zQSXgMgLw/
         4Sx8TEZVczKCP4O9PVmxH6c3NQdkZAkxHg/cfnlHTjVM+9L6Xw5bG0aNLGveO9brR9
         91OPC9ACS3psw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Colin Ian King <colin.king@canonical.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Bud Liviu-Alexandru <budliviu@gmail.com>,
        Paul Olaru <paul.olaru@oss.nxp.com>,
        sound-open-firmware@alsa-project.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: SOF: build compression interface into snd_sof.ko
Date:   Mon,  8 Nov 2021 12:11:14 +0100
Message-Id: <20211108111132.3800548-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

With CONFIG_SND_SOC_SOF_COMPRESS=m, the compression code is
not built into a the main SOF driver when that is built-in:

x86_64-linux-ld: sound/soc/sof/ipc.o: in function `ipc_stream_message':
ipc.c:(.text+0x5a2): undefined reference to `snd_sof_compr_fragment_elapsed'
x86_64-linux-ld: sound/soc/sof/topology.o: in function `sof_dai_load':
topology.c:(.text+0x32d1): undefined reference to `snd_sof_compr_init_elapsed_work'
x86_64-linux-ld: topology.c:(.text+0x32e1): undefined reference to `snd_sof_compr_init_elapsed_work'

Make this a 'bool' symbol so it just decides whether the
code gets built at all.

Fixes: 858f7a5c45ca ("ASoC: SOF: Introduce fragment elapsed notification API")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/soc/sof/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sof/Kconfig b/sound/soc/sof/Kconfig
index 6bb4db87af03..041c54639c4d 100644
--- a/sound/soc/sof/Kconfig
+++ b/sound/soc/sof/Kconfig
@@ -47,7 +47,7 @@ config SND_SOC_SOF_OF
 	  Say Y if you need this option. If unsure select "N".
 
 config SND_SOC_SOF_COMPRESS
-	tristate
+	bool
 	select SND_SOC_COMPRESS
 
 config SND_SOC_SOF_DEBUG_PROBES
-- 
2.29.2

