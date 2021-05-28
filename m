Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51AB33942B5
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 14:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233429AbhE1Mk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 08:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234486AbhE1MkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 08:40:13 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF677C061574
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 05:38:37 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id h20-20020a17090aa894b029015db8f3969eso2440533pjq.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 05:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QOiLxUjpo2oQOwyVvttRY0YkBpGLqZoOW124JZCFc10=;
        b=oCQadO3ZEmQpMTvV/1axTRAuuDUQ3M/P8Tl9ABkauh2hWV/g6REb2o5ZOb5RdLErno
         fKQu3tZsfRDc3+FnDV3ghJ3lbdoDe8r9IajsUu0/Sq5f2cNiRCh5+dUvRP7dV53NkNU/
         dAJn6n3p09/wmQsHRBZydW+8PtrzO4a4UXi0Idjh2JrBdr6ZBh+87HriZm0yLAnWY08U
         Vb4x08Ij7qtBqsRP96aThvu9lwHdQ/rsrMBVFZXS507rpVXlAUnsASVR9ivurfuYq6SW
         RZncg57dJ6SHiaFvhcrjK+fA2Y+8+QOSKiKc7kOJGvlaInAebEFRAhiyDTsNi8BBiZTk
         eezg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QOiLxUjpo2oQOwyVvttRY0YkBpGLqZoOW124JZCFc10=;
        b=T4BjLtsDzObexXHNnJPipZA5IwJf26Nf/uamC+sWhQJucLgglYtbC1U7t3h6OFTm6H
         UbIRCOYTvnEMEbGYVYUOWIp/dZ8ibquKY3J1TjvI8R/IAZADRRiJzcgiIXT9cnl9URQl
         rGwmdlTajco7DRq4gBBy2IouqswKA+mmoShqDPoHkh/0qSz64RlI6LnCEuEOpHDlVFIf
         Lao5eyhE7SWt6mBQQOL2zQ1zu7nzXLIQaE4aP81/JavvvfJs3ALtn28oHs+rqCTOlI62
         RZ0qcqZ1a+sU00h5s7OieQAB1qqPQn7R8UxCZRuM/pyYnjyI0PMZSM0960CGT3/RdgiY
         UiPg==
X-Gm-Message-State: AOAM5325OUAFctdO+GhdNBcxMYHYB0OUIh8Lgt2DhGeidIpvPCbUB/CU
        PA8/3JduQfqGkbIsdEFpOrhTDg==
X-Google-Smtp-Source: ABdhPJzmmvfKI2YfOUivLyOnWiZjRtTLUl2bwNA2jEpnIexvx0J2q22TJFGNE9C5La9Y2VyugC5e3Q==
X-Received: by 2002:a17:90a:1d0c:: with SMTP id c12mr4276342pjd.122.1622205517352;
        Fri, 28 May 2021 05:38:37 -0700 (PDT)
Received: from localhost.localdomain (122-117-179-2.HINET-IP.hinet.net. [122.117.179.2])
        by smtp.gmail.com with ESMTPSA id v11sm1563523pju.27.2021.05.28.05.38.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 05:38:36 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Manivannan Sadhasivam <mani@kernel.org>,
        Cristian Ciocaltea <cristian.ciocaltea@gmail.com>,
        linux-actions@lists.infradead.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH RFT] regulator: atc260x: Fix n_voltages and min_sel for pickable linear ranges
Date:   Fri, 28 May 2021 20:38:26 +0800
Message-Id: <20210528123826.350771-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The .n_voltages was missed for pickable linear ranges, fix it.
The min_sel for each pickable range should be starting from 0.

Fixes: 3b15ccac161a ("regulator: Add regulator driver for ATC260x PMICs")
Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
Hi Cristian,
I don't have this h/w to test, please review and test this patch.
Thanks,
Axel
 drivers/regulator/atc260x-regulator.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/regulator/atc260x-regulator.c b/drivers/regulator/atc260x-regulator.c
index d8b429955d33..5dee02394cd9 100644
--- a/drivers/regulator/atc260x-regulator.c
+++ b/drivers/regulator/atc260x-regulator.c
@@ -28,12 +28,12 @@ static const struct linear_range atc2609a_dcdc_voltage_ranges[] = {
 
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

