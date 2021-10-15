Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAAD242F3A9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 15:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239810AbhJONjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 09:39:20 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:49886 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S239956AbhJONih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 09:38:37 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19F4c2t1023483;
        Fri, 15 Oct 2021 08:36:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=l/+RJ9FDEJzZTolUJu3mZT8zz3TFCqtHXqHMWM5hWn4=;
 b=k0obp/Tq/+Ax4lMJ6ChTaEwYAw08PyWK6aiUo0FcP7QZ2ZHsGlZ65xUtGUqn1799xr88
 ve/qaSUw4kR9Y0E0/TSjzdrOvUJUmiP3dM5McCsNAbHDmswsYsZDR0P3lyFWUSBdjr7x
 Qgoi+eE3H8AnMHM8KN7SZlALvblYSYItt4P5OP++dXJVqzwPQ1wUNvthGPI6rbb8WSbQ
 EixXuzlfdP+1wM791lDwY3p1zwIpfz+H3LWgQXfoy4gsTKWtq3r8AiJpl94M60N7Uq5G
 KGSLxk+9t4pKIT6ZtwB51s6d+U5OgZMues73W+BC1EDkzL/6A565XBRoW8kXtzoDaFC0 tQ== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 3bq1gagp5v-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 15 Oct 2021 08:36:26 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 15 Oct
 2021 14:36:23 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.7 via Frontend
 Transport; Fri, 15 Oct 2021 14:36:23 +0100
Received: from AUSNPC0LSNW1-debian.cirrus.com (AUSNPC0LSNW1.ad.cirrus.com [198.61.65.254])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id AE71746D;
        Fri, 15 Oct 2021 13:36:23 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 07/16] ASoC: cs42l42: Correct power-up sequence to match datasheet
Date:   Fri, 15 Oct 2021 14:36:10 +0100
Message-ID: <20211015133619.4698-8-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211015133619.4698-1-rf@opensource.cirrus.com>
References: <20211015133619.4698-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 66iAUKjlTzJqnu9hdaA-sH5t7G3c3Eak
X-Proofpoint-GUID: 66iAUKjlTzJqnu9hdaA-sH5t7G3c3Eak
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The power-up sequence mandated in the datasheet is:

- VP must turn on first
- VA, VCP, VL, in any order
- VD_FILT after VL
- RESET must be asserted while VP turns on

- VD_FILT must turn off before VL
- VP must turn off last

This patch fixes the order the regulators are enabled and holds RESET
asserted around the power-up. The datasheet power-down order is the reverse
of the power-up order so this is automatically covered by listing the bulk
regulators in power-up order.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/soc/codecs/cs42l42.c | 22 ++++++++++++----------
 sound/soc/codecs/cs42l42.h |  4 ++--
 2 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/sound/soc/codecs/cs42l42.c b/sound/soc/codecs/cs42l42.c
index 629a0783e693..420e16563c45 100644
--- a/sound/soc/codecs/cs42l42.c
+++ b/sound/soc/codecs/cs42l42.c
@@ -2025,22 +2025,23 @@ static int cs42l42_i2c_probe(struct i2c_client *i2c_client,
 		return ret;
 	}
 
-	ret = regulator_bulk_enable(ARRAY_SIZE(cs42l42->supplies),
-				    cs42l42->supplies);
-	if (ret != 0) {
-		dev_err(&i2c_client->dev,
-			"Failed to enable supplies: %d\n", ret);
-		return ret;
-	}
-
-	/* Reset the Device */
+	/* Hold device in reset while it powers up */
 	cs42l42->reset_gpio = devm_gpiod_get(&i2c_client->dev, "reset", GPIOD_OUT_LOW);
 	if (IS_ERR(cs42l42->reset_gpio)) {
 		ret = PTR_ERR(cs42l42->reset_gpio);
 		dev_err(&i2c_client->dev, "Failed to request reset gpio: %d\n", ret);
-		goto err_disable;
+		return ret;
 	}
 
+	ret = regulator_bulk_enable(ARRAY_SIZE(cs42l42->supplies),
+				    cs42l42->supplies);
+	if (ret != 0) {
+		dev_err(&i2c_client->dev,
+			"Failed to enable supplies: %d\n", ret);
+		return ret;
+	}
+
+	/* Release reset and wait for boot */
 	gpiod_set_value_cansleep(cs42l42->reset_gpio, 1);
 	usleep_range(CS42L42_BOOT_TIME_US, CS42L42_BOOT_TIME_US * 2);
 
@@ -2116,6 +2117,7 @@ static int cs42l42_i2c_probe(struct i2c_client *i2c_client,
 	return 0;
 
 err_disable:
+	gpiod_set_value_cansleep(cs42l42->reset_gpio, 0);
 	regulator_bulk_disable(ARRAY_SIZE(cs42l42->supplies),
 				cs42l42->supplies);
 	return ret;
diff --git a/sound/soc/codecs/cs42l42.h b/sound/soc/codecs/cs42l42.h
index 0704c902475f..2343213d0cdb 100644
--- a/sound/soc/codecs/cs42l42.h
+++ b/sound/soc/codecs/cs42l42.h
@@ -822,11 +822,11 @@
 #define CS42L42_PLL_LOCK_TIMEOUT_US	1250
 
 static const char *const cs42l42_supply_names[CS42L42_NUM_SUPPLIES] = {
-	"VA",
 	"VP",
+	"VA",
 	"VCP",
-	"VD_FILT",
 	"VL",
+	"VD_FILT",
 };
 
 struct  cs42l42_private {
-- 
2.11.0

