Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23C05341AE7
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 12:03:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbhCSLDR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 07:03:17 -0400
Received: from inva020.nxp.com ([92.121.34.13]:56274 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229927AbhCSLCr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 07:02:47 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 92FD71A0F72;
        Fri, 19 Mar 2021 12:02:46 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 7A7E01A28BD;
        Fri, 19 Mar 2021 12:02:39 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id B4F154029D;
        Fri, 19 Mar 2021 12:02:30 +0100 (CET)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, shengjiu.wang@nxp.com,
        ckeepax@opensource.cirrus.com, kuninori.morimoto.gx@renesas.com,
        peter.ujfalusi@ti.com, gustavoars@kernel.org,
        pierre-louis.bossart@linux.intel.com, daniel.baluta@nxp.com,
        patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: wm8960: Fix wrong bclk and lrclk with pll enabled for some chips
Date:   Fri, 19 Mar 2021 18:48:46 +0800
Message-Id: <1616150926-22892-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The input MCLK is 12.288MHz, the desired output sysclk is 11.2896MHz
and sample rate is 44100Hz, with the configuration pllprescale=2,
postscale=sysclkdiv=1, some chip may have wrong bclk
and lrclk output with pll enabled in master mode, but with the
configuration pllprescale=1, postscale=2, the output clock is correct.

From Datasheet, the PLL performs best when f2 is between
90MHz and 100MHz when the desired sysclk output is 11.2896MHz
or 12.288MHz, so sysclkdiv = 2 (f2/8) is the best choice.

So search available sysclk_divs from 2 to 1 other than from 1 to 2.

Fixes: 84fdc00d519f ("ASoC: codec: wm9860: Refactor PLL out freq search")
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/codecs/wm8960.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm8960.c b/sound/soc/codecs/wm8960.c
index df351519a3a6..cda9cd935d4f 100644
--- a/sound/soc/codecs/wm8960.c
+++ b/sound/soc/codecs/wm8960.c
@@ -707,7 +707,13 @@ int wm8960_configure_pll(struct snd_soc_component *component, int freq_in,
 	best_freq_out = -EINVAL;
 	*sysclk_idx = *dac_idx = *bclk_idx = -1;
 
-	for (i = 0; i < ARRAY_SIZE(sysclk_divs); ++i) {
+	/*
+	 * From Datasheet, the PLL performs best when f2 is between
+	 * 90MHz and 100MHz, the desired sysclk output is 11.2896MHz
+	 * or 12.288MHz, then sysclkdiv = 2 is the best choice.
+	 * So search sysclk_divs from 2 to 1 other than from 1 to 2.
+	 */
+	for (i = ARRAY_SIZE(sysclk_divs) - 1; i >= 0; --i) {
 		if (sysclk_divs[i] == -1)
 			continue;
 		for (j = 0; j < ARRAY_SIZE(dac_divs); ++j) {
-- 
2.17.1

