Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE9663FE039
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 18:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344021AbhIAQmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 12:42:55 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:52708 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245469AbhIAQmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 12:42:54 -0400
Received: from localhost.localdomain (133-32-232-101.west.xps.vectant.ne.jp [133.32.232.101]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id 181GeCO2005174;
        Thu, 2 Sep 2021 01:40:12 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 181GeCO2005174
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1630514413;
        bh=sQ2RhCsMu7aC76iwNKL9hAmPl8fQjIe1J0BMr9NvZ0o=;
        h=From:To:Cc:Subject:Date:From;
        b=RmYm1BYTcVeJRHPm7je0GVran6Qp+4DLC45oR77rSi4UO6CSNc8eM3OJJgPiqHIZq
         yfmAG7FOOTugHXxovjhfvPFwwQ6oBbCbIIhzlHjKsOv1fQjNxRJ1sVryoPai+ZyAt9
         Nu9DmxfAeGyORCVP6trNudIw/me93dZBun5VPxnN0cgoAx9pUvC9ay3v8rqqi54fNm
         gPJNmJT08CgJnP8N4APonhJGQQRhIRcrnk43GkCLv0Y5HtiWC5Br5GT3h+rxe6jAe1
         ZisgioWcqZbCGyX3W+KoFsot35itxdScZ4oLkicRBlt1fRBzMI4HUdQ2P8ve8jN2n+
         XuZpYroh1dGzw==
X-Nifty-SrcIP: [133.32.232.101]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     ALSA Development Mailing List <alsa-devel@alsa-project.org>
Cc:     =?UTF-8?q?P=8F=AB=B1ter=20Ujfalusi?= <peter.ujfalusi@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: ti: rename CONFIG_SND_SOC_DM365_VOICE_CODEC_MODULE
Date:   Thu,  2 Sep 2021 01:40:09 +0900
Message-Id: <20210901164009.1546967-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kconfig generates include/generated/autoconf.h to make CONFIG options
available to the pre-processor. Symbols with the value 'm' are suffixed
with '_MODULE'

Here is a conflict; CONFIG_FOO=m results in '#define CONFIG_FOO_MODULE 1',
but CONFIG_FOO_MODULE=y also results in the same define.

Also, CONFIG options that end with '_MODULE' confuse the Kconfig/fixdep
interaction; fixdep always assumes CONFIG_FOO_MODULE comes from
CONFIG_FOO=m, so the dependency is not properly tracked for symbols
that end with '_MODULE'.

For these reasons, CONFIG options that end with '_MODULE' should be
avoided in general. (I am planning on adding a check in Kconfig.)

This is the only case in the current kernel.

The new option name was suggested by Péter Ujfalusi. [1]

[1] https://lore.kernel.org/all/d9e777dc-d274-92ee-4d77-711bfd553611@gmail.com/

Fixes: 147162f57515 ("ASoC: ti: fix SND_SOC_DM365_VOICE_CODEC dependencies")
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 sound/soc/ti/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/ti/Kconfig b/sound/soc/ti/Kconfig
index 698d7bc84dcf..3260a30d3d54 100644
--- a/sound/soc/ti/Kconfig
+++ b/sound/soc/ti/Kconfig
@@ -211,7 +211,7 @@ config SND_SOC_DM365_VOICE_CODEC
 	  Say Y if you want to add support for SoC On-chip voice codec
 endchoice
 
-config SND_SOC_DM365_VOICE_CODEC_MODULE
+config SND_SOC_DM365_SELECT_VOICE_CODECS
 	def_tristate y
 	depends on SND_SOC_DM365_VOICE_CODEC && SND_SOC
 	select MFD_DAVINCI_VOICECODEC
-- 
2.30.2

