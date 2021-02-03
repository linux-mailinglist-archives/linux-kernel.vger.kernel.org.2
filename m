Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9CDC30DE2C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 16:31:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234081AbhBCPbA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 10:31:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234073AbhBCPa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 10:30:26 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3367AC0617A9
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 07:29:06 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id n2so25662367iom.7
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 07:29:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H+XXRPtcVhqL4SZA2xE4JtYQXLSPRWqhEcRZvJyBubQ=;
        b=YovxfAMaF76XT4oZiDC/n4BsB6CfbxFMoq6w3nj3sc9K8BkiMOWb8UgvpQVmeZkvwA
         P+5FkylqmSrH8aOKZA/3AX4qI0KYjJ8AtL/KeaimrjMEdNNfSBJFsLwLgO2BfIfRWtV3
         Q502dUpZyZejYHakd9ulrcP2aVwOTmH2NysY1/rgUI9N1fGIZpxOr7X8hQLmxJY7T7lR
         x6vovDwjdeTIdQgBJieQYcNUK2zzySJ3c83oEjkBqekehRwN3skmj/leMsHg/uMf8WT5
         7WZcIZj8F5Zdvn0tS3ATXZxxin6G6OVwlkXJW/eXCc3l2w9kAQKZwVixb0p9TSn5igLq
         3+jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H+XXRPtcVhqL4SZA2xE4JtYQXLSPRWqhEcRZvJyBubQ=;
        b=jFZhXnXMzgOq6wzzgVL51Cq+gjRF5PvNARN6K2Y6ca+OzUbMHYo4xwRVyR05vdzkZZ
         rXXcaWkNwuazPgqksFkY07fqEkDZCDbBeRcnCl1SW6ey+5rgOh5TZ1ezBCiNfbmGodWU
         INLOzHG75JAl20OIrsvd/e6wUBuDA2lcqvDxyDHkHzGId+O1FLtWrFZBQF6pUb/hmDMv
         M3TONlf78WqbsUqcgBQwy5n8epjvHUBA1C73D9ZVkD5r/F+gAR4d7i3sqzf+SNIbeInj
         15I+eL5QtYzggPbz04kbRKwnl6mzAAxqnz6E2qzDAWLMRVOUU0m73XBCkKyZ2FO4I7ri
         Yt+w==
X-Gm-Message-State: AOAM531NByJZCzY84yYzv3OA64MifVuMY5EU7NkvcrpJxSz/VzXC9bnq
        tIJrfxkZvNmjt61VGlT4wWfv/w==
X-Google-Smtp-Source: ABdhPJy+sB7tlzpuJ5rowSGj+JwgQeYPg6HivOTNPTr/ebuhpfQOU0MW6qsT6UeDqw3JZBHgliB8yQ==
X-Received: by 2002:a05:6638:378c:: with SMTP id w12mr3458310jal.107.1612366145643;
        Wed, 03 Feb 2021 07:29:05 -0800 (PST)
Received: from beast.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id a15sm1119774ilb.11.2021.02.03.07.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 07:29:05 -0800 (PST)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     elder@kernel.org, evgreen@chromium.org, bjorn.andersson@linaro.org,
        cpratapa@codeaurora.org, subashab@codeaurora.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 5/7] net: ipa: use a Boolean rather than count when replenishing
Date:   Wed,  3 Feb 2021 09:28:53 -0600
Message-Id: <20210203152855.11866-6-elder@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210203152855.11866-1-elder@linaro.org>
References: <20210203152855.11866-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The count argument to ipa_endpoint_replenish() is only ever 0 or 1,
and always will be (because we always handle each receive buffer in
a single transaction).  Rename the argument to be add_one and change
it to be Boolean.

