Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 707AF40C41C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 13:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237421AbhIOLIV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 07:08:21 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:16894 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232540AbhIOLIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 07:08:20 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18F730fG016630;
        Wed, 15 Sep 2021 07:07:00 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 3b301k39c1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Sep 2021 07:07:00 -0400
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 18FB6wrq056138
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 15 Sep 2021 07:06:58 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.858.5; Wed, 15 Sep 2021
 07:06:57 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.858.5 via Frontend Transport;
 Wed, 15 Sep 2021 07:06:57 -0400
Received: from ramonaalexandra-Precision-5520.ad.analog.com ([10.48.65.154])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 18FB6u90006343;
        Wed, 15 Sep 2021 07:06:56 -0400
From:   Ramona Alexandra Nechita <ramona.nechita@analog.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <broonie@kernel.org>, <lgirdwood@gmail.com>,
        Ramona Alexandra Nechita <ramona.nechita@analog.com>
Subject: [PATCH] regulators: fix typo in Kconfig and max8973-regulator
Date:   Wed, 15 Sep 2021 14:06:27 +0300
Message-ID: <20210915110627.17525-1-ramona.nechita@analog.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: RggkgGseWZnGRFaB5giVM3ykvz_j05Es
X-Proofpoint-GUID: RggkgGseWZnGRFaB5giVM3ykvz_j05Es
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-15_02,2021-09-15_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=944 mlxscore=0 phishscore=0 clxscore=1011 suspectscore=0
 bulkscore=0 adultscore=0 spamscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109150072
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MAX8973 is supposed to be MAX8973A. Kconfig and the
initial comment of max8973-regulator.c were modified
accordingly.

Signed-off-by: Ramona Alexandra Nechita <ramona.nechita@analog.com>
---
 drivers/regulator/Kconfig             | 4 ++--
 drivers/regulator/max8973-regulator.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 3ee63531f6d5..4df0a8ee2a99 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -518,12 +518,12 @@ config REGULATOR_MAX8952
 	  modes ranging from 0.77V to 1.40V by 0.01V steps.
 
 config REGULATOR_MAX8973
-	tristate "Maxim MAX8973 voltage regulator "
+	tristate "Maxim MAX8973A voltage regulator "
 	depends on I2C
 	depends on THERMAL && THERMAL_OF
 	select REGMAP_I2C
 	help
-	  The MAXIM MAX8973 high-efficiency. three phase, DC-DC step-down
+	  The MAXIM MAX8973A high-efficiency. three phase, DC-DC step-down
 	  switching regulator delivers up to 9A of output current. Each
 	  phase operates at a 2MHz fixed frequency with a 120 deg shift
 	  from the adjacent phase, allowing the use of small magnetic component.
diff --git a/drivers/regulator/max8973-regulator.c b/drivers/regulator/max8973-regulator.c
index 9aee1444181d..76f8fe630cf8 100644
--- a/drivers/regulator/max8973-regulator.c
+++ b/drivers/regulator/max8973-regulator.c
@@ -1,7 +1,7 @@
 /*
  * max8973-regulator.c -- Maxim max8973
  *
- * Regulator driver for MAXIM 8973 DC-DC step-down switching regulator.
+ * Regulator driver for MAXIM 8973A DC-DC step-down switching regulator.
  *
  * Copyright (c) 2012, NVIDIA Corporation.
  *
-- 
2.25.1

