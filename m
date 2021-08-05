Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76D823E1936
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 18:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232258AbhHEQLn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 12:11:43 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:13066 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231755AbhHEQLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 12:11:36 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 175EPV3b027692;
        Thu, 5 Aug 2021 11:11:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=BgSkYgjyAhG7rLZdW0I+adkP4TYCDWsj5RMlEyx3YLg=;
 b=bRCXiuhZHqlxorm8aHg4ERUa9fdMvSL6odOAiX8bO1Il+jpXVC0nQnIH/76qIRcmYmP0
 JX1k+DhXfu+5PCOJDlH2I81yERoEbJJA44B8lD+wVg8PWAPpjhYAYYyUlQ1Wai0CAZSM
 avpKV04nh2zIc3x0VyleNPLcH5jit5tZaO4/6NByJQgK+qjNghakl+3Dk8gJDoVz+eRR
 br/ujKuPF7h7kX7gfw3xZVMEyWVJQu0v5QZ5ixeDRwsDn2qS2EVIn3xSwyHDNJQMeA+l
 rAw2ErJwl2pzXVFt2QOeWWbLmUUb4IY/BNZFwtPPoOHzNgNbTlSY2bgFw9EntKxMKBbP 4Q== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 3a8c61rku5-4
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
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id EC8E546E;
        Thu,  5 Aug 2021 16:11:14 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 5/8] ASoC: cs42l42: Add PLL configuration for 44.1kHz/16-bit
Date:   Thu, 5 Aug 2021 17:11:08 +0100
Message-ID: <20210805161111.10410-5-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210805161111.10410-1-rf@opensource.cirrus.com>
References: <20210805161111.10410-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: L2EKy52Z9vromiEx5Ebu5prVTIxmyS-i
X-Proofpoint-ORIG-GUID: L2EKy52Z9vromiEx5Ebu5prVTIxmyS-i
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 mlxscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 suspectscore=0
 mlxlogscore=999 adultscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108050099
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

44.1kHz 16-bit standard I2S gives a SCLK of 1.4112 MHz. Add
a PLL configuration for this.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/soc/codecs/cs42l42.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/cs42l42.c b/sound/soc/codecs/cs42l42.c
index 99c022be94a6..6895f2fe9eb0 100644
--- a/sound/soc/codecs/cs42l42.c
+++ b/sound/soc/codecs/cs42l42.c
@@ -586,6 +586,7 @@ struct cs42l42_pll_params {
  * Table 4-5 from the Datasheet
  */
 static const struct cs42l42_pll_params pll_ratio_table[] = {
+	{ 1411200, 0, 1, 0x00, 0x80, 0x000000, 0x03, 0x10, 11289600, 128, 2},
 	{ 1536000, 0, 1, 0x00, 0x7D, 0x000000, 0x03, 0x10, 12000000, 125, 2},
 	{ 2304000, 0, 1, 0x00, 0x55, 0xC00000, 0x02, 0x10, 12288000,  85, 2},
 	{ 2400000, 0, 1, 0x00, 0x50, 0x000000, 0x03, 0x10, 12000000,  80, 2},
-- 
2.11.0

