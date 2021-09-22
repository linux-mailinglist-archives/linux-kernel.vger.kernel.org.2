Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6351C413F83
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 04:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbhIVCil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 22:38:41 -0400
Received: from out0.migadu.com ([94.23.1.103]:22059 "EHLO out0.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229466AbhIVCik (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 22:38:40 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1632278228;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ddK4d5pIrtQQNOrk862QUGjXM4IpcsLs0bAShdHgcXk=;
        b=sK4J10W5afPPEsiI69FhcR8YYvZYFxxow0y8kGK3/34v77fn4lo0Jom6muC9UxrmjF6wU+
        n/58gzuQ04wtM+FBaXreDpOnA/Hsfm0dAcSGV8NKS7BQKpMFWXJXBPuCG1iO7cScGScUa8
        b/p4cR/uMO4M7ubQsyMwZizq+rZ3N84=
From:   Jackie Liu <liu.yun@linux.dev>
To:     geert+renesas@glider.be
Cc:     geert@linux-m68k.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, perex@perex.cz, liu.yun@linux.dev
Subject: [PATCH v2] ASoC: mediatek: make SND_SOC_MT8195 depends on COMMON_CLK
Date:   Wed, 22 Sep 2021 10:36:42 +0800
Message-Id: <20210922023642.3152359-1-liu.yun@linux.dev>
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

Let's add the missing real dependencies!

HAVE_CLK (clkdev_add, clkdev_drop)
COMMON_CLK (clk_unregister_gate, clk_register_gate)

Fixes: 6746cc858259 ("ASoC: mediatek: mt8195: add platform driver")
Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
---
 sound/soc/mediatek/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/mediatek/Kconfig b/sound/soc/mediatek/Kconfig
index 5a2f4667d50b..90356c8e1a3c 100644
--- a/sound/soc/mediatek/Kconfig
+++ b/sound/soc/mediatek/Kconfig
@@ -188,6 +188,7 @@ config SND_SOC_MT8192_MT6359_RT1015_RT5682
 config SND_SOC_MT8195
 	tristate "ASoC support for Mediatek MT8195 chip"
 	depends on ARCH_MEDIATEK || COMPILE_TEST
+	depends on COMMON_CLK
 	select SND_SOC_MEDIATEK
 	help
 	  This adds ASoC platform driver support for Mediatek MT8195 chip
-- 
2.25.1

