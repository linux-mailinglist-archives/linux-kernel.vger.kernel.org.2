Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 391ED3E1938
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 18:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232421AbhHEQLq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 12:11:46 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:16974 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231702AbhHEQLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 12:11:36 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 175EPV3Y027692;
        Thu, 5 Aug 2021 11:11:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=d3mPwDDSfaabebNz7Ge775dZvtX8lcNvZIXrc4dG88s=;
 b=nIHjKxX4LKdG+NVKHwFbXG2gg+aJbScXHz/Zgj9502KnGxhUokAg/YOJciU7fMD6LrJk
 izA+FeIWZ6K+rymOpgIEiSemY17adDfAi4if2PHAoySn3/VbFWFf40Ro8bDeCD1J/3sQ
 LdNVbzOJ+OJOzcgaSobQfwiWjCspWWDszqkjAOiPhR1Gno1xRWCHqE9XBwRNEejjFFSI
 19iSQJBAtQO3kVyUsj84Au3wo/c+6D2NeD8PKn4lvoN5uxeN0k3ERFdSNcWHNLw5jhGs
 +KZ5c7te2ryZxRPJmb6pc2mqNhlfAOYp9xjK89cTp9EYQL52p6mA3rJlHqKYrRTjYqcp bA== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 3a8c61rku6-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 05 Aug 2021 11:11:17 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Thu, 5 Aug
 2021 17:11:15 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.12 via Frontend
 Transport; Thu, 5 Aug 2021 17:11:15 +0100
Received: from AUSNPC0LSNW1-debian.cirrus.com (AUSNPC0LSNW1.ad.cirrus.com [198.61.65.37])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 8D43A45D;
        Thu,  5 Aug 2021 16:11:15 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 7/8] ASoC: cs42l42: Assume 24-bit samples are in 32-bit slots
Date:   Thu, 5 Aug 2021 17:11:10 +0100
Message-ID: <20210805161111.10410-7-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210805161111.10410-1-rf@opensource.cirrus.com>
References: <20210805161111.10410-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: RFG3QrSB7Xl2CJSzzW90kCByKMC4N6lT
X-Proofpoint-ORIG-GUID: RFG3QrSB7Xl2CJSzzW90kCByKMC4N6lT
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 mlxscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 suspectscore=0
 mlxlogscore=999 adultscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108050099
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the machine driver doesn't call snd_soc_dai_set_sysclk() the
SCLK is assumed to be sample_rate * sample_bits * 2 (that is, the
rate necessary for a standard I2S frame).

But 24-bit samples can be sent in either a 24-bit slot or a 32-bit
slot. If the PLL is configured for a 24-bit slot, but a 32-bit slot is
used, cs42l42 will be overclocked.

Ultimately it is the machine driver's responsibilty to call
snd_soc_dai_set_sysclk() if SLK will be different from the standard
I2S rate. However, it is convenient to assume 32-bit slots to allow
this common case without needing special machine driver support. The
machine driver then only has to set SCLK if the slots are 24-bit, but
if it fails to do this cs42l42 won't be overclocked.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/soc/codecs/cs42l42.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/codecs/cs42l42.c b/sound/soc/codecs/cs42l42.c
index b2ee51443a22..3677ed4670d0 100644
--- a/sound/soc/codecs/cs42l42.c
+++ b/sound/soc/codecs/cs42l42.c
@@ -844,6 +844,13 @@ static int cs42l42_pcm_hw_params(struct snd_pcm_substream *substream,
 	if (channels == 1)
 		cs42l42->bclk *= 2;
 
+	/*
+	 * Assume 24-bit samples are in 32-bit slots, to prevent SCLK being
+	 * more than assumed (which would result in overclocking).
+	 */
+	if (params_width(params) == 24)
+		cs42l42->bclk = (cs42l42->bclk / 3) * 4;
+
 	switch(substream->stream) {
 	case SNDRV_PCM_STREAM_CAPTURE:
 		if (channels == 2) {
-- 
2.11.0

