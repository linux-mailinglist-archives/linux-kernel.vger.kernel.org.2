Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41A9D3DA9B8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 19:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbhG2RJu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 13:09:50 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:57618 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229791AbhG2RJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 13:09:45 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 16T6K8lu018919;
        Thu, 29 Jul 2021 12:09:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=Yr+rALEqZLCX1Alk11rdAicsk1IoORZLMBQqoCy1fTI=;
 b=GnrfXQC3Dq7jZKOp5/RExJJkG5MgvJlsD6BcEYsGPDe8hWXcsb1kB6pUVbqrpF5yOX1a
 hSLozMkApylALcWs0azxLRlse8P82l7dAPgiyGpRZI3HQhveBghOC3D8blIWPbHE5eRV
 r+rR1ATqcXCJiofB7d6IYLLsCRq9rzNSdO9dtNEyuclAU1U3YnN7AHWMJl8egb6jSJmm
 AXV2c10vSioFAiyUWKBKZtK4hbCRsQXcvjaoBH97xdf06iFotuh55e5lYDghhFn+OHOk
 D1ggGokjKC+2IbkMteYFhQ3jPMTxRtKwKLtweATObPwiUn4ONv/xZsFVoEoPRmdUvfL3 OA== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 3a31m2t69n-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 29 Jul 2021 12:09:36 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 29 Jul
 2021 18:09:35 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Thu, 29 Jul 2021 18:09:35 +0100
Received: from AUSNPC0LSNW1-debian.cirrus.com (AUSNPC0LSNW1.ad.cirrus.com [198.61.65.56])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 0F89246E;
        Thu, 29 Jul 2021 17:09:35 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 3/3] ASoC: cs42l42: Fix bclk calculation for mono
Date:   Thu, 29 Jul 2021 18:09:29 +0100
Message-ID: <20210729170929.6589-3-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210729170929.6589-1-rf@opensource.cirrus.com>
References: <20210729170929.6589-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: doPdSMftA5y97bpOXaEOBwJFQKeGuUkv
X-Proofpoint-ORIG-GUID: doPdSMftA5y97bpOXaEOBwJFQKeGuUkv
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 impostorscore=0
 suspectscore=0 lowpriorityscore=0 mlxlogscore=999 phishscore=0 spamscore=0
 clxscore=1015 mlxscore=0 adultscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2107290101
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An I2S frame always has a left and right channel slot even if mono
data is being sent. So if channels==1 the actual bitclock frequency
is 2 * snd_soc_params_to_bclk(params).

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Fixes: 2cdba9b045c7 ("ASoC: cs42l42: Use bclk from hw_params if set_sysclk was not called")
---
 sound/soc/codecs/cs42l42.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/codecs/cs42l42.c b/sound/soc/codecs/cs42l42.c
index 38e243a815b1..08ca05bfbeb3 100644
--- a/sound/soc/codecs/cs42l42.c
+++ b/sound/soc/codecs/cs42l42.c
@@ -830,6 +830,10 @@ static int cs42l42_pcm_hw_params(struct snd_pcm_substream *substream,
 	cs42l42->srate = params_rate(params);
 	cs42l42->bclk = snd_soc_params_to_bclk(params);
 
+	/* I2S frame always has 2 channels even for mono audio */
+	if (channels == 1)
+		cs42l42->bclk *= 2;
+
 	switch(substream->stream) {
 	case SNDRV_PCM_STREAM_CAPTURE:
 		if (channels == 2) {
-- 
2.11.0

