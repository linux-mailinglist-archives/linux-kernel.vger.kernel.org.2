Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 778F94448DE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 20:19:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbhKCTWP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 15:22:15 -0400
Received: from smtp03.smtpout.orange.fr ([80.12.242.125]:65394 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbhKCTWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 15:22:08 -0400
Received: from pop-os.home ([86.243.171.122])
        by smtp.orange.fr with ESMTPA
        id iLnEmtQIGUGqliLnEms32M; Wed, 03 Nov 2021 20:19:29 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Wed, 03 Nov 2021 20:19:29 +0100
X-ME-IP: 86.243.171.122
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, srinivas.kandagatla@linaro.org,
        yang.lee@linux.alibaba.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] ASoC: codecs: Axe some dead code in 'wcd_mbhc_adc_hs_rem_irq()'
Date:   Wed,  3 Nov 2021 20:19:27 +0100
Message-Id: <57a89cc31eb2312addd3c77896d7df8206aef138.1635967035.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'hphpa_on' is know to be false, so this is just dead code that should be
removed.

Suggested-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
This patch is a follow-up of:
https://lore.kernel.org/kernel-janitors/988948f7f266aa00698704687537335b7e6a67b2.1634455711.git.christophe.jaillet@wanadoo.fr/
---
 sound/soc/codecs/wcd-mbhc-v2.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/sound/soc/codecs/wcd-mbhc-v2.c b/sound/soc/codecs/wcd-mbhc-v2.c
index 405128ccb4b0..b905eb8f3c67 100644
--- a/sound/soc/codecs/wcd-mbhc-v2.c
+++ b/sound/soc/codecs/wcd-mbhc-v2.c
@@ -1176,7 +1176,6 @@ static irqreturn_t wcd_mbhc_adc_hs_rem_irq(int irq, void *data)
 	struct wcd_mbhc *mbhc = data;
 	unsigned long timeout;
 	int adc_threshold, output_mv, retry = 0;
-	bool hphpa_on = false;
 
 	mutex_lock(&mbhc->lock);
 	timeout = jiffies + msecs_to_jiffies(WCD_FAKE_REMOVAL_MIN_PERIOD_MS);
@@ -1210,10 +1209,6 @@ static irqreturn_t wcd_mbhc_adc_hs_rem_irq(int irq, void *data)
 	wcd_mbhc_elec_hs_report_unplug(mbhc);
 	wcd_mbhc_write_field(mbhc, WCD_MBHC_BTN_ISRC_CTL, 0);
 
-	if (hphpa_on) {
-		hphpa_on = false;
-		wcd_mbhc_write_field(mbhc, WCD_MBHC_HPH_PA_EN, 3);
-	}
 exit:
 	mutex_unlock(&mbhc->lock);
 	return IRQ_HANDLED;
-- 
2.30.2

