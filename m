Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D580432ABBD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 21:41:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1837088AbhCBUi1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 15:38:27 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:60076 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1574639AbhCBRv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 12:51:27 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 122H1q3H022910;
        Tue, 2 Mar 2021 11:05:02 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=kCgmon+H0mCTEPsdSE/zvE9WEodhfHIQSgmuNA3+o1U=;
 b=hUVOqHeWS1DTR4rTXjLnq9BRUzAXO6VmLa2UtTWbYnEXaGnlGrq8fh5uB4/XZruhFVD/
 PgXmRYSTCan6nMMsW1O1Rug+jEBOZp1nQB9jaktjOhhZmEBDwJRmObWyEkQb+YoIxnX1
 3yMSushY43/YyYISpskSX9MmN2//ZQodHhchRi1iZN600vV//Iw6CMxp39Wc0IHyikRn
 oJjK3V7Io3droBKGX6JgYDHEMK1XIRHdHEB/9FouPaBOE1YfZ7YT+ssM3y+bN2Tqz19q
 6Q87o5ci9LtGrpVxdqsH95v8aJ/Aw8jdKBbGIBqFBQL6xoCtif6Jy7545wW27gz8HbGf 9Q== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 36ymc6usg7-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 02 Mar 2021 11:05:02 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Tue, 2 Mar 2021
 17:04:59 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Tue, 2 Mar 2021 17:04:59 +0000
Received: from mail1.cirrus.com (unknown [198.61.64.35])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id A8B8711CB;
        Tue,  2 Mar 2021 17:04:59 +0000 (UTC)
From:   Lucas Tanure <tanureal@opensource.cirrus.com>
To:     James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
CC:     Richard Fitzgerald <rf@opensource.cirrus.com>,
        <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        Lucas Tanure <tanureal@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 03/15] ASoC: cs42l42: Remove power if the driver is being removed
Date:   Tue, 2 Mar 2021 17:04:42 +0000
Message-ID: <20210302170454.39679-4-tanureal@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210302170454.39679-1-tanureal@opensource.cirrus.com>
References: <20210302170454.39679-1-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 clxscore=1015 suspectscore=0
 adultscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0 spamscore=0
 priorityscore=1501 mlxlogscore=974 bulkscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103020131
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ensure the power supplies are turned off when removing the driver

Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
---
 sound/soc/codecs/cs42l42.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/cs42l42.c b/sound/soc/codecs/cs42l42.c
index 2a25a30f842b1..00e303c711ddc 100644
--- a/sound/soc/codecs/cs42l42.c
+++ b/sound/soc/codecs/cs42l42.c
@@ -1852,6 +1852,8 @@ static int cs42l42_i2c_remove(struct i2c_client *i2c_client)
 	/* Hold down reset */
 	gpiod_set_value_cansleep(cs42l42->reset_gpio, 0);
 
+	regulator_bulk_disable(ARRAY_SIZE(cs42l42->supplies), cs42l42->supplies);
+
 	return 0;
 }
 
-- 
2.30.1

