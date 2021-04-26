Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40A6036B62A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 17:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234077AbhDZPyQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 11:54:16 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:36058 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233829AbhDZPyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 11:54:15 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13QFlh8M019154;
        Mon, 26 Apr 2021 10:53:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=emO8RGoxCntQUzHWVHwlmzoEg3zkJ8bMHe2pwdtqIUI=;
 b=lfLa6fC1i2WrwWn0oH0iAm3A37XumybZgwQxie1bW63N+WYwEwAVawQ6spJAUXFBuwcv
 9bKQmHKKHDlpxwzHtJ7E71EQ8Do6EK1EV1EVLHHr9RFHO+X36RCSJEJo/HNpkcMrxqFK
 dlWlTvg0BOdpbWN0C0TMGG7USM9cDd7GVs6//6yuMze6jhgUAeJLWjP17jto2jK/eqaj
 Vkx9OP5hkyPfeEVtsmX3Qs4O6jRi5d2iIuvmggnBt2uwGXRrGTskBLvqXZU6KYySSyDZ
 K/YwpCRNUhDxqPyjCg90esqy4WAAADhKZQeUkmIhmqpoP6DONJ1s96IQ/FaFo3lHdY56 Yw== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 385wdbr93m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 26 Apr 2021 10:53:12 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 26 Apr
 2021 16:53:11 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Mon, 26 Apr 2021 16:53:11 +0100
Received: from mail1.cirrus.com (unknown [198.61.65.115])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 05DFE11D1;
        Mon, 26 Apr 2021 15:53:11 +0000 (UTC)
From:   Lucas Tanure <tanureal@opensource.cirrus.com>
To:     James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>,
        Vitaly Rodionov <vitalyr@opensource.cirrus.com>,
        Lucas Tanure <tanureal@opensource.cirrus.com>
Subject: [PATCH 3/3] ASoC: cs42l42: Add support for ACPI table match entry
Date:   Mon, 26 Apr 2021 16:53:03 +0100
Message-ID: <20210426155303.853236-3-tanureal@opensource.cirrus.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210426155303.853236-1-tanureal@opensource.cirrus.com>
References: <20210426155303.853236-1-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: aW9obCLWO6rCodYdzKza_C54_RMZxnBn
X-Proofpoint-GUID: aW9obCLWO6rCodYdzKza_C54_RMZxnBn
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 clxscore=1015 mlxscore=0 bulkscore=0 phishscore=0 spamscore=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104260121
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vitaly Rodionov <vitalyr@opensource.cirrus.com>

Adding support for ACPI-based systems.

Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
---
 sound/soc/codecs/cs42l42.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/cs42l42.c b/sound/soc/codecs/cs42l42.c
index bce541735437..d9f8da7a68d0 100644
--- a/sound/soc/codecs/cs42l42.c
+++ b/sound/soc/codecs/cs42l42.c
@@ -19,6 +19,7 @@
 #include <linux/gpio.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
+#include <linux/acpi.h>
 #include <linux/platform_device.h>
 #include <linux/property.h>
 #include <linux/regulator/consumer.h>
@@ -2001,12 +2002,21 @@ static const struct dev_pm_ops cs42l42_runtime_pm = {
 			   NULL)
 };

+#ifdef CONFIG_OF
 static const struct of_device_id cs42l42_of_match[] = {
 	{ .compatible = "cirrus,cs42l42", },
-	{},
+	{}
 };
 MODULE_DEVICE_TABLE(of, cs42l42_of_match);
+#endif

+#ifdef CONFIG_ACPI
+static const struct acpi_device_id cs42l42_acpi_match[] = {
+	{"10134242", 0,},
+	{}
+};
+MODULE_DEVICE_TABLE(acpi, cs42l42_acpi_match);
+#endif

 static const struct i2c_device_id cs42l42_id[] = {
 	{"cs42l42", 0},
@@ -2019,7 +2029,8 @@ static struct i2c_driver cs42l42_i2c_driver = {
 	.driver = {
 		.name = "cs42l42",
 		.pm = &cs42l42_runtime_pm,
-		.of_match_table = cs42l42_of_match,
+		.of_match_table = of_match_ptr(cs42l42_of_match),
+		.acpi_match_table = ACPI_PTR(cs42l42_acpi_match),
 		},
 	.id_table = cs42l42_id,
 	.probe = cs42l42_i2c_probe,
--
2.31.1

