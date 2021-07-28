Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55CB33D9445
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 19:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbhG1R0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 13:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230506AbhG1RZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 13:25:59 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24B09C061757
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 10:25:57 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id b21so3941641ljo.13
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 10:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p27TKDYYHFYhqzphe1Tkc5vZ8HgmZG7DuroJKQvx2Sk=;
        b=WWj/mDctJd0LpDmEI37j9jLpw6K4K1KbxlqbiEIUddGBG3xkRVf1C+tV6dUf4WWRSr
         VJi0DBlFdu2SJfYzD1ksSUAhoYx3PCYc74k5DkjZEs631HteGfoI+v2tS548JkmuZy/D
         X+1lvGD8/v5s4G1AR1UxzcCbI0vPoVn83L6w0P7Wza/pY/LT4ikvuZSsRUjdQ3373GjZ
         YCWt+1RZ4v40k+5n0psTFV8Np2qwpEbN3wPdEvLYjfnD8t8kdpdCDg5Vg91rUfSx0IKV
         js9DFL7PvV/2t3aoAA/ZXRJoT2F12PJJPWAdkkdq+K3aQiyF9grX9B64vBdJW5EF0wuE
         Wddw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p27TKDYYHFYhqzphe1Tkc5vZ8HgmZG7DuroJKQvx2Sk=;
        b=C3UtrHK8M8AsUs4HLTh3guQFujaHveBlx6+Qz4uBmwylm0uhxKx+RwXI56VaLHrHDt
         y988l1XMv7a7xz4Hsc3v0zmv5TRAaRPVOOBnSnsZoOobSeioXzacZW3inDpKGyPqgZWr
         k8Gs+7DGHs174tg0LOM7FBLRsQ7hQZu0X/FgLaxywm0T4mWjb3c0ngEgFKCSAiTOeAzc
         yJBY8uvHGBauBPFyw719kmM4kNhxE7mLF4mhAWX4KysTlqXP0Db3hghKVmGUGvo5WiXH
         c12EnV4NzOuFcfAg7b3mFVNTQO7jlfbIPYxMTUEAvjV3UTC8EvUNIIngMuasq+TeVPRC
         VY8A==
X-Gm-Message-State: AOAM532mVHEaAz2KjtMtzErS+fgh3iBvIrFkuZ/3XCJ0LK6HbeeTNc5/
        cBNxrMvM1o1N0p4+BJrm+mc=
X-Google-Smtp-Source: ABdhPJwk6hc8tfxVgzbhLBEds+OOA+ylsWUJ6Hpwt7z/ofZyVmY0/X3MdFSq2Ltpe5M+UiHNIh04oQ==
X-Received: by 2002:a2e:9794:: with SMTP id y20mr477915lji.417.1627493155518;
        Wed, 28 Jul 2021 10:25:55 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-228-193.NA.cust.bahnhof.se. [98.128.228.193])
        by smtp.gmail.com with ESMTPSA id p28sm55974lfo.117.2021.07.28.10.25.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 10:25:55 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH] ASoC: samsung: Constify static snd_soc_ops
Date:   Wed, 28 Jul 2021 19:25:48 +0200
Message-Id: <20210728172548.234943-1-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.32.0
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
 sound/soc/samsung/aries_wm8994.c   | 2 +-
 sound/soc/samsung/arndale.c        | 4 ++--
 sound/soc/samsung/h1940_uda1380.c  | 2 +-
 sound/soc/samsung/littlemill.c     | 2 +-
 sound/soc/samsung/midas_wm1811.c   | 2 +-
 sound/soc/samsung/neo1973_wm8753.c | 4 ++--
 sound/soc/samsung/rx1950_uda1380.c | 2 +-
 sound/soc/samsung/smartq_wm8987.c  | 2 +-
 sound/soc/samsung/smdk_wm8580.c    | 2 +-
 sound/soc/samsung/smdk_wm8994.c    | 2 +-
 sound/soc/samsung/smdk_wm8994pcm.c | 2 +-
 sound/soc/samsung/tm2_wm5110.c     | 6 +++---
 sound/soc/samsung/tobermory.c      | 2 +-
 13 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/sound/soc/samsung/aries_wm8994.c b/sound/soc/samsung/aries_wm8994.c
index 0ac5956ba270..313ab650f8d9 100644
--- a/sound/soc/samsung/aries_wm8994.c
+++ b/sound/soc/samsung/aries_wm8994.c
@@ -310,7 +310,7 @@ static int aries_hw_free(struct snd_pcm_substream *substream)
 /*
  * Main DAI operations
  */
