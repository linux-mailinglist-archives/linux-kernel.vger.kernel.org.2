Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF86B396686
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 19:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234794AbhEaRJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 13:09:29 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:16312 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233092AbhEaQzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 12:55:31 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14VGpfL9008565;
        Mon, 31 May 2021 11:52:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=dqTOwjhr7Npem3urBCYYnMAA5DL+HiXM8f0EdwNTHLM=;
 b=Fuul6hxRPT9zkAu6rHtksE/mb0gbb3O52lL2eXfBSIQws2OjZeGcbHfboGlj9epJUjmN
 FBeAQ6FZ+iGEvA0EDwWRTTT957ybkUsxc6/2sbNCkW9fa2g3UzuQdAz6omxsfdiEtehh
 SEDXSKLw7d+rJh6ODSiOHIn4unG7DZ42Pv8W7tTqJStlyTDg3s2AdIn/aQ9nL788NAbJ
 3xhBoM/C6tGpYCcq1onyb3DbrKPaibJ6wq0OKjYwFZraoqctW03qq2m8AbtvZ1BnW1I7
 zgnA1iit2ht9FngvRE9hfRvUmuFW0ArSWpA9lrkyE9fAvP/wTdOGoPUFdeYgtUltgL4i tQ== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 38vv1h0cvr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 31 May 2021 11:52:59 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 31 May
 2021 17:37:54 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Mon, 31 May 2021 17:37:54 +0100
Received: from vitaly-Inspiron-5415.ad.cirrus.com (unknown [198.90.238.140])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id A63202B2;
        Mon, 31 May 2021 16:37:54 +0000 (UTC)
From:   Vitaly Rodionov <vitalyr@opensource.cirrus.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH v1 1/1] ALSA: hda/cirrus: Set Initial DMIC volume to -26 dB
Date:   Mon, 31 May 2021 17:37:54 +0100
Message-ID: <20210531163754.136736-1-vitalyr@opensource.cirrus.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: q9zGe_kq_7CSLQUe56y0KRyUE0--1XqA
X-Proofpoint-GUID: q9zGe_kq_7CSLQUe56y0KRyUE0--1XqA
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 spamscore=0
 suspectscore=0 mlxlogscore=999 clxscore=1015 phishscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105310126
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Binding <sbinding@opensource.cirrus.com>

Previously this fix was applied only to Bullseye variant laptops,
and should be applied to Cyborg and Warlock variants.

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
---
 sound/pci/hda/patch_cirrus.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/sound/pci/hda/patch_cirrus.c b/sound/pci/hda/patch_cirrus.c
index 726507d0b04c..8629e84fef23 100644
--- a/sound/pci/hda/patch_cirrus.c
+++ b/sound/pci/hda/patch_cirrus.c
@@ -2206,10 +2206,9 @@ static void cs8409_cs42l42_fixups(struct hda_codec *codec,
 		break;
 	case HDA_FIXUP_ACT_PROBE:
 
-		/* Set initial volume on Bullseye to -26 dB */
-		if (codec->fixup_id == CS8409_BULLSEYE)
-			snd_hda_codec_amp_init_stereo(codec, CS8409_CS42L42_DMIC_ADC_PIN_NID,
-					HDA_INPUT, 0, 0xff, 0x19);
+		/* Set initial DMIC volume to -26 dB */
+		snd_hda_codec_amp_init_stereo(codec, CS8409_CS42L42_DMIC_ADC_PIN_NID,
+				HDA_INPUT, 0, 0xff, 0x19);
 		snd_hda_gen_add_kctl(&spec->gen,
 			NULL, &cs8409_cs42l42_hp_volume_mixer);
 		snd_hda_gen_add_kctl(&spec->gen,
-- 
2.25.1

