Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD593319FAA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 14:18:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231602AbhBLNQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 08:16:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231466AbhBLNQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 08:16:34 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BBFAC061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 05:15:53 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id f1so13045773lfu.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 05:15:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kNfUMwXJsoKHQeXptuNd1laxxutYEsENQDplczxMvTQ=;
        b=U9kMLvw3+66zo/Cb7/7B/Wi9DPJ1U99GxpEBsXoOmEJprfaYXcEgHpkmqKQ0rr6d2y
         0j2RpI96LKVXj13MN/JKUC/Z54BVszxQMLKZp/kXlAf9Q+Ty8/TwO52jwvaK9MEUSbjw
         evQ8U9UqkwwsH3cO2AlIIkPDN6558cjFCzMhdcn8bRVOfdN+MO19R4qG0nBrklS/ghbq
         admRir1yUYAxvX5JugAavEEUJdDCMvYlu9J7AcgPD9gjd6TNFWrHlxFuQPuboPKabObG
         FOvbvsizTmCJETdlac9jL34X41zzPtMpdgE5H8UsqaiVeeb7FtnwmZVrc5/PwbB47hPc
         T5Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kNfUMwXJsoKHQeXptuNd1laxxutYEsENQDplczxMvTQ=;
        b=ChcsEE91YVIxATX88yPZpC4Z6BQCPf4vQkGDz8bQuUaQ4ylLao5mPdxlxhRlvavx67
         AHRFXD9eVOlfiL9hRvlnSWc78JllMVuk++hVjy8/33BOVcEccf5fvnlw/JH2TArAYdSv
         0PUJeIaZAPy2aX66VKuCvMKnoD5AVEfJdhQqimZs9S9rLkScDqu1rgZV3fIYGfOsvqpr
         E6XaLNDqzOZFgeE8ksBvdO8/xCx1L8C5K/SFZEOOt7M7OdF5qeZSHcErx4HL7rtt3lCM
         j4wQ7P39AKF09vMcRK1uKNNzwDy8j1oq677B6o8Hk2nX4d/oy4pUEgakCJ7QjN6U3rVG
         2iFg==
X-Gm-Message-State: AOAM532d1NXs0ikUunqQA2p+KV/KHkytuqIV1MdfYBKmwaLbQDwH2rYo
        fO/L7K7LQuXko56F6JSYKL1GoYFTp/ASXDGc
X-Google-Smtp-Source: ABdhPJyxYldTkDjFUhavPJDFmo5SZNs+btDvyxYX7E1iHc4y/uxolj8FTbGLfyHIHdOMV46UosYMog==
X-Received: by 2002:a19:78a:: with SMTP id 132mr1505818lfh.382.1613135752096;
        Fri, 12 Feb 2021 05:15:52 -0800 (PST)
Received: from localhost.localdomain (h-98-128-181-28.NA.cust.bahnhof.se. [98.128.181.28])
        by smtp.gmail.com with ESMTPSA id w21sm971448lfu.132.2021.02.12.05.15.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Feb 2021 05:15:50 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Pierre Ossman <pierre@ossman.eu>,
        Russell King <linux@armlinux.org.uk>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] mmc: core: Drop superfluous validations in mmc_hw|sw_reset()
Date:   Fri, 12 Feb 2021 14:15:32 +0100
Message-Id: <20210212131532.236775-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <p2/0002-mmc-core-Drop-reference-counting-of-the-bus_ops.patch>
References: <p2/0002-mmc-core-Drop-reference-counting-of-the-bus_ops.patch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mmc_hw|sw_reset() APIs are designed to be called solely from upper
layers, which means drivers that operates on top of the struct mmc_card,
like the mmc block device driver and an SDIO functional driver.

Additionally, as long as the struct mmc_host has a valid pointer to a
struct mmc_card, the corresponding host->bus_ops pointer stays valid and
assigned.

For these reasons, let's drop the superfluous reference counting and the
redundant validations in mmc_hw|sw_reset().

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Note, ideally mmc_hw|sw_reset() shall be converted to take a struct mmc_card*
as an in-parameter, rather than the current struct mmc_host*, but that is left
to a future/separate change.

---
 drivers/mmc/core/block.c |  2 +-
 drivers/mmc/core/core.c  | 21 +--------------------
 2 files changed, 2 insertions(+), 21 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index b877f62df366..b7d3f5a73388 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -947,7 +947,7 @@ static int mmc_blk_reset(struct mmc_blk_data *md, struct mmc_host *host,
 	md->reset_done |= type;
 	err = mmc_hw_reset(host);
 	/* Ensure we switch back to the correct partition */
-	if (err != -EOPNOTSUPP) {
+	if (err) {
 		struct mmc_blk_data *main_md =
 			dev_get_drvdata(&host->card->dev);
 		int part_err;
diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 1136b859ddd8..2e41fa598bd6 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2080,18 +2080,7 @@ int mmc_hw_reset(struct mmc_host *host)
 {
 	int ret;
 
-	if (!host->card)
-		return -EINVAL;
-
-	mmc_bus_get(host);
-	if (!host->bus_ops || host->bus_dead || !host->bus_ops->hw_reset) {
-		mmc_bus_put(host);
-		return -EOPNOTSUPP;
-	}
-
 	ret = host->bus_ops->hw_reset(host);
-	mmc_bus_put(host);
-
 	if (ret < 0)
 		pr_warn("%s: tried to HW reset card, got error %d\n",
 			mmc_hostname(host), ret);
@@ -2104,18 +2093,10 @@ int mmc_sw_reset(struct mmc_host *host)
 {
 	int ret;
 
-	if (!host->card)
-		return -EINVAL;
-
-	mmc_bus_get(host);
-	if (!host->bus_ops || host->bus_dead || !host->bus_ops->sw_reset) {
-		mmc_bus_put(host);
+	if (!host->bus_ops->sw_reset)
 		return -EOPNOTSUPP;
-	}
 
 	ret = host->bus_ops->sw_reset(host);
-	mmc_bus_put(host);
-
 	if (ret)
 		pr_warn("%s: tried to SW reset card, got error %d\n",
 			mmc_hostname(host), ret);
-- 
2.25.1

