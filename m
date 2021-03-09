Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 420A13328C1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 15:40:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbhCIOWC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 09:22:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbhCIOVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 09:21:47 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9E02C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 06:21:46 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id u14so15953851wri.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 06:21:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7SC3b5p8KCrikFDvbH6RkupntFDK0hUEiUc11Ocw6b0=;
        b=ZjYFfHHMPU1GSEGxy+aUr8HnsSN0WaY9mrC7mCccdGr/Fz9YNCK7a4NU+MUZLNRuu4
         q6vgSODxMs3509ZhsFRJVg0NbQeePxj+ZD0rmcs666nAwCEakjLc5J86eQkzPHAIQPgj
         lFvX43AYDJ4Du/7rEQFgmExVuHqBigutDRplslMCNEUtmL2yf8lddLAQCGrOvlZl8RKJ
         P/7pZ0BYqEu0YxTEjsim6fyzxTusPVZGkWKF3u2gIXTeusDhEukBIQsSPS9e6ELLR7Hw
         qD+Mp7+/HARdwBTHa+eLGboLwOuRWjPketW19KwckDK5HRe69cmgcmyP6Z75ukQEXygK
         SdlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7SC3b5p8KCrikFDvbH6RkupntFDK0hUEiUc11Ocw6b0=;
        b=QY9dHi+mfZbNYyT0kUYa7r2Kk6AamJXDLn151gILwcIpiZLl0F5AvTm9S2nykarkgf
         3m1gZDE9Izsb05GjHkJUePEYg7jOugfC1dufUwXDJ/gq8CPypwJmdU+CTA4xpywD5npb
         yt2oEmT/Y2+D+gkqJHk2taOggoiikyJB/0vD9+gTcZbtiZa0MU+OaxZ7wfWAbhMURFLp
         q+VD4/6rEWAwzgzzq99fd1UwlSyJ9CMLhArgC5MXLwMjD6ktYNKIjPCBGQdppb2lGsrW
         7M5aWdn2lx16dSGZ3P7N4chTErDrUM0iGtdQcAjpmTQv+QrgnYSjL41sAE4fpT0EI3W+
         gAKg==
X-Gm-Message-State: AOAM532GiyIJyZ1gNRMwNlUvjinJKtRyHiAJJTemvnBckbYpuXuJL3wS
        kdW7ExGe3zLHQn1Lv4wDVlu1kA==
X-Google-Smtp-Source: ABdhPJxjfJmsj6wcZ6mWd395YhO8e0N+Y5BahWUgBX7oVvKHjeizC9yhxYugXazs9FVzQyn+8YItsw==
X-Received: by 2002:adf:8562:: with SMTP id 89mr28558921wrh.101.1615299705585;
        Tue, 09 Mar 2021 06:21:45 -0800 (PST)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id j14sm22265123wrw.69.2021.03.09.06.21.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 06:21:45 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     perex@perex.cz, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        john.stultz@linaro.org, amit.pundir@linaro.org,
        bjorn.andersson@linaro.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 1/3] ASoC: qcom: sdm845: Fix array out of bounds access
Date:   Tue,  9 Mar 2021 14:21:27 +0000
Message-Id: <20210309142129.14182-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210309142129.14182-1-srinivas.kandagatla@linaro.org>
References: <20210309142129.14182-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Static analysis Coverity had detected a potential array out-of-bounds
write issue due to the fact that MAX AFE port Id was set to 16 instead
of using AFE_PORT_MAX macro.

Fix this by properly using AFE_PORT_MAX macro.

Fixes: 1b93a8843147 ("ASoC: qcom: sdm845: handle soundwire stream")
Reported-by: John Stultz <john.stultz@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/sdm845.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/qcom/sdm845.c b/sound/soc/qcom/sdm845.c
index 6c2760e27ea6..1e2c2d0902ea 100644
--- a/sound/soc/qcom/sdm845.c
+++ b/sound/soc/qcom/sdm845.c
@@ -33,12 +33,12 @@
 struct sdm845_snd_data {
 	struct snd_soc_jack jack;
 	bool jack_setup;
-	bool stream_prepared[SLIM_MAX_RX_PORTS];
+	bool stream_prepared[AFE_PORT_MAX];
 	struct snd_soc_card *card;
 	uint32_t pri_mi2s_clk_count;
 	uint32_t sec_mi2s_clk_count;
 	uint32_t quat_tdm_clk_count;
-	struct sdw_stream_runtime *sruntime[SLIM_MAX_RX_PORTS];
+	struct sdw_stream_runtime *sruntime[AFE_PORT_MAX];
 };
 
 static unsigned int tdm_slot_offset[8] = {0, 4, 8, 12, 16, 20, 24, 28};
-- 
2.21.0

