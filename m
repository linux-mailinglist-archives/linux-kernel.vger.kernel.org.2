Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35ACA45A03C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 11:30:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235398AbhKWKdc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 05:33:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235161AbhKWKdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 05:33:31 -0500
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74153C061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 02:30:23 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:e4da:38c:79e9:48bf])
        by albert.telenet-ops.be with bizsmtp
        id MmWE260014yPVd606mWEn0; Tue, 23 Nov 2021 11:30:21 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1mpT41-00EUu8-OA; Tue, 23 Nov 2021 11:30:13 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1mpT41-000JAa-B5; Tue, 23 Nov 2021 11:30:13 +0100
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     YC Hung <yc.hung@mediatek.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     sound-open-firmware@alsa-project.org, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] ASoC: SOF: mediatek: Use %pR/%pa to print resources/physical addresses
Date:   Tue, 23 Nov 2021 11:30:13 +0100
Message-Id: <20211123103013.73645-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 32-bit with CONFIG_ARCH_DMA_ADDR_T_64BIT=n:

    sound/soc/sof/mediatek/mt8195/mt8195.c: In function ‘platform_parse_resource’:
    sound/soc/sof/mediatek/mt8195/mt8195.c:51:15: error: format ‘%llx’ expects argument of type ‘long long unsigned int’, but argument 4 has type ‘unsigned int’ [-Werror=format=]
       51 |  dev_dbg(dev, "DMA pbase=0x%llx, size=0x%llx\n",
	  |               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    sound/soc/sof/mediatek/mt8195/mt8195.c: In function ‘adsp_memory_remap_init’:
    sound/soc/sof/mediatek/mt8195/mt8195.c:167:15: error: format ‘%llx’ expects argument of type ‘long long unsigned int’, but argument 4 has type ‘phys_addr_t’ {aka ‘unsigned int’} [-Werror=format=]
      167 |  dev_dbg(dev, "adsp->pa_dram %llx, offset %#x\n", adsp->pa_dram, offset);
	  |               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    sound/soc/sof/mediatek/mt8195/mt8195.c: In function ‘adsp_shared_base_ioremap’:
    sound/soc/sof/mediatek/mt8195/mt8195.c:196:15: error: format ‘%llx’ expects argument of type ‘long long unsigned int’, but argument 5 has type ‘phys_addr_t’ {aka ‘unsigned int’} [-Werror=format=]
      196 |  dev_dbg(dev, "shared-dram vbase=%p, phy addr :%llx,  size=%#x\n",
	  |               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Fix the first cases by printing the full resource using %pR.
Fix the other cases by printing the physical addresses using %pa.

Reported-by: noreply@ellerman.id.au
Fixes: 32d7e03d26fd9318 ("ASoC: SOF: mediatek: Add mt8195 hardware support")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 sound/soc/sof/mediatek/mt8195/mt8195.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/sound/soc/sof/mediatek/mt8195/mt8195.c b/sound/soc/sof/mediatek/mt8195/mt8195.c
index 40e5a25875a6a93c..b1580b6ac8e19e61 100644
--- a/sound/soc/sof/mediatek/mt8195/mt8195.c
+++ b/sound/soc/sof/mediatek/mt8195/mt8195.c
@@ -48,8 +48,7 @@ static int platform_parse_resource(struct platform_device *pdev, void *data)
 		return ret;
 	}
 
-	dev_dbg(dev, "DMA pbase=0x%llx, size=0x%llx\n",
-		(phys_addr_t)res.start, resource_size(&res));
+	dev_dbg(dev, "DMA %pR\n", &res);
 
 	ret = of_reserved_mem_device_init(dev);
 	if (ret) {
@@ -164,7 +163,7 @@ static int adsp_memory_remap_init(struct device *dev, struct mtk_adsp_chip_info
 	offset = adsp->pa_dram - DRAM_PHYS_BASE_FROM_DSP_VIEW;
 	adsp->dram_offset = offset;
 	offset >>= DRAM_REMAP_SHIFT;
-	dev_dbg(dev, "adsp->pa_dram %llx, offset %#x\n", adsp->pa_dram, offset);
+	dev_dbg(dev, "adsp->pa_dram %pa, offset %#x\n", &adsp->pa_dram, offset);
 	writel(offset, vaddr_emi_map);
 	if (offset != readl(vaddr_emi_map)) {
 		dev_err(dev, "write emi map fail : %#x\n", readl(vaddr_emi_map));
@@ -193,8 +192,8 @@ static int adsp_shared_base_ioremap(struct platform_device *pdev, void *data)
 			return -ENOMEM;
 		}
 	}
-	dev_dbg(dev, "shared-dram vbase=%p, phy addr :%llx,  size=%#x\n",
-		adsp->shared_dram, adsp->pa_shared_dram, shared_size);
+	dev_dbg(dev, "shared-dram vbase=%p, phy addr :%pa,  size=%#x\n",
+		adsp->shared_dram, &adsp->pa_shared_dram, shared_size);
 
 	return 0;
 }
-- 
2.25.1

