Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE5813245AE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 22:21:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235907AbhBXVUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 16:20:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235838AbhBXVUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 16:20:09 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 850A1C061756
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 13:19:28 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id q23so4095248lji.8
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 13:19:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c5DfhNeAwwpzk7lWN1yZX9gxlgXcH020L1Zpko4icfU=;
        b=rY1yV1Ai7VAOwjIchhxUfiW8HVXTOFHY5DnR9H8zP+eRqagNAMjQYPGfHocaReUgXT
         7fPrshHgVB0+Pn/XzRV1BrxiBf4xncSskLnIHDq2N9MaoFqM+NgIkncuaUbQGsU5MX+V
         R3fTyyKnFFSg1fvlU19X6fum4X/yZT7z38ftVh3R3ZbfqY3MGJ2uLpyE/JBs3MRV7l1b
         GnSEy+v6Stb9UDUH2ICCT+lRsMMFFfmyGRcik5gbTNi/+PywZ7w3wqZmsb/GgfyvSSD8
         bRpk5FQEcRio5K7jXIXS7Z5Xiu4Q2225vb1VgcOkYiePAFDXGLV50NeuYfEgpb8+B5SK
         JSmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c5DfhNeAwwpzk7lWN1yZX9gxlgXcH020L1Zpko4icfU=;
        b=EGpGarV3v6Bw1xY5KqdV84vil1tLOmnMoFiqOfHY3lgo//3O8d0LZNJTgq+iMhgUgn
         94Cn32FTDjwPyef7P9MhWbf1HGITIEAIreWxQaeOkTb9UfZJXJrsm0HzgKCBaEvnXrZp
         jLzlzkOur8ooV5Gm9KDr7CoEhoVuTpB9SYdc0wHwglGnXzbqtdyh74VBAA8MQxUHNKJM
         1SPWqInnlgwKBGT2U6bpxIA2vfHzxOGOCbqF/PpP+pUFMuCGmbfO+WhwVT7d6WS6VsLp
         MqHk6RYOLeGXLfb8WD2vLpm0kflsu07ilFMTQ68Pt+YuU3EvU9UxCt8ekuvkFeqpvCvI
         h4jA==
X-Gm-Message-State: AOAM531HYfowv9yonmh8VaR2ec7YzEiW03De/18JpLJksSujxjLo7TlV
        rIxyQtaqrTcqkgUqsgEO7So=
X-Google-Smtp-Source: ABdhPJyR9BMQ7aExvBSaCCsIx3H0Jt1U9lYeloXAZJ9u96glq0dhBhN8B3JCTqcrdLKmD63SuRXarA==
X-Received: by 2002:a2e:90d0:: with SMTP id o16mr15999620ljg.304.1614201567029;
        Wed, 24 Feb 2021 13:19:27 -0800 (PST)
Received: from localhost.localdomain (h-98-128-229-129.NA.cust.bahnhof.se. [98.128.229.129])
        by smtp.gmail.com with ESMTPSA id w26sm717116lfr.186.2021.02.24.13.19.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 13:19:26 -0800 (PST)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Oder Chiou <oder_chiou@realtek.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH 2/4] ASoC: rt*: Constify static struct snd_soc_dai_ops
Date:   Wed, 24 Feb 2021 22:19:16 +0100
Message-Id: <20210224211918.39109-3-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210224211918.39109-1-rikard.falkeborn@gmail.com>
References: <20210224211918.39109-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only usage of them is to assign their address to the ops field in
the snd_soc_dai_driver struct, which is a pointer to const. Make them
const to allow the compiler to put them in read-only memory.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 sound/soc/codecs/rt1015.c     | 2 +-
 sound/soc/codecs/rt1016.c     | 2 +-
 sound/soc/codecs/rt5682-sdw.c | 2 +-
 sound/soc/codecs/rt700.c      | 2 +-
 sound/soc/codecs/rt711.c      | 2 +-
 sound/soc/codecs/rt715.c      | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/rt1015.c b/sound/soc/codecs/rt1015.c
index 844e4079d176..501cc45240b4 100644
--- a/sound/soc/codecs/rt1015.c
+++ b/sound/soc/codecs/rt1015.c
@@ -1028,7 +1028,7 @@ static void rt1015_remove(struct snd_soc_component *component)
 #define RT1015_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE | \
 			SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S8)
 
