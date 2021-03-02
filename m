Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D55932A546
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 17:01:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350425AbhCBMVW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 07:21:22 -0500
Received: from inva020.nxp.com ([92.121.34.13]:51238 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1383694AbhCBL5m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 06:57:42 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 232CA1A0716;
        Tue,  2 Mar 2021 12:30:57 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 494451A06FF;
        Tue,  2 Mar 2021 12:30:50 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 8515F402B4;
        Tue,  2 Mar 2021 12:30:42 +0100 (CET)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, kstewart@linuxfoundation.org, allison@lohutok.net,
        shengjiu.wang@nxp.com, tglx@linutronix.de, info@metux.net,
        ckeepax@opensource.wolfsonmicro.com, patches@opensource.cirrus.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: wm8960: Remove bitclk relax condition
Date:   Tue,  2 Mar 2021 19:18:11 +0800
Message-Id: <1614683891-29255-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Baluta <daniel.baluta@nxp.com>

Using a higher bitclk then expected doesn't always work.
Here is an example:

aplay -Dhw:0,0 -d 5 -r 48000 -f S24_LE -c 2 audio48k24b2c.wav

In this case, the required bitclk is 48000 * 24 * 2 = 2304000
but the closest bitclk that can be derived is 3072000. Since
the clock is faster than expected, it will start to send bytes
from the next channel so the sound will be corrupted.

Fixes: 82bab88910ee ("ASoC: codec: wm8960: Relax bit clock computation when using PLL")
Fixes: 3c01b9ee2ab9 ("ASoC: codec: wm8960: Relax bit clock computation")
Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/codecs/wm8960.c | 29 +++--------------------------
 1 file changed, 3 insertions(+), 26 deletions(-)

diff --git a/sound/soc/codecs/wm8960.c b/sound/soc/codecs/wm8960.c
index df351519a3a6..368bec1dfbdb 100644
--- a/sound/soc/codecs/wm8960.c
+++ b/sound/soc/codecs/wm8960.c
@@ -608,10 +608,6 @@ static const int bclk_divs[] = {
  *		- lrclk      = sysclk / dac_divs
  *		- 10 * bclk  = sysclk / bclk_divs
  *
- *	If we cannot find an exact match for (sysclk, lrclk, bclk)
- *	triplet, we relax the bclk such that bclk is chosen as the
- *	closest available frequency greater than expected bclk.
- *
  * @wm8960: codec private data
  * @mclk: MCLK used to derive sysclk
  * @sysclk_idx: sysclk_divs index for found sysclk
@@ -629,7 +625,7 @@ int wm8960_configure_sysclk(struct wm8960_priv *wm8960, int mclk,
 {
 	int sysclk, bclk, lrclk;
 	int i, j, k;
-	int diff, closest = mclk;
+	int diff;
 
 	/* marker for no match */
 	*bclk_idx = -1;
@@ -653,12 +649,6 @@ int wm8960_configure_sysclk(struct wm8960_priv *wm8960, int mclk,
 					*bclk_idx = k;
 					break;
 				}
-				if (diff > 0 && closest > diff) {
-					*sysclk_idx = i;
-					*dac_idx = j;
-					*bclk_idx = k;
-					closest = diff;
-				}
 			}
 			if (k != ARRAY_SIZE(bclk_divs))
 				break;
@@ -676,10 +666,6 @@ int wm8960_configure_sysclk(struct wm8960_priv *wm8960, int mclk,
  *		- freq_out    = sysclk * sysclk_divs
  *		- 10 * sysclk = bclk * bclk_divs
  *
- * 	If we cannot find an exact match for (sysclk, lrclk, bclk)
- * 	triplet, we relax the bclk such that bclk is chosen as the
- * 	closest available frequency greater than expected bclk.
- *
  * @component: component structure
  * @freq_in: input frequency used to derive freq out via PLL
  * @sysclk_idx: sysclk_divs index for found sysclk
@@ -697,14 +683,12 @@ int wm8960_configure_pll(struct snd_soc_component *component, int freq_in,
 {
 	struct wm8960_priv *wm8960 = snd_soc_component_get_drvdata(component);
 	int sysclk, bclk, lrclk, freq_out;
-	int diff, closest, best_freq_out;
+	int diff;
 	int i, j, k;
 
 	bclk = wm8960->bclk;
 	lrclk = wm8960->lrclk;
-	closest = freq_in;
 
-	best_freq_out = -EINVAL;
 	*sysclk_idx = *dac_idx = *bclk_idx = -1;
 
 	for (i = 0; i < ARRAY_SIZE(sysclk_divs); ++i) {
@@ -725,18 +709,11 @@ int wm8960_configure_pll(struct snd_soc_component *component, int freq_in,
 					*bclk_idx = k;
 					return freq_out;
 				}
-				if (diff > 0 && closest > diff) {
-					*sysclk_idx = i;
-					*dac_idx = j;
-					*bclk_idx = k;
-					closest = diff;
-					best_freq_out = freq_out;
-				}
 			}
 		}
 	}
 
-	return best_freq_out;
+	return -EINVAL;
 }
 static int wm8960_configure_clocking(struct snd_soc_component *component)
 {
-- 
2.27.0

