Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20777312061
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 00:00:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbhBFW7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Feb 2021 17:59:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbhBFW7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Feb 2021 17:59:37 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C11B1C061786
        for <linux-kernel@vger.kernel.org>; Sat,  6 Feb 2021 14:58:56 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id w36so2673313lfu.4
        for <linux-kernel@vger.kernel.org>; Sat, 06 Feb 2021 14:58:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aqb4s2Ei4nQ5JzQuxmamKDisIzQOM+m6EVfsBNYONRE=;
        b=bL14WlfBBkJuhiBNnv/jm9VeZsNQgSgO4Ppp/WZu8TftLEV1sdk+caORZ0FCmCnnw3
         Et0YIFiWjG8KdbWmh8bspRSwDc8FHwKSjXG1nOPId+yGNsSMJA2WZL3P6I1J8f0e03qU
         eECUlBLhHzZjp27Zpu4HmWimtaRxtbi98cfhW212apL+lh2bcaB1lJmEBfZxQee6tSpZ
         2tjCIfmE0ka0BkmKU4eQ1ENF8FUURcKOxiBF8pkfFCvWcHJ1YPpXbnkL8k9wHQEh7w8w
         cyQ39TX+AAy94TQfGNQnClNQXhfTvV3V+hDCmBQ98tdnTkeu5f/zXJIZcFXNxTQXeEx8
         Wdpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aqb4s2Ei4nQ5JzQuxmamKDisIzQOM+m6EVfsBNYONRE=;
        b=ZlEDKUf7N7lABmpL+BxltW83S8hghtcTTsRDnoYgR5yRCVkc7aYtg+rrPUmvf3UEdR
         tCXmC0Sup1/1LMu5GNO7QWpVeo1U3esG3EoBMcS4UWW4vF/uQoaQT73LrkhQCRo6V255
         P6t1cAPq0qz9myR/IwXdFQ6U1KTq2T0k1Aqqw2JDGFP3cXQNY7oIQ12XGhrFIkNyb8Oy
         E3b5/JefCYgXdbN5aBtQhTPr4//NqYI/XF9lwv1psLMZ+A/vU9gxlhfCRV2DJltANX5j
         Fz/M3utAxWKvvaQycY+e7UDf3xTWreK+icvYd2TYGKdkEK3QToBWSn2KFxsKrBqMlZEo
         /paQ==
X-Gm-Message-State: AOAM532T1xpKskZMclUMdeKvw7YctSQLHJpPpmiCz03ayhxvbt0nhnIa
        B/bJMR6ZIOHlASwac1MN7x0=
X-Google-Smtp-Source: ABdhPJw/YnVxaE3qbFOm+hUdBcFziMPiJkNg5hDiTQSDVPpUFCjZV4Fl7/pjyIWIu+JMzLyzIrii9A==
X-Received: by 2002:a19:4c02:: with SMTP id z2mr5912641lfa.590.1612652335311;
        Sat, 06 Feb 2021 14:58:55 -0800 (PST)
Received: from localhost.localdomain (h-158-174-22-164.NA.cust.bahnhof.se. [158.174.22.164])
        by smtp.gmail.com with ESMTPSA id c20sm1467081lfh.275.2021.02.06.14.58.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Feb 2021 14:58:54 -0800 (PST)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Timur Tabi <timur@kernel.org>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     Fabio Estevam <festevam@gmail.com>,
        Shengjiu Wang <shengjiu.wang@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH] ASoC: fsl: constify static snd_soc_dai_ops structs
Date:   Sat,  6 Feb 2021 23:58:49 +0100
Message-Id: <20210206225849.51071-1-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only usage of these is to assign their address to the 'ops' field in
the snd_soc_dai_driver struct, which is a pointer to const. Make them
const to allow the compiler to put them in read-only memory.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 sound/soc/fsl/fsl_easrc.c  | 2 +-
 sound/soc/fsl/fsl_micfil.c | 2 +-
 sound/soc/fsl/fsl_xcvr.c   | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/fsl/fsl_easrc.c b/sound/soc/fsl/fsl_easrc.c
index 60951a8aabd3..636a702f37a6 100644
--- a/sound/soc/fsl/fsl_easrc.c
+++ b/sound/soc/fsl/fsl_easrc.c
@@ -1530,7 +1530,7 @@ static int fsl_easrc_hw_free(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static struct snd_soc_dai_ops fsl_easrc_dai_ops = {
+static const struct snd_soc_dai_ops fsl_easrc_dai_ops = {
 	.startup = fsl_easrc_startup,
 	.trigger = fsl_easrc_trigger,
 	.hw_params = fsl_easrc_hw_params,
diff --git a/sound/soc/fsl/fsl_micfil.c b/sound/soc/fsl/fsl_micfil.c
index 8aedf6590b28..5935af2e5ff4 100644
--- a/sound/soc/fsl/fsl_micfil.c
+++ b/sound/soc/fsl/fsl_micfil.c
@@ -381,7 +381,7 @@ static int fsl_micfil_set_dai_sysclk(struct snd_soc_dai *dai, int clk_id,
 	return ret;
 }
 
-static struct snd_soc_dai_ops fsl_micfil_dai_ops = {
+static const struct snd_soc_dai_ops fsl_micfil_dai_ops = {
 	.startup = fsl_micfil_startup,
 	.trigger = fsl_micfil_trigger,
 	.hw_params = fsl_micfil_hw_params,
diff --git a/sound/soc/fsl/fsl_xcvr.c b/sound/soc/fsl/fsl_xcvr.c
index dd228b421e2c..6dd0a5fcd455 100644
--- a/sound/soc/fsl/fsl_xcvr.c
+++ b/sound/soc/fsl/fsl_xcvr.c
@@ -857,7 +857,7 @@ static struct snd_kcontrol_new fsl_xcvr_tx_ctls[] = {
 	},
 };
 
-static struct snd_soc_dai_ops fsl_xcvr_dai_ops = {
+static const struct snd_soc_dai_ops fsl_xcvr_dai_ops = {
 	.prepare = fsl_xcvr_prepare,
 	.startup = fsl_xcvr_startup,
 	.shutdown = fsl_xcvr_shutdown,
-- 
2.30.0

