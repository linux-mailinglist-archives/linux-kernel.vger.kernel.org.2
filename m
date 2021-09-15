Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4742C40C431
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 13:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237236AbhIOLNx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 07:13:53 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:39052 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232516AbhIOLNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 07:13:52 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18FACkUK027517;
        Wed, 15 Sep 2021 07:12:30 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 3b2v0scayh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Sep 2021 07:12:30 -0400
Received: from SCSQMBX11.ad.analog.com (SCSQMBX11.ad.analog.com [10.77.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 18FBCSEB056258
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 15 Sep 2021 07:12:28 -0400
Received: from SCSQMBX10.ad.analog.com (10.77.17.5) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.858.5; Wed, 15 Sep 2021
 04:12:27 -0700
Received: from zeus.spd.analog.com (10.66.68.11) by scsqmbx10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server id 15.2.858.5 via Frontend Transport;
 Wed, 15 Sep 2021 04:12:27 -0700
Received: from ramonaalexandra-Precision-5520.ad.analog.com ([10.48.65.154])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 18FBCOfu006464;
        Wed, 15 Sep 2021 07:12:24 -0400
From:   Ramona Alexandra Nechita <ramona.nechita@analog.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <zbr@ioremap.net>,
        Ramona Alexandra Nechita <ramona.nechita@analog.com>
Subject: [PATCH] w1: masters: Specified DS2482 variations in Kconfig
Date:   Wed, 15 Sep 2021 14:12:11 +0300
Message-ID: <20210915111211.17741-1-ramona.nechita@analog.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: LjrwU_HDffT0e6dpgeW1Wq-8SWHBujjZ
X-Proofpoint-GUID: LjrwU_HDffT0e6dpgeW1Wq-8SWHBujjZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-15_02,2021-09-15_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 clxscore=1011 adultscore=0 mlxlogscore=802
 impostorscore=0 spamscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0
 phishscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109150072
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DS2482 is available as DS2482-100 and DS2482-800.
THis specification was added to the Kconfig.

Signed-off-by: Ramona Alexandra Nechita <ramona.nechita@analog.com>
---
 drivers/w1/masters/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/w1/masters/Kconfig b/drivers/w1/masters/Kconfig
index 24b9a8e05f64..fe28975a50b2 100644
--- a/drivers/w1/masters/Kconfig
+++ b/drivers/w1/masters/Kconfig
@@ -26,10 +26,10 @@ config W1_MASTER_DS2490
 	  will be called ds2490.
 
 config W1_MASTER_DS2482
-	tristate "Maxim DS2482 I2C to 1-Wire bridge"
+	tristate "Maxim DS2482-100 and DS2482-800 I2C to 1-Wire bridge"
 	depends on I2C
 	help
-	  If you say yes here you get support for the Maxim DS2482
+	  If you say yes here you get support for the Maxim DS2482-100 and DS2482-800
 	  I2C to 1-Wire bridge.
 
 	  This driver can also be built as a module.  If so, the module
-- 
2.25.1

