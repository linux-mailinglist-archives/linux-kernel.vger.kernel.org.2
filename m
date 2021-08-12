Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDCEC3EAA48
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 20:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233866AbhHLSgS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 14:36:18 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:27940 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233760AbhHLSgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 14:36:17 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 17CG4uIo006578;
        Thu, 12 Aug 2021 13:35:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=2qaNU/9SbdAwPAbu1s3M/VnkPHYwhQu8hZp0xILVN2M=;
 b=N9q1WjNXGMbN29PtmnKP7DVSHdobxG0Wr8SK/yu399Z/7TM9/VE6fyWCSe0OzhzyZ02g
 lx8vkqtpd5WOC+6itJmtKXv/9ydJi+rNG+C7VTrmH6gKC09kXayFAxJecrjqmsmL3TZw
 m9qBKKAdL1jgQKpfsmCTXnFao6D1bZXeHeUabwvMoI94sGD1Wxq1JH/V6C1pTMmBWtq/
 ftaC0LZh5zZy8YI9BfGN7LRp4NoYdt7VyedQGe5DXtasq0i6r33jIdSujp/mg0dc1F0B
 VwQvyYjNp+oeQg313RzGGPD6bguHFiyPoP8+j6yYKY3Sb5xS48WjVbZJufUjAlCioqS5 Sw== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 3ad6urg6vc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 12 Aug 2021 13:35:06 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Thu, 12 Aug
 2021 19:35:04 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.12 via Frontend
 Transport; Thu, 12 Aug 2021 19:35:04 +0100
Received: from vitaly-Inspiron-5415.ad.cirrus.com (unknown [198.90.238.180])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 958EA45D;
        Thu, 12 Aug 2021 18:35:04 +0000 (UTC)
From:   Vitaly Rodionov <vitalyr@opensource.cirrus.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH 1/2] ALSA: hda/cs8409: Prevent pops and clicks during suspend
Date:   Thu, 12 Aug 2021 19:34:32 +0100
Message-ID: <20210812183433.6330-1-vitalyr@opensource.cirrus.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: zMKMBwW3dRiq2f0298hxpr9cRXiDEW5X
X-Proofpoint-GUID: zMKMBwW3dRiq2f0298hxpr9cRXiDEW5X
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 priorityscore=1501
 malwarescore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0
 mlxlogscore=999 clxscore=1015 phishscore=0 adultscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108120120
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Binding <sbinding@opensource.cirrus.com>

Some of the register values set for type detection cause pops during suspend,
ensure these are cleaned up after type detection completes, as well
ensuring that these are cleared when we suspend.

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
---
 sound/pci/hda/patch_cs8409.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/pci/hda/patch_cs8409.c b/sound/pci/hda/patch_cs8409.c
index 272497b6cfcb..9db16b6292f4 100644
--- a/sound/pci/hda/patch_cs8409.c
+++ b/sound/pci/hda/patch_cs8409.c
@@ -708,6 +708,10 @@ static int cs42l42_jack_unsol_event(struct sub_codec *cs42l42)
 				cs42l42->mic_jack_in = 1;
 			}
 		}
+		/* Configure the HSDET mode. */
+		cs8409_i2c_write(cs42l42, 0x1120, 0x80);
+		/* Enable the HPOUT ground clamp and configure the HP pull-down */
+		cs8409_i2c_write(cs42l42, 0x1F06, 0x02);
 		/* Re-Enable Tip Sense Interrupt */
 		cs8409_i2c_write(cs42l42, 0x1320, 0xF3);
 	} else {
@@ -756,6 +760,8 @@ static void cs42l42_suspend(struct sub_codec *cs42l42)
 	unsigned int gpio_data;
 	int reg_cdc_status = 0;
 	const struct cs8409_i2c_param cs42l42_pwr_down_seq[] = {
+		{ 0x1F06, 0x02 },
+		{ 0x1129, 0x00 },
 		{ 0x2301, 0x3F },
 		{ 0x2302, 0x3F },
 		{ 0x2303, 0x3F },
-- 
2.25.1

