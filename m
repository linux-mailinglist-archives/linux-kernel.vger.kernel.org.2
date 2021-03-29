Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4442034D2D6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 16:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbhC2Ov3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 10:51:29 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:15376 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbhC2Ou4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 10:50:56 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4F8Fnn6wQqz9sMm;
        Mon, 29 Mar 2021 22:48:45 +0800 (CST)
Received: from localhost (10.174.179.96) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.498.0; Mon, 29 Mar 2021
 22:50:41 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <Vijendar.Mukunda@amd.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] ASoC: amd: acp-da7219-max98357a: Fix -Wunused-variable warning
Date:   Mon, 29 Mar 2021 22:50:37 +0800
Message-ID: <20210329145037.23756-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.96]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While ACPI is not set, make W=1 warns:

sound/soc/amd/acp-da7219-max98357a.c:684:28: warning: ‘cz_rt5682_card’ defined but not used [-Wunused-variable]
 static struct snd_soc_card cz_rt5682_card = {
                            ^~~~~~~~~~~~~~
sound/soc/amd/acp-da7219-max98357a.c:671:28: warning: ‘cz_card’ defined but not used [-Wunused-variable]
 static struct snd_soc_card cz_card = {

Use #ifdef block to guard this.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 sound/soc/amd/acp-da7219-max98357a.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/sound/soc/amd/acp-da7219-max98357a.c b/sound/soc/amd/acp-da7219-max98357a.c
index e65e007fc604..1bf0458e22a8 100644
--- a/sound/soc/amd/acp-da7219-max98357a.c
+++ b/sound/soc/amd/acp-da7219-max98357a.c
@@ -47,13 +47,15 @@
 #define DUAL_CHANNEL		2
 #define RT5682_PLL_FREQ (48000 * 512)
 
+extern bool bt_uart_enable;
+void *acp_soc_is_rltk_max(struct device *dev);
+
+#ifdef CONFIG_ACPI
 static struct snd_soc_jack cz_jack;
 static struct clk *da7219_dai_wclk;
 static struct clk *da7219_dai_bclk;
 static struct clk *rt5682_dai_wclk;
 static struct clk *rt5682_dai_bclk;
-extern bool bt_uart_enable;
-void *acp_soc_is_rltk_max(struct device *dev);
 
 static int cz_da7219_init(struct snd_soc_pcm_runtime *rtd)
 {
@@ -692,6 +694,7 @@ static struct snd_soc_card cz_rt5682_card = {
 	.controls = cz_mc_controls,
 	.num_controls = ARRAY_SIZE(cz_mc_controls),
 };
+#endif
 
 void *acp_soc_is_rltk_max(struct device *dev)
 {
-- 
2.17.1

