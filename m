Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFB4532FC9C
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 20:14:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231455AbhCFTOC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Mar 2021 14:14:02 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:35738 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231377AbhCFTNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Mar 2021 14:13:48 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 126JCNcc017698;
        Sat, 6 Mar 2021 13:13:32 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=CiEKSTjYLcSgfPsH1Wdc4wThi9n7EU2ewT3omwX+a3A=;
 b=XZz3Wsg12l/BdxwD+TiTxtPSlk0ihUGZuVVvCq4YwL9213sosLzxEEHLelAGyK9MhNsn
 JWfdbWs2QtGWIkdS8auxCchXQOLCGPY7xl2iGgY8BgnJv3+VGGGNmgI0UvZDcWN+vyZC
 1H8azKy7s5jCNCRCqY7Dtv/nzzbI6jrLbdOQojjKbz0HdDPIJxFBFD+jWSZVjOly+u1m
 5HNc9KEOuNMrFUHiP5IA/HLPfwc9TxfcD1EOttDNy2wCvof+aGGkEP+cPAPFVv08jx0M
 vElafsA8tYQIHmSp3jJSmKM1fdiAobhPD4ZgXDNPNe4/JpQ0IjMkiMWpo8Z32p1M6zj9 ZQ== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 3748198d08-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sat, 06 Mar 2021 13:13:32 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Sat, 6 Mar 2021
 18:56:27 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2176.2 via Frontend
 Transport; Sat, 6 Mar 2021 18:56:27 +0000
Received: from mail1.cirrus.com (unknown [198.61.64.35])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 94D2111CB;
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
Subject: [PATCH v3 07/15] ASoC: cs42l42: Disable regulators if probe fails
Date:   Sat, 6 Mar 2021 18:55:45 +0000
Message-ID: <20210306185553.62053-8-tanureal@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210306185553.62053-1-tanureal@opensource.cirrus.com>
References: <20210306185553.62053-1-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 suspectscore=0
 phishscore=0 malwarescore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 mlxscore=0 adultscore=0 spamscore=0 mlxlogscore=999 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103060119
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case of cs42l42_i2c_probe() fail, the regulators were left enabled.

Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
---
Changes in v3:
- No changes

Changes in v2:
- No changes

 sound/soc/codecs/cs42l42.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/cs42l42.c b/sound/soc/codecs/cs42l42.c
index f61404de139b0..81cdd09d80bb3 100644
--- a/sound/soc/codecs/cs42l42.c
+++ b/sound/soc/codecs/cs42l42.c
@@ -1750,8 +1750,10 @@ static int cs42l42_i2c_probe(struct i2c_client *i2c_client,
 	/* Reset the Device */
 	cs42l42->reset_gpio = devm_gpiod_get_optional(&i2c_client->dev,
 		"reset", GPIOD_OUT_LOW);
-	if (IS_ERR(cs42l42->reset_gpio))
-		return PTR_ERR(cs42l42->reset_gpio);
+	if (IS_ERR(cs42l42->reset_gpio)) {
+		ret = PTR_ERR(cs42l42->reset_gpio);
+		goto err_disable;
+	}
 
 	if (cs42l42->reset_gpio) {
 		dev_dbg(&i2c_client->dev, "Found reset GPIO\n");
@@ -1785,13 +1787,13 @@ static int cs42l42_i2c_probe(struct i2c_client *i2c_client,
 		dev_err(&i2c_client->dev,
 			"CS42L42 Device ID (%X). Expected %X\n",
 			devid, CS42L42_CHIP_ID);
-		return ret;
+		goto err_disable;
 	}
 
 	ret = regmap_read(cs42l42->regmap, CS42L42_REVID, &reg);
 	if (ret < 0) {
 		dev_err(&i2c_client->dev, "Get Revision ID failed\n");
-		return ret;
+		goto err_disable;
 	}
 
 	dev_info(&i2c_client->dev,
@@ -1817,7 +1819,7 @@ static int cs42l42_i2c_probe(struct i2c_client *i2c_client,
 	if (i2c_client->dev.of_node) {
 		ret = cs42l42_handle_device_data(i2c_client, cs42l42);
 		if (ret != 0)
-			return ret;
+			goto err_disable;
 	}
 
 	/* Setup headset detection */
-- 
2.30.1

