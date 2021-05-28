Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6BB3948FD
	for <lists+linux-kernel@lfdr.de>; Sat, 29 May 2021 01:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbhE1XDe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 19:03:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbhE1XDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 19:03:33 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3A43C061574
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 16:01:57 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id e22so3609906pgv.10
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 16:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4kSS03/9tUwCrR5zMvZVoCOgRBPUucyXZ21jl4g9sFE=;
        b=F57V7KhrKsdzMnZh5aymYpbs2+OkJO3iX9brb4TMrG8M1ZykVjWPfDvEZWGYoUc8TC
         /ioMgEsdaK1EZfr8jLlNFzdoera1fn6oqzP65A6KVlufikHhL5Kc2iwzpgMnTjOJAq2c
         b+XW+pr9qocQxswqH188fikWhPJ/oxpcLPWw06J9MpzMhQ0mQ9NFKY2G4nGnRcB+i/NK
         y+AyafQQmp9fz2A+qOpjc9hnrz8HyG1D7KzzfynEPSaIh4CutnOLhFmBdjZtULNziJ71
         qo092IuCfDnUKihnPk1q3+GPsBtRHUk4lhF9+GbseKG3pNC26qHJTsoQcwJCDI4C+cO0
         HZZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4kSS03/9tUwCrR5zMvZVoCOgRBPUucyXZ21jl4g9sFE=;
        b=t8sZ4Et8yN8bLXeZd06jw5bjO5iej2fQSXbKAgq3u0s8opLAXyMPq7TCMRx+fY4rin
         qacAHZlskKr3edYiuJYbRAFl0wkFX5aZeCWXBgF+0/WE6JzEYG09FT7gvjIYm2GYm3ov
         diZo6ig0R3wQ7x8ryt4YeTOzpMBJ3ADBx0w9hK9sVj48HItkGIoa9tKS2HboYzf9LC3q
         65sbg9uAZw1j7y1H7LOole/QlVW/2gAgCz8MxkFwIcxYhlfkTK1WklPnpIQTTs2xvzyo
         ItlyJHZPkqln90/XCQk6wj33MWZD2L1a9MjDGzXFkA8U1Po5NXJQa6S4uxSQQz8T7RNQ
         qusw==
X-Gm-Message-State: AOAM5313JY15AXbJJd3VAAUxmQPTSlgHAomHhjXh8mj0xyHNeVmt8Pw+
        /MGU9ZYhekTVwxn9+fh5+VWJGw==
X-Google-Smtp-Source: ABdhPJyGzo9Ou+NjfZ4fI9Ui3Mcrxsn47Bo24EvTa0/KWU+cPDxZ5jfKFBvdQHBSRVnqtRsafQvxhg==
X-Received: by 2002:a62:ee0f:0:b029:2e9:a990:5afb with SMTP id e15-20020a62ee0f0000b02902e9a9905afbmr330670pfi.41.1622242917048;
        Fri, 28 May 2021 16:01:57 -0700 (PDT)
Received: from localhost.localdomain (122-117-179-2.HINET-IP.hinet.net. [122.117.179.2])
        by smtp.gmail.com with ESMTPSA id l20sm4921331pjq.38.2021.05.28.16.01.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 16:01:56 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Manivannan Sadhasivam <mani@kernel.org>,
        Cristian Ciocaltea <cristian.ciocaltea@gmail.com>,
        linux-actions@lists.infradead.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH v2] regulator: atc260x: Fix n_voltages and min_sel for pickable linear ranges
Date:   Sat, 29 May 2021 07:01:47 +0800
Message-Id: <20210528230147.363974-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The .n_voltages was missed for pickable linear ranges, fix it.
The min_sel for each pickable range should be starting from 0.
Also fix atc260x_ldo_voltage_range_sel setting (bit 5 - LDO<N>_VOL_SEL
in datasheet).

