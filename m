Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D7914045D7
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 08:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350904AbhIIG4s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 02:56:48 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:34364 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231176AbhIIG4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 02:56:47 -0400
X-UUID: b2aad2fe9f79486eacd995cca291d26e-20210909
X-UUID: b2aad2fe9f79486eacd995cca291d26e-20210909
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <trevor.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1896985547; Thu, 09 Sep 2021 14:55:36 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 9 Sep 2021 14:55:35 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 9 Sep 2021 14:55:35 +0800
From:   Trevor Wu <trevor.wu@mediatek.com>
To:     <broonie@kernel.org>, <tiwai@suse.com>, <matthias.bgg@gmail.com>
CC:     <trevor.wu@mediatek.com>, <alsa-devel@alsa-project.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <rdunlap@infradead.org>,
        <geert@linux-m68k.org>, <wenst@chromium.org>,
        <bicycle.tsai@mediatek.com>, <jiaxin.yu@mediatek.com>,
        <shane.chien@mediatek.com>
Subject: [PATCH] ASoC: mediatek: add required config dependency
Date:   Thu, 9 Sep 2021 14:55:33 +0800
Message-ID: <20210909065533.2114-1-trevor.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because SND_SOC_MT8195 depends on COMPILE_TEST, it's possible to build
MT8195 driver in many different config combinations.
Add all dependent config for SND_SOC_MT8195 in case some errors happen
when COMPILE_TEST is enabled.

Signed-off-by: Trevor Wu <trevor.wu@mediatek.com>
Reported-by: Randy Dunlap <rdunlap@infradead.org>
---
 sound/soc/mediatek/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/mediatek/Kconfig b/sound/soc/mediatek/Kconfig
index 5a2f4667d50b..81ad2dcee9eb 100644
--- a/sound/soc/mediatek/Kconfig
+++ b/sound/soc/mediatek/Kconfig
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config SND_SOC_MEDIATEK
 	tristate
+	select REGMAP_MMIO
 
 config SND_SOC_MT2701
 	tristate "ASoC support for Mediatek MT2701 chip"
@@ -188,7 +189,9 @@ config SND_SOC_MT8192_MT6359_RT1015_RT5682
 config SND_SOC_MT8195
 	tristate "ASoC support for Mediatek MT8195 chip"
 	depends on ARCH_MEDIATEK || COMPILE_TEST
+	depends on COMMON_CLK
 	select SND_SOC_MEDIATEK
+	select MFD_SYSCON if SND_SOC_MT6359
 	help
 	  This adds ASoC platform driver support for Mediatek MT8195 chip
 	  that can be used with other codecs.
-- 
2.18.0

