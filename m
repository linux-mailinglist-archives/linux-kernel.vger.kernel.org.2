Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CFA5311A6F
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 04:46:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232447AbhBFDqY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 22:46:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231466AbhBFCr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 21:47:59 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2F6BC061A27
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 14:11:08 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id u8so8697263ior.13
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 14:11:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p5s7C++oXCKkL15pcRUUu+6lFMtCGoUhTxjbs8xu7G8=;
        b=BTEuxbCCuEIbEh3Xb6lKeZylFVq79zCpfoq3Qe9xk58lEmVUp3XxdGh6Gid63VWwoR
         VNA6pAn08IVlLt16Vm9+/RguhOrnxo/92jgQgGsA1+CyhGy7kQw8Y1CihWcub4RdNZSd
         vx3e1tX/pLnSAZecxcvoRFg/4KI6kJB1pY+Tm6tiDn4SzyhfcgjFWsIa4at4898aWki/
         SbeythTF4biNSWniAe5g/58y6PozXVQ2MxYSY33HCXxZ1x1s4sBRPVBVhquKJFON8XxF
         m2YGyyCmbc0Jp7QyjQULVnL37y6gcvDELTLeXNKPL8BzfXnDViqjTtUbdjcRpdSFXx4V
         jNnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p5s7C++oXCKkL15pcRUUu+6lFMtCGoUhTxjbs8xu7G8=;
        b=Timzma5zNN1JSBwG1Aee1G3z2l/1V0qa4rWl4kt3EAZfP7SaQ5clCTIywbkmEIk1qy
         aVBJH+Kt15ApSntQNvOFDf7JhNZjczwwPwN1wCEmWDI8ssoqvoNUcMJ9iZmCipIaOVLL
         9E82LfOBAY+YzeUFx4FAOHyKfQg7PyDc675UgeOGK9KYzI8bWSwVqRctL7Qkg5ZfxAkO
         xa15r2vkeVaGCgtxYlL/+8m3uFcd7++UIgOKdzmkaBoA/nlo1agJ9sTR7L0MecNKrCmQ
         CrFw932AKqsjak7/8dGT8HVJ2G8vQG0Y2n/0rkBSYNMtCjwiFuM7PgUVcuNI4cbXnbTs
         mIeg==
X-Gm-Message-State: AOAM532jDePxoKXKnZOF7oP2IALEJk5M3XCZ/GBC3rGhbEtwTCbXLjor
        4sYoE5rH3M6YXgSF9/mSLQ6PNg==
X-Google-Smtp-Source: ABdhPJzaa0f4HaulF5va8EIB+Lbb4Ar7YMJaoCv+GmNz+VQNzZF7IMtPrstFfdSM/kF/FtGiV00Gdg==
X-Received: by 2002:a05:6602:8f:: with SMTP id h15mr5769771iob.29.1612563068102;
        Fri, 05 Feb 2021 14:11:08 -0800 (PST)
Received: from beast.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id m15sm4647171ilh.6.2021.02.05.14.11.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 14:11:07 -0800 (PST)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     elder@kernel.org, evgreen@chromium.org, bjorn.andersson@linaro.org,
        cpratapa@codeaurora.org, subashab@codeaurora.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 1/7] net: ipa: move mutex calls into __gsi_channel_stop()
Date:   Fri,  5 Feb 2021 16:10:54 -0600
Message-Id: <20210205221100.1738-2-elder@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210205221100.1738-1-elder@linaro.org>
References: <20210205221100.1738-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the mutex calls out of gsi_channel_stop_retry() and into
__gsi_channel_stop(), to make the latter more semantically similar
to to __gsi_channel_start().

Signed-off-by: Alex Elder <elder@linaro.org>
---
v2: - Return early in some cases, to avoid blocks of indented code
    - Update description, to better reflect the updated patch
    - Fix v1 bug in gsi_channel_stop(); disable things on *success*

 drivers/net/ipa/gsi.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ipa/gsi.c b/drivers/net/ipa/gsi.c
index 53640447bf123..f0432c965168c 100644
--- a/drivers/net/ipa/gsi.c
+++ b/drivers/net/ipa/gsi.c
@@ -910,11 +910,8 @@ int gsi_channel_start(struct gsi *gsi, u32 channel_id)
 static int gsi_channel_stop_retry(struct gsi_channel *channel)
 {
 	u32 retries = GSI_CHANNEL_STOP_RETRIES;
-	struct gsi *gsi = channel->gsi;
 	int ret;
 
-	mutex_lock(&gsi->mutex);
-
 	do {
 		ret = gsi_channel_stop_command(channel);
 		if (ret != -EAGAIN)
@@ -922,24 +919,33 @@ static int gsi_channel_stop_retry(struct gsi_channel *channel)
 		usleep_range(3 * USEC_PER_MSEC, 5 * USEC_PER_MSEC);
 	} while (retries--);
 
-	mutex_unlock(&gsi->mutex);
-
 	return ret;
 }
 
 static int __gsi_channel_stop(struct gsi_channel *channel, bool stop)
 {
+	struct gsi *gsi = channel->gsi;
 	int ret;
 
 	/* Wait for any underway transactions to complete before stopping. */
 	gsi_channel_trans_quiesce(channel);
 
-	ret = stop ? gsi_channel_stop_retry(channel) : 0;
-	/* Finally, ensure NAPI polling has finished. */
-	if (!ret)
-		napi_synchronize(&channel->napi);
+	if (!stop)
+		return 0;
 
-	return ret;
+	mutex_lock(&gsi->mutex);
+
+	ret = gsi_channel_stop_retry(channel);
+
+	mutex_unlock(&gsi->mutex);
+
+	if (ret)
+		return ret;
+
+	/* Ensure NAPI polling has finished. */
+	napi_synchronize(&channel->napi);
+
+	return 0;
 }
 
 /* Stop a started channel */
@@ -948,11 +954,11 @@ int gsi_channel_stop(struct gsi *gsi, u32 channel_id)
 	struct gsi_channel *channel = &gsi->channel[channel_id];
 	int ret;
 
-	/* Only disable the completion interrupt if stop is successful */
 	ret = __gsi_channel_stop(channel, true);
 	if (ret)
 		return ret;
 
+	/* Disable the completion interrupt and NAPI if successful */
 	gsi_irq_ieob_disable_one(gsi, channel->evt_ring_id);
 	napi_disable(&channel->napi);
 
-- 
2.20.1