Fixes: 3b15ccac161a ("regulator: Add regulator driver for ATC260x PMICs")
Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
v2: Fix atc260x_ldo_voltage_range_sel setting (bit 5 - LDO<N>_VOL_SEL
in datasheet).
 drivers/regulator/atc260x-regulator.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/regulator/atc260x-regulator.c b/drivers/regulator/atc260x-regulator.c
index d8b429955d33..05147d2c3842 100644
--- a/drivers/regulator/atc260x-regulator.c
+++ b/drivers/regulator/atc260x-regulator.c
@@ -28,16 +28,16 @@ static const struct linear_range atc2609a_dcdc_voltage_ranges[] = {
 
 static const struct linear_range atc2609a_ldo_voltage_ranges0[] = {
 	REGULATOR_LINEAR_RANGE(700000, 0, 15, 100000),
-	REGULATOR_LINEAR_RANGE(2100000, 16, 28, 100000),
+	REGULATOR_LINEAR_RANGE(2100000, 0, 12, 100000),
 };
 
 static const struct linear_range atc2609a_ldo_voltage_ranges1[] = {
 	REGULATOR_LINEAR_RANGE(850000, 0, 15, 100000),
-	REGULATOR_LINEAR_RANGE(2100000, 16, 27, 100000),
+	REGULATOR_LINEAR_RANGE(2100000, 0, 11, 100000),
 };
 
 static const unsigned int atc260x_ldo_voltage_range_sel[] = {
-	0x0, 0x1,
+	0x0, 0x20,
 };
 
 static int atc260x_dcdc_set_voltage_time_sel(struct regulator_dev *rdev,
@@ -411,7 +411,7 @@ enum atc2609a_reg_ids {
 	.owner = THIS_MODULE, \
 }
 
-#define atc2609a_reg_desc_ldo_range_pick(num, n_range) { \
+#define atc2609a_reg_desc_ldo_range_pick(num, n_range, n_volt) { \
 	.name = "LDO"#num, \
 	.supply_name = "ldo"#num, \
 	.of_match = of_match_ptr("ldo"#num), \
@@ -421,6 +421,7 @@ enum atc2609a_reg_ids {
 	.type = REGULATOR_VOLTAGE, \
 	.linear_ranges = atc2609a_ldo_voltage_ranges##n_range, \
 	.n_linear_ranges = ARRAY_SIZE(atc2609a_ldo_voltage_ranges##n_range), \
+	.n_voltages = n_volt, \
 	.vsel_reg = ATC2609A_PMU_LDO##num##_CTL0, \
 	.vsel_mask = GENMASK(4, 1), \
 	.vsel_range_reg = ATC2609A_PMU_LDO##num##_CTL0, \
@@ -458,12 +459,12 @@ static const struct regulator_desc atc2609a_reg[] = {
 	atc2609a_reg_desc_ldo_bypass(0),
 	atc2609a_reg_desc_ldo_bypass(1),
 	atc2609a_reg_desc_ldo_bypass(2),
-	atc2609a_reg_desc_ldo_range_pick(3, 0),
-	atc2609a_reg_desc_ldo_range_pick(4, 0),
+	atc2609a_reg_desc_ldo_range_pick(3, 0, 29),
+	atc2609a_reg_desc_ldo_range_pick(4, 0, 29),
 	atc2609a_reg_desc_ldo(5),
-	atc2609a_reg_desc_ldo_range_pick(6, 1),
-	atc2609a_reg_desc_ldo_range_pick(7, 0),
-	atc2609a_reg_desc_ldo_range_pick(8, 0),
+	atc2609a_reg_desc_ldo_range_pick(6, 1, 28),
+	atc2609a_reg_desc_ldo_range_pick(7, 0, 29),
+	atc2609a_reg_desc_ldo_range_pick(8, 0, 29),
 	atc2609a_reg_desc_ldo_fixed(9),
 };
 
-- 
2.25.1

