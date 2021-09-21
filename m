Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C080412F89
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 09:34:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbhIUHf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 03:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbhIUHfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 03:35:55 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98BC2C061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 00:34:27 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id l6so8009390plh.9
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 00:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oIJeMbHxMu9wl8J86TMN3akNUdvjmRjWbKEAkHMeMlY=;
        b=LpIaBsKMOsEN0w91XVOXIqx7N9WT4h8imK48xF4jq3Q2lWAtl1WgX6HVZCwQayAIT/
         jHlEls3zn7hibAYCfLjMwBpP9WT4IAeZtX1RMCL8zeopn3J0CXDMiCAS8TaQYbRftJqT
         5KSMtugVY6LYxd3VhdOEIjq3IYhm1t+BaozjnJwxmb/ZIqREZGEgbU4bQGSOSSlEgx1Z
         wuYW6q35W0Yx2ScSYeL4NrDrQPrDTddDWdgJMcTFG22gGMGul5IuofkHHYh6fpwyJ+KU
         Zx0N3Q6mn0eINsc/gnTgnfuTySqWYtcmBrPqS9dQ1C3WcyvN1NyM178/j1aYfzoL21wd
         RbKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oIJeMbHxMu9wl8J86TMN3akNUdvjmRjWbKEAkHMeMlY=;
        b=3QEqmXJkI0dQHOE46HQmDIT3FdhHVirFGXBjoLvrxuYUMgunYqbMUbkdfR5L3REgmt
         VaQp7nKxe4gjs005Q88eX/pso1Z7zKpc2kJHVIi4FOoRhsgjcCEyQhniqEOOu3WqWb9Y
         UxmaId3SQLpa2aEF6RJgfXcJ20mMoU/VGaDypdZ2q2Cjq7l5Hp1dz59ZftIlUZj981j3
         H5riAfFR7u9gCoNo6FZFlKsbOjfMtoshp4EZmbljuwaAJ2d9CzKqOzOk0vIH3cxYhWZl
         tBWT5IzFDWdlwkL+X2f8yW22+6jzAV6YcVWfM5+TCO1pluUj9Sdo5bX2NWGJrk9K7Tww
         UzGQ==
X-Gm-Message-State: AOAM530FfftjJiXYGXuuQBm14b1gwCdHazEX+wT87lKqRzZi99qsvPqd
        w67YhuW53YOp90O+Skj8u6BX8DtmLLI=
X-Google-Smtp-Source: ABdhPJzg3zFMgXBqbkGWXkq2u5by+cHchp61zrpZX4yklrr382bRbtt/QVpzvDfLdnMylKmtyUrU6w==
X-Received: by 2002:a17:90a:1a19:: with SMTP id 25mr3733534pjk.34.1632209667166;
        Tue, 21 Sep 2021 00:34:27 -0700 (PDT)
Received: from localhost.localdomain ([2402:e280:2130:198:9b25:1cfb:9ff3:2a8f])
        by smtp.gmail.com with ESMTPSA id x8sm16565957pfq.131.2021.09.21.00.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 00:34:26 -0700 (PDT)
From:   Benjamin Philip <benjamin.philip495@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Benjamin Philip <benjamin.philip495@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 1/8] staging: rts5208: remove unnecessary parentheses in rtsx_card.c
Date:   Tue, 21 Sep 2021 13:03:42 +0530
Message-Id: <41db2310fdd942a8d840e21572f1fe21879798e2.1632209460.git.benjamin.philip495@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1632209460.git.benjamin.philip495@gmail.com>
References: <cover.1632209460.git.benjamin.philip495@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit removes unnecessary parentheses that have been flagged
by checkpatch.pl in rtsx_card.c.

Signed-off-by: Benjamin Philip <benjamin.philip495@gmail.com>
---
 drivers/staging/rts5208/rtsx_card.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rts5208/rtsx_card.c b/drivers/staging/rts5208/rtsx_card.c
index 294f381518fa..326b04756f62 100644
--- a/drivers/staging/rts5208/rtsx_card.c
+++ b/drivers/staging/rts5208/rtsx_card.c
@@ -165,7 +165,7 @@ void do_reset_sd_card(struct rtsx_chip *chip)
 		chip->card_fail &= ~SD_CARD;
 		chip->rw_card[chip->card2lun[SD_CARD]] = sd_rw;
 	} else {
-		if (chip->sd_io || (chip->sd_reset_counter >= MAX_RESET_CNT)) {
+		if (chip->sd_io || chip->sd_reset_counter >= MAX_RESET_CNT) {
 			clear_bit(SD_NR, &chip->need_reset);
 			chip->sd_reset_counter = 0;
 			chip->sd_show_cnt = 0;
@@ -636,7 +636,7 @@ int switch_ssc_clock(struct rtsx_chip *chip, int clk)
 	dev_dbg(rtsx_dev(chip), "Switch SSC clock to %dMHz (cur_clk = %d)\n",
 		clk, chip->cur_clk);
 
-	if ((clk <= 2) || (n > max_n))
+	if (clk <= 2 || n > max_n)
 		return STATUS_FAIL;
 
 	mcu_cnt = (u8)(125 / clk + 3);
@@ -886,7 +886,7 @@ int card_power_on(struct rtsx_chip *chip, u8 card)
 	int retval;
 	u8 mask, val1, val2;
 
-	if (CHECK_LUN_MODE(chip, SD_MS_2LUN) && (card == MS_CARD)) {
+	if (CHECK_LUN_MODE(chip, SD_MS_2LUN) && card == MS_CARD) {
 		mask = MS_POWER_MASK;
 		val1 = MS_PARTIAL_POWER_ON;
 		val2 = MS_POWER_ON;
@@ -920,7 +920,7 @@ int card_power_off(struct rtsx_chip *chip, u8 card)
 	int retval;
 	u8 mask, val;
 
-	if (CHECK_LUN_MODE(chip, SD_MS_2LUN) && (card == MS_CARD)) {
+	if (CHECK_LUN_MODE(chip, SD_MS_2LUN) && card == MS_CARD) {
 		mask = MS_POWER_MASK;
 		val = MS_POWER_OFF;
 	} else {
-- 
2.31.1

