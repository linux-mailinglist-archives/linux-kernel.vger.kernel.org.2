Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C11E3DF222
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 18:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232109AbhHCQJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 12:09:02 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:27482 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231386AbhHCQI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 12:08:58 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 173DLO6n010886;
        Tue, 3 Aug 2021 11:08:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=OVfZ3pt8A3wXqJh2udmbOd+r3erd/wK8N4VYd970WG4=;
 b=RH0ttlnsyE26gFHHzDrQ8UWxHeNfp9uJMCs8iV3ejxWU9lJV7MlEQ+Qsb20TfEr1mmPh
 2xA3uiowQBsKaihxi8bBzDse2ogRpt+GsXsAPq9iVllbagHH1a29bmtNBecqh0EoZye5
 dBqMW0mAxCfpT7suzfpaG/76IQj5Z80lUZg0h3GX8gdIftYRtXierLKwVSSBOFofD82D
 HuWNu2E+9oXa+y49V7NBphyHmeeNBX0Z+Ucc4INq78QgBYXaJ6vdXd+M2eKcPsLqweke
 P8KePXKH7vXKVui8gloF3esTk9pLIdsseAIEZ/OGTjmftNGBjq9RXsYTHFcOgIW8gotJ Xw== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 3a6r9fhbme-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 03 Aug 2021 11:08:40 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Tue, 3 Aug
 2021 17:08:38 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.12 via Frontend
 Transport; Tue, 3 Aug 2021 17:08:38 +0100
Received: from AUSNPC0LSNW1-debian.cirrus.com (AUSNPC0LSNW1.ad.cirrus.com [198.61.65.37])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 4CCC42BA;
        Tue,  3 Aug 2021 16:08:38 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>,
        <alsa-devel@alsa-project.org>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 2/2] ASoC: cs42l42: Remove duplicate control for WNF filter frequency
Date:   Tue, 3 Aug 2021 17:08:34 +0100
Message-ID: <20210803160834.9005-2-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210803160834.9005-1-rf@opensource.cirrus.com>
References: <20210803160834.9005-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: ebl6xWMYHEmi4vTN7nxvH6dLUn9I1Oe3
X-Proofpoint-ORIG-GUID: ebl6xWMYHEmi4vTN7nxvH6dLUn9I1Oe3
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 bulkscore=0
 phishscore=0 clxscore=1015 priorityscore=1501 malwarescore=0 adultscore=0
 lowpriorityscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108030106
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver was defining two ALSA controls that both change the same
register field for the wind noise filter corner frequency. The filter
response has two corners, at different frequencies, and the duplicate
controls most likely were an attempt to be able to set the value using
either of the frequencies.

However, having two controls changing the same field can be problematic
and it is unnecessary. Both frequencies are related to each other so
setting one implies exactly what the other would be.

Removing a control affects user-side code, but there is currently no
known use of the removed control so it would be best to remove it now
before it becomes a problem.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Fixes: 2c394ca79604 ("ASoC: Add support for CS42L42 codec")
---
 sound/soc/codecs/cs42l42.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/sound/soc/codecs/cs42l42.c b/sound/soc/codecs/cs42l42.c
index 2db87e3a4dc3..a00dc3c65549 100644
--- a/sound/soc/codecs/cs42l42.c
+++ b/sound/soc/codecs/cs42l42.c
@@ -425,15 +425,6 @@ static SOC_ENUM_SINGLE_DECL(cs42l42_wnf3_freq_enum, CS42L42_ADC_WNF_HPF_CTL,
 			    CS42L42_ADC_WNF_CF_SHIFT,
 			    cs42l42_wnf3_freq_text);
 
-static const char * const cs42l42_wnf05_freq_text[] = {
-	"280Hz", "315Hz", "350Hz", "385Hz",
-	"420Hz", "455Hz", "490Hz", "525Hz"
-};
-
-static SOC_ENUM_SINGLE_DECL(cs42l42_wnf05_freq_enum, CS42L42_ADC_WNF_HPF_CTL,
-			    CS42L42_ADC_WNF_CF_SHIFT,
-			    cs42l42_wnf05_freq_text);
-
 static const struct snd_kcontrol_new cs42l42_snd_controls[] = {
 	/* ADC Volume and Filter Controls */
 	SOC_SINGLE("ADC Notch Switch", CS42L42_ADC_CTL,
@@ -451,7 +442,6 @@ static const struct snd_kcontrol_new cs42l42_snd_controls[] = {
 				CS42L42_ADC_HPF_EN_SHIFT, true, false),
 	SOC_ENUM("HPF Corner Freq", cs42l42_hpf_freq_enum),
 	SOC_ENUM("WNF 3dB Freq", cs42l42_wnf3_freq_enum),
-	SOC_ENUM("WNF 05dB Freq", cs42l42_wnf05_freq_enum),
 
 	/* DAC Volume and Filter Controls */
 	SOC_SINGLE("DACA Invert Switch", CS42L42_DAC_CTL1,
-- 
2.11.0

