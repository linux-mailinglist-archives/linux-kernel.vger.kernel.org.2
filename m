Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 302F9308E6C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 21:31:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233083AbhA2UXK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 15:23:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233270AbhA2UVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 15:21:54 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0790AC061793
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jan 2021 12:20:28 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id u17so10676057iow.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jan 2021 12:20:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DlCW8F0szf7ZcEm2ZEhTbHkqGMJz2nWWOYmbZKt8Dqw=;
        b=aaQJw63j+v5Mf3M1169h/bqRGX0yIu3UppnOZifSqHHBn+FDqmMT8NKZXuYXklhj0m
         zIFWUwfWNk1Vioc2DTO2+reSsuTs5DUcVNrpjop7FN/iUkq/Nt5XCTxH43Kmqa/3Uasi
         fk6WqgG0ihlVgAXUiSPmdzh5UgNh4nUJhTH1ePrT+0X9npLfFhLAAZtn/SNraxGX8uT4
         A6l9bpniux8idbwKfSo8aAUDiLGtQcsRqLbAUdXjOi5+rKk17s+Rt9SVLi7T/V3rVljW
         7Ha4u6jzVXwyFEsJ5eNB78gn5eS0E6bv5PqGGJ6htXJ5ttcT52t5AMmDHKMcduz/C2sR
         NA/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DlCW8F0szf7ZcEm2ZEhTbHkqGMJz2nWWOYmbZKt8Dqw=;
        b=QDupgvz7RQBjPwColRQbWdtVQ0FG4vdpIVq2SWbTtxwI59Tpd6hEPvIxEOMddmyDDG
         Za2DCDUiPBbrXzCV2jbkuWwORZIMSIlaw2c87bE/VBViBAn/7rXszMyQkNA9876lzRgE
         jE53X+g0dsOddIBylLot+/bLzMwrRY6UDmR6VnnXXZpQ54UPChSeK5sF8msKfrwTOmKO
         XkoyhUvX+D+Q8Z/wh+nWv26taKzVcjXhSTgzh9XZILFDhVJpz4LZYg06qhOP6y94V89n
         z6YIFsH+F1VtfdKDiLwGdqSv/m0mg+L/E9ELaQxLg63bExw1lUlwpEnQ07cL7yTnyWXA
         f5ww==
X-Gm-Message-State: AOAM533exxO5fuTNtjCVr2wM6enC6mcLoPBEYSZBE/09qg1PR1XuZ92y
        I+fvVxqhIbpaPNsiLFBlf/NwXg==
X-Google-Smtp-Source: ABdhPJxsq/8ENo6WJV/bYOIl0R7Fal8MGrhbzIMXeJ4/TP0s9QxSDvBEp5ZyUQuLdJPS3DzNRFTxFw==
X-Received: by 2002:a6b:700e:: with SMTP id l14mr4732380ioc.148.1611951627512;
        Fri, 29 Jan 2021 12:20:27 -0800 (PST)
Received: from presto.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id h23sm4645738ila.15.2021.01.29.12.20.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jan 2021 12:20:26 -0800 (PST)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     elder@kernel.org, evgreen@chromium.org, bjorn.andersson@linaro.org,
        cpratapa@codeaurora.org, subashab@codeaurora.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 4/9] net: ipa: kill gsi_channel_freeze() and gsi_channel_thaw()
Date:   Fri, 29 Jan 2021 14:20:14 -0600
Message-Id: <20210129202019.2099259-5-elder@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210129202019.2099259-1-elder@linaro.org>
References: <20210129202019.2099259-1-elder@linaro.org>
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

