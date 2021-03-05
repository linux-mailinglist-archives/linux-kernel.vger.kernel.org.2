Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF55132F149
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 18:35:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbhCERfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 12:35:18 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:31392 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229792AbhCERfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 12:35:05 -0500
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 125HUg0j001824;
        Fri, 5 Mar 2021 11:34:48 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=11rGUtyJmP7HKLy3D23ZZDv+qF7JzV2QzjUhD9/jmAM=;
 b=lXCUJmoBcjWM0s+Q8Zc9QPXRs8K35BAoqPefGpHbuu5vNgALFRZlD8/4YjRMX1gOUHcT
 Ew0Urp/R7riigbQ4NsDcwyFayg6MGVzpvDFp6JVZQ3xtVuDilsze81GzdQ9fgA4dV/BK
 YJTncXxMHogVGtaKZ0z9THrLgR08omyn10OyT5xfkXo+VAipJ0LItQ3hXWz+YbVSrBL6
 kYsU4HvkluEeeVsklFSTies7WjwMYhfRbGYePpa1HsPoEbpBol2v2VuKzn6cURXlwDqx
 O5FVm3uL1NASG4KafPsWnnCsZh+soCxKy5vVtgB3X01cQbeQKBUkK2DIv0pyXk3l38s9 yQ== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 36ykctraxk-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 05 Mar 2021 11:34:48 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Fri, 5 Mar 2021
 17:34:47 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2176.2 via Frontend
 Transport; Fri, 5 Mar 2021 17:34:47 +0000
Received: from mail1.cirrus.com (unknown [198.61.64.35])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id CB87011D7;
        Fri,  5 Mar 2021 17:34:46 +0000 (UTC)
From:   Lucas Tanure <tanureal@opensource.cirrus.com>
To:     James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     Richard Fitzgerald <rf@opensource.cirrus.com>,
        <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>,
        Lucas Tanure <tanureal@opensource.cirrus.com>
Subject: [PATCH v2 06/15] ASoC: cs42l42: Remove power if the driver is being removed
Date:   Fri, 5 Mar 2021 17:34:33 +0000
Message-ID: <20210305173442.195740-7-tanureal@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210305173442.195740-1-tanureal@opensource.cirrus.com>
References: <20210305173442.195740-1-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 clxscore=1015
 malwarescore=0 priorityscore=1501 suspectscore=0 spamscore=0 phishscore=0
 mlxscore=0 impostorscore=0 mlxlogscore=842 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103050090
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ensure the power supplies are turned off when removing the driver

Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
---
Changes in v2:
- Use PM functions to shutdown the codec
- Disable IRQ before pm_suspend

 sound/soc/codecs/cs42l42.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/cs42l42.c b/sound/soc/codecs/cs42l42.c
index 811b7b1c9732e..78274537a22af 100644
--- a/sound/soc/codecs/cs42l42.c
+++ b/sound/soc/codecs/cs42l42.c
@@ -25,6 +25,7 @@
 #include <linux/of.h>
 #include <linux/of_gpio.h>
 #include <linux/of_device.h>
+#include <linux/pm_runtime.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
@@ -1840,10 +1841,9 @@ static int cs42l42_i2c_probe(struct i2c_client *i2c_client,

 static int cs42l42_i2c_remove(struct i2c_client *i2c_client)
 {
-	struct cs42l42_private *cs42l42 = i2c_get_clientdata(i2c_client);
-
-	/* Hold down reset */
-	gpiod_set_value_cansleep(cs42l42->reset_gpio, 0);
+	disable_irq(i2c_client->irq);
+	pm_runtime_suspend(&i2c_client->dev);
+	pm_runtime_disable(&i2c_client->dev);

 	return 0;
 }
--
2.30.1

