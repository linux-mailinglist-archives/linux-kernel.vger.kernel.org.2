Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BFFB412A78
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 03:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232267AbhIUBmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 21:42:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232072AbhIUBjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 21:39:11 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 528A5C01AE60
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 12:40:04 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id m3so69673007lfu.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 12:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0d+1u0/MGOf1Q+rRJjNzrlBMOxR6V08d5yL0PRRuFjk=;
        b=Z27HSHOXeONBAxoy541SkWEavFdL299blXuqc2n5ujiwo7gG80cp8+qYAGh1PzTLb+
         f1D74ClKDHTv+VFv1IgQbF9kOYYPrg8ok2OnadReIJlKhVlN5AJv1Ab9aakm5RA6DB+u
         25Hgq7Qaj11btnrGSzWCi3PdFes+eWMGo5CWJ9rR8fnAeltDP4NffLDjv9NbnQeisFu8
         TH7U86NaUg3q/hLUOoxnXUZfBk23sEjy9c1uaFLcQ4JY7VWeHNBD2J2VZ6UHy4WyFTmZ
         FIru+MgsMYPAx9e7JVmxk2COcGnYkK/9RXdjoimhDOO76gKDZOLWvfQIKehOGJTPtqNo
         t74A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0d+1u0/MGOf1Q+rRJjNzrlBMOxR6V08d5yL0PRRuFjk=;
        b=P92pocXVRUQfxM4KYSzxz95CWdIXGVPx3wdRQleFnnWF+Hrv5f0nLKgICqjfrD8nE3
         VS8M/4z89GVj7y268iEXU9TWl2hME92kPW/WP6+jCkEstbs8Sq9/xsLT+cO3/nPsOt6V
         1BTOKZmlRuz2OW2B9qt1oFku8mFc9T2LRwYc2o2uYMUNZ5go+1GKB25sGj0W6UpCRyzG
         UCRQrBf6zmINAuGg/nQh7slouLR4TTC7JMJ5uHBXcEJcYoMChtEbTuQ5XI8X98POX0nP
         xNdJSMQENdVgJlOeALypyUkCQ7fc9u4wgooUbyt1HbV9yVeTttKUweGMsM07YQES4u0x
         oT5Q==
X-Gm-Message-State: AOAM532mcgjGxcUfTU1NXirXWCQZcZ6VK+GJ3i5z8MKMwZajx4c4w0Q/
        cidArNJ7SjH1j5uIQZ4f4Cc=
X-Google-Smtp-Source: ABdhPJxkMxrniDwwp6a9hFc5k/MvdsynqXqzCzYiuyoNQHhMjqhkhBiYHRLG4GrNFJMcpZTnzrtiTw==
X-Received: by 2002:a2e:bd8b:: with SMTP id o11mr14743218ljq.321.1632166802693;
        Mon, 20 Sep 2021 12:40:02 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-228-193.NA.cust.bahnhof.se. [98.128.228.193])
        by smtp.gmail.com with ESMTPSA id y11sm475899lfs.135.2021.09.20.12.40.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 12:40:02 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Nicolin Chen <nicoleotsuka@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Fabio Estevam <festevam@gmail.com>,
        Shengjiu Wang <shengjiu.wang@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH] ASoC: fsl: Constify static snd_soc_ops
Date:   Mon, 20 Sep 2021 21:39:47 +0200
Message-Id: <20210920193947.10237-1-rikard.falkeborn@gmail.com>
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
 sound/soc/fsl/imx-audmix.c | 4 ++--
 sound/soc/fsl/imx-card.c   | 4 ++--
 sound/soc/fsl/imx-hdmi.c   | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/fsl/imx-audmix.c b/sound/soc/fsl/imx-audmix.c
index a364e2415de0..0d637929bfef 100644
--- a/sound/soc/fsl/imx-audmix.c
+++ b/sound/soc/fsl/imx-audmix.c
@@ -132,12 +132,12 @@ static int imx_audmix_be_hw_params(struct snd_pcm_substream *substream,
 	return ret;
 }
 
-static struct snd_soc_ops imx_audmix_fe_ops = {
+static const struct snd_soc_ops imx_audmix_fe_ops = {
 	.startup = imx_audmix_fe_startup,
 	.hw_params = imx_audmix_fe_hw_params,
 };
 
-static struct snd_soc_ops imx_audmix_be_ops = {
+static const struct snd_soc_ops imx_audmix_be_ops = {
 	.hw_params = imx_audmix_be_hw_params,
 };
 
diff --git a/sound/soc/fsl/imx-card.c b/sound/soc/fsl/imx-card.c
index 58fd0639a069..05dff2dc1d19 100644
--- a/sound/soc/fsl/imx-card.c
+++ b/sound/soc/fsl/imx-card.c
@@ -442,12 +442,12 @@ static int imx_aif_startup(struct snd_pcm_substream *substream)
 	return ret;
 }
 
-static struct snd_soc_ops imx_aif_ops = {
+static const struct snd_soc_ops imx_aif_ops = {
 	.hw_params = imx_aif_hw_params,
 	.startup = imx_aif_startup,
 };
 
-static struct snd_soc_ops imx_aif_ops_be = {
+static const struct snd_soc_ops imx_aif_ops_be = {
 	.hw_params = imx_aif_hw_params,
 };
 
diff --git a/sound/soc/fsl/imx-hdmi.c b/sound/soc/fsl/imx-hdmi.c
index 34a0dceae621..2b663c39edb2 100644
--- a/sound/soc/fsl/imx-hdmi.c
+++ b/sound/soc/fsl/imx-hdmi.c
@@ -59,7 +59,7 @@ static int imx_hdmi_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static struct snd_soc_ops imx_hdmi_ops = {
+static const struct snd_soc_ops imx_hdmi_ops = {
 	.hw_params = imx_hdmi_hw_params,
 };
 
-- 
2.33.0

