Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB69E3641B4
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 14:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239121AbhDSMaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 08:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233780AbhDSMaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 08:30:22 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA907C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 05:29:51 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id y4so15495240lfl.10
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 05:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ceVsjztUkjkjgdJT/9OnFlYTCetL4aB8s6SCxtd3uSM=;
        b=HEWlImLWkr4Q/N+F5Q1IILtXLfTt/msC7DflWzk05hi4BZoB5jZGHZYcRM7oAfumGG
         5Dd/KEkfsUhIOyNwsQSqOH9sEgzr1Xpc+qJZwko9eXcZU1jynwhxF2O8iBvLRaY+f/uT
         SRf9mRbvtijLKzczjDcR8+nm3ba9aVvGyczlVkhqJmHqMsV7sQx76YffdWX9k0Vz4Jh8
         ar+MX/WsSTDRJrkKob88ud+bf8mwFnnHcRI8HZjkMIDBGmvEm9e+jFZeZV1Xdr2y9G1x
         mQIhVvg/AIzWdiu3xcHcz8H1siI/K2cYKk1mPORjyilZ+0N6LvOkbLhkWjOLf6N8SUNr
         Pg1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ceVsjztUkjkjgdJT/9OnFlYTCetL4aB8s6SCxtd3uSM=;
        b=fHFzEXzIQHoySuskbgsF/deb11AWvbKeSR0z0Y5OmB+IEdcru09TIynl9MV55rAUp9
         w1yuZr0y4+GJ2QnTtP+sUOUfTdGriE/MaGEpSxHd+K4eb35btriib87dv0n7RaYdECDB
         m4tbtla00p7teyC7QyeSNH7cIFbVw3il5jKOtifos/JTQXCsVNfNDPBRfyZUBZplbltm
         Aqhp19oT2bA2d2eSoywQl75uMxtjfSN58iIs0j6+naoYOAOQxBWZl7GCRYzXkFa2NDOj
         PAFhftpSHQVTc1WEL7YRhQ/HFTki1iZrMZjJhphV2ik2C9q1tJitNxS5IZa/d0Z45/LB
         bCsA==
X-Gm-Message-State: AOAM533gMM7UyjYpgURM2HTgNUQR/RwPM+bMr4UE2+WEl7nH+TNtABNI
        bXx1n11bMNNivNMQ2Gk8SpTfPQ==
X-Google-Smtp-Source: ABdhPJw+JtarImMdnuQlmAPIbiSUBWZSPasiV4JgqFZPQL/vVWFs1nr58W+SA5rV5M+NtqnEMtbakQ==
X-Received: by 2002:a05:6512:238e:: with SMTP id c14mr11960357lfv.124.1618835390404;
        Mon, 19 Apr 2021 05:29:50 -0700 (PDT)
Received: from localhost.localdomain (h-155-4-129-234.NA.cust.bahnhof.se. [155.4.129.234])
        by smtp.gmail.com with ESMTPSA id y7sm410988lfl.233.2021.04.19.05.29.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 05:29:49 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Avri Altman <avri.altman@wdc.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] mmc: core: Move eMMC cache flushing to a new bus_ops callback
Date:   Mon, 19 Apr 2021 14:29:43 +0200
Message-Id: <20210419122943.68234-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To prepare to add internal cache management for SD cards, let's start by
moving the eMMC specific code into a new ->flush_cache() bus_ops callback.

In this way, it becomes more straight-forward to add the SD specific parts,
as subsequent changes are about to show.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/core.c    | 11 +++++++++++
 drivers/mmc/core/core.h    |  2 ++
 drivers/mmc/core/mmc.c     | 25 +++++++++++++++++++++++--
 drivers/mmc/core/mmc_ops.c | 23 -----------------------
 drivers/mmc/core/mmc_ops.h |  1 -
 5 files changed, 36 insertions(+), 26 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index f194940c5974..64eb3c8f0d15 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2044,6 +2044,17 @@ int mmc_sw_reset(struct mmc_host *host)
 }
 EXPORT_SYMBOL(mmc_sw_reset);
 
