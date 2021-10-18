Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0881943240F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 18:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233735AbhJRQq5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 12:46:57 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:53834 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232858AbhJRQq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 12:46:56 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19IDIugK002086;
        Mon, 18 Oct 2021 11:44:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=g2keZwZ3YbmiZsBBYq3iwJPeFMf1WnyhEQ2eg27YkXk=;
 b=ZwIqPcj/8kupRSNZTybT0jB+tGOc29pZ6PeaJ0lY4QH4hV+0EA/W5Gqk9Y4zUSql14kS
 YEfdZSfNN9pqX2RFI0GC3SyxSDxYa76OYXK0tfN2/e1tKpAHY2bqLN/2yulftl2WsHID
 5J5z+eCKYJaGXiTUMpcURojMa5pPehf5Vhoj1wnLRTXBSbs98AP9rG5d6XR6EL2xOh3e
 C2UmFxghfgJ+Eew1SQV6G82OjBkajCbtuaWp7RmV7gUM1CqXxWc+E2HftcMA8zbHcK79
 ySDslfUOnw10Es3WxDPamMd56izb/76Nt3i7tMNP0aPAzj7+5aRVEJKv5PtUXf5IxcNv Iw== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 3bs5p88g66-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 18 Oct 2021 11:44:37 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Mon, 18 Oct
 2021 17:44:35 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.7 via Frontend
 Transport; Mon, 18 Oct 2021 17:44:35 +0100
Received: from AUSNPC0LSNW1-debian.cirrus.com (AUSNPC0LSNW1.ad.cirrus.com [198.61.64.121])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id BA217B15;
        Mon, 18 Oct 2021 16:44:34 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH] ASoC: cs42l42: Remove unused runtime_suspend/runtime_resume callbacks
Date:   Mon, 18 Oct 2021 17:44:31 +0100
Message-ID: <20211018164431.5871-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: m53f-sWNMRlKcbnHRmnRMgmsYFp6O6PB
X-Proofpoint-ORIG-GUID: m53f-sWNMRlKcbnHRmnRMgmsYFp6O6PB
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver has runtime_suspend and runtime_resume callbacks, but
pm_runtime is never enabled so these functions won't be called. They
could not be used anyway because the runtime_suspend would cause jack
detect to stop working.

These functions are unused - delete them.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/soc/codecs/cs42l42.c | 51 +---------------------------------------------
 1 file changed, 1 insertion(+), 50 deletions(-)

diff --git a/sound/soc/codecs/cs42l42.c b/sound/soc/codecs/cs42l42.c
index 5e4d6791756b..0dbe4e23194b 100644
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
@@ -2175,59 +2174,12 @@ static int cs42l42_i2c_remove(struct i2c_client *i2c_client)
 	if (i2c_client->irq)
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
-
-	/* Hold down reset */
 	gpiod_set_value_cansleep(cs42l42->reset_gpio, 0);
-
-	/* remove power */
-	regulator_bulk_disable(ARRAY_SIZE(cs42l42->supplies),
-				cs42l42->supplies);
+	regulator_bulk_disable(ARRAY_SIZE(cs42l42->supplies), cs42l42->supplies);
 
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
@@ -2254,7 +2206,6 @@ MODULE_DEVICE_TABLE(i2c, cs42l42_id);
 static struct i2c_driver cs42l42_i2c_driver = {
 	.driver = {
 		.name = "cs42l42",
-		.pm = &cs42l42_runtime_pm,
 		.of_match_table = of_match_ptr(cs42l42_of_match),
 		.acpi_match_table = ACPI_PTR(cs42l42_acpi_match),
 		},
-- 
2.11.0

