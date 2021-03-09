Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0E873322CA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 11:17:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbhCIKQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 05:16:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbhCIKQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 05:16:18 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09AD0C06175F
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 02:16:17 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id i9so1241027wml.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 02:16:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7SC3b5p8KCrikFDvbH6RkupntFDK0hUEiUc11Ocw6b0=;
        b=iUEr5zGceE8+/7/m0L48oYW6R+wRzRzdZyKswX3XC7nqAOveY6c5JXSRotZGpPCYmW
         7BzzSUj07puMvOdkaYigM6brsgxXhFTrHd2e0CAww5IWkMEoG/0XpMKahYzuLGybG+j5
         X1IJxTBo6IsKVtEnFxHAtzT9zWKcSVFkyRgQBzI/jyqLnuSLUb4L8OxEX31eirYRgoPe
         m9MJGvzC7tD2DvUGh3PRk0ivlS4Q/Bt+Uf87m1qnumj+4RuFEn867Aq/KOAbsUvMSyaR
         jT4e8mMJyFmMEVHHy0mzFDJbix14iuCwcRUduaiosftVartrXFrGRrAdOFvJ81ocQI7p
         vu9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7SC3b5p8KCrikFDvbH6RkupntFDK0hUEiUc11Ocw6b0=;
        b=jGRY0PGOUKM6XIdvaXzpNzM5pUDZrw8sonluBG5Hn6CiNjM8IMf2CHQhMqwvPCI1Hk
         2EdOxTeseho9D9ENzNmPJmBgPxYX1z/Eryqtg/vyC6ZBbkvPgTcRerzXQjAoLW14K2iM
         epWmGkaMEUl5sih/8SHA0iZIwTlq4SywSeRED81PmLk+G9mCWX/DvCIrJqIbIA+Hk63w
         dxP6YnvoHnHhEFXMbVyXQHseCKijs23M6Y4brCqE3VkSUg1FR+DVzYYy/r7rqMtskwBA
         SzBxIxP7L30/I6hQSfhchrFEUeVctnzWxWyRPYg8IBo+QGX6fy9UEJlw9klIaFEkd/4n
         +YJw==
X-Gm-Message-State: AOAM5325xCHQaFMNf8nZKg0nBBU2jFGAeYwaUjJCtHK/ccnQuipqmQaA
        xJC+tH5D5pd0ZinTTO24ZwOkPQ==
X-Google-Smtp-Source: ABdhPJyjP9o7LviiwTh3yXCbAa9pkMn+bLirElNITQyZFrbR2RAgXQ8Tosz1vNZ68GAL66UEo2XgMQ==
X-Received: by 2002:a05:600c:19d1:: with SMTP id u17mr3119882wmq.141.1615284976563;
        Tue, 09 Mar 2021 02:16:16 -0800 (PST)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id r2sm22552248wrt.8.2021.03.09.02.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 02:16:16 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     perex@perex.cz, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        john.stultz@linaro.org, amit.pundir@linaro.org,
        bjorn.andersson@linaro.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 1/3] ASoC: qcom: sdm845: Fix array out of bounds access
Date:   Tue,  9 Mar 2021 10:16:11 +0000
Message-Id: <20210309101613.25995-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210309101613.25995-1-srinivas.kandagatla@linaro.org>
References: <20210309101613.25995-1-srinivas.kandagatla@linaro.org>
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

