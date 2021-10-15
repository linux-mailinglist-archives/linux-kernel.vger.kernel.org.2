Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFE0542F3B9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 15:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240057AbhJONjm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 09:39:42 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:39906 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S240001AbhJONik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 09:38:40 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19F4c2t7023483;
        Fri, 15 Oct 2021 08:36:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=RGJD8vABM3n+dz6ADGavc8MFL5Y167NLIR1g7/+WtxM=;
 b=pKY1TKMnwUTBxTCe7Z3401I4oXbscJifJBCmEAhPfDi3qj9zf6A6QtGOzK7KHuO6uDYC
 xMyJPOvQRME4ktpOvg7PqmYripzuh0H2ve1a/Up7NdLpy/3lwAOk4lnZfJH7UlfZ3GFB
 x7xg4wVbuFmopcYKfVpUe6L6YhcXcawLvdOEJUOSWoPLUO4l63yYJ4MWD8dSqHUk4usv
 +JKfs1Tft1y6rABfdnFSQMgp1Y87SwVxHn9KA/mSob8jZazWjxFgLwXVpM3RKG19jzEn
 pbtXUzWT7e1raBBG5AO14LU8594sGxBZkKXh771z3TqO4sbvQAmzKGBMLjXZ1ABPh0gK 5g== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 3bq1gagp5v-10
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 15 Oct 2021 08:36:30 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 15 Oct
 2021 14:36:25 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.7 via Frontend
 Transport; Fri, 15 Oct 2021 14:36:25 +0100
Received: from AUSNPC0LSNW1-debian.cirrus.com (AUSNPC0LSNW1.ad.cirrus.com [198.61.65.254])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 9E4F846D;
        Fri, 15 Oct 2021 13:36:25 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 14/16] ASoC: cs42l42: Mark OSC_SWITCH_STATUS register volatile
Date:   Fri, 15 Oct 2021 14:36:17 +0100
Message-ID: <20211015133619.4698-15-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211015133619.4698-1-rf@opensource.cirrus.com>
References: <20211015133619.4698-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: ljmEU0sDgK4pl_qnb6vWD1dL_hIHC8qb
X-Proofpoint-GUID: ljmEU0sDgK4pl_qnb6vWD1dL_hIHC8qb
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

OSC_SWITCH_STATUS is a volatile register indicating the current state
of the clock switch logic.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/soc/codecs/cs42l42.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cs42l42.c b/sound/soc/codecs/cs42l42.c
index 05b8ae62b20d..8e4a43c5a120 100644
--- a/sound/soc/codecs/cs42l42.c
+++ b/sound/soc/codecs/cs42l42.c
@@ -52,7 +52,6 @@ static const struct reg_default cs42l42_reg_defaults[] = {
 	{ CS42L42_RSENSE_CTL1,			0x40 },
 	{ CS42L42_RSENSE_CTL2,			0x00 },
 	{ CS42L42_OSC_SWITCH,			0x00 },
-	{ CS42L42_OSC_SWITCH_STATUS,		0x05 },
 	{ CS42L42_RSENSE_CTL3,			0x1B },
 	{ CS42L42_TSENSE_CTL,			0x1B },
 	{ CS42L42_TSRS_INT_DISABLE,		0x00 },
@@ -331,6 +330,7 @@ static bool cs42l42_volatile_register(struct device *dev, unsigned int reg)
 	case CS42L42_DEVID_CD:
 	case CS42L42_DEVID_E:
 	case CS42L42_MCLK_STATUS:
+	case CS42L42_OSC_SWITCH_STATUS:
 	case CS42L42_TRSENSE_STATUS:
 	case CS42L42_HS_DET_STATUS:
 	case CS42L42_ADC_OVFL_STATUS:
-- 
2.11.0

