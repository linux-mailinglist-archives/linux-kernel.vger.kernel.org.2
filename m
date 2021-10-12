Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7308642AE40
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 22:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234865AbhJLU5f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 16:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbhJLU5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 16:57:33 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F1ECC061570
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 13:55:31 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id x27so2268761lfu.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 13:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jsTwWPNABO7t6fYSb716Ke2gFPfWwq6MzrlHVefhOG4=;
        b=do27g9P3KSwt6TKXbelpk/lcgXOP6GAq8OMm5ZHF/QAlOrJTGEOkXuRQqA4TUJ9c/P
         66JUgBvqGQLSmp13USy9H6SlSuFXh0cYCidN0h/0pSpTGwW04N6fMGJ7VMaKENkwSjj4
         14SbMobnC4j+lhRxoNOlGSfbmvsiksnZoLUiLsxkbVL77M6iqYhkMLiVa4m9vE6Fqyze
         0Mef049jkTxMYqYvutftjFLn3g5OsQJVA9vNT4fTVpa22hwfkRJVOg3fiS7tf2cHdmbz
         WIx8LqVz/eHXA6efl75cAHbBCGlf1Ae1qenLFwaF2m21Y4LsU8vSvFTEpzbW80JCsb/G
         KyGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jsTwWPNABO7t6fYSb716Ke2gFPfWwq6MzrlHVefhOG4=;
        b=bgjw3H88cGnWbml6im1DzdBJZVDKNOMsxIhCgj1TMVf8ASmRmdp3gwNOxyTQALEPnY
         fEBjTjH4h+Wl8Q158zDXdUOqDyk2gLvBGGVNGj4wcqqE565KVyy2aQCyLoPs+ZnbDuUw
         DzN0pWnaARoFmhM42SKuByNmQa32tUt1wemGuJEuO0UkWQmMDTiOLK4ozql4o+833FYA
         NoapSmEiNcb4cjuFBCqPk9mWgTg4YDrCw3L8xnAeGhCHuCpQLJDATuRTd/LenGJtov3w
         0PKl7BrMEXo7srcWLls4avz1QO/ACt1Ph5CoHOhgIM7qqlU82OKYuZo+YJfL04gMiZvO
         yUBg==
X-Gm-Message-State: AOAM532UJA4MVf04bzcH+Kp0hQcHKqg8CyhdqbhUGPIGawgQMyOUpK50
        Jl24Fqouk4m/Zs8Liw0dd9k=
X-Google-Smtp-Source: ABdhPJz0oVp0tzpS6B29DUSsGL7OQuWzGhvARKE6lL1ybJlZbpr+cXjJ8yKiFPTS4fdrrCuRDf44iw==
X-Received: by 2002:ac2:4c48:: with SMTP id o8mr30372629lfk.286.1634072129486;
        Tue, 12 Oct 2021 13:55:29 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-5.NA.cust.bahnhof.se. [158.174.22.5])
        by smtp.gmail.com with ESMTPSA id p23sm1274514ljm.127.2021.10.12.13.55.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 13:55:29 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tzung-Bi Shih <tzungbi@google.com>,
        Jiaxin Yu <jiaxin.yu@mediatek.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH] ASoC: mediatek: Constify static snd_soc_ops
Date:   Tue, 12 Oct 2021 22:55:21 +0200
Message-Id: <20211012205521.14098-1-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These are only assigned to the ops field in the snd_soc_dai_link struct
which is a pointer to const struct snd_soc_ops. Make them const to allow
the compiler to put them in read-only memory.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 sound/soc/mediatek/mt2701/mt2701-cs42448.c                 | 2 +-
 sound/soc/mediatek/mt2701/mt2701-wm8960.c                  | 2 +-
 sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/mediatek/mt2701/mt2701-cs42448.c b/sound/soc/mediatek/mt2701/mt2701-cs42448.c
index 44a8d5cfb0aa..d9fd6eb786aa 100644
--- a/sound/soc/mediatek/mt2701/mt2701-cs42448.c
+++ b/sound/soc/mediatek/mt2701/mt2701-cs42448.c
@@ -146,7 +146,7 @@ static int mt2701_cs42448_be_ops_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static struct snd_soc_ops mt2701_cs42448_be_ops = {
+static const struct snd_soc_ops mt2701_cs42448_be_ops = {
 	.hw_params = mt2701_cs42448_be_ops_hw_params
 };
 
diff --git a/sound/soc/mediatek/mt2701/mt2701-wm8960.c b/sound/soc/mediatek/mt2701/mt2701-wm8960.c
index 414e422c0eba..f56de1b918bf 100644
--- a/sound/soc/mediatek/mt2701/mt2701-wm8960.c
+++ b/sound/soc/mediatek/mt2701/mt2701-wm8960.c
@@ -40,7 +40,7 @@ static int mt2701_wm8960_be_ops_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static struct snd_soc_ops mt2701_wm8960_be_ops = {
+static const struct snd_soc_ops mt2701_wm8960_be_ops = {
 	.hw_params = mt2701_wm8960_be_ops_hw_params
 };
 
diff --git a/sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c b/sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c
index 94dcbd36c869..aeb1af86047e 100644
--- a/sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c
+++ b/sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c
@@ -335,7 +335,7 @@ static void mt8183_mt6358_tdm_shutdown(struct snd_pcm_substream *substream)
 			__func__, ret);
 }
 
-static struct snd_soc_ops mt8183_mt6358_tdm_ops = {
+static const struct snd_soc_ops mt8183_mt6358_tdm_ops = {
 	.startup = mt8183_mt6358_tdm_startup,
 	.shutdown = mt8183_mt6358_tdm_shutdown,
 };
-- 
2.33.0

