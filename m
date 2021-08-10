Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A4AA3E7C7F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 17:40:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243528AbhHJPkJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 11:40:09 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:21688 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S243417AbhHJPin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 11:38:43 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 17AAlVvB027584;
        Tue, 10 Aug 2021 10:38:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=gP0i53yT3qfs0wrMdXQHVjqCcdpnkbwnhZgmeA0RguM=;
 b=XlpFHYB46f3HyZrHrQBNYqKWz7K/jMTb8zJ9Fy8JZ3Q+YmViRWSb/I6lslNXli5ztgdR
 MkZbjpACvNCk60A+YE10NfLTtgRRLI6i4ap7lIyGrA+VcSb1yjqoM8/Rd0emBZzHkceL
 P7agWx8OmGb+q/sV+VAza3GJPjRsjA0/Vrrk9SAiv03xlfLYTaj/qE/tlXAaPiC2JARR
 YKbA82jAFH/pEdRA1srWpaEmTGWJ8MAArrFsrHKWoQIRdMfhQgnKFgb5gB9uoFlNS2x7
 pGVM7pkywGWg5rIMNAzEQNoLSPAP7GlOnG0eVp6YFUhzfD1vCH7wLg0nWcKMdnJOkVlo EA== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 3abr0u0e2c-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 10 Aug 2021 10:38:07 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Tue, 10 Aug
 2021 16:38:05 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.12 via Frontend
 Transport; Tue, 10 Aug 2021 16:38:05 +0100
Received: from AUSNPC0LSNW1-debian.cirrus.com (AUSNPC0LSNW1.ad.cirrus.com [198.61.64.221])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id E569D46E;
        Tue, 10 Aug 2021 15:38:04 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 09/12] ASoC: cs42l42: Remove runtime_suspend/runtime_resume callbacks
Date:   Tue, 10 Aug 2021 16:37:56 +0100
Message-ID: <20210810153759.24333-10-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210810153759.24333-1-rf@opensource.cirrus.com>
References: <20210810153759.24333-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: EnMbIdztKnvCslrgyjGYjbOurnm-2pub
X-Proofpoint-GUID: EnMbIdztKnvCslrgyjGYjbOurnm-2pub
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 clxscore=1015 priorityscore=1501 adultscore=0 mlxlogscore=866 mlxscore=0
 spamscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108100099
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver has runtime_suspend and runtime_resume callbacks, but
pm_runtime is never enabled so these functions won't be called, and
the runtime_suspend would cause jack detect to stop working.

These functions are unused - delete them.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/soc/codecs/cs42l42.c | 44 --------------------------------------------
 1 file changed, 44 deletions(-)

diff --git a/sound/soc/codecs/cs42l42.c b/sound/soc/codecs/cs42l42.c
index b7a1231add2d..93a8fa290cb6 100644
--- a/sound/soc/codecs/cs42l42.c
+++ b/sound/soc/codecs/cs42l42.c
@@ -25,7 +25,6 @@
 #include <linux/regulator/consumer.h>
 #include <linux/gpio/consumer.h>
 #include <linux/of_device.h>
-#include <linux/pm_runtime.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
@@ -2067,19 +2066,6 @@ static int cs42l42_i2c_remove(struct i2c_client *i2c_client)
 	struct cs42l42_private *cs42l42 = i2c_get_clientdata(i2c_client);
 
 	devm_free_irq(&i2c_client->dev, i2c_client->irq, cs42l42);
-	pm_runtime_suspend(&i2c_client->dev);
-	pm_runtime_disable(&i2c_client->dev);
-
-	return 0;
-}
-
-#ifdef CONFIG_PM
-static int cs42l42_runtime_suspend(struct device *dev)
-{
-	struct cs42l42_private *cs42l42 = dev_get_drvdata(dev);
-
-	regcache_cache_only(cs42l42->regmap, true);
-	regcache_mark_dirty(cs42l42->regmap);
 
 	/* Hold down reset */
 	gpiod_set_value_cansleep(cs42l42->reset_gpio, 0);
@@ -2091,35 +2077,6 @@ static int cs42l42_runtime_suspend(struct device *dev)
 	return 0;
 }
 
-static int cs42l42_runtime_resume(struct device *dev)
-{
-	struct cs42l42_private *cs42l42 = dev_get_drvdata(dev);
-	int ret;
-
-	/* Enable power */
-	ret = regulator_bulk_enable(ARRAY_SIZE(cs42l42->supplies),
-					cs42l42->supplies);
-	if (ret != 0) {
-		dev_err(dev, "Failed to enable supplies: %d\n",
-			ret);
-		return ret;
-	}
-
-	gpiod_set_value_cansleep(cs42l42->reset_gpio, 1);
-	usleep_range(CS42L42_BOOT_TIME_US, CS42L42_BOOT_TIME_US * 2);
-
-	regcache_cache_only(cs42l42->regmap, false);
-	regcache_sync(cs42l42->regmap);
-
-	return 0;
-}
-#endif
-
-static const struct dev_pm_ops cs42l42_runtime_pm = {
-	SET_RUNTIME_PM_OPS(cs42l42_runtime_suspend, cs42l42_runtime_resume,
-			   NULL)
-};
-
 #ifdef CONFIG_OF
 static const struct of_device_id cs42l42_of_match[] = {
 	{ .compatible = "cirrus,cs42l42", },
@@ -2146,7 +2103,6 @@ MODULE_DEVICE_TABLE(i2c, cs42l42_id);
 static struct i2c_driver cs42l42_i2c_driver = {
 	.driver = {
 		.name = "cs42l42",
-		.pm = &cs42l42_runtime_pm,
 		.of_match_table = of_match_ptr(cs42l42_of_match),
 		.acpi_match_table = ACPI_PTR(cs42l42_acpi_match),
 		},
-- 
2.11.0

