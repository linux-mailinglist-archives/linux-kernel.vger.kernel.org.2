Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 374793ADA07
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jun 2021 14:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234224AbhFSMoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Jun 2021 08:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234109AbhFSMn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jun 2021 08:43:56 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16A20C061574
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jun 2021 05:41:45 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id bb20so3091482pjb.3
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jun 2021 05:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GVmpKAp6rjaIfFI7T/LlovcRftWqv7+neej3D4qlrZ0=;
        b=AVGgYiiPgJmoCLwV8OBd5JW7JrdxKlyjaLgaPsHnGMEHd/D2ncIfRXy8dPwMWUEqsz
         7FKF7W3h7fhOvOEF6zBkW1Xn68g3jKpcNlRRI0r8SlgE0Wg+I8Y3Um96AetIbxEVf497
         8GOiNhvy59ARK3Jb+yPBW3UfhGioTwTXr5MQ8fBuLSIbajEQHwE47Tnwl0eYlLLQNyVI
         kSMQKrNmy7Rd3buPWlbpZC1bHgklDmGiGkRpHpXOwweS4QK6yr+YtwxVGM4gZEOdPPA7
         LqxiA1BT0ahWyxJpsGPnWGn2n8RnkPA3PdRA9QL2Zw2RX4qX5vwgJaesfm8ByLJ8vRTi
         7ejg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GVmpKAp6rjaIfFI7T/LlovcRftWqv7+neej3D4qlrZ0=;
        b=g9kX7cj77bHrzqwa+fh1WWoqUyhYdmV+q8/VunGKrlDZbL9Z2kmCVqjArlN0o327y7
         Wv9uB6Sk/iUY9WsZaJNxwCcBaejvPl2xkSx4pwEh4jhohBU//jv3yoqXRQyVPNvFmsl+
         eEeRyPt3yfa0e2Ccv5SI7CaoUMiCwEijg+6JnE2pxTo/1PK5t0IhiPzzHPVZqZBnG0Ov
         SaldMjW1jW/p9RuPy73QVq2xn9ISuljbTrkyWx1OTxLSbAGWzfa830okC1Stt2+a6UXJ
         7SCW+xid1LxrlT9io3emqpkrHZC7R3WHgW3CJkuQb4WtvoQ+mnYCqSjV+JYABMJDc3K6
         iv7g==
X-Gm-Message-State: AOAM532XDitUL4mrG7eBXzU4dIrcSpYKjdC3CeqIa9oKv4cF+V+j1eUH
        q9jXtAqjEkR7fRknfxWB6mu/VA==
X-Google-Smtp-Source: ABdhPJzp8G+4wyqJO/xXtih/gyaQA2KdnkLmIKBP15endq9HvnxHUFMKNzKemGeDbyi2mYsf/k/Nng==
X-Received: by 2002:a17:90a:4404:: with SMTP id s4mr27756203pjg.218.1624106504539;
        Sat, 19 Jun 2021 05:41:44 -0700 (PDT)
Received: from localhost.localdomain (122-117-179-2.HINET-IP.hinet.net. [122.117.179.2])
        by smtp.gmail.com with ESMTPSA id x6sm6687607pjn.53.2021.06.19.05.41.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jun 2021 05:41:43 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Guodong Xu <guodong.xu@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] regulator: hi6421: Use correct variable type for regmap api val argument
Date:   Sat, 19 Jun 2021 20:41:33 +0800
Message-Id: <20210619124133.4096683-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use unsigned int instead of u32 for regmap_read/regmap_update_bits val
argument.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/hi6421-regulator.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/regulator/hi6421-regulator.c b/drivers/regulator/hi6421-regulator.c
index dc631c1a46b4..bff8c515dcde 100644
--- a/drivers/regulator/hi6421-regulator.c
+++ b/drivers/regulator/hi6421-regulator.c
@@ -386,7 +386,7 @@ static int hi6421_regulator_enable(struct regulator_dev *rdev)
 static unsigned int hi6421_regulator_ldo_get_mode(struct regulator_dev *rdev)
 {
 	struct hi6421_regulator_info *info = rdev_get_drvdata(rdev);
-	u32 reg_val;
+	unsigned int reg_val;
 
 	regmap_read(rdev->regmap, rdev->desc->enable_reg, &reg_val);
 	if (reg_val & info->mode_mask)
@@ -398,7 +398,7 @@ static unsigned int hi6421_regulator_ldo_get_mode(struct regulator_dev *rdev)
 static unsigned int hi6421_regulator_buck_get_mode(struct regulator_dev *rdev)
 {
 	struct hi6421_regulator_info *info = rdev_get_drvdata(rdev);
-	u32 reg_val;
+	unsigned int reg_val;
 
 	regmap_read(rdev->regmap, rdev->desc->enable_reg, &reg_val);
 	if (reg_val & info->mode_mask)
@@ -411,7 +411,7 @@ static int hi6421_regulator_ldo_set_mode(struct regulator_dev *rdev,
 						unsigned int mode)
 {
 	struct hi6421_regulator_info *info = rdev_get_drvdata(rdev);
-	u32 new_mode;
+	unsigned int new_mode;
 
 	switch (mode) {
 	case REGULATOR_MODE_NORMAL:
@@ -435,7 +435,7 @@ static int hi6421_regulator_buck_set_mode(struct regulator_dev *rdev,
 						unsigned int mode)
 {
 	struct hi6421_regulator_info *info = rdev_get_drvdata(rdev);
-	u32 new_mode;
+	unsigned int new_mode;
 
 	switch (mode) {
 	case REGULATOR_MODE_NORMAL:
-- 
2.25.1