Update the function description to reflect the current code.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/ipa_endpoint.c | 35 ++++++++++++++++++----------------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ipa/ipa_endpoint.c b/drivers/net/ipa/ipa_endpoint.c
index 7a46c790afbef..bff5d6ffd1186 100644
--- a/drivers/net/ipa/ipa_endpoint.c
+++ b/drivers/net/ipa/ipa_endpoint.c
@@ -1020,31 +1020,34 @@ static int ipa_endpoint_replenish_one(struct ipa_endpoint *endpoint)
 }
 
 /**
- * ipa_endpoint_replenish() - Replenish the Rx packets cache.
+ * ipa_endpoint_replenish() - Replenish endpoint receive buffers
  * @endpoint:	Endpoint to be replenished
- * @count:	Number of buffers to send to hardware
+ * @add_one:	Whether this is replacing a just-consumed buffer
  *
- * Allocate RX packet wrapper structures with maximal socket buffers
- * for an endpoint.  These are supplied to the hardware, which fills
- * them with incoming data.
+ * The IPA hardware can hold a fixed number of receive buffers for an RX
+ * endpoint, based on the number of entries in the underlying channel ring
+ * buffer.  If an endpoint's "backlog" is non-zero, it indicates how many
+ * more receive buffers can be supplied to the hardware.  Replenishing for
+ * an endpoint can be disabled, in which case requests to replenish a
+ * buffer are "saved", and transferred to the backlog once it is re-enabled
+ * again.
  */
-static void ipa_endpoint_replenish(struct ipa_endpoint *endpoint, u32 count)
+static void ipa_endpoint_replenish(struct ipa_endpoint *endpoint, bool add_one)
 {
 	struct gsi *gsi;
 	u32 backlog;
 
 	if (!endpoint->replenish_enabled) {
-		if (count)
-			atomic_add(count, &endpoint->replenish_saved);
+		if (add_one)
+			atomic_inc(&endpoint->replenish_saved);
 		return;
 	}
 
-
 	while (atomic_dec_not_zero(&endpoint->replenish_backlog))
 		if (ipa_endpoint_replenish_one(endpoint))
 			goto try_again_later;
-	if (count)
-		atomic_add(count, &endpoint->replenish_backlog);
+	if (add_one)
+		atomic_inc(&endpoint->replenish_backlog);
 
 	return;
 
@@ -1052,8 +1055,8 @@ static void ipa_endpoint_replenish(struct ipa_endpoint *endpoint, u32 count)
 	/* The last one didn't succeed, so fix the backlog */
 	backlog = atomic_inc_return(&endpoint->replenish_backlog);
 
-	if (count)
-		atomic_add(count, &endpoint->replenish_backlog);
+	if (add_one)
+		atomic_inc(&endpoint->replenish_backlog);
 
 	/* Whenever a receive buffer transaction completes we'll try to
 	 * replenish again.  It's unlikely, but if we fail to supply even
@@ -1080,7 +1083,7 @@ static void ipa_endpoint_replenish_enable(struct ipa_endpoint *endpoint)
 	/* Start replenishing if hardware currently has no buffers */
 	max_backlog = gsi_channel_tre_max(gsi, endpoint->channel_id);
 	if (atomic_read(&endpoint->replenish_backlog) == max_backlog)
-		ipa_endpoint_replenish(endpoint, 0);
+		ipa_endpoint_replenish(endpoint, false);
 }
 
 static void ipa_endpoint_replenish_disable(struct ipa_endpoint *endpoint)
@@ -1099,7 +1102,7 @@ static void ipa_endpoint_replenish_work(struct work_struct *work)
 
 	endpoint = container_of(dwork, struct ipa_endpoint, replenish_work);
 
-	ipa_endpoint_replenish(endpoint, 0);
+	ipa_endpoint_replenish(endpoint, false);
 }
 
 static void ipa_endpoint_skb_copy(struct ipa_endpoint *endpoint,
@@ -1300,7 +1303,7 @@ static void ipa_endpoint_rx_complete(struct ipa_endpoint *endpoint,
 {
 	struct page *page;
 
-	ipa_endpoint_replenish(endpoint, 1);
+	ipa_endpoint_replenish(endpoint, true);
 
 	if (trans->cancelled)
 		return;
-- 
2.20.1

