Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8521B33286F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 15:22:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbhCIOWD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 09:22:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbhCIOVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 09:21:48 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0746C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 06:21:47 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id v15so15943182wrx.4
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 06:21:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WX5B3jn3ABsmJDUgiZ1eHo/S/aL6tIYdkt/tUOvK0TM=;
        b=aI3BpLNT8H1pAZ2QrPtQOMPukaNZTV5XdPv0BIdLmV+U3RrU37YBlnpBUuNtvp1A51
         z3g2+djeS/JMErH3+T4OcThXvEmuF0cW1gdDx/IXCKB5iyyVw98ibLi/ED9MKvUgTFGS
         0pfo4CWdeyF/q8afoxMGvMCUkSGUvbxlj9pc9GRPsKtzLoKLsHzGlKjVudWqg9lLipTB
         qTk8zFMK2wtILWS81tbJPCVBLaoRtJNjFB4KbmC50px3JR+ARNFPyI6Mtue/Pii/E8su
         FXRWwNbaNdxCmuNbSDq01DBxy8DQ2DZwCPmBkPsw6q26YzNnKsIO9bQUO+vqvkctHkJm
         n9ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WX5B3jn3ABsmJDUgiZ1eHo/S/aL6tIYdkt/tUOvK0TM=;
        b=JMzLL30YzAZKwgOEi4AnDfCFCS76HT+odk5NKiloqoAi9si0CVNdWimXKNy+PH1fff
         viJ9s3giQReoIk3Mgd09Of90yXUYuIjXekeFxqx4Kghc9G1QrZp9i2GiWtljVa8uOBKt
         Wip/ht5WQOjKFLM5ebl4vaXrdtDli9M0AOB6YFXdoTIONqlgzU/BcS+pbJowLoiSOw6k
         TrRFAZIGjlyvDri/tlnL7D/yyuLGYxldPu9RqPwogTuGJ6nf9TpjsMB0ZeEJKGPoGEfC
         Ke6Mabxnwi1oPtu2BP6msSbRtMfuM10Y2VFVUej+tK5IDN+MOxTJ1VdggJNN//M89+QX
         Nx4A==
X-Gm-Message-State: AOAM530nQdC4gniDX7WMFXHeIkLqI3SACblWPDbIqvYeL3af2rNdqgCd
        OAv2x7J/mtTLNE//JSlCjzFQLA==
X-Google-Smtp-Source: ABdhPJwYXhOQbTlcvqtTYprGnLpaUkSDnqmPYYiIhTH9Kd+QvviUvnz+zH5mxzXedEh28pEH0OTgPQ==
X-Received: by 2002:adf:9bcf:: with SMTP id e15mr27691462wrc.276.1615299706510;
        Tue, 09 Mar 2021 06:21:46 -0800 (PST)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id j14sm22265123wrw.69.2021.03.09.06.21.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 06:21:46 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     perex@perex.cz, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        john.stultz@linaro.org, amit.pundir@linaro.org,
        bjorn.andersson@linaro.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 2/3] ASoC: qcom: sdm845: Fix array out of range on rx slim channels
Date:   Tue,  9 Mar 2021 14:21:28 +0000
Message-Id: <20210309142129.14182-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210309142129.14182-1-srinivas.kandagatla@linaro.org>
References: <20210309142129.14182-1-srinivas.kandagatla@linaro.org>
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

