Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FA85453143
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 12:50:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235507AbhKPLxd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 06:53:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235578AbhKPLxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 06:53:24 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18800C061746
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 03:50:27 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id 133so16693791wme.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 03:50:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YqhuwHNxm7z2yboLK3WpqR4Y4LFQ6CPMaK61Ve4wq0Q=;
        b=mF9iqJBhZ2+3lU2ljVFIGxW5v67PqTcMT1NPsEPuzx+T+tVzPW+0bMY0aLGohljptU
         vumHlIWSTf+mfM4PqPkPw0OqR0eiDX1QkNq+3m/H876Lq02kYDBGkv/wes857sTBPUHV
         rwmoWbRIKavv6HL3G+5baCUBoe8Cz8dI26KI/fesHGvI522NS6Bg2Bd8vc77btoqiRTd
         +gix7ZDVmwqqjDPYYdDr/yTEOM0Ar76SpT/O6uS5ijx6Mo0wz8pOBHD1d+UVk5FZvJz8
         I/1C2GeqTtHpkLPuOQ2MReZ5c3wyC/Fj/VQVitIb1WFMEe4c4wKpkvpJvOwCC+5F467W
         ZHcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YqhuwHNxm7z2yboLK3WpqR4Y4LFQ6CPMaK61Ve4wq0Q=;
        b=hab7A30WCom0la0a/B0U+vK6j4IwBH5HqR141Myz1oqGNKglptmCR7arnZknf+bEJI
         xKN5l2IPtepv2TCzzPUj0bDPbOMq5el9DVdH0rM6XAeD5OI61f6isOzlUFLRjLl4ee4X
         ZZPaEp430p65QYSEz3ZjV5Kbqr6CE/WPW0spwQGwXEg5At8mmQ8wC8r8JetSbE3s+Ko7
         GjiEB1CkEMod0KtQmAD94SX9A2OHrKXxvT6LGdvJfCam0QX+3GKxLjVrc89SKhG0FEXB
         yjvyDyNQj4AmhgLAjoGgI/15Mo1KcUGIz0PL+jXtbk7N3mz0cck3QM6y5wffJz9TIEsA
         wR+A==
X-Gm-Message-State: AOAM5315wHikNvARM3JqIUC+Rgrg5HwKAy0AyzeriFljoOvlKVNBNDAB
        ko91qzl3wAyoZsO7t3St07uwew==
X-Google-Smtp-Source: ABdhPJzRU3oGNEgu0PJAQbnwa1+iKoPx4e3I0NVt+Ubpw7Kci1Y/sVALjqisSHRLYFLECOde+K/dMg==
X-Received: by 2002:a05:600c:2046:: with SMTP id p6mr68795075wmg.87.1637063425752;
        Tue, 16 Nov 2021 03:50:25 -0800 (PST)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id t127sm2351065wma.9.2021.11.16.03.50.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 03:50:24 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH] ASoC: qcom: sdm845: only setup slim ports once
Date:   Tue, 16 Nov 2021 11:50:21 +0000
Message-Id: <20211116115021.14213-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently same slim channel map setup for every dai link, which is redundant.
Fix this by adding a flag and conditionally setting these channel maps.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/sdm845.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/sound/soc/qcom/sdm845.c b/sound/soc/qcom/sdm845.c
index 0adfc5708949..a1d5d96744b5 100644
--- a/sound/soc/qcom/sdm845.c
+++ b/sound/soc/qcom/sdm845.c
@@ -33,6 +33,7 @@
 struct sdm845_snd_data {
 	struct snd_soc_jack jack;
 	bool jack_setup;
+	bool slim_port_setup;
 	bool stream_prepared[AFE_PORT_MAX];
 	struct snd_soc_card *card;
 	uint32_t pri_mi2s_clk_count;
@@ -224,6 +225,7 @@ static int sdm845_dai_init(struct snd_soc_pcm_runtime *rtd)
 	struct snd_soc_dai *codec_dai = asoc_rtd_to_codec(rtd, 0);
 	struct snd_soc_dai *cpu_dai = asoc_rtd_to_cpu(rtd, 0);
 	struct sdm845_snd_data *pdata = snd_soc_card_get_drvdata(card);
+	struct snd_soc_dai_link *link = rtd->dai_link;
 	struct snd_jack *jack;
 	/*
 	 * Codec SLIMBUS configuration
@@ -276,6 +278,10 @@ static int sdm845_dai_init(struct snd_soc_pcm_runtime *rtd)
 		}
 		break;
 	case SLIMBUS_0_RX...SLIMBUS_6_TX:
+		/* setting up wcd multiple times for slim port is redundant */
+		if (pdata->slim_port_setup || !link->no_pcm)
+			return 0;
+
 		for_each_rtd_codec_dais(rtd, i, codec_dai) {
 			rval = snd_soc_dai_set_channel_map(codec_dai,
 							  ARRAY_SIZE(tx_ch),
@@ -295,8 +301,10 @@ static int sdm845_dai_init(struct snd_soc_pcm_runtime *rtd)
 				dev_warn(card->dev, "Failed to set jack: %d\n", rval);
 				return rval;
 			}
-
 		}
+
+		pdata->slim_port_setup = true;
+
 		break;
 	default:
 		break;
-- 
2.21.0

