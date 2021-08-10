Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 805FD3DF221
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 18:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232016AbhHCQJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 12:09:00 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:30120 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231327AbhHCQI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 12:08:57 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 173DLVK7012697;
        Tue, 3 Aug 2021 11:08:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=bNzxUipQQFzCfuCe+1vyTKbuwcV51H4im/2UTcOieIk=;
 b=lUyqwRUGifinjLSFsnqsiA8+07TMzNE9nvDRJdGPf36g8Sug4iFIdqahXe9sy9lstsEn
 3IASRG7w4GlD1mxsTApxnn3fzBaPcDgTISPUTZpHhAHZbMiWxdMteVzx6QHLutA1ZnV9
 F+O8lCbdR412eGKyKzYszJchkfWuI9h9MBGZkxwJjxjrg2P6ruQKq8DUYmEcegiPCi9V
 tTr/aK9AA0IDH45QcV599woZwXPTGfMZ8a+wdWcWlgN+IxFLZVKxg+vYPSGKNY6lOGLN
 qEh7H02d+008TIbOw6hQDwQ2rLQgc5SgODcSd0iRwENOIP/wV/V1PZ2pn8xVMqQAu0O7 JA== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 3a6qc9sd6y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 03 Aug 2021 11:08:38 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Tue, 3 Aug
 2021 17:08:36 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.12 via Frontend
 Transport; Tue, 3 Aug 2021 17:08:36 +0100
Received: from AUSNPC0LSNW1-debian.cirrus.com (AUSNPC0LSNW1.ad.cirrus.com [198.61.65.37])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 54AB02BA;
        Tue,  3 Aug 2021 16:08:36 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>,
        <alsa-devel@alsa-project.org>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 1/2] ASoC: cs42l42: Fix inversion of ADC Notch Switch control
Date:   Tue, 3 Aug 2021 17:08:33 +0100
Message-ID: <20210803160834.9005-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: N22vGn8KCWW-43V709cjnmqGRF3Sd_Oc
X-Proofpoint-ORIG-GUID: N22vGn8KCWW-43V709cjnmqGRF3Sd_Oc
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 impostorscore=0
 mlxscore=0 suspectscore=0 bulkscore=0 clxscore=1015 adultscore=0
 mlxlogscore=999 malwarescore=0 priorityscore=1501 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108030106
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The underlying register field has inverted sense (0 = enabled) so
the control definition must be marked as inverted.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Fixes: 2c394ca79604 ("ASoC: Add support for CS42L42 codec")
---
 sound/soc/codecs/cs42l42.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cs42l42.c b/sound/soc/codecs/cs42l42.c
index 08ca05bfbeb3..2db87e3a4dc3 100644
--- a/sound/soc/codecs/cs42l42.c
+++ b/sound/soc/codecs/cs42l42.c
@@ -437,7 +437,7 @@ static SOC_ENUM_SINGLE_DECL(cs42l42_wnf05_freq_enum, CS42L42_ADC_WNF_HPF_CTL,
 static const struct snd_kcontrol_new cs42l42_snd_controls[] = {
 	/* ADC Volume and Filter Controls */
 	SOC_SINGLE("ADC Notch Switch", CS42L42_ADC_CTL,
-				CS42L42_ADC_NOTCH_DIS_SHIFT, true, false),
+				CS42L42_ADC_NOTCH_DIS_SHIFT, true, true),
 	SOC_SINGLE("ADC Weak Force Switch", CS42L42_ADC_CTL,
 				CS42L42_ADC_FORCE_WEAK_VCM_SHIFT, true, false),
 	SOC_SINGLE("ADC Invert Switch", CS42L42_ADC_CTL,
-- 
2.11.0

