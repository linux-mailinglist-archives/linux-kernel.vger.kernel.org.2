Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82F7233C667
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 20:08:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232993AbhCOTHl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 15:07:41 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:7238 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232555AbhCOTHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 15:07:33 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12FJ65v9021194;
        Mon, 15 Mar 2021 14:07:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=7KBPY2X89s0vTPAt6SMa+ECPtJ75/eiv5q7pLjiQtvs=;
 b=DJVvMjmCkwM3IOS1qkGtFcLmK2Zpldvp3tp1NoQBFBHmwTX6dD9snhA1uu2Srrpe3FS9
 C2gMUt7iuv/Kp5ir8WUH/IAddLRyeaTyOPLw56VumyoMFCohWvsLBeVECYnwr8yMQJkB
 5n9MsGVY98CSOpJDCofB9yryFiIIE5qIrzhY16fv96qd3/b2d2DcZOVOdZHsVqJkHegL
 kSTIeecUQenm3T/TCm8OqOiyGInzdk696o7TZY9+DTe/AY5k4snuy7EOCORr2UnhsNcF
 BhWAIzQIgkNSIhCdHZeJfcTJQXy6Irf6YjXhHiNcN4Aq03pcG1GdiiUu1c7Iu8RRJ4vs cQ== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 378tpv2t0m-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 15 Mar 2021 14:07:20 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Mon, 15 Mar
 2021 19:07:18 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2176.2 via Frontend
 Transport; Mon, 15 Mar 2021 19:07:18 +0000
Received: from vitaly-Inspiron-5415.ad.cirrus.com (unknown [198.90.238.45])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 00B8411CB;
        Mon, 15 Mar 2021 19:07:17 +0000 (UTC)
From:   Vitaly Rodionov <vitalyr@opensource.cirrus.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>,
        Stefan Binding <sbinding@opensource.cirrus.com>,
        You-Sheng Yang <vicamo.yang@canonical.com>
Subject: [PATCH v3 3/4] ALSA: hda/cirrus: Fix CS42L42 Headset Mic volume control name
Date:   Mon, 15 Mar 2021 19:07:15 +0000
Message-ID: <20210315190716.47686-4-vitalyr@opensource.cirrus.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210315190716.47686-1-vitalyr@opensource.cirrus.com>
References: <20210315190716.47686-1-vitalyr@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 malwarescore=0
 priorityscore=1501 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0
 bulkscore=0 phishscore=0 mlxlogscore=999 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103150128
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Binding <sbinding@opensource.cirrus.com>

Existing name "Headset Mic Volume Control" causes multiple Microphone
entries to appear in UI. Using name "Mic Volume Control" ensures only a
single Microphone entry exists when the Headset is connected.

Tested on DELL Inspiron-3505, DELL Inspiron-3501, DELL Inspiron-3500

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
BugLink: https://bugs.launchpad.net/bugs/1918378
Reported-and-tested-by: You-Sheng Yang <vicamo.yang@canonical.com>

Changes in v1:
- No changes

Changes in v2:
- No changes

Changes in v3:
- No changes

---
 sound/pci/hda/patch_cirrus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_cirrus.c b/sound/pci/hda/patch_cirrus.c
index 275bba02cc05..c99ec5e485af 100644
--- a/sound/pci/hda/patch_cirrus.c
+++ b/sound/pci/hda/patch_cirrus.c
@@ -1789,7 +1789,7 @@ static const struct snd_kcontrol_new cs8409_cs42l42_hp_volume_mixer = {
 static const struct snd_kcontrol_new cs8409_cs42l42_amic_volume_mixer = {
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 	.index = 0,
-	.name = "Headset Mic Capture Volume",
+	.name = "Mic Capture Volume",
 	.subdevice = (HDA_SUBDEV_AMP_FLAG | HDA_SUBDEV_NID_FLAG),
 	.access = (SNDRV_CTL_ELEM_ACCESS_READWRITE
 			 | SNDRV_CTL_ELEM_ACCESS_TLV_READ),
-- 
2.25.1

