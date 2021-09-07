Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E990402E7C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 20:43:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345953AbhIGSo1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 14:44:27 -0400
Received: from mga18.intel.com ([134.134.136.126]:24451 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240131AbhIGSo0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 14:44:26 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10100"; a="207403796"
X-IronPort-AV: E=Sophos;i="5.85,274,1624345200"; 
   d="scan'208";a="207403796"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2021 11:43:19 -0700
X-IronPort-AV: E=Sophos;i="5.85,274,1624345200"; 
   d="scan'208";a="464977752"
Received: from fdiasmor-mobl1.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.209.186.104])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2021 11:43:17 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     tiwai@suse.de, broonie@kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Chuhong Yuan <hslester96@gmail.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Gu Shengxian <gushengxian@yulong.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] ASoC: amd: acp: declare and add prefix to 'bt_uart_enable' symbol
Date:   Tue,  7 Sep 2021 13:42:14 -0500
Message-Id: <20210907184216.33067-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sparse reports the following warning:

sound/soc/amd/acp-pcm-dma.c:39:6: error: symbol 'bt_uart_enable' was
not declared. Should it be static?

It's not very good practice to export such symbols that can easily
conflict, add the acp_ prefix and add declaration in header file.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/amd/acp-da7219-max98357a.c | 6 +++---
 sound/soc/amd/acp-pcm-dma.c          | 6 +++---
 sound/soc/amd/acp.h                  | 2 ++
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/sound/soc/amd/acp-da7219-max98357a.c b/sound/soc/amd/acp-da7219-max98357a.c
index b3df98a9f9f3..b2065f3fe42c 100644
--- a/sound/soc/amd/acp-da7219-max98357a.c
+++ b/sound/soc/amd/acp-da7219-max98357a.c
@@ -33,7 +33,7 @@ static struct clk *da7219_dai_wclk;
 static struct clk *da7219_dai_bclk;
 static struct clk *rt5682_dai_wclk;
 static struct clk *rt5682_dai_bclk;
-extern bool bt_uart_enable;
+
 void *acp_soc_is_rltk_max(struct device *dev);
 
 static int cz_da7219_init(struct snd_soc_pcm_runtime *rtd)
@@ -760,8 +760,8 @@ static int cz_probe(struct platform_device *pdev)
 				"devm_snd_soc_register_card(%s) failed\n",
 				card->name);
 	}
-	bt_uart_enable = !device_property_read_bool(&pdev->dev,
-						    "bt-pad-enable");
+	acp_bt_uart_enable = !device_property_read_bool(&pdev->dev,
+							"bt-pad-enable");
 	return 0;
 }
 
diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
index 11b3c4f39eba..1f322accd9ea 100644
--- a/sound/soc/amd/acp-pcm-dma.c
+++ b/sound/soc/amd/acp-pcm-dma.c
@@ -36,8 +36,8 @@
 #define ST_MIN_BUFFER ST_MAX_BUFFER
 
 #define DRV_NAME "acp_audio_dma"
-bool bt_uart_enable = true;
-EXPORT_SYMBOL(bt_uart_enable);
+bool acp_bt_uart_enable = true;
+EXPORT_SYMBOL(acp_bt_uart_enable);
 
 static const struct snd_pcm_hardware acp_pcm_hardware_playback = {
 	.info = SNDRV_PCM_INFO_INTERLEAVED |
@@ -596,7 +596,7 @@ static int acp_init(void __iomem *acp_mmio, u32 asic_type)
 	acp_reg_write(val, acp_mmio, mmACP_SOFT_RESET);
 
 	/* For BT instance change pins from UART to BT */
-	if (!bt_uart_enable) {
+	if (!acp_bt_uart_enable) {
 		val = acp_reg_read(acp_mmio, mmACP_BT_UART_PAD_SEL);
 		val |= ACP_BT_UART_PAD_SELECT_MASK;
 		acp_reg_write(val, acp_mmio, mmACP_BT_UART_PAD_SEL);
diff --git a/sound/soc/amd/acp.h b/sound/soc/amd/acp.h
index e5ab6c6040a6..85529ed7e5f5 100644
--- a/sound/soc/amd/acp.h
+++ b/sound/soc/amd/acp.h
@@ -204,4 +204,6 @@ typedef struct acp_dma_dscr_transfer {
 	u32 reserved;
 } acp_dma_dscr_transfer_t;
 
+extern bool acp_bt_uart_enable;
+
 #endif /*__ACP_HW_H */
-- 
2.25.1

