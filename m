Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33466410428
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 07:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232911AbhIRFS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Sep 2021 01:18:27 -0400
Received: from out1.migadu.com ([91.121.223.63]:32770 "EHLO out1.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231805AbhIRFSZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 01:18:25 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1631942220;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=YgJDbXaqJ3Ha3WbQsOvoy/UQMUfudfwN7QWrGoG+YYI=;
        b=G25mYM0YqrPowWgM+C/uJt5kHfK8K618C2MeGqcXOMaIWHNtCEUPVByRxUr9PrHuyU3ezh
        M+if66DkyUaWBPcl+Yel/nNi7eX13p4Jwd9OOw+qA+mtXxVpRTM+ChFl3EibFGv/3l/3Il
        mbUpoGFYGe0YPXx3cwghRbVPYhWbv+Y=
From:   Jackie Liu <liu.yun@linux.dev>
To:     geert+renesas@glider.be
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        perex@perex.cz
Subject: [PATCH] ASoC: mediatek: SND_SOC_MT8195 remove depends on COMPILE_TEST
Date:   Sat, 18 Sep 2021 13:16:32 +0800
Message-Id: <20210918051632.1297025-1-liu.yun@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: liu.yun@linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jackie Liu <liuyun01@kylinos.cn>

After compiling with COMPILE_TEST, we are most likely to compile on a
different architecture, such as x86. At this time, it is possible that
the HAVE_CLK macro is not selected, resulting in compilation failure.

Avoid fail like:

  Kernel: arch/x86/boot/bzImage is ready  (#17)
  ERROR: modpost: "clkdev_add" [sound/soc/mediatek/mt8195/snd-soc-mt8195-afe.ko] undefined!
  ERROR: modpost: "clkdev_drop" [sound/soc/mediatek/mt8195/snd-soc-mt8195-afe.ko] undefined!
  ERROR: modpost: "clk_unregister_gate" [sound/soc/mediatek/mt8195/snd-soc-mt8195-afe.ko] undefined!
  ERROR: modpost: "clk_register_gate" [sound/soc/mediatek/mt8195/snd-soc-mt8195-afe.ko] undefined!
  make[1]: *** [scripts/Makefile.modpost:134: modules-only.symvers] Error 1
  make[1]: *** Deleting file 'modules-only.symvers'
  make: *** [Makefile:1783: modules] Error 2

Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Fixes: 940ffa194547 ("ASoC: mediatek: SND_SOC_MT8195 should depend on ARCH_MEDIATEK")
Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
---
 sound/soc/mediatek/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/mediatek/Kconfig b/sound/soc/mediatek/Kconfig
index 5a2f4667d50b..2287328e845c 100644
--- a/sound/soc/mediatek/Kconfig
+++ b/sound/soc/mediatek/Kconfig
@@ -187,7 +187,7 @@ config SND_SOC_MT8192_MT6359_RT1015_RT5682
 
 config SND_SOC_MT8195
 	tristate "ASoC support for Mediatek MT8195 chip"
-	depends on ARCH_MEDIATEK || COMPILE_TEST
+	depends on ARCH_MEDIATEK
 	select SND_SOC_MEDIATEK
 	help
 	  This adds ASoC platform driver support for Mediatek MT8195 chip
-- 
2.25.1

