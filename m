Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8306308E71
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 21:32:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233364AbhA2UYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 15:24:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233286AbhA2UWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 15:22:21 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47BC1C0617AA
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jan 2021 12:20:30 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id d13so10656062ioy.4
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jan 2021 12:20:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dckDUrUnoDH+LwVUXQzomAtKdVp8ub5VC5ncTRfi83U=;
        b=OxLIExw065dW18xdMJZEUF1uluq1FcKZQbi/lts06z7tN4jmjuoOKMoUtNzqk0H1VV
         D2onKN2Xs6wWr+XgRU+jzt0m2TjQQSgpQa/FAH5AqklTrLk86SAyuHntLAdVd1j2wjhE
         IobhNcWiOPeyiWTQIb1YIsZ4jTsPpVTJnH3dYKvsX2Vn3H/mDaxp7hrZdaCs+VV/KYR2
         CkHJP6piH7i5ljMlIzkykEr5FQf175Taz9LuCy0seve9yfmRTdSjkWHC/ZfU1TlsysSi
         lCal5G7xZr2R9CkO8u2cw+YTgOQqtm6X1N2kcLWzk+PAd3hWW16EGcJcWUbYzzSxL1v7
         LshQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dckDUrUnoDH+LwVUXQzomAtKdVp8ub5VC5ncTRfi83U=;
        b=WL6H3CJh/0bpE42KD9ikeeVRLX+8hbXQt7t6TKRFSkpKGi+/gioxbtzlJiXQC+TnGD
         z5eyjlyk0sXLV3wi2E/+L5GuXKY37DgmUc99eDiZpdg7AE8Qx80rVnKO5qzRMaP3Ce23
         iZbanLJGhe8QVyzY0ameiB1L2sXBlI0F8a3n8Pr2xHwEvDKg6l+FXX8SFk4OjoDQ7UDo
         HezJoZfNANfhGTTKYFjSSn1cNrrBBZX6f3kCZBvcU2pdabapc7/7SE6y4SMfygmQ5TI0
         k0w/+OE35cWk9IOmyIS/1dorc0bKGTXo57X1ar3moTcNDpquUPHSArhp9xXaMi2zYc7J
         vXWQ==
X-Gm-Message-State: AOAM533k4NNbj5VSsMOQpnZhogFX6Pd5M7pXpbWAhOueJLVTuENLdUi0
        85ESw0fIvYO444Ai/J/LvjeB+g==
X-Google-Smtp-Source: ABdhPJw8Wuwd4nPWJhNmNiTMFGC/IQiPrm2292zQyZg0j+BIwoGu3ysfCI80YEPmE7T1t53Lqt2vDQ==
X-Received: by 2002:a5d:9bc5:: with SMTP id d5mr5380657ion.119.1611951629744;
        Fri, 29 Jan 2021 12:20:29 -0800 (PST)
Received: from presto.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id h23sm4645738ila.15.2021.01.29.12.20.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jan 2021 12:20:29 -0800 (PST)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     elder@kernel.org, evgreen@chromium.org, bjorn.andersson@linaro.org,
        cpratapa@codeaurora.org, subashab@codeaurora.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 6/9] net: ipa: move completion interrupt enable/disable
Date:   Fri, 29 Jan 2021 14:20:16 -0600
Message-Id: <20210129202019.2099259-7-elder@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210129202019.2099259-1-elder@linaro.org>
References: <20210129202019.2099259-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the calls to enable or disable IEOB interrupts out of
__gsi_channel_start() and __gsi_channel_stop() and into their
callers.  This is a small step to make the next patch easier
to understand.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/gsi.c | 45 +++++++++++++++++++++++++++++++------------
 1 file changed, 33 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ipa/gsi.c b/drivers/net/ipa/gsi.c
index 1a02936b4db06..70647e8450845 100644
--- a/drivers/net/ipa/gsi.c
+++ b/drivers/net/ipa/gsi.c
@@ -860,17 +860,13 @@ static int __gsi_channel_start(struct gsi_channel *channel, bool start)
 	struct gsi *gsi = channel->gsi;
 	int ret;
 
