Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C338333301
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 03:15:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231473AbhCJCOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 21:14:37 -0500
Received: from inva020.nxp.com ([92.121.34.13]:59832 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229775AbhCJCOI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 21:14:08 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id AECC51A07AD;
        Wed, 10 Mar 2021 03:14:03 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 164151A056F;
        Wed, 10 Mar 2021 03:13:57 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 44464402A7;
        Wed, 10 Mar 2021 03:13:48 +0100 (CET)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, shengjiu.wang@nxp.com,
        ckeepax@opensource.cirrus.com, kuninori.morimoto.gx@renesas.com,
        gustavoars@kernel.org, pierre-louis.bossart@linux.intel.com,
        daniel.baluta@nxp.com, patches@opensource.cirrus.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [RESEND PATCH v2] ASoC: wm8960: Remove bitclk relax condition in wm8960_configure_sysclk
Date:   Wed, 10 Mar 2021 10:00:42 +0800
Message-Id: <1615341642-3797-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The call sequence in wm8960_configure_clocking is

   ret = wm8960_configure_sysclk();
   if (ret >= 0)
        goto configure_clock;

   ....

   ret = wm8960_configure_pll();

configure_clock:
   ...

wm8960_configure_sysclk is called before wm8960_configure_pll, as
there is bitclk relax on both functions, so wm8960_configure_sysclk
always return success, then wm8960_configure_pll() never be called.

With this case:
aplay -Dhw:0,0 -d 5 -r 48000 -f S24_LE -c 2 audio48k24b2c.wav
the required bitclk is 48000 * 24 * 2 = 2304000, bitclk got from
wm8960_configure_sysclk is 3072000, but if go to wm8960_configure_pll.
it can get correct bitclk 2304000.

So bitclk relax condition should be removed in wm8960_configure_sysclk,
then wm8960_configure_pll can be called, and there is also bitclk relax
function in wm8960_configure_pll.

Fixes: 3c01b9ee2ab9 ("ASoC: codec: wm8960: Relax bit clock computation")
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
changes in resend v2
- Add acked-by Charles

changes in v2:
- Find the real reason for the case, just patially remove bitclk relax

 sound/soc/codecs/wm8960.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/sound/soc/codecs/wm8960.c b/sound/soc/codecs/wm8960.c
index df351519a3a6..847ca16b9841 100644
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
-- 
2.27.0

