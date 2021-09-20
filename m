Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBE1641127E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 12:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234503AbhITKDi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 06:03:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:43792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229724AbhITKDh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 06:03:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 65C8C60240;
        Mon, 20 Sep 2021 10:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632132130;
        bh=z0yF78RdBg7hKlSTk5BKsjKH8v+YlV3IKCN8scl8+PA=;
        h=From:To:Cc:Subject:Date:From;
        b=It7WL4JobI3VYNZiMpQb3/orFfG9CEejphtd8OJuPHG2srcIB+ZJSwoIw/xnznw09
         Bm0bk1XPN8soXvom2a8nhGwUtGCFQRiXwyxAjh5j5znRvGzInCXjI2E4b48LU7h0pt
         m/V3Ex929pBT4rqU2LjvrccEi+vu8H3vCKf/7hMD2r76Q5fFUZFOa+BZxmjyz78S/3
         XpCan3VqcvbftRlNYSm+Uu1eN7YKqY55ba6y+802zo2BoQrKw/dqpoH2tUBFuvabv7
         umiTId0YNGfsHxcxYA2fQNL6BNtJvmpfvzJSW3GAHP60H0k+uZWKRRWaV34kF1FtWB
         344zktGw3md5Q==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Trevor Wu <trevor.wu@mediatek.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Arnd Bergmann <arnd@arndb.de>, Jiaxin Yu <jiaxin.yu@mediatek.com>,
        Tzung-Bi Shih <tzungbi@google.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH] ASoC: mediatek: mt8195: force COMMON_CLK dependency
Date:   Mon, 20 Sep 2021 12:01:58 +0200
Message-Id: <20210920100206.1418649-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Without CONFIG_COMMON_CLK, this driver fails to link:

ERROR: modpost: "clk_unregister_gate" [sound/soc/mediatek/mt8195/snd-soc-mt8195-afe.ko] undefined!
ERROR: modpost: "clk_register_gate" [sound/soc/mediatek/mt8195/snd-soc-mt8195-afe.ko] undefined!

Add the proper Kconfig dependency for compile testing.

Fixes: 6746cc858259 ("ASoC: mediatek: mt8195: add platform driver")
Fixes: 940ffa194547 ("ASoC: mediatek: SND_SOC_MT8195 should depend on ARCH_MEDIATEK")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/soc/mediatek/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/mediatek/Kconfig b/sound/soc/mediatek/Kconfig
index 5a2f4667d50b..268c1f74aa3e 100644
--- a/sound/soc/mediatek/Kconfig
+++ b/sound/soc/mediatek/Kconfig
@@ -187,7 +187,7 @@ config SND_SOC_MT8192_MT6359_RT1015_RT5682
 
 config SND_SOC_MT8195
 	tristate "ASoC support for Mediatek MT8195 chip"
-	depends on ARCH_MEDIATEK || COMPILE_TEST
+	depends on ARCH_MEDIATEK || (COMPILE_TEST && COMMON_CLK)
 	select SND_SOC_MEDIATEK
 	help
 	  This adds ASoC platform driver support for Mediatek MT8195 chip
-- 
2.29.2

