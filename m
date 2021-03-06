Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CB4032FC9D
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 20:14:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231472AbhCFTOE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Mar 2021 14:14:04 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:60864 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231375AbhCFTNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Mar 2021 14:13:48 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 126J6uDK011401;
        Sat, 6 Mar 2021 13:13:33 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=kNd2bY0yYzXE4zeUHnZxMKJTNKV9o6qwBbU7E9c3S8c=;
 b=nWZrkfM6tPyb8IjsnxSkabTdLtrIubSyNv2Mjg/8MBTJ/rlQ9P6Hrs5NOIfEkm21r96h
 I8yTP5+6H04xQIC7wuMrQAIRxzF7NElumn5OpCHeTddIFnQ5gP0zMJqA95vU7O+eEiTt
 vnP2aiXrl2Gd5YTiisAAeVNRaoMuxOidAPEgNl75OW921bMlK5ectLkYxHOH94W45cOH
 BjA8qW4v9l0l3e455wINusHkhDY9eor7UxVuuoCO/N+ohYm4+Vi+UTYZbSrfJ1XGCGo5
 IRLG5+XMFoBH2w6GrZjw7a6DHP8kN00XWq78lOek8Nx/ctRcP01NYz7egLnPTSFCNrZx lg== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 3748198d06-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sat, 06 Mar 2021 13:13:33 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Sat, 6 Mar 2021
 18:56:27 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2176.2 via Frontend
 Transport; Sat, 6 Mar 2021 18:56:27 +0000
Received: from mail1.cirrus.com (unknown [198.61.64.35])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 4732B11D7;
        Sat,  6 Mar 2021 18:56:27 +0000 (UTC)
From:   Lucas Tanure <tanureal@opensource.cirrus.com>
To:     James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Lucas Tanure <tanureal@opensource.cirrus.com>
Subject: [PATCH v3 06/15] ASoC: cs42l42: Remove power if the driver is being removed
Date:   Sat, 6 Mar 2021 18:55:44 +0000
Message-ID: <20210306185553.62053-7-tanureal@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210306185553.62053-1-tanureal@opensource.cirrus.com>
References: <20210306185553.62053-1-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 suspectscore=0
 phishscore=0 malwarescore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 mlxscore=0 adultscore=0 spamscore=0 mlxlogscore=793 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103060119
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ensure the power supplies are turned off when removing the driver

Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
---
Changes in v3:
- Free IRQ before pm_suspend

Changes in v2:
- Use PM functions to shutdown the codec
- Disable IRQ before pm_suspend

 sound/soc/codecs/cs42l42.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/cs42l42.c b/sound/soc/codecs/cs42l42.c
index 811b7b1c9732e..f61404de139b0 100644
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
@@ -1842,8 +1843,9 @@ static int cs42l42_i2c_remove(struct i2c_client *i2c_client)
 {
 	struct cs42l42_private *cs42l42 = i2c_get_clientdata(i2c_client);
 
-	/* Hold down reset */
-	gpiod_set_value_cansleep(cs42l42->reset_gpio, 0);
+	devm_free_irq(&i2c_client->dev, i2c_client->irq, cs42l42);
+	pm_runtime_suspend(&i2c_client->dev);
+	pm_runtime_disable(&i2c_client->dev);
 
 	return 0;
 }
-- 
2.30.1

