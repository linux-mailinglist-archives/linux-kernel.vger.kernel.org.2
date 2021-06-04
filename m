Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC96F39B85B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 13:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbhFDLya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 07:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbhFDLy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 07:54:29 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64F0EC061761
        for <linux-kernel@vger.kernel.org>; Fri,  4 Jun 2021 04:52:43 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id f5so5793126eds.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 04:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1RUP68I3HwNhuXkqx8NfMcQ+Gf4uaCrCeHBt2iSVUE0=;
        b=f9JycFgOvdiHQiHOBO/jYEJjkIyxvmi829WYnht/Iug8GevPoV+bkkrt2d2T6GQEDG
         o8xbcOwQo0j+SDXJtjWqT6oDDc8LWq76ZEU8sXN48T7CAxlKwd4MByqTnxQxoVwU77Vd
         klP5SCZJKwN3B7ddQAHBF1hb37VKUkc8fSPMhJBq5NqdY9VmjsOrvZVuqC6a4zNAy1ze
         62Kq/ORU21mrHljkgdHmuWh+dVd8LcsnGoc/c4od4E8BX/lJqcEPbRJYFUoEFC2QjfZq
         g496bfFMlFa+MdJRDklyDAyTsv+fMuHR2cr3EgPHo/qMV7vj2nEJTREYWJ7vM6MBnhVN
         gMmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1RUP68I3HwNhuXkqx8NfMcQ+Gf4uaCrCeHBt2iSVUE0=;
        b=eYYFM0YvjRRUTb1jqb+BQCgIAFQ+OktsaVskRp3vL9raopil2TRfLJISQE9s3wtk5O
         QGDWHCl/aXYTORxEXAcjzSv8EXVLztzXWKPd6+w1sIxRAgL9VTMvQCmVWYZcPonQEa3Z
         JkMztL4njyKhVAHkWrfkGzmMNXD2+elKwIIg11t56+JJx66ckfIQCQNTHCQTGAabs6Sl
         M4ZwXESz26QfGs0gKuNioEV3sDWH477e+CMCbBRklF7Ds/mjX7L1qamYTEWEBNa7CC8k
         VPnZjlT3Vx6P99o4lySpjP+Ui3izaDOxzMTFx7+mOMhLUAXS49geuPzh7gmWwnGH/VoP
         +TFA==
X-Gm-Message-State: AOAM533r23vHweZQNDtL0Q6SA6k6rxc/4bFbF4IfiYhQyc/FIttSALDk
        F62oOQ51oRoCLM/yPNUstZW/ng==
X-Google-Smtp-Source: ABdhPJzDgNHamWELP1ANrh5hTiuWCkMg/JkfPPGz4kOH6i8YxZ8+Sf0m2C8gWpLOblkVy4xTKvqUjw==
X-Received: by 2002:a05:6402:40c:: with SMTP id q12mr4242123edv.0.1622807562067;
        Fri, 04 Jun 2021 04:52:42 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id x9sm2805527eje.64.2021.06.04.04.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 04:52:41 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     robh@kernel.org, devicetree@vger.kernel.org, perex@perex.cz,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        lgirdwood@gmail.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v3 4/4] ASoC: qcom: sdm845: add jack support for WCD934x
Date:   Fri,  4 Jun 2021 12:52:30 +0100
Message-Id: <20210604115230.23259-5-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210604115230.23259-1-srinivas.kandagatla@linaro.org>
References: <20210604115230.23259-1-srinivas.kandagatla@linaro.org>
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

