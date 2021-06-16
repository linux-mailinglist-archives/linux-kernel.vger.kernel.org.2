Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E3CA3A9CC7
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 15:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233563AbhFPN6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 09:58:38 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:18532 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232791AbhFPN6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 09:58:25 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15GDtur2003960;
        Wed, 16 Jun 2021 08:56:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=z4ir6OwFS6D0/KhBWykA4un0BnM5Kr4vp3bJU94cqYA=;
 b=dMOuz5qV5HfNYC/fKjVn+CppN+YTU0XS4WxjeVCCHiCyk2zMcPEM3Ihe/bXb+NE5XG7z
 IqGKLjzkmwwUrsMtyGtTy0CMEOvih/t7DeAMLbPR+LUjvMaIFBmdnYJrmVgX/2Lpy3Ul
 ojV78GZJUZqe4DoQ6rS2WJbW2ZWQ70woeFMed03KEgrXM5xsBvAaBUp7O91EvG61BbDF
 0xBKIhKJYUR9Lz+qldZSvSJlcXQ/ndBZNDtCGM23zMfaaEK7IMsNIqHhP0D+stIWju1i
 GjybU6MJ6sgjQz2w2T4XD2bhtd4Joq4FeXRqqzL0oo6Be/e/9zprrah5m+q54998U4q/ 8Q== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 397ab2gn60-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 16 Jun 2021 08:56:08 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Wed, 16 Jun
 2021 14:56:07 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Wed, 16 Jun 2021 14:56:07 +0100
Received: from AUSNPC0LSNW1-debian.cirrus.com (AUSNPC0LSNW1.ad.cirrus.com [198.61.65.68])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 5DF2E2B2;
        Wed, 16 Jun 2021 13:56:06 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH] ASoC: cs42l42: Correct definition of CS42L42_ADC_PDN_MASK
Date:   Wed, 16 Jun 2021 14:56:04 +0100
Message-ID: <20210616135604.19363-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Vr5Xh5MzxCjSkwp-T4ItcZmvOhW9gSEr
X-Proofpoint-GUID: Vr5Xh5MzxCjSkwp-T4ItcZmvOhW9gSEr
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 bulkscore=0
 spamscore=0 mlxlogscore=707 clxscore=1015 impostorscore=0 adultscore=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106160081
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The definition of CS42L42_ADC_PDN_MASK was incorrectly defined
as the HP_PDN bit.

Fixes: 2c394ca79604 ("ASoC: Add support for CS42L42 codec")
Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/soc/codecs/cs42l42.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cs42l42.h b/sound/soc/codecs/cs42l42.h
index 7bf05ff05f74..206b3c81d3e0 100644
--- a/sound/soc/codecs/cs42l42.h
+++ b/sound/soc/codecs/cs42l42.h
@@ -79,7 +79,7 @@
 #define CS42L42_HP_PDN_SHIFT		3
 #define CS42L42_HP_PDN_MASK		(1 << CS42L42_HP_PDN_SHIFT)
 #define CS42L42_ADC_PDN_SHIFT		2
-#define CS42L42_ADC_PDN_MASK		(1 << CS42L42_HP_PDN_SHIFT)
+#define CS42L42_ADC_PDN_MASK		(1 << CS42L42_ADC_PDN_SHIFT)
 #define CS42L42_PDN_ALL_SHIFT		0
 #define CS42L42_PDN_ALL_MASK		(1 << CS42L42_PDN_ALL_SHIFT)
 
-- 
2.20.1

