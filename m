Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6395E3DA9B9
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 19:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231666AbhG2RJx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 13:09:53 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:42232 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229890AbhG2RJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 13:09:45 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 16T6K8lt018919;
        Thu, 29 Jul 2021 12:09:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=Ww6B18qARdfihWYJjZN/A6kyrA9q9+jD6MjTKwlaLaU=;
 b=aZ6K2UAOWA9pA1oFTFgk1b9Tg13LlRqWegoy+WBU141qfl+/VMlgbhXxNXLfOsjLkKDg
 l/WD8SwOPbG/ChYND79kPeHXR2rZ3G4k3Nz1ZLIaYHt65UnhwZI+6GIgk4mugT7ewvfx
 KZotLLrsOunHnWG+Vge02F2e/GnRynFZYmJ2uP2Ownq1+70ARy//XZQWuG1KDnquwFMw
 yZtMg8d8aYwvXXC3kWTE8jOWbstwRdL2CHT4ap6PnlMgTWp/OVfv1lH2ehV/hy0qFcTy
 UXQmGiAHG4lJeJeKj3fgQ1TfILrrjhr0g3bfnfyZTx9UCTyAG7ETJLD8VJyy90u07ypd 1g== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 3a31m2t69n-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 29 Jul 2021 12:09:35 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 29 Jul
 2021 18:09:35 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Thu, 29 Jul 2021 18:09:34 +0100
Received: from AUSNPC0LSNW1-debian.cirrus.com (AUSNPC0LSNW1.ad.cirrus.com [198.61.65.56])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id BF7872BA;
        Thu, 29 Jul 2021 17:09:34 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 2/3] ASoC: cs42l42: Don't allow SND_SOC_DAIFMT_LEFT_J
Date:   Thu, 29 Jul 2021 18:09:28 +0100
Message-ID: <20210729170929.6589-2-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210729170929.6589-1-rf@opensource.cirrus.com>
References: <20210729170929.6589-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: VitUmnYvM_qaod4fvaAcZ6ZVNeLxUxE5
X-Proofpoint-ORIG-GUID: VitUmnYvM_qaod4fvaAcZ6ZVNeLxUxE5
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 impostorscore=0
 suspectscore=0 lowpriorityscore=0 mlxlogscore=730 phishscore=0 spamscore=0
 clxscore=1015 mlxscore=0 adultscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2107290101
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver has no support for left-justified protocol so it should
not have been allowing this to be passed to cs42l42_set_dai_fmt().

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Fixes: 2c394ca79604 ("ASoC: Add support for CS42L42 codec")
---
 sound/soc/codecs/cs42l42.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/cs42l42.c b/sound/soc/codecs/cs42l42.c
index 2fd20511f246..38e243a815b1 100644
--- a/sound/soc/codecs/cs42l42.c
+++ b/sound/soc/codecs/cs42l42.c
@@ -788,7 +788,6 @@ static int cs42l42_set_dai_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
 	/* interface format */
 	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
 	case SND_SOC_DAIFMT_I2S:
-	case SND_SOC_DAIFMT_LEFT_J:
 		break;
 	default:
 		return -EINVAL;
-- 
2.11.0

