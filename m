Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8051372DB3
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 18:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231785AbhEDQNm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 12:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231782AbhEDQNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 12:13:40 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EDA9C061574
        for <linux-kernel@vger.kernel.org>; Tue,  4 May 2021 09:12:44 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 12so14038425lfq.13
        for <linux-kernel@vger.kernel.org>; Tue, 04 May 2021 09:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BD0REsdi9mYrsTQHgnQYm8ynmTMvDhWbCRyzYdtenaE=;
        b=BNrJU8ETwTzMQmDoewcwRrwdt+JF/8bPFkNqC9iSYX8GmcOdxoZUPWw9E4k0cnGKvk
         77PhDK128+Z1d73zP2zPsDGLqcOZA04MD5Ys3wFNpOmsNZv1z0Yak4clljxF8NwEiVdY
         y93x/3Sx8ITu7wIKkkWw5t/QHsdQzwokdnLWsU4akPfRIFxjPS6u6rNGB9xbC6z4Rhvi
         PdxHhC34fXzWlJpQGf92/0W5QoV76LROJ3y3ExKR0XPlE2ByVMXKdaclarn5RP7OSIb6
         5vrWZawduBZ9kpPE+YYKSt5n9MKaPfD65yTIMiZvkIGJb9mEJhqntqAbw9r+PTdPsM1i
         mtAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BD0REsdi9mYrsTQHgnQYm8ynmTMvDhWbCRyzYdtenaE=;
        b=qoOCrU+I7vWmL5dKT7rebCyBvRzUr1Czz5AogZNOh8waRzTqXRcOk1Qnfe85f9FoSV
         e+O5BCqISh7HF6xf798SPqs8pnyf1r4gJlgZLQ1JVOG7oaqmlu0SYEWvEo9EKwhwSAMQ
         4dLeZwAzTHRjp7QljJopPdACt7EwweR/EpTArY5CFkwbgvL6GTT6dj/kMSIFJoOIzYry
         3upDE+Rqoxe24wez8o6hNx6sBQcFdxFXoGZRpfcMzjMo9G2xULkVciihYC/r8KIYDDgB
         aVgLsEfEi9OuPFrlh3tAChXtM2/fMbym4PtTS5l5oLwIjWAYF0LQBIibNBOWc3EnDmvy
         7HtA==
X-Gm-Message-State: AOAM533N9tRnSBezevCgP8L8OwFFydPSSiceFavbW/ZPgdRAc7WRRFT9
        dp8McjH6KLcmUcYwun+HwWzyp8dURQnYX+KF
X-Google-Smtp-Source: ABdhPJzTWescUDGeNdcqNOKmn/4NYKWiyZROmOnTzqAYSbKve6znLgTJKGetZjhuqJS77CByg7cxeQ==
X-Received: by 2002:a19:48d7:: with SMTP id v206mr17301695lfa.629.1620144763115;
        Tue, 04 May 2021 09:12:43 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-180-197.NA.cust.bahnhof.se. [98.128.180.197])
        by smtp.gmail.com with ESMTPSA id s20sm164193ljs.116.2021.05.04.09.12.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 May 2021 09:12:41 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Avri Altman <avri.altman@wdc.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 05/11] mmc: core: Enable eMMC sleep commands to use HW busy polling
Date:   Tue,  4 May 2021 18:12:16 +0200
Message-Id: <20210504161222.101536-6-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210504161222.101536-1-ulf.hansson@linaro.org>
References: <20210504161222.101536-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After the eMMC sleep command (CMD5) has been sent, the card start signals
busy on the DAT0 line, which can be monitored to understand when it's
allowed to proceed to power off the VCC regulator.

When MMC_CAP_WAIT_WHILE_BUSY isn't supported by the host the DAT0 line
isn't being monitored for busy completion, but instead we are waiting a
fixed period of time. The time corresponds to the sleep timeout that is
specified in the EXT_CSD register of the eMMC card. This is many cases
suboptimal, as the timeout corresponds to the worst case scenario.

To improve the situation add support for HW busy polling through the
->card_busy() host ops, when the host supports this.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/mmc.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 63a7bd0b239c..13074aa1f605 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1905,6 +1905,14 @@ static int mmc_can_sleep(struct mmc_card *card)
 	return card->ext_csd.rev >= 3;
 }
 
+static int mmc_sleep_busy_cb(void *cb_data, bool *busy)
+{
+	struct mmc_host *host = cb_data;
+
+	*busy = host->ops->card_busy(host);
+	return 0;
+}
+
 static int mmc_sleep(struct mmc_host *host)
 {
 	struct mmc_command cmd = {};
@@ -1930,13 +1938,20 @@ static int mmc_sleep(struct mmc_host *host)
 		goto out_release;
 
 	/*
-	 * If the host does not wait while the card signals busy, then we will
-	 * will have to wait the sleep/awake timeout.  Note, we cannot use the
-	 * SEND_STATUS command to poll the status because that command (and most
-	 * others) is invalid while the card sleeps.
+	 * If the host does not wait while the card signals busy, then we can
+	 * try to poll, but only if the host supports HW polling, as the
+	 * SEND_STATUS cmd is not allowed. If we can't poll, then we simply need
+	 * to wait the sleep/awake timeout.
 	 */
-	if (!use_r1b_resp || !(host->caps & MMC_CAP_WAIT_WHILE_BUSY))
+	if (host->caps & MMC_CAP_WAIT_WHILE_BUSY && use_r1b_resp)
+		goto out_release;
+
+	if (!host->ops->card_busy) {
 		mmc_delay(timeout_ms);
+		goto out_release;
+	}
+
+	err = __mmc_poll_for_busy(card, timeout_ms, &mmc_sleep_busy_cb, host);
 
 out_release:
 	mmc_retune_release(host);
-- 
2.25.1

