Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C5283E7C77
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 17:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243441AbhHJPjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 11:39:11 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:58706 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S243218AbhHJPin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 11:38:43 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 17AAlVv9027584;
        Tue, 10 Aug 2021 10:38:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=aSYUEE0jZpyk028RRipO92c7iM0eaAioStDtPkIyM8Q=;
 b=VtjgihuU1iQS9Xj48Kp48vNoM8yD6G4+ltz/tynYvSbcgEy+2iA/ksCGc45gay0lZA5k
 CyK/QhUyr13K0UyapssFH2tYlcYZLZuLoDl7Tsv9IECxjgSEJgFm3XT+vpx7qbb7Bo3w
 UUDj8ur2RfV/c/dDwubEPxw/weaGMyzlSQcMgnZlOVJVa+0Lq+l/o6K7yhfSHXm0XqhG
 EHDoI5Bgs6IJcjeZWpLil4uUuj6DRK1Ugvi2Uct+q73Oq4/J2Qtei9X9JEaF+9XebhGj
 bYNm6PCZHgFunkpiAT2GFNk66Lpj8iH5fDx7a1rJQ11S4CpG0KkDKsqfUWb32qrx6RIh JA== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 3abr0u0e2c-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 10 Aug 2021 10:38:06 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Tue, 10 Aug
 2021 16:38:04 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.12 via Frontend
 Transport; Tue, 10 Aug 2021 16:38:04 +0100
Received: from AUSNPC0LSNW1-debian.cirrus.com (AUSNPC0LSNW1.ad.cirrus.com [198.61.64.221])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 1E45B2A9;
        Tue, 10 Aug 2021 15:38:04 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 06/12] ASoC: cs42l42: Mark OSC_SWITCH_STATUS register volatile
Date:   Tue, 10 Aug 2021 16:37:53 +0100
Message-ID: <20210810153759.24333-7-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210810153759.24333-1-rf@opensource.cirrus.com>
References: <20210810153759.24333-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 7h1Q2ZWa94_mQXPP-BlUn6CXShQJxKxu
X-Proofpoint-GUID: 7h1Q2ZWa94_mQXPP-BlUn6CXShQJxKxu
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 clxscore=1015 priorityscore=1501 adultscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108100099
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

OSC_SWITCH_STATUS is a volatile register indicating the current state
of the clock switch logic.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/soc/codecs/cs42l42.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/cs42l42.c b/sound/soc/codecs/cs42l42.c
index 14fd70c56891..dd677055a3c1 100644
--- a/sound/soc/codecs/cs42l42.c
+++ b/sound/soc/codecs/cs42l42.c
@@ -351,6 +351,7 @@ static bool cs42l42_volatile_register(struct device *dev, unsigned int reg)
 	case CS42L42_DEVID_CD:
 	case CS42L42_DEVID_E:
 	case CS42L42_MCLK_STATUS:
+	case CS42L42_OSC_SWITCH_STATUS:
 	case CS42L42_TRSENSE_STATUS:
 	case CS42L42_HS_DET_STATUS:
 	case CS42L42_ADC_OVFL_STATUS:
-- 
2.11.0

