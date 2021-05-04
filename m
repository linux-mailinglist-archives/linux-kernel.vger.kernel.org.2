Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91A3F372DAA
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 18:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231767AbhEDQNg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 12:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231737AbhEDQNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 12:13:34 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43DE1C061763
        for <linux-kernel@vger.kernel.org>; Tue,  4 May 2021 09:12:38 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id n138so14139931lfa.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 May 2021 09:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0EaNyrJPx800SxJDWlIRfuBN901wRckS9/iskflhAQE=;
        b=rLqzdYDt2bR1nt+32bTw5Wj2OBKwKaY9mrTO+TeMNsCSJDdsSHogYHXYq5aVUojavE
         3LCmWXYW2vY3UAjcjB/f3iKc/sj6kaqqMUPm4/EO9RaJa6D6V5mAWSivkj7fGhnKWuAV
         UrvtBimlKBhnhYKItjnUr1wwzR9g4K7+MjnfkHv9MyLN6ZNtmBhyFXD1gUiCVeObhn8R
         9rT7bJ6X7D4bzJG7yDkJ6XVoqMPt1cZICN+UiFYlAIS0c8ftRV2e172076Fxst9vrAo7
         VralKmATjvw3d4BaT3+vwxzZPv4NA3r48RUgGFmcu+i085fi3Cdgy0POR82KLLN+201j
         36hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0EaNyrJPx800SxJDWlIRfuBN901wRckS9/iskflhAQE=;
        b=Ad4VXf1fUNTvVrwATvkW/KnZWjm/9ulKuowBCdekfyLL2Dg5NN6JQL02lN48+7g1rR
         Qklwohz9Oyc5uZ/cwNuj7L/J6uoiK28z6oeWkE+/1KNHhkjoPSTizD+kx6gZcOisp025
         E9hPJ57kr1A2ishtzCQnkgBSVg7hZlsSURPWLJbu9H64UBSSHBkAYdOM2N7RMrr0P6Q2
         L6nC/fTJQfeUx/jfdGZISn7SJCEIs2Hg5n0cnymTrbjw6fH3HdaYnQH3igDGO7WTtlCS
         7rTTyk0nSVGdy8rUEwk4y5NjlGvtWwwBsnzWIH7MKSUMYIoi30JO1ZykxL9oli1PdGwP
         jf3w==
X-Gm-Message-State: AOAM533JKczIubdQCxiFKY4+bPb5j6UVII96BMbs1ZWuCemySflLxASO
        f6z2L6Y8pueOGe0rBYtOd+rwKA==
X-Google-Smtp-Source: ABdhPJwJgHrJrftbsHwgtxIfiKijEzdjusVilj+/efOsaaWnqgmRssrUyapG+NpbSFPTrxS8x3rgWA==
X-Received: by 2002:ac2:5fcb:: with SMTP id q11mr17218402lfg.248.1620144756714;
        Tue, 04 May 2021 09:12:36 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-180-197.NA.cust.bahnhof.se. [98.128.180.197])
        by smtp.gmail.com with ESMTPSA id s20sm164193ljs.116.2021.05.04.09.12.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 May 2021 09:12:35 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Avri Altman <avri.altman@wdc.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 02/11] mmc: core: Take into account MMC_CAP_NEED_RSP_BUSY for eMMC HPI commands
Date:   Tue,  4 May 2021 18:12:13 +0200
Message-Id: <20210504161222.101536-3-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210504161222.101536-1-ulf.hansson@linaro.org>
References: <20210504161222.101536-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In mmc_send_hpi_cmd() the host->max_busy_timeout is being validated towards
the timeout for the eMMC HPI command, as to decide whether an R1 or R1B
response should be used.

Although, it has turned out the some host can't cope with that conversion,
but needs R1B, which means MMC_CAP_NEED_RSP_BUSY is set for them. Let's
take this into account, via using the common mmc_prepare_busy_cmd() when
doing the validation, which also avoids some open coding.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/mmc_ops.c | 21 +++++----------------
 1 file changed, 5 insertions(+), 16 deletions(-)

diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index 025a4134d5c7..66ae699a410f 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -817,28 +817,17 @@ static int mmc_send_hpi_cmd(struct mmc_card *card)
 {
 	unsigned int busy_timeout_ms = card->ext_csd.out_of_int_time;
 	struct mmc_host *host = card->host;
-	bool use_r1b_resp = true;
+	bool use_r1b_resp = false;
 	struct mmc_command cmd = {};
 	int err;
 
 	cmd.opcode = card->ext_csd.hpi_cmd;
 	cmd.arg = card->rca << 16 | 1;
+	cmd.flags = MMC_RSP_R1 | MMC_CMD_AC;
 
-	/*
-	 * Make sure the host's max_busy_timeout fit the needed timeout for HPI.
-	 * In case it doesn't, let's instruct the host to avoid HW busy
-	 * detection, by using a R1 response instead of R1B.
-	 */
-	if (host->max_busy_timeout && busy_timeout_ms > host->max_busy_timeout)
-		use_r1b_resp = false;
-
-	if (cmd.opcode == MMC_STOP_TRANSMISSION && use_r1b_resp) {
-		cmd.flags = MMC_RSP_R1B | MMC_CMD_AC;
-		cmd.busy_timeout = busy_timeout_ms;
-	} else {
-		cmd.flags = MMC_RSP_R1 | MMC_CMD_AC;
-		use_r1b_resp = false;
-	}
+	if (cmd.opcode == MMC_STOP_TRANSMISSION)
+		use_r1b_resp = mmc_prepare_busy_cmd(host, &cmd,
+						    busy_timeout_ms);
 
 	err = mmc_wait_for_cmd(host, &cmd, 0);
 	if (err) {
-- 
2.25.1

