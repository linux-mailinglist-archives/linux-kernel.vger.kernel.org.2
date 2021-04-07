Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55D27356F7F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 16:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348892AbhDGO5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 10:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345804AbhDGO5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 10:57:52 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3EF8C061756
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 07:57:41 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id ba6so13736513edb.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 07:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QA9e9N4IOvSwJUEhUzTdNXyCf8iiGr98JuVf3SJbSws=;
        b=JAQF9H0gQEXFL9/pYT2lgmKwCmo/8UEfkLEab3w+3B+f/2dTBlLibW3g3Eepx+nKfg
         jhiSXd2zDe6fNoMhr8cXIQAJWBt056NgQLQ5WfHIL+BDAV10JNXkybazYAdZfM2hASV0
         Qltio+F9iYnQLNESFD5gMQ8WXpGpaGPNnkgf942WWDLAriwHIpFzo2p+j4WGWj2NHGk1
         8ta/ACdwML+eDZa1w6uvpqIT+EaL/F+xWZSGBYygd+j+kJzycS6hX6EaZVpdavH8dnO4
         r17E9jKOpOvZidos86qEA38r/Sijo0poC0OyUBLHBnG0Im/CmuZyvtmQLzBMPPB++k0O
         PsJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QA9e9N4IOvSwJUEhUzTdNXyCf8iiGr98JuVf3SJbSws=;
        b=aPXup6SI1o9w5OSfjZPPQYzdQNEw15S5CLsOTxZzYQAyl1qfqUL0FJN5FU+UPtyRG0
         Ij7wKpeNub2R6CyuTByBosoZK62sQdyoP8TGslS79iUdYB6TYqOCECrWnpcXpTKrHA3Z
         3KhioXB36tlnWdShW+ljF7Vu7UM1+pqZvX+0GxMVPsZ4sQ247YpvWndojGbU/nokQmwQ
         eK5Qwbu5qBo3/k21VhkiUOAmf2MuJ30I4S82UfPFlHGiHsmdxFbrXG5nEY0xTn5YdTXF
         z6Mse7avKIu696oE+aSrMmwemfyjG1dEDyFgdYmlGiEIAn0q9SqDfBuvG2MC3V7ugewb
         8jRw==
X-Gm-Message-State: AOAM53069oRICJ7gA/Fy9DxsrnGwF+fDtM5wdT/jnsjkxEzyKHAUC4tq
        1c94nry4MqPqRWOnQLYVBTw4Wg==
X-Google-Smtp-Source: ABdhPJxrD/E7UI8yZ+sfbW3oM0l+FNRA5WDYTfCEADpbzEgpOMkZgtqqaQVPNqZsN4PMZL+SMysa6Q==
X-Received: by 2002:aa7:d88b:: with SMTP id u11mr4983769edq.254.1617807460510;
        Wed, 07 Apr 2021 07:57:40 -0700 (PDT)
Received: from starbuck.lan (82-65-169-74.subs.proxad.net. [82.65.169.74])
        by smtp.googlemail.com with ESMTPSA id yh6sm3732875ejb.37.2021.04.07.07.57.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 07:57:40 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        Kevin Hilman <khilman@baylibre.com>
Subject: [PATCH] ASoC: meson: axg-frddr: set fifo depth according to the period
Date:   Wed,  7 Apr 2021 16:57:14 +0200
Message-Id: <20210407145714.311138-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the period is small, using all the FRDDR fifo depth increases the
latency of the playback because the following device won't start pulling
data until the fifo reaches the depth set. We can adjust this depth so trim
it down for small periods.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/soc/meson/axg-frddr.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/sound/soc/meson/axg-frddr.c b/sound/soc/meson/axg-frddr.c
index c3ae8ac30745..8ed114de0bdf 100644
--- a/sound/soc/meson/axg-frddr.c
+++ b/sound/soc/meson/axg-frddr.c
@@ -11,6 +11,7 @@
 #include <linux/regmap.h>
 #include <linux/module.h>
 #include <linux/of_platform.h>
+#include <sound/pcm_params.h>
 #include <sound/soc.h>
 #include <sound/soc-dai.h>
 
@@ -46,11 +47,28 @@ static int g12a_frddr_dai_prepare(struct snd_pcm_substream *substream,
 	return 0;
 }
 
+static int axg_frddr_dai_hw_params(struct snd_pcm_substream *substream,
+				   struct snd_pcm_hw_params *params,
+				   struct snd_soc_dai *dai)
+{
+	struct axg_fifo *fifo = snd_soc_dai_get_drvdata(dai);
+	unsigned int period, depth, val;
+
+	period = params_period_bytes(params);
+
+	/* Trim the FIFO depth if the period is small to improve latency */
+	depth = min(period, fifo->depth);
+	val = (depth / AXG_FIFO_BURST) - 1;
+	regmap_update_bits(fifo->map, FIFO_CTRL1, CTRL1_FRDDR_DEPTH_MASK,
+			   CTRL1_FRDDR_DEPTH(val));
+
+	return 0;
+}
+
 static int axg_frddr_dai_startup(struct snd_pcm_substream *substream,
 				 struct snd_soc_dai *dai)
 {
 	struct axg_fifo *fifo = snd_soc_dai_get_drvdata(dai);
-	unsigned int val;
 	int ret;
 
 	/* Enable pclk to access registers and clock the fifo ip */
@@ -61,11 +79,6 @@ static int axg_frddr_dai_startup(struct snd_pcm_substream *substream,
 	/* Apply single buffer mode to the interface */
 	regmap_update_bits(fifo->map, FIFO_CTRL0, CTRL0_FRDDR_PP_MODE, 0);
 
-	/* Use all fifo depth */
-	val = (fifo->depth / AXG_FIFO_BURST) - 1;
-	regmap_update_bits(fifo->map, FIFO_CTRL1, CTRL1_FRDDR_DEPTH_MASK,
-			   CTRL1_FRDDR_DEPTH(val));
-
 	return 0;
 }
 
@@ -84,6 +97,7 @@ static int axg_frddr_pcm_new(struct snd_soc_pcm_runtime *rtd,
 }
 
 static const struct snd_soc_dai_ops axg_frddr_ops = {
+	.hw_params	= axg_frddr_dai_hw_params,
 	.startup	= axg_frddr_dai_startup,
 	.shutdown	= axg_frddr_dai_shutdown,
 };
-- 
2.30.2