+int mmc_flush_cache(struct mmc_card *card)
+{
+	const struct mmc_bus_ops *bus_ops = card->host->bus_ops;
+
+	if (bus_ops->flush_cache)
+		return bus_ops->flush_cache(card);
+
+	return 0;
+}
+EXPORT_SYMBOL(mmc_flush_cache);
+
 static int mmc_rescan_try_freq(struct mmc_host *host, unsigned freq)
 {
 	host->f_init = freq;
diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
index 8032451abaea..b00012f14671 100644
--- a/drivers/mmc/core/core.h
+++ b/drivers/mmc/core/core.h
@@ -20,6 +20,7 @@ struct mmc_request;
 struct mmc_bus_ops {
 	void (*remove)(struct mmc_host *);
 	void (*detect)(struct mmc_host *);
+	int (*flush_cache)(struct mmc_card *);
 	int (*pre_suspend)(struct mmc_host *);
 	int (*suspend)(struct mmc_host *);
 	int (*resume)(struct mmc_host *);
@@ -98,6 +99,7 @@ bool mmc_is_req_done(struct mmc_host *host, struct mmc_request *mrq);
 
 int mmc_start_request(struct mmc_host *host, struct mmc_request *mrq);
 
+int mmc_flush_cache(struct mmc_card *card);
 int mmc_erase(struct mmc_card *card, unsigned int from, unsigned int nr,
 		unsigned int arg);
 int mmc_can_erase(struct mmc_card *card);
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 8741271d3971..77c9ca024285 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -28,6 +28,7 @@
 
 #define DEFAULT_CMD6_TIMEOUT_MS	500
 #define MIN_CACHE_EN_TIMEOUT_MS 1600
+#define CACHE_FLUSH_TIMEOUT_MS 30000 /* 30s */
 
 static const unsigned int tran_exp[] = {
 	10000,		100000,		1000000,	10000000,
@@ -2029,6 +2030,25 @@ static void mmc_detect(struct mmc_host *host)
 	}
 }
 
+/*
+ * Flush the internal cache of the eMMC to non-volatile storage.
+ */
+static int _mmc_flush_cache(struct mmc_card *card)
+{
+	int err = 0;
+
+	if (card->ext_csd.cache_size > 0 && card->ext_csd.cache_ctrl & 1) {
+		err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
+				 EXT_CSD_FLUSH_CACHE, 1,
+				 CACHE_FLUSH_TIMEOUT_MS);
+		if (err)
+			pr_err("%s: cache flush error %d\n",
+					mmc_hostname(card->host), err);
+	}
+
+	return err;
+}
+
 static int _mmc_suspend(struct mmc_host *host, bool is_suspend)
 {
 	int err = 0;
@@ -2040,7 +2060,7 @@ static int _mmc_suspend(struct mmc_host *host, bool is_suspend)
 	if (mmc_card_suspended(host->card))
 		goto out;
 
-	err = mmc_flush_cache(host->card);
+	err = _mmc_flush_cache(host->card);
 	if (err)
 		goto out;
 
@@ -2181,7 +2201,7 @@ static int _mmc_hw_reset(struct mmc_host *host)
 	 * In the case of recovery, we can't expect flushing the cache to work
 	 * always, but we have a go and ignore errors.
 	 */
-	mmc_flush_cache(host->card);
+	_mmc_flush_cache(host->card);
 
 	if ((host->caps & MMC_CAP_HW_RESET) && host->ops->hw_reset &&
 	     mmc_can_reset(card)) {
@@ -2201,6 +2221,7 @@ static int _mmc_hw_reset(struct mmc_host *host)
 static const struct mmc_bus_ops mmc_ops = {
 	.remove = mmc_remove,
 	.detect = mmc_detect,
+	.flush_cache = _mmc_flush_cache,
 	.suspend = mmc_suspend,
 	.resume = mmc_resume,
 	.runtime_suspend = mmc_runtime_suspend,
diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index f413474f0f80..b03e3cf5dab4 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -20,7 +20,6 @@
 #include "mmc_ops.h"
 
 #define MMC_BKOPS_TIMEOUT_MS		(120 * 1000) /* 120s */
-#define MMC_CACHE_FLUSH_TIMEOUT_MS	(30 * 1000) /* 30s */
 #define MMC_SANITIZE_TIMEOUT_MS		(240 * 1000) /* 240s */
 
 static const u8 tuning_blk_pattern_4bit[] = {
@@ -960,28 +959,6 @@ void mmc_run_bkops(struct mmc_card *card)
 }
 EXPORT_SYMBOL(mmc_run_bkops);
 
-/*
- * Flush the cache to the non-volatile storage.
- */
-int mmc_flush_cache(struct mmc_card *card)
-{
-	int err = 0;
-
-	if (mmc_card_mmc(card) &&
-			(card->ext_csd.cache_size > 0) &&
-			(card->ext_csd.cache_ctrl & 1)) {
-		err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
-				 EXT_CSD_FLUSH_CACHE, 1,
-				 MMC_CACHE_FLUSH_TIMEOUT_MS);
-		if (err)
-			pr_err("%s: cache flush error %d\n",
-					mmc_hostname(card->host), err);
-	}
-
-	return err;
-}
-EXPORT_SYMBOL(mmc_flush_cache);
-
 static int mmc_cmdq_switch(struct mmc_card *card, bool enable)
 {
 	u8 val = enable ? EXT_CSD_CMDQ_MODE_ENABLED : 0;
diff --git a/drivers/mmc/core/mmc_ops.h b/drivers/mmc/core/mmc_ops.h
index 632009260e51..c155ff7b9989 100644
--- a/drivers/mmc/core/mmc_ops.h
+++ b/drivers/mmc/core/mmc_ops.h
@@ -43,7 +43,6 @@ int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
 int mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
 		unsigned int timeout_ms);
 void mmc_run_bkops(struct mmc_card *card);
-int mmc_flush_cache(struct mmc_card *card);
 int mmc_cmdq_enable(struct mmc_card *card);
 int mmc_cmdq_disable(struct mmc_card *card);
 int mmc_sanitize(struct mmc_card *card);
-- 
2.25.1

