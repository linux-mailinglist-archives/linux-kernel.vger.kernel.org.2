Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23D803D8C1A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 12:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235977AbhG1KpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 06:45:16 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:28978 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232736AbhG1KpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 06:45:14 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 16S9sqNC011869;
        Wed, 28 Jul 2021 05:44:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=GB3EbKE7hKlhl0c2XPYMf5voKtRwqX6e5b211MdPeTA=;
 b=j6c37jIz1+6BHc8bSMeBumHGuHSb1OjnQcLV8WwtAq3XfIwwsQfBRKgyNAavTlwWPZcw
 dvjfAqvZRoiEWS5dbZn3X+k4KH5Kr/wf/iopNVCmg7tj2TdGyD481kYhYrMDC3vxpn42
 S0vcuBVcL4gfRb9dwk5p9Zoxr6v4Dl4Z06Wk+Er8P5rJMXXpYdOREvSDyZyV0y0H1qgG
 8d4vdGWijUqQ11sVlKh7lexK5jGWwudhX/v9vTee7keMnQwW2M/M/CsccOSZmBNO6bNn
 LCRhBcqsAWrK2ADO67fPIP+bcIA4rYDy71OdCco+NuKk5V2ZwxnCuyNqgatfI/0czttd xQ== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 3a31m2r8mc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 28 Jul 2021 05:44:21 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Wed, 28 Jul
 2021 11:44:19 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Wed, 28 Jul 2021 11:44:19 +0100
Received: from aryzen.ad.cirrus.com (unknown [198.61.64.62])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 2E9B12BA;
        Wed, 28 Jul 2021 10:44:18 +0000 (UTC)
From:   Lucas Tanure <tanureal@opensource.cirrus.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "Charles Keepax" <ckeepax@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
CC:     Simon Trimmer <simont@opensource.cirrus.com>,
        James Schulman <james.schulman@cirrus.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Adam Brickman <Adam.Brickman@cirrus.com>,
        <patches@opensource.cirrus.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>,
        Lucas Tanure <tanureal@opensource.cirrus.com>
Subject: [PATCH] ASoC: wm_adsp: Let soc_cleanup_component_debugfs remove debugfs
Date:   Wed, 28 Jul 2021 11:44:16 +0100
Message-ID: <20210728104416.636591-1-tanureal@opensource.cirrus.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: q0AXOg9GFU2JVE_0alP0nzsjk3G96kY-
X-Proofpoint-ORIG-GUID: q0AXOg9GFU2JVE_0alP0nzsjk3G96kY-
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 impostorscore=0
 suspectscore=0 lowpriorityscore=0 mlxlogscore=891 phishscore=0 spamscore=0
 clxscore=1011 mlxscore=0 adultscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2107280059
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

soc_cleanup_component_debugfs will debugfs_remove_recursive
the component->debugfs_root, so adsp doesn't need to also
remove the same entry.
By doing that adsp also creates a race with core component,
which causes a NULL pointer dereference

Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
---
 sound/soc/codecs/wm_adsp.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index b395df1eb72d..bbe27ab3b1fc 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -747,7 +747,6 @@ static void wm_adsp2_init_debugfs(struct wm_adsp *dsp,
 static void wm_adsp2_cleanup_debugfs(struct wm_adsp *dsp)
 {
 	wm_adsp_debugfs_clear(dsp);
-	debugfs_remove_recursive(dsp->debugfs_root);
 }
 #else
 static inline void wm_adsp2_init_debugfs(struct wm_adsp *dsp,
-- 
2.32.0

