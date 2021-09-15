Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0467F40C3B8
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 12:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232970AbhIOKmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 06:42:06 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:44108 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232454AbhIOKmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 06:42:04 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18FADI8O026708;
        Wed, 15 Sep 2021 06:40:44 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 3b2v0sc797-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Sep 2021 06:40:44 -0400
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 18FAehnv055463
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 15 Sep 2021 06:40:43 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.858.5;
 Wed, 15 Sep 2021 06:40:42 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.858.5;
 Wed, 15 Sep 2021 06:40:42 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.858.5 via Frontend Transport;
 Wed, 15 Sep 2021 06:40:42 -0400
Received: from ramonaalexandra-Precision-5520.ad.analog.com ([10.48.65.154])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 18FAeeUx004353;
        Wed, 15 Sep 2021 06:40:40 -0400
From:   Ramona Alexandra Nechita <ramona.nechita@analog.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <lee.jones@linaro.org>,
        Ramona Alexandra Nechita <ramona.nechita@analog.com>
Subject: [PATCH] mfd: fixed typo in Kconfig from AD5520 to ADP5520
Date:   Wed, 15 Sep 2021 13:40:16 +0300
Message-ID: <20210915104016.16947-1-ramona.nechita@analog.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: sdOi8cMVVViRSekjs81Vt5RbakIViebg
X-Proofpoint-GUID: sdOi8cMVVViRSekjs81Vt5RbakIViebg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-15_02,2021-09-15_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 clxscore=1011 adultscore=0 mlxlogscore=999
 impostorscore=0 spamscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0
 phishscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109150068
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The description mentioned AD5520, which is a different device.
Fixed the typo.

Signed-off-by: Ramona Alexandra Nechita <ramona.nechita@analog.com>
---
 drivers/mfd/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index ae24d3ea68ea..54cd9f2c857f 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -93,7 +93,7 @@ config PMIC_ADP5520
 	bool "Analog Devices ADP5520/01 MFD PMIC Core Support"
 	depends on I2C=y
 	help
-	  Say yes here to add support for Analog Devices AD5520 and ADP5501,
+	  Say yes here to add support for Analog Devices ADP5520 and ADP5501,
 	  Multifunction Power Management IC. This includes
 	  the I2C driver and the core APIs _only_, you have to select
 	  individual components like LCD backlight, LEDs, GPIOs and Kepad
-- 
2.25.1

