Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F1AB356F86
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 16:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348962AbhDGO7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 10:59:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345747AbhDGO7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 10:59:37 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29F85C061756
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 07:59:25 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 18so3746908edx.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 07:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RhiVLxZ189Mfi2/3w2wk+mT3BSMHUmXI5aQWXNu5k2c=;
        b=zZoVhHro6L2LnmIIbWv4pad71Bvb0y4XyBmWu6P/hmrzntRYC0UoynxC+JhP2SKoXn
         UEzcesZpmt7p760jdD0RYi8NswCaIA3X+aKJW5tmY70iG49QyQW34o0HeYE/Iw7QuTxj
         a6GSlrLvuch1v7YuT1uXu0mApwSkZSjjeEO8Zf0820ze9vQ5dP1wqwTcGU5V0mtXEw8V
         cIziaxSKFvXB+k0Zi4h7WVHuTkIw23lFacZs7QDfM4n1zLia7x5pw+yD1CpWlDFQe3Hn
         QRkm2ORd+tRA4G1Zp3DrSUB7MkfwTPo2P+DOk7H3u9YsZZXwbIr0rIELnx3PdBGjYecq
         d5Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RhiVLxZ189Mfi2/3w2wk+mT3BSMHUmXI5aQWXNu5k2c=;
        b=MbHh/qi4sLcNK6BimTw3kGYFNF5Uf4s+J7z+KKKaA9kZ2oG137v0zKuH9eGKzc5a4C
         9+GLzMk4uJ9RalNh3QJHKCWSyAIvqQH41B4oQ2pThhAg237JsPWmasiwR7Rbmldcb88r
         bHKwF067rm3lXpR/FkHAKVNi0x8pXrCNYoVuD4Nh4gVJ8vRTojVtv+UwCyE7TRjDrwcS
         xA6+Msw4KcJY0RJf3ZdwxUrcbr/hxQ5TbYD1+o9l529lMOtvu+dIq8YRe4zgMyibwy42
         5gvfXp2ojQjAI3g5lAu0dsZdlQTz/JZKNnuTQMkqGXv11UCQ8oFJQy9xNiJXl5oFq5Bf
         oCwA==
X-Gm-Message-State: AOAM5300KD6j4u1WVBx3HIqKtKQf2Uiq2nAEdawDEfxCNx0eK2BDFIek
        3aDXBovdQlU9T1EJKgVMQF6lXA==
X-Google-Smtp-Source: ABdhPJxzmktfBJNJzlo7KcK7eCSOqr9CD9XKZcsYIEH7+/H04DXrYXnpi/VBjAARwmgiCznZjmuALA==
X-Received: by 2002:a05:6402:1606:: with SMTP id f6mr4867670edv.216.1617807563889;
        Wed, 07 Apr 2021 07:59:23 -0700 (PDT)
Received: from starbuck.lan (82-65-169-74.subs.proxad.net. [82.65.169.74])
        by smtp.googlemail.com with ESMTPSA id pj18sm6144647ejb.101.2021.04.07.07.59.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 07:59:23 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        Kevin Hilman <khilman@baylibre.com>
Subject: [PATCH] ASoC: meson: axg-fifo: add NO_PERIOD_WAKEUP support
Date:   Wed,  7 Apr 2021 16:59:14 +0200
Message-Id: <20210407145914.311479-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On the AXG family, the fifo irq is not necessary for the HW to operate.
It is just used to notify that a period has elapsed. If userpace does not
care for these wakeups (such as pipewire), we are just wasting CPU cycles.

Add support for NO_PERIOD_WAKEUP and disable irq when they are no needed.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/soc/meson/axg-fifo.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/sound/soc/meson/axg-fifo.c b/sound/soc/meson/axg-fifo.c
index b2e867113226..b9af2d513e09 100644
--- a/sound/soc/meson/axg-fifo.c
+++ b/sound/soc/meson/axg-fifo.c
@@ -27,8 +27,8 @@ static struct snd_pcm_hardware axg_fifo_hw = {
 		 SNDRV_PCM_INFO_MMAP |
 		 SNDRV_PCM_INFO_MMAP_VALID |
 		 SNDRV_PCM_INFO_BLOCK_TRANSFER |
-		 SNDRV_PCM_INFO_PAUSE),
-
+		 SNDRV_PCM_INFO_PAUSE |
+		 SNDRV_PCM_INFO_NO_PERIOD_WAKEUP),
 	.formats = AXG_FIFO_FORMATS,
 	.rate_min = 5512,
 	.rate_max = 192000,
@@ -113,7 +113,7 @@ int axg_fifo_pcm_hw_params(struct snd_soc_component *component,
 {
 	struct snd_pcm_runtime *runtime = ss->runtime;
 	struct axg_fifo *fifo = axg_fifo_data(ss);
-	unsigned int burst_num, period, threshold;
+	unsigned int burst_num, period, threshold, irq_en;
 	dma_addr_t end_ptr;
 
 	period = params_period_bytes(params);
@@ -142,10 +142,11 @@ int axg_fifo_pcm_hw_params(struct snd_soc_component *component,
 	regmap_field_write(fifo->field_threshold,
 			   threshold ? threshold - 1 : 0);
 
-	/* Enable block count irq */
+	/* Enable irq if necessary  */
+	irq_en = runtime->no_period_wakeup ? 0 : FIFO_INT_COUNT_REPEAT;
 	regmap_update_bits(fifo->map, FIFO_CTRL0,
 			   CTRL0_INT_EN(FIFO_INT_COUNT_REPEAT),
-			   CTRL0_INT_EN(FIFO_INT_COUNT_REPEAT));
+			   CTRL0_INT_EN(irq_en));
 
 	return 0;
 }
-- 
2.30.2

