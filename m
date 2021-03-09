Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0370A3322CC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 11:17:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbhCIKQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 05:16:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbhCIKQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 05:16:19 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3AECC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 02:16:18 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id l22so1234630wme.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 02:16:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WX5B3jn3ABsmJDUgiZ1eHo/S/aL6tIYdkt/tUOvK0TM=;
        b=vN04cyxDqUiaMClGFuacj9KHo6lA5Hfq2nxSH040ePyBd3FennWQC/tAWuSBtqUKE7
         fVONhlsKroMNejjvUHSlU4t2OZRF8TZ02QMC0yzd03YUT8oIMkDz3piacSSLrAMJwvWI
         IdBM7MwXQNyuah+bClcd8A/K2Lshp7nmrFGc+pxsRocT8xic6mukCT/hWmYPkw9zqQ1d
         E8HIZopo3kjSFP02eBPu32hZ+L4KyLpEZw6iZENOBAmt0Cbj5rvQX9YlfpCKmqjHHthU
         lBdgmF2yf6/Af7s2TO9NBrx1URmr5QYNmmnzL1bs5abtJ07HAVF2N0wi/6jgtMqpx+16
         PKzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WX5B3jn3ABsmJDUgiZ1eHo/S/aL6tIYdkt/tUOvK0TM=;
        b=Ew8RhoQPz5fxD7rqGfa8/IV4M6nA/S6mPeDZpXmWpX61WasYoVKUpjFTGRb6Q+I+fs
         j7T+8Sxm+ICndPHcFLefxPSm4KVHJaCIlEfNwfhEpvgXTEpSTaax5pMRVR9zzWmVuadC
         84Vxw8WoDkegI/LJ24j+jJGIIn+wAwLe/ml4jLhubLv8PPGMatUEEWhBB1+zLRvhJiEE
         7aAljWAeyE710jycQ748MORdMV0vs35i/hcC8yY+Dsgk/JY99u8T75XaCf/gF4tlgAWx
         Zp2+fERHOTMLc5qzmRogZz/xUsYRGTEJp1oNp+1o425593NQoIsu3K0fT7YWNBrkEXJH
         4b1w==
X-Gm-Message-State: AOAM530sZ/djnmezRGUhi7W2CgRjHCCC8VH+f0JJ7e63US80qnvISTjm
        8f6p5TrfVkS1mKKPY9OV2hrevQ==
X-Google-Smtp-Source: ABdhPJy0TulbZb3A9b1N+k2CzwpgJACMjLIPJ6Slj0duc3bnYWnBDMNEy8FnmYKVFP+bv3j/XS90/A==
X-Received: by 2002:a05:600c:2cb9:: with SMTP id h25mr3217369wmc.110.1615284977493;
        Tue, 09 Mar 2021 02:16:17 -0800 (PST)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id r2sm22552248wrt.8.2021.03.09.02.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 02:16:17 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     perex@perex.cz, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        john.stultz@linaro.org, amit.pundir@linaro.org,
        bjorn.andersson@linaro.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 2/3] ASoC: qcom: sdm845: Fix array out of range on rx slim channels
Date:   Tue,  9 Mar 2021 10:16:12 +0000
Message-Id: <20210309101613.25995-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210309101613.25995-1-srinivas.kandagatla@linaro.org>
References: <20210309101613.25995-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WCD934x has only 13 RX SLIM ports however we are setting it as 16
in set_channel_map, this will lead to array out of bounds error!

Orignally caught by enabling USBAN array out of bounds check:

Fixes: 5caf64c633a3 ("ASoC: qcom: sdm845: add support to DB845c and Lenovo Yoga")
Reported-by: John Stultz <john.stultz@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/sdm845.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/qcom/sdm845.c b/sound/soc/qcom/sdm845.c
index 1e2c2d0902ea..153e9b2de0b5 100644
--- a/sound/soc/qcom/sdm845.c
+++ b/sound/soc/qcom/sdm845.c
@@ -27,7 +27,7 @@
 #define SPK_TDM_RX_MASK         0x03
 #define NUM_TDM_SLOTS           8
 #define SLIM_MAX_TX_PORTS 16
-#define SLIM_MAX_RX_PORTS 16
+#define SLIM_MAX_RX_PORTS 13
 #define WCD934X_DEFAULT_MCLK_RATE	9600000
 
 struct sdm845_snd_data {
-- 
2.21.0

