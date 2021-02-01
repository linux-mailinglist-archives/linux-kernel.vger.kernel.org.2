Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08EB230ADDF
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 18:32:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232008AbhBARau (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 12:30:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231831AbhBARaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 12:30:20 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DC33C06178B
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 09:29:00 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id l4so16356059ilo.11
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 09:29:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DlCW8F0szf7ZcEm2ZEhTbHkqGMJz2nWWOYmbZKt8Dqw=;
        b=ghtetcHIUsxWLmMhZWewAvClfll7oHvu1j/xc8IPS0HcJyNq5OlSTlf67LdNXRauda
         rNnjFHJcIuCDYtdPZ/gCFKOQHko+47Fkmr6cxdHdlBRzwbIkywsrOR8jFFstxS0EmcQC
         Q99eaHWvJpIS0ymTMSIolQow6bbw838FLl9poUvhcN6Ot/EKcb0IjT9KenChGx7/T5TJ
         +RvGoXRc1NDH+xqfvAI6PEgwyG6L3W0uUyOoRSaeI+Ux8VhVqNz55KmzZUh9TEzZo1Hp
         GAN+UNGYDvWyR5VtEjG7I1CsqpSJpQmXpPvhIC5YfpQUw9+LTbbwrDDwNXf2WwU5WVj9
         3IJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DlCW8F0szf7ZcEm2ZEhTbHkqGMJz2nWWOYmbZKt8Dqw=;
        b=VBykKL/E4pHjUJVXRsTaN0vDwyQ6xsfC6QREbyPAOe2MneP5ncHVT3mq6K9978Sgzd
         SyoT00Z7uZcmsoDWRth/Rue9ChLp23d/oDLeeVVV4lSjLUW+n2q8dQ0JQryvu1+22pXL
         dfjaf6t/fdfE//QmmbJveh0ylYlYgChIzA2HpCpbwf50Yj7wRBLNCfl5YfS5rBwwv9MK
         HKHuhtPzSMBj7DfgFKmbtEiIsDWhZAaWc90dqWFB1X2GYqFWBYwGpHOuAoOjbFFRXxkX
         Cfb1Ep4NyR3Pwd3n17rHJh0ipDC25oT0XEIC5r9xYqcWWHcKKkGQ9IcZuHli1Kq6/Fgp
         BUSA==
X-Gm-Message-State: AOAM530fS0ie4wbQ/wUaie7vVp754qhp4eDEDt7ddkhFRYHteptqgtix
        x4ji6YWxQ35AR8itarHFRF7zhg==
X-Google-Smtp-Source: ABdhPJw5zLE1a5ZjzQQMkQ5IoE4vmILj7Lp+FIeWPK3swkN2HhP5qvQdAVppV2VtRJzwikgoZa0JeQ==
X-Received: by 2002:a92:d0d:: with SMTP id 13mr13492710iln.36.1612200539712;
        Mon, 01 Feb 2021 09:28:59 -0800 (PST)
Received: from presto.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id v2sm9529856ilj.19.2021.02.01.09.28.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 09:28:59 -0800 (PST)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     willemdebruijn.kernel@gmail.com, elder@kernel.org,
        evgreen@chromium.org, bjorn.andersson@linaro.org,
        cpratapa@codeaurora.org, subashab@codeaurora.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 4/7] net: ipa: kill gsi_channel_freeze() and gsi_channel_thaw()
Date:   Mon,  1 Feb 2021 11:28:47 -0600
Message-Id: <20210201172850.2221624-5-elder@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210201172850.2221624-1-elder@linaro.org>
References: <20210201172850.2221624-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Open-code gsi_channel_freeze() and gsi_channel_thaw() in all callers
and get rid of these two functions.  This is part of reworking the
sequence of things done during channel suspend/resume and start/stop.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/gsi.c | 37 ++++++++++++-------------------------
 1 file changed, 12 insertions(+), 25 deletions(-)

diff --git a/drivers/net/ipa/gsi.c b/drivers/net/ipa/gsi.c
index bba64887fe969..565c785e33a25 100644
--- a/drivers/net/ipa/gsi.c
+++ b/drivers/net/ipa/gsi.c
@@ -764,24 +764,6 @@ static void gsi_channel_trans_quiesce(struct gsi_channel *channel)
 	}
 }
 
-/* Stop channel activity.  Transactions may not be allocated until thawed. */
-static void gsi_channel_freeze(struct gsi_channel *channel)
-{
-	gsi_channel_trans_quiesce(channel);
-
-	napi_disable(&channel->napi);
-
-	gsi_irq_ieob_disable_one(channel->gsi, channel->evt_ring_id);
-}
-
-/* Allow transactions to be used on the channel again. */
-static void gsi_channel_thaw(struct gsi_channel *channel)
-{
-	gsi_irq_ieob_enable_one(channel->gsi, channel->evt_ring_id);
-
-	napi_enable(&channel->napi);
-}
-
 /* Program a channel for use */
 static void gsi_channel_program(struct gsi_channel *channel, bool doorbell)
 {
@@ -884,9 +866,10 @@ static int __gsi_channel_start(struct gsi_channel *channel, bool start)
 
 	mutex_unlock(&gsi->mutex);
 
-	/* Thaw the channel if successful */
-	if (!ret)
-		gsi_channel_thaw(channel);
+	if (!ret) {
+		gsi_irq_ieob_enable_one(gsi, channel->evt_ring_id);
+		napi_enable(&channel->napi);
+	}
 
 	return ret;
 }
@@ -921,15 +904,19 @@ static int gsi_channel_stop_retry(struct gsi_channel *channel)
 
 static int __gsi_channel_stop(struct gsi_channel *channel, bool stop)
 {
+	struct gsi *gsi = channel->gsi;
 	int ret;
 
-	gsi_channel_freeze(channel);
+	gsi_channel_trans_quiesce(channel);
+	napi_disable(&channel->napi);
+	gsi_irq_ieob_disable_one(gsi, channel->evt_ring_id);
 
 	ret = stop ? gsi_channel_stop_retry(channel) : 0;
 
-	/* Re-thaw the channel if an error occurred while stopping */
-	if (ret)
-		gsi_channel_thaw(channel);
+	if (ret) {
+		gsi_irq_ieob_enable_one(gsi, channel->evt_ring_id);
+		napi_enable(&channel->napi);
+	}
 
 	return ret;
 }
-- 
2.27.0

