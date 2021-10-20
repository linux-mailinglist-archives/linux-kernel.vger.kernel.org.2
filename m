Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78CD5434A54
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 13:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbhJTLo4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 07:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbhJTLou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 07:44:50 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3EA2C061746
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 04:42:35 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id v127so18293458wme.5
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 04:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Qt1kRkQIhdl5KXXeNc9j0xtUv1cZrn94RpXEyZ0WvkQ=;
        b=CSs/m7ZiRFp2v9dmNvryyzrk/kgz9iLi+f2hjBXZ86n0m66tOIlF4bDh7TwJRT1YeQ
         xtBGU9XamE3lh+vsqdLOabMO5xm1lkoHFIupF1+zP32Zesf/TOmtuj56oEbiVFHYKcYj
         xlWS/CYCWtAW+LhgD3srkF/TORtFL79SqihWMaU1ga/VS1usykttVpe5JTNzM36AbqS/
         /DthTpsIp6ZetkkMqdYyK7wmpb1CEIOipRi4S+kQa05b0IbSDbxhRYPx8RjVflQmADO7
         g3A0WZ0DtBg45SmRNRXQ9whBClOz6e+KKRRY0s/BZe2P0bNcoFXhoBw6LcCy0vkaVGCn
         leIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Qt1kRkQIhdl5KXXeNc9j0xtUv1cZrn94RpXEyZ0WvkQ=;
        b=KBpSGg1P8N71WuAZWMH83+iIc2Oz8UcN5a2S5wL6DPO0D/4vRuFepTWMtaIEaegsI9
         37PYuMUowlFK9EKBAt6Q/AfNFN3DhsQoc5jOnnlLQDASPJ3DNMPwcYEWt/2lQTIGFAF0
         SRyifh5cwHLCvfxXT7bsQjDM6LCwTtnDIMrKpEH2ehlcA+7qo2ceHUDeccnm5xnliXYY
         DkWc7CKkHGD06bM2Q2p2lJCy6XYRwyA4qzkwU2mBg4GgBWGW2isMgA0vTTgkUQDeBpje
         DdMIQeUbPS5OubAgxqlFyWqNBK23Ef5awE+cK3x6Uv16I/JE4FZclNIu37D605Q+pn7g
         0gfw==
X-Gm-Message-State: AOAM530K40zwb2KbYB/Aal1FtaRc1hBPbTEqL9EWyq6BuFmlABEdPmZH
        tg7lQk2sPozTV7CsPyQ2UOH9bQ==
X-Google-Smtp-Source: ABdhPJywVaZAqRITJci/WxzJmCqmvcgN4vbJsFCQPeyynKUpuyJ2uNuZgf6d9710w0xmYnfDbyl08w==
X-Received: by 2002:a5d:630b:: with SMTP id i11mr51027972wru.65.1634730154240;
        Wed, 20 Oct 2021 04:42:34 -0700 (PDT)
Received: from jackdaw.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id s14sm1732927wro.76.2021.10.20.04.42.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 04:42:33 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org
Subject: [PATCH 2/2] ASoC: meson: axg-tdm-interface: manage formatters in trigger
Date:   Wed, 20 Oct 2021 13:42:17 +0200
Message-Id: <20211020114217.133153-3-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211020114217.133153-1-jbrunet@baylibre.com>
References: <20211020114217.133153-1-jbrunet@baylibre.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So far, the formatters have been reset/enabled using the .prepare()
callback. This was done in this callback because walking the formatters use
a mutex so it could not be done in .trigger(), which is atomic by default.

It turns out there is a problem on capture path of the AXG series.
The FIFO may get out of sync with the TDM decoder if the IP are not enabled
in a specific order. The FIFO must be enabled before the formatter starts
producing data. IOW, we must deal with FE before the BE. The .prepare()
callback is called on the BEs before the FE so it is not OK for the AXG.

The .trigger() callback order can be configured, and it deals with the FE
before the BEs by default. To solve our problem, we just need to start and
stop the formatters from the .trigger() callback. It is OK do so now that
the links have been made 'nonatomic' in the card driver.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/soc/meson/axg-tdm-interface.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/sound/soc/meson/axg-tdm-interface.c b/sound/soc/meson/axg-tdm-interface.c
index 87cac440b369..db077773af7a 100644
--- a/sound/soc/meson/axg-tdm-interface.c
+++ b/sound/soc/meson/axg-tdm-interface.c
@@ -351,13 +351,29 @@ static int axg_tdm_iface_hw_free(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static int axg_tdm_iface_prepare(struct snd_pcm_substream *substream,
+static int axg_tdm_iface_trigger(struct snd_pcm_substream *substream,
+				 int cmd,
 				 struct snd_soc_dai *dai)
 {
-	struct axg_tdm_stream *ts = snd_soc_dai_get_dma_data(dai, substream);
+	struct axg_tdm_stream *ts =
+		snd_soc_dai_get_dma_data(dai, substream);
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+	case SNDRV_PCM_TRIGGER_RESUME:
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		axg_tdm_stream_start(ts);
+		break;
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+	case SNDRV_PCM_TRIGGER_STOP:
+		axg_tdm_stream_stop(ts);
+		break;
+	default:
+		return -EINVAL;
+	}
 
-	/* Force all attached formatters to update */
-	return axg_tdm_stream_reset(ts);
+	return 0;
 }
 
 static int axg_tdm_iface_remove_dai(struct snd_soc_dai *dai)
@@ -397,8 +413,8 @@ static const struct snd_soc_dai_ops axg_tdm_iface_ops = {
 	.set_fmt	= axg_tdm_iface_set_fmt,
 	.startup	= axg_tdm_iface_startup,
 	.hw_params	= axg_tdm_iface_hw_params,
-	.prepare	= axg_tdm_iface_prepare,
 	.hw_free	= axg_tdm_iface_hw_free,
+	.trigger	= axg_tdm_iface_trigger,
 };
 
 /* TDM Backend DAIs */
-- 
2.33.0

