Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F44C37A78F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 15:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231426AbhEKNa2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 09:30:28 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:53638 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231305AbhEKNaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 09:30:23 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14BDQoux022683;
        Tue, 11 May 2021 08:29:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=bzqrVrM9xmJqVMzON06i42Dfv5kRx48381tnaoZJZNo=;
 b=Nqy5mVmT1iXyXnG1c/w3i0CMrqgBVypsQl0w4kkXvr0nOuKDWqNQ+t3bpplGHsio64BC
 ZXZ4Dj2WWIj13/AVmyuScXoXCLapQM2X+D+I7Oa2IoeBqolaTrENdf8ncP3l5ZsBYWkK
 q0pNyl/61sBK4tO5ZzLHBM2t51UjtYHHW6LAbEksnEzLTOR25+YfYtjjPyfC8v+kG/oR
 A9zrdGnECIuzAR2fkMV9rSxTkX+WANDUu057aOsL8j4jGhvLCIWbDSJF+OtF0MqyV40f
 st0uK9nPIEJErLWYWN+0Wkh2ZlWLAwC+N8gSNHQP/7a58IUaSmKuhz/cVJqLdvuQ9N8/ yA== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 38f2d4sjyd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 11 May 2021 08:29:01 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 11 May
 2021 14:29:00 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Tue, 11 May 2021 14:29:00 +0100
Received: from AUSNPC0LSNW1-debian.cirrus.com (AUSNPC0LSNW1.ad.cirrus.com [198.61.65.125])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 0ACD311CF;
        Tue, 11 May 2021 13:29:00 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH] ASoC: cs42l42: Regmap must use_single_read/write
Date:   Tue, 11 May 2021 14:28:55 +0100
Message-ID: <20210511132855.27159-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: XcBi5beSO0DhnWP_9TGAh6jYrGzhXj7f
X-Proofpoint-ORIG-GUID: XcBi5beSO0DhnWP_9TGAh6jYrGzhXj7f
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1011 spamscore=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 adultscore=0 impostorscore=0
 malwarescore=0 mlxscore=0 phishscore=0 priorityscore=1501 mlxlogscore=575
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105110103
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cs42l42 does not support standard burst transfers so the use_single_read
and use_single_write flags must be set in the regmap config.

Because of this bug, the patch:

commit 0a0eb567e1d4 ("ASoC: cs42l42: Minor error paths fixups")

broke cs42l42 probe() because without the use_single_* flags it causes
regmap to issue a burst read.

However, the missing use_single_* could cause problems anyway because the
regmap cache can attempt burst transfers if these flags are not set.

Fixes: 2c394ca79604 ("ASoC: Add support for CS42L42 codec")
Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/soc/codecs/cs42l42.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/codecs/cs42l42.c b/sound/soc/codecs/cs42l42.c
index d7fb6b38fd7c..e4b058a1d6af 100644
--- a/sound/soc/codecs/cs42l42.c
+++ b/sound/soc/codecs/cs42l42.c
@@ -400,6 +400,9 @@ static const struct regmap_config cs42l42_regmap = {
 	.reg_defaults = cs42l42_reg_defaults,
 	.num_reg_defaults = ARRAY_SIZE(cs42l42_reg_defaults),
 	.cache_type = REGCACHE_RBTREE,
+
+	.use_single_read = true,
+	.use_single_write = true,
 };
 
 static DECLARE_TLV_DB_SCALE(adc_tlv, -9600, 100, false);
-- 
2.20.1

