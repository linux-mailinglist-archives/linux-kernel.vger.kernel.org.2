Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF47E42F39F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 15:36:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239362AbhJONjC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 09:39:02 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:41926 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S239929AbhJONig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 09:38:36 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19FCfErN009690;
        Fri, 15 Oct 2021 08:36:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=NZ1y1vHKxSWxoIA9oRp13eOqEB4AqI7vO8Ocv/KaWwA=;
 b=V26f+WAOa3edVyxI449Ngabv6wnXk0GH81TuXwuXtfwp/qhBPEePgOOyNunYFFNs8djm
 vwUnn/dvTAmQpiu4/3kHdPQs85uaQPEGMHw4NAbOpl+DXh9MS1yK0SCQKJ3wRSdf/ycU
 /PUDQFzRIIdmmngTEG5PZyepELk81XGXZvvLRNgoxCXeJ8K63UTXDgbXKZZ7izawee6e
 HOfRsHx/cyl51/Y5W+++kk9nGjU/9MUef498JH2eINliwEiCS8IxmKGn3TGlK6DgZ8p4
 SqW0UyjCWFt8ijAkiuNhWwlwF4GEpH6kbAZyNMyX4ODyLvbqfgncO8QPZHhibdjRvEj/ mA== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 3bq1gagp5w-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 15 Oct 2021 08:36:26 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 15 Oct
 2021 14:36:23 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.7 via Frontend
 Transport; Fri, 15 Oct 2021 14:36:23 +0100
Received: from AUSNPC0LSNW1-debian.cirrus.com (AUSNPC0LSNW1.ad.cirrus.com [198.61.65.254])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 6B07411DA;
        Fri, 15 Oct 2021 13:36:23 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 06/16] ASoC: cs42l42: Reset GPIO is mandatory
Date:   Fri, 15 Oct 2021 14:36:09 +0100
Message-ID: <20211015133619.4698-7-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211015133619.4698-1-rf@opensource.cirrus.com>
References: <20211015133619.4698-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: S-9aqI3ecKkvULeCgr7cqZhNpKSv2h-3
X-Proofpoint-GUID: S-9aqI3ecKkvULeCgr7cqZhNpKSv2h-3
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hard RESET must be used to correctly power-up the cs42l42, as
described in the datasheet.

The code was getting the GPIO with devm_gpiod_get_optional(). Change
this to devm_gpiod_get().

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/soc/codecs/cs42l42.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/cs42l42.c b/sound/soc/codecs/cs42l42.c
index 0ecf2129ea45..629a0783e693 100644
--- a/sound/soc/codecs/cs42l42.c
+++ b/sound/soc/codecs/cs42l42.c
@@ -2034,17 +2034,14 @@ static int cs42l42_i2c_probe(struct i2c_client *i2c_client,
 	}
 
 	/* Reset the Device */
-	cs42l42->reset_gpio = devm_gpiod_get_optional(&i2c_client->dev,
-		"reset", GPIOD_OUT_LOW);
+	cs42l42->reset_gpio = devm_gpiod_get(&i2c_client->dev, "reset", GPIOD_OUT_LOW);
 	if (IS_ERR(cs42l42->reset_gpio)) {
 		ret = PTR_ERR(cs42l42->reset_gpio);
+		dev_err(&i2c_client->dev, "Failed to request reset gpio: %d\n", ret);
 		goto err_disable;
 	}
 
-	if (cs42l42->reset_gpio) {
-		dev_dbg(&i2c_client->dev, "Found reset GPIO\n");
-		gpiod_set_value_cansleep(cs42l42->reset_gpio, 1);
-	}
+	gpiod_set_value_cansleep(cs42l42->reset_gpio, 1);
 	usleep_range(CS42L42_BOOT_TIME_US, CS42L42_BOOT_TIME_US * 2);
 
 	/* Request IRQ */
-- 
2.11.0

