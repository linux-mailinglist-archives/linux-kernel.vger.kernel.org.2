Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0863132F157
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 18:36:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbhCERfx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 12:35:53 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:14772 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229854AbhCERff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 12:35:35 -0500
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 125HUg0k001824;
        Fri, 5 Mar 2021 11:34:48 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=d/rdx5IyQDbqeis2vUZ+ex3yXt5Jft5sLBdaoiwDShg=;
 b=iKS+dRiAaNC/zXY7FgN+Ko3w7PPaVWPQbid1GZhuFEcxRsV7mHvwXuDQjSgDHvWFrOO4
 LDGLk9rwsLXM9i2UfjT2/dACINTx4B/DBOMtmGSqDgNYXiB/A2AJExdOZD9hdJYqOKOh
 ozg+VTkmTqWWVP6hwtw/qeYdzGQRPinxUJe70TUSUauiylOhvBWGNwJFM77GSaCzN9UK
 dsoSPgPnqSpPuzjdPc6x8QWQUXivmxW10vIC4p3j5jp9Vq4pTza5czuNioolXsH6d2ls
 m4n4mF9Mg3iS/T1x5rY4NNuuNr/xI5sJkg93+M6I+XdIcNv4F8mXVcGVwP9ELVYpgboK kA== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 36ykctraxk-5
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
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 2F1BF11CB;
        Fri,  5 Mar 2021 17:34:47 +0000 (UTC)
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
Subject: [PATCH v2 07/15] ASoC: cs42l42: Disable regulators if probe fails
Date:   Fri, 5 Mar 2021 17:34:34 +0000
Message-ID: <20210305173442.195740-8-tanureal@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210305173442.195740-1-tanureal@opensource.cirrus.com>
References: <20210305173442.195740-1-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 clxscore=1015
 malwarescore=0 priorityscore=1501 suspectscore=0 spamscore=0 phishscore=0
 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103050090
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case of cs42l42_i2c_probe() fail, the regulators were left enabled.

Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
---
Changes in v2:
- No changes

 sound/soc/codecs/cs42l42.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/cs42l42.c b/sound/soc/codecs/cs42l42.c
index 78274537a22af..33c072f71867b 100644
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

