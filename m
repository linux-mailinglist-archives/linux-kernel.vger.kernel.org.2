Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F508308E72
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 21:32:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233306AbhA2UYi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 15:24:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233293AbhA2UW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 15:22:28 -0500
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ED36C061354
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jan 2021 12:20:33 -0800 (PST)
Received: by mail-il1-x135.google.com with SMTP id m20so2144181ilj.13
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jan 2021 12:20:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xs7nwLsyXg7XVa6pclIbxwm44u118oon6gH7yricI1w=;
        b=i1920T7mfZTSl9wqKgNaG+Eqam2WWs+8OVhme/B74E3ozFb71n9IBLyXnTOTmkcqtA
         kNUaOPsnUuzMZNAM/2P7C8Rn2GqZkr5yLnrqvzCkGUGLRIIjn+WxSQ4ZsNqKN36tyXT4
         aq1CaGvAvjHa1oaLJ8LvKtF/lRaQuh2ZhukqUYy246eBGawDknYPLO9JZlFYBvUSeW6P
         GEyUjEzbOknLWe9iO8AZOxqTpfmcdzr1U3RiSvWwqImN/iaKYVJ/W0GIPGba7xs62ABC
         XQT/+0y3WGxTwEfIskFCj7p6UcnrSMvYdIC88hZVGWsAUw3+DBhGRGZ9AdeSskJZYNSu
         ecMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xs7nwLsyXg7XVa6pclIbxwm44u118oon6gH7yricI1w=;
        b=QpHcccRN7LvuDNuzeehGyerYi/xhReZYcCipnfrotjL1vqJPjPVPxQmVDiitGwJB5Z
         mEwq1qTs1t1QVAQq13u4s87DHh3wp0qtE3dDZLvhuL32/a2QZbLy/7q0+gr093FQ7H7s
         cYcq5QI/slF9PDuuhccJPRxTIW2vI2LXBTpKodi/man5uDgeKEhvmsQXdGNjjBmpCX4B
         l907RgNwcuuD814LHLll//nKLaK22pbFG8dvwief4ZBZi3kR45ejnC5k5A6nOZix0+8d
         w8SI6z+zvpW6Dw3SoFu78J9e4rH4JC/iyI0wV+32PnO7xq2ZfhKEcNvDAVuMiLoe2a9l
         PqWw==
X-Gm-Message-State: AOAM533prf+oubB2lw/GoPYvxvpfOBDZO8puTf4VzsHLyB833ym3IuZ6
        V/DAtX8bQRiKTuCq45pT6hpmaGHAwEcvUw==
X-Google-Smtp-Source: ABdhPJyoRPyYINZYmIwvm/IQaCtEy/UOu6sM69wPKIlG3eE0dpCWHyDr7VDuO/XMIz6m1SiB0sHobQ==
X-Received: by 2002:a92:ce41:: with SMTP id a1mr4912576ilr.182.1611951632879;
        Fri, 29 Jan 2021 12:20:32 -0800 (PST)
Received: from presto.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id h23sm4645738ila.15.2021.01.29.12.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jan 2021 12:20:32 -0800 (PST)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     elder@kernel.org, evgreen@chromium.org, bjorn.andersson@linaro.org,
        cpratapa@codeaurora.org, subashab@codeaurora.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 9/9] net: ipa: don't disable NAPI in suspend
Date:   Fri, 29 Jan 2021 14:20:19 -0600
Message-Id: <20210129202019.2099259-10-elder@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210129202019.2099259-1-elder@linaro.org>
References: <20210129202019.2099259-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The channel stop and suspend paths both call __gsi_channel_stop(),
which quiesces channel activity, disables NAPI, and (on other than
SDM845) stops the channel.  Similarly, the start and resume paths
share __gsi_channel_start(), which starts the channel and re-enables
NAPI again.

Disabling NAPI should be done when stopping a channel, but this
should *not* be done when suspending.  It's not necessary in the
suspend path anyway, because the stopped channel (or suspended
endpoint on SDM845) will not cause interrupts to schedule NAPI,
and gsi_channel_trans_quiesce() won't return until there are no
more transactions to process in the NAPI polling loop.

Instead, enable NAPI in gsi_channel_start(), when the completion
interrupt is first enabled.  Disable it again in gsi_channel_stop(),
when finally disabling the interrupt.

Add a call to napi_synchronize() to __gsi_channel_stop(), to ensure
NAPI polling is done before moving on.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/gsi.c | 35 +++++++++++++++++++++--------------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ipa/gsi.c b/drivers/net/ipa/gsi.c
index 217ca21bfe043..afc5c9ede01af 100644
--- a/drivers/net/ipa/gsi.c
+++ b/drivers/net/ipa/gsi.c
@@ -876,15 +876,15 @@ static int __gsi_channel_start(struct gsi_channel *channel, bool start)
 	struct gsi *gsi = channel->gsi;
 	int ret;
 
+	if (!start)
+		return 0;
+
 	mutex_lock(&gsi->mutex);
 
-	ret = start ? gsi_channel_start_command(channel) : 0;
+	ret = gsi_channel_start_command(channel);
 
 	mutex_unlock(&gsi->mutex);
 
-	if (!ret)
-		napi_enable(&channel->napi);
-
 	return ret;
 }
 
@@ -894,12 +894,16 @@ int gsi_channel_start(struct gsi *gsi, u32 channel_id)
 	struct gsi_channel *channel = &gsi->channel[channel_id];
 	int ret;
 
-	/* Enable the completion interrupt */
+	/* Enable NAPI and the completion interrupt */
+	napi_enable(&channel->napi);
 	gsi_irq_ieob_enable_one(gsi, channel->evt_ring_id);
 
 	ret = __gsi_channel_start(channel, true);
-	if (ret)
-		gsi_irq_ieob_disable_one(gsi, channel->evt_ring_id);
+	if (!ret)
+		return 0;
+
+	gsi_irq_ieob_disable_one(gsi, channel->evt_ring_id);
+	napi_disable(&channel->napi);
 
 	return ret;
 }
@@ -928,13 +932,13 @@ static int __gsi_channel_stop(struct gsi_channel *channel, bool stop)
 {
 	int ret;
 
+	/* Wait for any underway transactions to complete before stopping. */
 	gsi_channel_trans_quiesce(channel);
-	napi_disable(&channel->napi);
 
 	ret = stop ? gsi_channel_stop_retry(channel) : 0;
-
-	if (ret)
-		napi_enable(&channel->napi);
+	/* Finally, ensure NAPI polling has finished. */
+	if (!ret)
+		napi_synchronize(&channel->napi);
 
 	return ret;
 }
@@ -947,10 +951,13 @@ int gsi_channel_stop(struct gsi *gsi, u32 channel_id)
 
 	/* Only disable the completion interrupt if stop is successful */
 	ret = __gsi_channel_stop(channel, true);
-	if (!ret)
-		gsi_irq_ieob_disable_one(gsi, channel->evt_ring_id);
+	if (ret)
+		return ret;
 
-	return ret;
+	gsi_irq_ieob_disable_one(gsi, channel->evt_ring_id);
+	napi_disable(&channel->napi);
+
+	return 0;
 }
 
 /* Reset and reconfigure a channel, (possibly) enabling the doorbell engine */
-- 
2.27.0

