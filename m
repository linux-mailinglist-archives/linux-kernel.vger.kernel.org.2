Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17F6A3D8F7B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 15:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236842AbhG1Nrp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 09:47:45 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:44204 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S236667AbhG1No6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 09:44:58 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 16S674iW029982;
        Wed, 28 Jul 2021 08:44:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=eyP6h++2gOwhr+wnC1bIE5FbiFiAdnH3d/gCDZwEA64=;
 b=aRn+OhQZ4NdSdXT7Y0Jl5i9VSd2fiCeQzUZ3F41EHLy9aMfwG1PvgUfPcPKequGwJD7Z
 IQcc2CLeH/Ax4xERLc4f1O0Nn4rHkIXDXy7dRiYks+wxyBQk5vELclhDWWsk8kaxRRsk
 DOKnk4prQ3+desTP5+3ZTlDJgOihA+5bGypghI7sZqkRgr0VenLjFThb7ZBuVlFV7XsT
 Jj9OCjFA8r97VCALNngdtLelz/kypBPd/cHJl5e+qdNBzUQj6y2bD3ids0Ujr12f3vOt
 jYU6mLpXDvDOms5xkXS6wHCKfe4rhuzX/Z+g6WbdqR4MYrPV5S+z83bFNhm0kzHI0u1q bg== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 3a31m2resc-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 28 Jul 2021 08:44:40 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Wed, 28 Jul
 2021 14:44:38 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Wed, 28 Jul 2021 14:44:38 +0100
Received: from vitaly-Inspiron-5415.ad.cirrus.com (unknown [198.90.238.32])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 4116D2BA;
        Wed, 28 Jul 2021 13:44:38 +0000 (UTC)
From:   Vitaly Rodionov <vitalyr@opensource.cirrus.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH v2 26/27] ALSA: hda/cs8409: Follow correct CS42L42 power down sequence for suspend
Date:   Wed, 28 Jul 2021 14:44:07 +0100
Message-ID: <20210728134408.369396-27-vitalyr@opensource.cirrus.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210728134408.369396-1-vitalyr@opensource.cirrus.com>
References: <20210728134408.369396-1-vitalyr@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: ySOGJnZ8qjlEBNnvN1Mpsh9UlcGK744w
X-Proofpoint-ORIG-GUID: ySOGJnZ8qjlEBNnvN1Mpsh9UlcGK744w
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 impostorscore=0
 suspectscore=0 lowpriorityscore=0 mlxlogscore=999 phishscore=0 spamscore=0
 clxscore=1015 mlxscore=0 adultscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2107280077
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Binding <sbinding@opensource.cirrus.com>

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>

Changes in v2:
- No changes

---
 sound/pci/hda/patch_cs8409.c | 23 ++++++++++++++++++++++-
 sound/pci/hda/patch_cs8409.h |  2 ++
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_cs8409.c b/sound/pci/hda/patch_cs8409.c
index 1e48337b782b..0baed8bebfbb 100644
--- a/sound/pci/hda/patch_cs8409.c
+++ b/sound/pci/hda/patch_cs8409.c
@@ -11,6 +11,7 @@
 #include <linux/module.h>
 #include <sound/core.h>
 #include <linux/mutex.h>
+#include <linux/iopoll.h>
 
 #include "patch_cs8409.h"
 
@@ -198,6 +199,7 @@ static int cs8409_i2c_read(struct sub_codec *scodec, unsigned int addr)
 	read_data = cs8409_vendor_coef_get(codec, CS8409_I2C_QREAD);
 
 	mutex_unlock(&spec->i2c_mux);
+
 	return read_data & 0x0ff;
 
 error:
@@ -654,9 +656,28 @@ static void cs42l42_suspend(struct sub_codec *cs42l42)
 {
 	struct hda_codec *codec = cs42l42->codec;
 	unsigned int gpio_data;
+	int reg_cdc_status = 0;
+	const struct cs8409_i2c_param cs42l42_pwr_down_seq[] = {
+		{ 0x2301, 0x3F },
+		{ 0x2302, 0x3F },
+		{ 0x2303, 0x3F },
+		{ 0x2001, 0x0F },
+		{ 0x2A01, 0x00 },
+		{ 0x1207, 0x00 },
+		{ 0x1101, 0xFE },
+		{ 0x1102, 0x8C },
+		{ 0x1101, 0xFF },
+	};
+
+	cs8409_i2c_bulk_write(cs42l42, cs42l42_pwr_down_seq, ARRAY_SIZE(cs42l42_pwr_down_seq));
+
+	if (read_poll_timeout(cs8409_i2c_read, reg_cdc_status,
+			(reg_cdc_status & 0x1), CS42L42_PDN_SLEEP_US, CS42L42_PDN_TIMEOUT_US,
+			true, cs42l42, 0x1308) < 0)
+		codec_warn(codec, "Timeout waiting for PDN_DONE for CS42L42\n");
 
 	/* Power down CS42L42 ASP/EQ/MIX/HP */
-	cs8409_i2c_write(cs42l42, 0x1101, 0xfe);
+	cs8409_i2c_write(cs42l42, 0x1102, 0x9C);
 	cs42l42->suspended = 1;
 	cs42l42->last_page = 0;
 
diff --git a/sound/pci/hda/patch_cs8409.h b/sound/pci/hda/patch_cs8409.h
index 71dbbd8e2f3b..09987daa9cbf 100644
--- a/sound/pci/hda/patch_cs8409.h
+++ b/sound/pci/hda/patch_cs8409.h
@@ -233,6 +233,8 @@ enum cs8409_coefficient_index_registers {
 #define CS42L42_JACK_REMOVED			(0x00)
 #define CS42L42_I2C_TIMEOUT_US			(20000)
 #define CS42L42_I2C_SLEEP_US			(2000)
+#define CS42L42_PDN_TIMEOUT_US			(250000)
+#define CS42L42_PDN_SLEEP_US			(2000)
 
 /* Dell BULLSEYE / WARLOCK / CYBORG Specific Definitions */
 
-- 
2.25.1

