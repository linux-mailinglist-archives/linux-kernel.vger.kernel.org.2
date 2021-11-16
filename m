Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 161154537C9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 17:39:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234570AbhKPQmK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 11:42:10 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:59508 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234344AbhKPQmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 11:42:08 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1AG9thsm031145;
        Tue, 16 Nov 2021 10:39:06 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=FEUrRir95EdRlOkdHZ8wD6uApb8cU96x+YvCL8fRpZA=;
 b=iSYHDYqZFz8aSm77AzJW6KJIV8vNfTyWP5bIThr0s9DzLeFPNCkKhyYpmcSLhdSGteqj
 0a3m8KCYYoPehGSHIv8/H4ylTSdQpqF8IZW1llb6kUukRvzBQQWvB85v2xYirn/rXC1+
 X3iX5VYoFJo4W6rfoZUxqhla6lVzZsCMXa+Obl3YfOvUZ01H4r8Uqk57upmkx91867oT
 wEQS0N6RxGQXvR/QUuPJyqX5vvqnKQwe2gDooo5Mh+yL3v3Rm02PWioZraGgtYdqj+CV
 BTI9s6+sNdO97600WSvYzoPL422/iWbOPh2d9jjjkgKxPK1PVRShlUyKTc54WYmQ+v4Z Kg== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3cbjn01y8t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 16 Nov 2021 10:39:06 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 16 Nov
 2021 16:39:04 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Tue, 16 Nov 2021 16:39:04 +0000
Received: from AUSNPC0LSNW1-debian.cirrus.com (AUSNPC0LSNW1.ad.cirrus.com [198.61.65.41])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 8DB9D11DC;
        Tue, 16 Nov 2021 16:39:04 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH v2 2/4] ASoC: cs42l42: Remove redundant writes to RS_PLUG/RS_UNPLUG masks
Date:   Tue, 16 Nov 2021 16:38:59 +0000
Message-ID: <20211116163901.45390-3-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211116163901.45390-1-rf@opensource.cirrus.com>
References: <20211116163901.45390-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: q8SaG2eSnDgXBgJbmgGSX12LZx6Qzn4G
X-Proofpoint-ORIG-GUID: q8SaG2eSnDgXBgJbmgGSX12LZx6Qzn4G
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RS_PLUG and RS_UNPLUG interrupt masks are always written as 1 so
those writes are redundant and can be deleted.

This makes it completely clear in the code that only the TS_PLUG and
TS_UNPLUG masks are being changed.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/soc/codecs/cs42l42.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/sound/soc/codecs/cs42l42.c b/sound/soc/codecs/cs42l42.c
index 92bdc3a355ff..3674f73301dc 100644
--- a/sound/soc/codecs/cs42l42.c
+++ b/sound/soc/codecs/cs42l42.c
@@ -1320,12 +1320,8 @@ static void cs42l42_process_hs_type_detect(struct cs42l42_private *cs42l42)
 	/* Unmask tip sense interrupts */
 	regmap_update_bits(cs42l42->regmap,
 		CS42L42_TSRS_PLUG_INT_MASK,
-		CS42L42_RS_PLUG_MASK |
-		CS42L42_RS_UNPLUG_MASK |
 		CS42L42_TS_PLUG_MASK |
 		CS42L42_TS_UNPLUG_MASK,
-		(1 << CS42L42_RS_PLUG_SHIFT) |
-		(1 << CS42L42_RS_UNPLUG_SHIFT) |
 		(0 << CS42L42_TS_PLUG_SHIFT) |
 		(0 << CS42L42_TS_UNPLUG_SHIFT));
 }
@@ -1335,12 +1331,8 @@ static void cs42l42_init_hs_type_detect(struct cs42l42_private *cs42l42)
 	/* Mask tip sense interrupts */
 	regmap_update_bits(cs42l42->regmap,
 				CS42L42_TSRS_PLUG_INT_MASK,
-				CS42L42_RS_PLUG_MASK |
-				CS42L42_RS_UNPLUG_MASK |
 				CS42L42_TS_PLUG_MASK |
 				CS42L42_TS_UNPLUG_MASK,
-				(1 << CS42L42_RS_PLUG_SHIFT) |
-				(1 << CS42L42_RS_UNPLUG_SHIFT) |
 				(1 << CS42L42_TS_PLUG_SHIFT) |
 				(1 << CS42L42_TS_UNPLUG_SHIFT));
 
-- 
2.11.0