-static struct snd_soc_ops aries_ops = {
+static const struct snd_soc_ops aries_ops = {
 	.hw_params = aries_hw_params,
 	.hw_free = aries_hw_free,
 };
diff --git a/sound/soc/samsung/arndale.c b/sound/soc/samsung/arndale.c
index 28587375813a..606ac5e33a8e 100644
--- a/sound/soc/samsung/arndale.c
+++ b/sound/soc/samsung/arndale.c
@@ -48,7 +48,7 @@ static int arndale_rt5631_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static struct snd_soc_ops arndale_rt5631_ops = {
+static const struct snd_soc_ops arndale_rt5631_ops = {
 	.hw_params = arndale_rt5631_hw_params,
 };
 
@@ -80,7 +80,7 @@ static int arndale_wm1811_hw_params(struct snd_pcm_substream *substream,
 					rclk + 1, SND_SOC_CLOCK_IN);
 }
 
-static struct snd_soc_ops arndale_wm1811_ops = {
+static const struct snd_soc_ops arndale_wm1811_ops = {
 	.hw_params = arndale_wm1811_hw_params,
 };
 
diff --git a/sound/soc/samsung/h1940_uda1380.c b/sound/soc/samsung/h1940_uda1380.c
index 8aa78ff640f5..c994e67d1eaf 100644
--- a/sound/soc/samsung/h1940_uda1380.c
+++ b/sound/soc/samsung/h1940_uda1380.c
@@ -112,7 +112,7 @@ static int h1940_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static struct snd_soc_ops h1940_ops = {
+static const struct snd_soc_ops h1940_ops = {
 	.startup	= h1940_startup,
 	.hw_params	= h1940_hw_params,
 };
diff --git a/sound/soc/samsung/littlemill.c b/sound/soc/samsung/littlemill.c
index a1ff1400857e..390f2dd735ad 100644
--- a/sound/soc/samsung/littlemill.c
+++ b/sound/soc/samsung/littlemill.c
@@ -130,7 +130,7 @@ static int littlemill_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static struct snd_soc_ops littlemill_ops = {
+static const struct snd_soc_ops littlemill_ops = {
 	.hw_params = littlemill_hw_params,
 };
 
diff --git a/sound/soc/samsung/midas_wm1811.c b/sound/soc/samsung/midas_wm1811.c
index 1f9a553edf19..a2019535a0b1 100644
--- a/sound/soc/samsung/midas_wm1811.c
+++ b/sound/soc/samsung/midas_wm1811.c
@@ -129,7 +129,7 @@ static int midas_aif1_hw_params(struct snd_pcm_substream *substream,
 	return midas_start_fll1(rtd, pll_out);
 }
 
-static struct snd_soc_ops midas_aif1_ops = {
+static const struct snd_soc_ops midas_aif1_ops = {
 	.hw_params = midas_aif1_hw_params,
 };
 
diff --git a/sound/soc/samsung/neo1973_wm8753.c b/sound/soc/samsung/neo1973_wm8753.c
index 9266070e0181..c98b68567a89 100644
--- a/sound/soc/samsung/neo1973_wm8753.c
+++ b/sound/soc/samsung/neo1973_wm8753.c
@@ -106,7 +106,7 @@ static int neo1973_hifi_hw_free(struct snd_pcm_substream *substream)
 /*
  * Neo1973 WM8753 HiFi DAI opserations.
  */
-static struct snd_soc_ops neo1973_hifi_ops = {
+static const struct snd_soc_ops neo1973_hifi_ops = {
 	.hw_params = neo1973_hifi_hw_params,
 	.hw_free = neo1973_hifi_hw_free,
 };
@@ -158,7 +158,7 @@ static int neo1973_voice_hw_free(struct snd_pcm_substream *substream)
 	return snd_soc_dai_set_pll(codec_dai, WM8753_PLL2, 0, 0, 0);
 }
 
-static struct snd_soc_ops neo1973_voice_ops = {
+static const struct snd_soc_ops neo1973_voice_ops = {
 	.hw_params = neo1973_voice_hw_params,
 	.hw_free = neo1973_voice_hw_free,
 };
diff --git a/sound/soc/samsung/rx1950_uda1380.c b/sound/soc/samsung/rx1950_uda1380.c
index 400a7f77c711..6ea1c8cc9167 100644
--- a/sound/soc/samsung/rx1950_uda1380.c
+++ b/sound/soc/samsung/rx1950_uda1380.c
@@ -62,7 +62,7 @@ static struct snd_soc_jack_gpio hp_jack_gpios[] = {
 	},
 };
 
-static struct snd_soc_ops rx1950_ops = {
+static const struct snd_soc_ops rx1950_ops = {
 	.startup	= rx1950_startup,
 	.hw_params	= rx1950_hw_params,
 };
diff --git a/sound/soc/samsung/smartq_wm8987.c b/sound/soc/samsung/smartq_wm8987.c
index c95629becbc3..cee39ad16667 100644
--- a/sound/soc/samsung/smartq_wm8987.c
+++ b/sound/soc/samsung/smartq_wm8987.c
@@ -70,7 +70,7 @@ static int smartq_hifi_hw_params(struct snd_pcm_substream *substream,
 /*
  * SmartQ WM8987 HiFi DAI operations.
  */
-static struct snd_soc_ops smartq_hifi_ops = {
+static const struct snd_soc_ops smartq_hifi_ops = {
 	.hw_params = smartq_hifi_hw_params,
 };
 
diff --git a/sound/soc/samsung/smdk_wm8580.c b/sound/soc/samsung/smdk_wm8580.c
index ed753a2f202e..78703d095a6f 100644
--- a/sound/soc/samsung/smdk_wm8580.c
+++ b/sound/soc/samsung/smdk_wm8580.c
@@ -86,7 +86,7 @@ static int smdk_hw_params(struct snd_pcm_substream *substream,
 /*
  * SMDK WM8580 DAI operations.
  */
-static struct snd_soc_ops smdk_ops = {
+static const struct snd_soc_ops smdk_ops = {
 	.hw_params = smdk_hw_params,
 };
 
diff --git a/sound/soc/samsung/smdk_wm8994.c b/sound/soc/samsung/smdk_wm8994.c
index 39a7a449f554..7661b637946d 100644
--- a/sound/soc/samsung/smdk_wm8994.c
+++ b/sound/soc/samsung/smdk_wm8994.c
@@ -73,7 +73,7 @@ static int smdk_hw_params(struct snd_pcm_substream *substream,
 /*
  * SMDK WM8994 DAI operations.
  */
-static struct snd_soc_ops smdk_ops = {
+static const struct snd_soc_ops smdk_ops = {
 	.hw_params = smdk_hw_params,
 };
 
diff --git a/sound/soc/samsung/smdk_wm8994pcm.c b/sound/soc/samsung/smdk_wm8994pcm.c
index a01640576f71..029448f5bedb 100644
--- a/sound/soc/samsung/smdk_wm8994pcm.c
+++ b/sound/soc/samsung/smdk_wm8994pcm.c
@@ -85,7 +85,7 @@ static int smdk_wm8994_pcm_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static struct snd_soc_ops smdk_wm8994_pcm_ops = {
+static const struct snd_soc_ops smdk_wm8994_pcm_ops = {
 	.hw_params = smdk_wm8994_pcm_hw_params,
 };
 
diff --git a/sound/soc/samsung/tm2_wm5110.c b/sound/soc/samsung/tm2_wm5110.c
index 84c2c63d5a87..a2c77e6defec 100644
--- a/sound/soc/samsung/tm2_wm5110.c
+++ b/sound/soc/samsung/tm2_wm5110.c
@@ -126,7 +126,7 @@ static int tm2_aif1_hw_params(struct snd_pcm_substream *substream,
 	return tm2_start_sysclk(rtd->card);
 }
 
-static struct snd_soc_ops tm2_aif1_ops = {
+static const struct snd_soc_ops tm2_aif1_ops = {
 	.hw_params = tm2_aif1_hw_params,
 };
 
@@ -200,7 +200,7 @@ static int tm2_aif2_hw_free(struct snd_pcm_substream *substream)
 	return ret;
 }
 
-static struct snd_soc_ops tm2_aif2_ops = {
+static const struct snd_soc_ops tm2_aif2_ops = {
 	.hw_params = tm2_aif2_hw_params,
 	.hw_free = tm2_aif2_hw_free,
 };
@@ -254,7 +254,7 @@ static int tm2_hdmi_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static struct snd_soc_ops tm2_hdmi_ops = {
+static const struct snd_soc_ops tm2_hdmi_ops = {
 	.hw_params = tm2_hdmi_hw_params,
 };
 
diff --git a/sound/soc/samsung/tobermory.c b/sound/soc/samsung/tobermory.c
index c962d2c2a7f7..15223d860cb7 100644
--- a/sound/soc/samsung/tobermory.c
+++ b/sound/soc/samsung/tobermory.c
@@ -105,7 +105,7 @@ static int tobermory_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static struct snd_soc_ops tobermory_ops = {
+static const struct snd_soc_ops tobermory_ops = {
 	.hw_params = tobermory_hw_params,
 };
 
-- 
2.32.0

