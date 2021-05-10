Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7C313780F4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 12:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231131AbhEJKNf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 06:13:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230337AbhEJKN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 06:13:27 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB05AC06138D
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 03:12:18 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id l14so15990116wrx.5
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 03:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1RUP68I3HwNhuXkqx8NfMcQ+Gf4uaCrCeHBt2iSVUE0=;
        b=Ia2f0k5b0Vf6TsMPCzwMZHwwp+JOEI/DGNgUINsuRemHW0a0PU3R4PaTCjICwWAnju
         VJs2s5jBI0XyJrHwF4lho8YSz5CTYRWNGWd5wJHqr+zExfcmUJuhG6/F2fnu5zf2jWQ7
         jLXD1tG6UVVopdAXa325epwi9P5F7ZEp3MpWIxvOEsrWYYRFnZmiCrkUWf9gp9RQNBaV
         MLi9hlvIgh42uZGNXnM414RW+twhQf2bNzsT6dFCcLQN0LoqgG3RcXQUUXIJDHsfGt0H
         X7trKfRGlnF9bRtJIaPlnqrCT1hMUPyF6vhnk2+wjeO50ZF2HhaxtrhRybCxZv4O1bAN
         /QMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1RUP68I3HwNhuXkqx8NfMcQ+Gf4uaCrCeHBt2iSVUE0=;
        b=QG5MxeG5rEbBs7MzkorbcMgcTZ3XnNuItInv8rOYsSBF6h0kNT7DGkeUBMAknnDm1K
         q3H5zczmFZzzJIv4xxc3+/A4IH9oc5hzY24Ry4teVTUZpjLXd0VOZnQixK/gO3dmS4S0
         BENH9AV5DJAgvEEps0F0JMz56wfnnufky55BO+20C6K0YOiAvQtBjmXqymYLL4R9IDiq
         WDBeYMG09TWUSEIGXJ1bK3iNXpuH4o1SRszHnYde7qLrlIAcaogx4dZXoZaqovodcVBf
         jynTFvLjk+tHvbTnj2bOlThRhSk/rsVr0ZXM2n/9KCnDREWzZNivNDJB7T0AugoCpXcR
         +K/A==
X-Gm-Message-State: AOAM532EYuYFL9G0PYFTPx+7HNG7uzPwlyyT1J9iE/L+F9pdtAl4aM6l
        yew0eb4lPiaJD/L/+ajOOFA/BA==
X-Google-Smtp-Source: ABdhPJy1zZnboxYwU59hy7FUd2GyKCZNULHvX4RQWWp+fstvZEyAyCkHKdPtDLe5i77CJgMopibHDA==
X-Received: by 2002:adf:d1c6:: with SMTP id b6mr26190938wrd.110.1620641537371;
        Mon, 10 May 2021 03:12:17 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id b7sm22072109wri.83.2021.05.10.03.12.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 03:12:16 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     robh@kernel.org, devicetree@vger.kernel.org, perex@perex.cz,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        lgirdwood@gmail.com, lee.jones@linaro.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 4/4] ASoC: qcom: sdm845: add jack support for WCD934x
Date:   Mon, 10 May 2021 11:12:01 +0100
Message-Id: <20210510101201.7281-5-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210510101201.7281-1-srinivas.kandagatla@linaro.org>
References: <20210510101201.7281-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/sdm845.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/soc/qcom/sdm845.c b/sound/soc/qcom/sdm845.c
index 153e9b2de0b5..0adfc5708949 100644
--- a/sound/soc/qcom/sdm845.c
+++ b/sound/soc/qcom/sdm845.c
@@ -288,6 +288,14 @@ static int sdm845_dai_init(struct snd_soc_pcm_runtime *rtd)
 			snd_soc_dai_set_sysclk(codec_dai, 0,
 					       WCD934X_DEFAULT_MCLK_RATE,
 					       SNDRV_PCM_STREAM_PLAYBACK);
+
+			rval = snd_soc_component_set_jack(codec_dai->component,
+							  &pdata->jack, NULL);
+			if (rval != 0 && rval != -ENOTSUPP) {
+				dev_warn(card->dev, "Failed to set jack: %d\n", rval);
+				return rval;
+			}
+
 		}
 		break;
 	default:
-- 
2.21.0

