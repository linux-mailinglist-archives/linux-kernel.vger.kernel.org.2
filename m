Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02FF531C813
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 10:29:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbhBPJ2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 04:28:53 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:20722 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230011AbhBPJ1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 04:27:36 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11G9QkNe015993;
        Tue, 16 Feb 2021 04:26:46 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 36p9gay1ah-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 Feb 2021 04:26:46 -0500
Received: from SCSQMBX10.ad.analog.com (SCSQMBX10.ad.analog.com [10.77.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 11G9Qi6P044547
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 16 Feb 2021 04:26:45 -0500
Received: from SCSQCASHYB6.ad.analog.com (10.77.17.132) by
 SCSQMBX10.ad.analog.com (10.77.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.721.2;
 Tue, 16 Feb 2021 01:26:43 -0800
Received: from SCSQMBX10.ad.analog.com (10.77.17.5) by
 SCSQCASHYB6.ad.analog.com (10.77.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.721.2;
 Tue, 16 Feb 2021 01:26:43 -0800
Received: from zeus.spd.analog.com (10.66.68.11) by scsqmbx10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server id 15.2.721.2 via Frontend Transport;
 Tue, 16 Feb 2021 01:26:42 -0800
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 11G9Qedj029420;
        Tue, 16 Feb 2021 04:26:40 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>, <mircea.caprioru@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH] iio: dac: ad5686: Add support for AD5673R/AD5677R
Date:   Tue, 16 Feb 2021 11:28:55 +0200
Message-ID: <20210216092855.11619-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-15_16:2021-02-12,2021-02-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 phishscore=0 clxscore=1015
 mlxscore=0 priorityscore=1501 impostorscore=0 adultscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102160088
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mircea Caprioru <mircea.caprioru@analog.com>

The AD5673R/AD5677R are low power, 16-channel, 12-/16-bit buffered voltage
output digital-to-analog converters (DACs). They include a 2.5 V internal
reference (enabled by default).

These devices are very similar to AD5674R/AD5679R, except that they
have an i2c interface.

Signed-off-by: Mircea Caprioru <mircea.caprioru@analog.com>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/dac/Kconfig      |  5 +++--
 drivers/iio/dac/ad5686.c     | 12 ++++++++++++
 drivers/iio/dac/ad5686.h     |  2 ++
 drivers/iio/dac/ad5696-i2c.c |  6 ++++--
 4 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
index cea07b4cced1..75e1f2b48638 100644
--- a/drivers/iio/dac/Kconfig
+++ b/drivers/iio/dac/Kconfig
@@ -142,8 +142,9 @@ config AD5696_I2C
 	select AD5686
 	help
 	  Say yes here to build support for Analog Devices AD5311R, AD5338R,
-	  AD5671R, AD5675R, AD5691R, AD5692R, AD5693, AD5693R, AD5694, AD5694R,
-	  AD5695R, AD5696, and AD5696R Digital to Analog converters.
+	  AD5671R, AD5673R, AD5675R, AD5677R, AD5691R, AD5692R, AD5693, AD5693R,
+	  AD5694, AD5694R, AD5695R, AD5696, and AD5696R Digital to Analog
+	  converters.
 
 	  To compile this driver as a module, choose M here: the module will be
 	  called ad5696.
diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
index 7d6792ac1020..99a95282ac57 100644
--- a/drivers/iio/dac/ad5686.c
+++ b/drivers/iio/dac/ad5686.c
@@ -301,6 +301,12 @@ static const struct ad5686_chip_info ad5686_chip_info_tbl[] = {
 		.num_channels = 8,
 		.regmap_type = AD5686_REGMAP,
 	},
+	[ID_AD5673R] = {
+		.channels = ad5674r_channels,
+		.int_vref_mv = 2500,
+		.num_channels = 16,
+		.regmap_type = AD5686_REGMAP,
+	},
 	[ID_AD5674R] = {
 		.channels = ad5674r_channels,
 		.int_vref_mv = 2500,
@@ -324,6 +330,12 @@ static const struct ad5686_chip_info ad5686_chip_info_tbl[] = {
 		.num_channels = 8,
 		.regmap_type = AD5686_REGMAP,
 	},
+	[ID_AD5677R] = {
+		.channels = ad5679r_channels,
+		.int_vref_mv = 2500,
+		.num_channels = 16,
+		.regmap_type = AD5686_REGMAP,
+	},
 	[ID_AD5679R] = {
 		.channels = ad5679r_channels,
 		.int_vref_mv = 2500,
diff --git a/drivers/iio/dac/ad5686.h b/drivers/iio/dac/ad5686.h
index d9c8ba413fe9..f89a6f92b427 100644
--- a/drivers/iio/dac/ad5686.h
+++ b/drivers/iio/dac/ad5686.h
@@ -55,10 +55,12 @@ enum ad5686_supported_device_ids {
 	ID_AD5338R,
 	ID_AD5671R,
 	ID_AD5672R,
+	ID_AD5673R,
 	ID_AD5674R,
 	ID_AD5675R,
 	ID_AD5676,
 	ID_AD5676R,
+	ID_AD5677R,
 	ID_AD5679R,
 	ID_AD5681R,
 	ID_AD5682R,
diff --git a/drivers/iio/dac/ad5696-i2c.c b/drivers/iio/dac/ad5696-i2c.c
index a39eda7c02d2..24a6a4a5a2e0 100644
--- a/drivers/iio/dac/ad5696-i2c.c
+++ b/drivers/iio/dac/ad5696-i2c.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * AD5671R, AD5675R, AD5691R, AD5692R, AD5693, AD5693R,
- * AD5694, AD5694R, AD5695R, AD5696, AD5696R
+ * AD5338R, AD5671R, AD5673R, AD5675R, AD5677R, AD5691R, AD5692R, AD5693,
+ * AD5693R, AD5694, AD5694R, AD5695R, AD5696, AD5696R
  * Digital to analog converters driver
  *
  * Copyright 2018 Analog Devices Inc.
@@ -74,7 +74,9 @@ static const struct i2c_device_id ad5686_i2c_id[] = {
 	{"ad5311r", ID_AD5311R},
 	{"ad5338r", ID_AD5338R},
 	{"ad5671r", ID_AD5671R},
+	{"ad5673r", ID_AD5673R},
 	{"ad5675r", ID_AD5675R},
+	{"ad5677r", ID_AD5677R},
 	{"ad5691r", ID_AD5691R},
 	{"ad5692r", ID_AD5692R},
 	{"ad5693", ID_AD5693},
-- 
2.17.1

