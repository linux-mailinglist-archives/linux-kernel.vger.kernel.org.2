Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBA233D11ED
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 17:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239767AbhGUOYk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 10:24:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:58406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239462AbhGUOYi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 10:24:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 19E1B60FF1;
        Wed, 21 Jul 2021 15:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626879914;
        bh=LlZsTCwo55N+RZAir1Av59XUrJ9QoPgdyfVVcThgmU0=;
        h=From:To:Cc:Subject:Date:From;
        b=WKZDCgOBjqILAGhDpdTVHkDHsrxce8rMUvBPzPZqC3HXdO83Q8ga62HWf2xGvmovt
         7jg+Y5v/9rdSQx9w9jJUsnOHWep2quxQfaVP4OYKRfhsJHaWUimWOu7iGbFeaDsjYL
         R1y/p7bPfifpppU71AMjt7JQ+vYjCcZ72UqJ1nHiCOA93IgEDuOlufjpxP4MO6JQU3
         w7/6maXf1yz+hBbvHGYaYnrZyXQmyrEMFQWoqecWo44Cw2DI3HCbCgjzpDi9nbxnOJ
         pJrdqsrwvsmBjSfyCWrkMtn1F4j1+4GqezA1TZR0wAtFYHp1fb2A0d3/+3x6Mc89on
         A5Aud3XlQad9A==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: codecs: wcd938x: fix wcd module dependency
Date:   Wed, 21 Jul 2021 17:04:45 +0200
Message-Id: <20210721150510.1837221-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

With SND_SOC_ALL_CODECS=y and SND_SOC_WCD938X_SDW=m, there is a link
error from a reverse dependency, since the built-in codec driver calls
into the modular soundwire back-end:

x86_64-linux-ld: sound/soc/codecs/wcd938x.o: in function `wcd938x_codec_free':
wcd938x.c:(.text+0x2c0): undefined reference to `wcd938x_sdw_free'
x86_64-linux-ld: sound/soc/codecs/wcd938x.o: in function `wcd938x_codec_hw_params':
wcd938x.c:(.text+0x2f6): undefined reference to `wcd938x_sdw_hw_params'
x86_64-linux-ld: sound/soc/codecs/wcd938x.o: in function `wcd938x_codec_set_sdw_stream':
wcd938x.c:(.text+0x332): undefined reference to `wcd938x_sdw_set_sdw_stream'
x86_64-linux-ld: sound/soc/codecs/wcd938x.o: in function `wcd938x_tx_swr_ctrl':
wcd938x.c:(.text+0x23de): undefined reference to `wcd938x_swr_get_current_bank'
x86_64-linux-ld: sound/soc/codecs/wcd938x.o: in function `wcd938x_bind':
wcd938x.c:(.text+0x2579): undefined reference to `wcd938x_sdw_device_get'
x86_64-linux-ld: wcd938x.c:(.text+0x25a1): undefined reference to `wcd938x_sdw_device_get'
x86_64-linux-ld: wcd938x.c:(.text+0x262a): undefined reference to `__devm_regmap_init_sdw'

Work around this using two small hacks: An added Kconfig dependency
prevents the main driver from being built-in when soundwire support
itself is a loadable module to allow calling devm_regmap_init_sdw(),
and a Makefile trick links the wcd938x-sdw backend as built-in
if needed to solve the dependency between the two modules.

Fixes: 045442228868 ("ASoC: codecs: wcd938x: add audio routing and Kconfig")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
I saw this on -rc2, please ignore if this is already fixed
---
 sound/soc/codecs/Kconfig  | 1 +
 sound/soc/codecs/Makefile | 5 ++++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 7ebae3f09435..459deba31485 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -1558,6 +1558,7 @@ config SND_SOC_WCD934X
 
 config SND_SOC_WCD938X
 	tristate
+	depends on SOUNDWIRE || !SOUNDWIRE
 
 config SND_SOC_WCD938X_SDW
 	tristate "WCD9380/WCD9385 Codec - SDW"
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index de8b83dd2c76..7bb38c370842 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -583,7 +583,10 @@ obj-$(CONFIG_SND_SOC_WCD_MBHC)	+= snd-soc-wcd-mbhc.o
 obj-$(CONFIG_SND_SOC_WCD9335)	+= snd-soc-wcd9335.o
 obj-$(CONFIG_SND_SOC_WCD934X)	+= snd-soc-wcd934x.o
 obj-$(CONFIG_SND_SOC_WCD938X)	+= snd-soc-wcd938x.o
-obj-$(CONFIG_SND_SOC_WCD938X_SDW) += snd-soc-wcd938x-sdw.o
+ifdef CONFIG_SND_SOC_WCD938X_SDW
+# avoid link failure by forcing sdw code built-in when needed
+obj-$(CONFIG_SND_SOC_WCD938X) += snd-soc-wcd938x-sdw.o
+endif
 obj-$(CONFIG_SND_SOC_WL1273)	+= snd-soc-wl1273.o
 obj-$(CONFIG_SND_SOC_WM0010)	+= snd-soc-wm0010.o
 obj-$(CONFIG_SND_SOC_WM1250_EV1) += snd-soc-wm1250-ev1.o
-- 
2.29.2

