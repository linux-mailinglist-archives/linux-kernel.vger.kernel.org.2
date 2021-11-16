Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3EC5453132
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 12:48:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235484AbhKPLv2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 06:51:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235498AbhKPLul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 06:50:41 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3BCFC061202
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 03:47:43 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id i12so15807723wmq.4
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 03:47:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BreePb5GENJp3mJic8QydE3AcREz91hseAFIh0zQTP8=;
        b=h58ZjGHK8mUkiEOmFRLQ13XAaJmcPc0DZ+2L2pt3TAVqlZUp9Aeh+QnbXaRF/kmDDS
         CeO6ZCmO2Uk1a8eYLiPojv8Q+SCHcQnnB+9u5z0rqABl12codsgDiQEBwq7Vmvue4KQe
         sJSn/jMaDVPIsI3dvVyOTPR+mvmKJ8v5xKTBxhbV5EsW/E4MIqnwvfNt2gYBUrOz7Rdr
         xV2HtkVUnLh5yU5B3fTgHGzNpamr1Dnddm6CH/C6T7TjjIAbQ+LujDKXRL1qT3CZs6XV
         r54yjF5hwXIUivFJ7qqFFAVsrvEIRv6DwzFu+6bRpY22eq+urLjN3v+qf5qucELxcxmU
         KyFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BreePb5GENJp3mJic8QydE3AcREz91hseAFIh0zQTP8=;
        b=zeAcizfXsce2ltCNaCSmhY0qPUJN1c4HcP5V/C6SMiMEpznvQudM6ST9O7hjO1UbPb
         Z0E1CLapXHX3SZfmo2Rnc3xyRfz4hT3jEMxohAQQL7L69U4v4ilczbS6PvusOMfdgcbP
         lPd3cSl1pimt/fByp1rV5EvvTdxIrx0ygNjunkyRfiphaSCxSsKG6MupaGr+ove8x6Mn
         xdhAa2iA9tVBo9Rs5USzxDHgdWgBxOc83zdT94EI0yYj/7xfnko+w/r2PqfNN8Cnw91/
         03KgHj2E/FSdSObpcp2MPuyINZFJYajCNN0vIayJxKgf8aVvJgd+O7/7Xgj1LQyALU4H
         uznQ==
X-Gm-Message-State: AOAM531B6MmiKDK40QPVg8IlUAdy5xFZiV0CbzJW943OPZHyCfxSw7Nk
        gOsuBTJxiVOuB3cYT6e43w6pvQ==
X-Google-Smtp-Source: ABdhPJz1Og9ErHvhqbGGcLvGNuby/ITMs3yp4XsutAa8tHnOO8MFr3kYznP+4PwAubYNC430akC2wg==
X-Received: by 2002:a05:600c:4104:: with SMTP id j4mr7047632wmi.178.1637063262636;
        Tue, 16 Nov 2021 03:47:42 -0800 (PST)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id l8sm2260523wmc.40.2021.11.16.03.47.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 03:47:42 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 3/5] ASoC: qdsp6: q6asm: fix q6asm_dai_prepare error handling
Date:   Tue, 16 Nov 2021 11:47:19 +0000
Message-Id: <20211116114721.12517-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20211116114721.12517-1-srinivas.kandagatla@linaro.org>
References: <20211116114721.12517-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Error handling in q6asm_dai_prepare() seems to be completely broken,
Fix this by handling it properly.

Fixes: 2a9e92d371db ("ASoC: qdsp6: q6asm: Add q6asm dai driver")
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/qdsp6/q6asm-dai.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6asm-dai.c b/sound/soc/qcom/qdsp6/q6asm-dai.c
index 46f365528d50..b74b67720ef4 100644
--- a/sound/soc/qcom/qdsp6/q6asm-dai.c
+++ b/sound/soc/qcom/qdsp6/q6asm-dai.c
@@ -269,9 +269,7 @@ static int q6asm_dai_prepare(struct snd_soc_component *component,
 
 	if (ret < 0) {
 		dev_err(dev, "%s: q6asm_open_write failed\n", __func__);
-		q6asm_audio_client_free(prtd->audio_client);
-		prtd->audio_client = NULL;
-		return -ENOMEM;
+		goto open_err;
 	}
 
 	prtd->session_id = q6asm_get_session_id(prtd->audio_client);
@@ -279,7 +277,7 @@ static int q6asm_dai_prepare(struct snd_soc_component *component,
 			      prtd->session_id, substream->stream);
 	if (ret) {
 		dev_err(dev, "%s: stream reg failed ret:%d\n", __func__, ret);
-		return ret;
+		goto routing_err;
 	}
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
@@ -301,10 +299,19 @@ static int q6asm_dai_prepare(struct snd_soc_component *component,
 	}
 	if (ret < 0)
 		dev_info(dev, "%s: CMD Format block failed\n", __func__);
+	else
+		prtd->state = Q6ASM_STREAM_RUNNING;
 
-	prtd->state = Q6ASM_STREAM_RUNNING;
+	return ret;
 
-	return 0;
+routing_err:
+	q6asm_cmd(prtd->audio_client, prtd->stream_id,  CMD_CLOSE);
+open_err:
+	q6asm_unmap_memory_regions(substream->stream, prtd->audio_client);
+	q6asm_audio_client_free(prtd->audio_client);
+	prtd->audio_client = NULL;
+
+	return ret;
 }
 
 static int q6asm_dai_trigger(struct snd_soc_component *component,
-- 
2.21.0

