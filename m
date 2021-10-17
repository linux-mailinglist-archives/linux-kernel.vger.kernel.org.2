Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5495843070D
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Oct 2021 09:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237279AbhJQHdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Oct 2021 03:33:37 -0400
Received: from smtp04.smtpout.orange.fr ([80.12.242.126]:56770 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232716AbhJQHd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Oct 2021 03:33:29 -0400
Received: from pop-os.home ([92.140.161.106])
        by smtp.orange.fr with ESMTPA
        id c0dWmm9RWWUfjc0dWm9RJT; Sun, 17 Oct 2021 09:31:18 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sun, 17 Oct 2021 09:31:18 +0200
X-ME-IP: 92.140.161.106
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, srinivas.kandagatla@linaro.org,
        yang.lee@linux.alibaba.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] ASoC: codecs: Fix WCD_MBHC_HPH_PA_EN usage
Date:   Sun, 17 Oct 2021 09:31:12 +0200
Message-Id: <988948f7f266aa00698704687537335b7e6a67b2.1634455711.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'hphpa_on' is known to be false, so the if block at the end of the function
is dead code.

Turn it into a meaningful code by having 'hphpa_on' be static. Use is as a
flip-flop variable.

Fixes: 0e5c9e7ff899 ("ASoC: codecs: wcd: add multi button Headset detection support")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
The purpose of this patch is not to be correct (!) but to draw attention
on several points:
   - in 'wcd_mbhc_adc_hs_rem_irq()', the "if (hphpa_on)" path is dead code
     because 'hphpa_on' is known to be false
   - What is this magic number '3'?
     All 'wcd_mbhc_read_field()' look for 0 or non-0
   - a 'mutex_[un]lock()' in an IRQ handler looks spurious to me

Instead of this (likely broken) patch, it is likely that something is
missing elsewhere. Maybe in 'wcd_mbhc_adc_hs_ins_irq()'.
I also guess that 'hphpa_on' should be read for somewhere else.
---
 sound/soc/codecs/wcd-mbhc-v2.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wcd-mbhc-v2.c b/sound/soc/codecs/wcd-mbhc-v2.c
index 405128ccb4b0..783d8c35bc1b 100644
--- a/sound/soc/codecs/wcd-mbhc-v2.c
+++ b/sound/soc/codecs/wcd-mbhc-v2.c
@@ -1176,7 +1176,7 @@ static irqreturn_t wcd_mbhc_adc_hs_rem_irq(int irq, void *data)
 	struct wcd_mbhc *mbhc = data;
 	unsigned long timeout;
 	int adc_threshold, output_mv, retry = 0;
-	bool hphpa_on = false;
+	static bool hphpa_on = false;
 
 	mutex_lock(&mbhc->lock);
 	timeout = jiffies + msecs_to_jiffies(WCD_FAKE_REMOVAL_MIN_PERIOD_MS);
@@ -1212,6 +1212,9 @@ static irqreturn_t wcd_mbhc_adc_hs_rem_irq(int irq, void *data)
 
 	if (hphpa_on) {
 		hphpa_on = false;
+		wcd_mbhc_write_field(mbhc, WCD_MBHC_HPH_PA_EN, 0);
+	} else {
+		hphpa_on = true;
 		wcd_mbhc_write_field(mbhc, WCD_MBHC_HPH_PA_EN, 3);
 	}
 exit:
-- 
2.30.2

