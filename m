Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F321A3E193C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 18:12:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231654AbhHEQLz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 12:11:55 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:1836 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231815AbhHEQLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 12:11:36 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 175EPV3c027692;
        Thu, 5 Aug 2021 11:11:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=u3bgx8JMeKH6mKpqx9P6VjyjfpLTa00DuM6UQOOAF9k=;
 b=UyWyQz3h/0/XP2pemKi2I2RpvjHXBToS65wbFHbFzYSaaDWFJXRe6Sf3lqbsoZSX5RPi
 IThQWXYzrmQLeP4rvHcWAxhihwn7oaJZWc0zSOjSDtr1TCvhSiLzXxze9CARgmnSNedR
 8zisO+s7mUTpKzdVmVfOnuT0W5KcTDmcNk1O7yd9WRClhmT150n0cf+PSlE7lzFz4aFz
 bRkmaWtBvzXqgKZP5U246OadlET9LiE0/f3+mH/PCsTqPgdAKtDPEbU9w4LrlfrRvh5L
 El1w6lw/xXEGY0oOi4zn1ZOErQKUz6HGlogmzYJTzTdRghvKkD+o7H8ijkPogn0jaEXV dw== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 3a8c61rku5-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 05 Aug 2021 11:11:18 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Thu, 5 Aug
 2021 17:11:15 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.12 via Frontend
 Transport; Thu, 5 Aug 2021 17:11:15 +0100
Received: from AUSNPC0LSNW1-debian.cirrus.com (AUSNPC0LSNW1.ad.cirrus.com [198.61.65.37])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 45DBA2BA;
        Thu,  5 Aug 2021 16:11:15 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 6/8] ASoC: cs42l42: Validate dai_set_sysclk() frequency
Date:   Thu, 5 Aug 2021 17:11:09 +0100
Message-ID: <20210805161111.10410-6-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210805161111.10410-1-rf@opensource.cirrus.com>
References: <20210805161111.10410-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: L-xhSgF0BA1B2So2qlXRxRHh1YS-U3yW
X-Proofpoint-ORIG-GUID: L-xhSgF0BA1B2So2qlXRxRHh1YS-U3yW
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 mlxscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 suspectscore=0
 mlxlogscore=774 adultscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108050099
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the machine driver calls snd_set_sysclk() with an unsupported
SCLK frequency, return an error instead of letting hw_params() fail.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/soc/codecs/cs42l42.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/cs42l42.c b/sound/soc/codecs/cs42l42.c
index 6895f2fe9eb0..b2ee51443a22 100644
--- a/sound/soc/codecs/cs42l42.c
+++ b/sound/soc/codecs/cs42l42.c
@@ -891,10 +891,23 @@ static int cs42l42_set_sysclk(struct snd_soc_dai *dai,
 {
 	struct snd_soc_component *component = dai->component;
 	struct cs42l42_private *cs42l42 = snd_soc_component_get_drvdata(component);
+	int i;
 
-	cs42l42->sclk = freq;
+	if (freq == 0) {
+		cs42l42->sclk = 0;
+		return 0;
+	}
 
-	return 0;
+	for (i = 0; i < ARRAY_SIZE(pll_ratio_table); i++) {
+		if (pll_ratio_table[i].sclk == freq) {
+			cs42l42->sclk = freq;
+			return 0;
+		}
+	}
+
+	dev_err(component->dev, "SCLK %u not supported\n", freq);
+
+	return -EINVAL;
 }
 
 static int cs42l42_mute_stream(struct snd_soc_dai *dai, int mute, int stream)
-- 
2.11.0