-static struct snd_soc_dai_ops rt1015_aif_dai_ops = {
+static const struct snd_soc_dai_ops rt1015_aif_dai_ops = {
 	.hw_params = rt1015_hw_params,
 	.set_fmt = rt1015_set_dai_fmt,
 	.set_tdm_slot = rt1015_set_tdm_slot,
diff --git a/sound/soc/codecs/rt1016.c b/sound/soc/codecs/rt1016.c
index a23d368ab4da..483375fc16ca 100644
--- a/sound/soc/codecs/rt1016.c
+++ b/sound/soc/codecs/rt1016.c
@@ -534,7 +534,7 @@ static void rt1016_remove(struct snd_soc_component *component)
 #define RT1016_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE | \
 			SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S8)
 
-static struct snd_soc_dai_ops rt1016_aif_dai_ops = {
+static const struct snd_soc_dai_ops rt1016_aif_dai_ops = {
 	.hw_params = rt1016_hw_params,
 	.set_fmt = rt1016_set_dai_fmt,
 };
diff --git a/sound/soc/codecs/rt5682-sdw.c b/sound/soc/codecs/rt5682-sdw.c
index 0b7ac74e671d..5e097f776561 100644
--- a/sound/soc/codecs/rt5682-sdw.c
+++ b/sound/soc/codecs/rt5682-sdw.c
@@ -269,7 +269,7 @@ static int rt5682_sdw_hw_free(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static struct snd_soc_dai_ops rt5682_sdw_ops = {
+static const struct snd_soc_dai_ops rt5682_sdw_ops = {
 	.hw_params	= rt5682_sdw_hw_params,
 	.hw_free	= rt5682_sdw_hw_free,
 	.set_sdw_stream	= rt5682_set_sdw_stream,
diff --git a/sound/soc/codecs/rt700.c b/sound/soc/codecs/rt700.c
index 66ec395dbbcd..01af9d9dd3ca 100644
--- a/sound/soc/codecs/rt700.c
+++ b/sound/soc/codecs/rt700.c
@@ -1002,7 +1002,7 @@ static int rt700_pcm_hw_free(struct snd_pcm_substream *substream,
 #define RT700_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE | \
 			SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S8)
 
-static struct snd_soc_dai_ops rt700_ops = {
+static const struct snd_soc_dai_ops rt700_ops = {
 	.hw_params	= rt700_pcm_hw_params,
 	.hw_free	= rt700_pcm_hw_free,
 	.set_sdw_stream	= rt700_set_sdw_stream,
diff --git a/sound/soc/codecs/rt711.c b/sound/soc/codecs/rt711.c
index 85f744184a60..202bf6fbc5be 100644
--- a/sound/soc/codecs/rt711.c
+++ b/sound/soc/codecs/rt711.c
@@ -1048,7 +1048,7 @@ static int rt711_pcm_hw_free(struct snd_pcm_substream *substream,
 #define RT711_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE | \
 			SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S8)
 
-static struct snd_soc_dai_ops rt711_ops = {
+static const struct snd_soc_dai_ops rt711_ops = {
 	.hw_params	= rt711_pcm_hw_params,
 	.hw_free	= rt711_pcm_hw_free,
 	.set_sdw_stream	= rt711_set_sdw_stream,
diff --git a/sound/soc/codecs/rt715.c b/sound/soc/codecs/rt715.c
index 9a7d393d424a..f419d001a3fb 100644
--- a/sound/soc/codecs/rt715.c
+++ b/sound/soc/codecs/rt715.c
@@ -683,7 +683,7 @@ static int rt715_pcm_hw_free(struct snd_pcm_substream *substream,
 #define RT715_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE | \
 			SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S8)
 
-static struct snd_soc_dai_ops rt715_ops = {
+static const struct snd_soc_dai_ops rt715_ops = {
 	.hw_params	= rt715_pcm_hw_params,
 	.hw_free	= rt715_pcm_hw_free,
 	.set_sdw_stream	= rt715_set_sdw_stream,
-- 
2.30.1

