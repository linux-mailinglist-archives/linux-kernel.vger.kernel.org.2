Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39382410F71
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 08:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233195AbhITGNQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 02:13:16 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:21630 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230269AbhITGNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 02:13:13 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18JMXS8H007602;
        Mon, 20 Sep 2021 02:11:45 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 3b6ccp1k9y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Sep 2021 02:11:45 -0400
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 18K6BiDH045014
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 20 Sep 2021 02:11:44 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.858.5; Mon, 20 Sep 2021
 02:11:43 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.858.5 via Frontend
 Transport; Mon, 20 Sep 2021 02:11:43 -0400
Received: from ramonaalexandra-Precision-5520.ad.analog.com ([10.48.65.154])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 18K6BfpF009620;
        Mon, 20 Sep 2021 02:11:41 -0400
From:   Ramona Alexandra Nechita <ramona.nechita@analog.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <lgirdwood@gmail.com>, <broonie@kernel.org>,
        Ramona Alexandra Nechita <ramona.nechita@analog.com>
Subject: [PATCH v2] regulators: fix typo in Kconfig and max8973-regulator
Date:   Mon, 20 Sep 2021 09:11:37 +0300
Message-ID: <20210920061137.10884-1-ramona.nechita@analog.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: j0DxxjgHOiaKZwXSFTXE8FuRs1fzjLqx
X-Proofpoint-ORIG-GUID: j0DxxjgHOiaKZwXSFTXE8FuRs1fzjLqx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-20_03,2021-09-17_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 phishscore=0 mlxlogscore=936 clxscore=1015 adultscore=0
 bulkscore=0 malwarescore=0 mlxscore=0 spamscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109200037
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MAX8973 is supposed to be MAX8973A. Kconfig and the
initial comment of max8973-regulator.c were modified
accordingly.

Signed-off-by: Ramona Alexandra Nechita <ramona.nechita@analog.com>
---
 drivers/regulator/Kconfig             | 4 ++--
 drivers/regulator/max8973-regulator.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 3ee63531f6d5..7daacb8c63ed 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -518,12 +518,12 @@ config REGULATOR_MAX8952
 	  modes ranging from 0.77V to 1.40V by 0.01V steps.
 
 config REGULATOR_MAX8973
-	tristate "Maxim MAX8973 voltage regulator "
+	tristate "Maxim MAX8973A voltage regulator"
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
index 9aee1444181d..f25514f714a9 100644
--- a/drivers/regulator/max8973-regulator.c
+++ b/drivers/regulator/max8973-regulator.c
@@ -1,7 +1,7 @@
 /*
- * max8973-regulator.c -- Maxim max8973
+ * max8973-regulator.c -- Maxim max8973A
  *
- * Regulator driver for MAXIM 8973 DC-DC step-down switching regulator.
+ * Regulator driver for MAXIM 8973A DC-DC step-down switching regulator.
  *
  * Copyright (c) 2012, NVIDIA Corporation.
  *
-- 
2.25.1