-	gsi_irq_ieob_enable_one(gsi, channel->evt_ring_id);
-
 	mutex_lock(&gsi->mutex);
 
 	ret = start ? gsi_channel_start_command(channel) : 0;
 
 	mutex_unlock(&gsi->mutex);
 
-	if (ret)
-		gsi_irq_ieob_disable_one(gsi, channel->evt_ring_id);
-	else
+	if (!ret)
 		napi_enable(&channel->napi);
 
 	return ret;
@@ -880,8 +876,16 @@ static int __gsi_channel_start(struct gsi_channel *channel, bool start)
 int gsi_channel_start(struct gsi *gsi, u32 channel_id)
 {
 	struct gsi_channel *channel = &gsi->channel[channel_id];
+	int ret;
 
-	return __gsi_channel_start(channel, true);
+	/* Enable the completion interrupt */
+	gsi_irq_ieob_enable_one(gsi, channel->evt_ring_id);
+
+	ret = __gsi_channel_start(channel, true);
+	if (ret)
+		gsi_irq_ieob_disable_one(gsi, channel->evt_ring_id);
+
+	return ret;
 }
 
 static int gsi_channel_stop_retry(struct gsi_channel *channel)
@@ -906,7 +910,6 @@ static int gsi_channel_stop_retry(struct gsi_channel *channel)
 
 static int __gsi_channel_stop(struct gsi_channel *channel, bool stop)
 {
-	struct gsi *gsi = channel->gsi;
 	int ret;
 
 	gsi_channel_trans_quiesce(channel);
@@ -916,8 +919,6 @@ static int __gsi_channel_stop(struct gsi_channel *channel, bool stop)
 
 	if (ret)
 		napi_enable(&channel->napi);
-	else
-		gsi_irq_ieob_disable_one(gsi, channel->evt_ring_id);
 
 	return ret;
 }
@@ -926,8 +927,14 @@ static int __gsi_channel_stop(struct gsi_channel *channel, bool stop)
 int gsi_channel_stop(struct gsi *gsi, u32 channel_id)
 {
 	struct gsi_channel *channel = &gsi->channel[channel_id];
+	int ret;
 
-	return __gsi_channel_stop(channel, true);
+	/* Only disable the completion interrupt if stop is successful */
+	ret = __gsi_channel_stop(channel, true);
+	if (!ret)
+		gsi_irq_ieob_disable_one(gsi, channel->evt_ring_id);
+
+	return ret;
 }
 
 /* Reset and reconfigure a channel, (possibly) enabling the doorbell engine */
@@ -952,16 +959,30 @@ void gsi_channel_reset(struct gsi *gsi, u32 channel_id, bool doorbell)
 int gsi_channel_suspend(struct gsi *gsi, u32 channel_id, bool stop)
 {
 	struct gsi_channel *channel = &gsi->channel[channel_id];
+	int ret;
 
-	return __gsi_channel_stop(channel, stop);
+	/* No completions when suspended; disable interrupt if successful */
+	ret = __gsi_channel_stop(channel, stop);
+	if (!ret)
+		gsi_irq_ieob_disable_one(gsi, channel->evt_ring_id);
+
+	return ret;
 }
 
 /* Resume a suspended channel (starting will be requested if STOPPED) */
 int gsi_channel_resume(struct gsi *gsi, u32 channel_id, bool start)
 {
 	struct gsi_channel *channel = &gsi->channel[channel_id];
+	int ret;
 
-	return __gsi_channel_start(channel, start);
+	/* Re-enable the completion interrupt */
+	gsi_irq_ieob_enable_one(gsi, channel->evt_ring_id);
+
+	ret = __gsi_channel_start(channel, start);
+	if (ret)
+		gsi_irq_ieob_disable_one(gsi, channel->evt_ring_id);
+
+	return ret;
 }
 
 /**
-- 
2.27.0

