Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B58223D663C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 20:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232502AbhGZRV6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 13:21:58 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:38366 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231190AbhGZRVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 13:21:50 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 16Q9Xcmi002242;
        Mon, 26 Jul 2021 13:02:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=QWiHQMVOHBhw0u8c5gA8RvVvl40HiqX2WR4zmrFGUFU=;
 b=e55214fVMYKSGuNHIyuKibKXihzXAe2zY79Gpx1uok1PLcHREQaCGLOZxxH7lEynuMaI
 o/3H1nNF2LbVOlDe+aiM4LRhGrm6tU9Q1Drjwrjm5br8LjZO/N+LoxJLm3WmUQR9DJoW
 z+7QIQ98Y0JQOVGuw/HiOhsL5RFYbQJrChyBQVAF7JCjo4+5qSIKM3oq4yGsfaX9skUD
 yfpo3lOhi+YaFk4Es50bPcyG8Tfwd5xggJvGwDhIj9b4GuJx/4ATveys5jw0AA/Yi+tc
 tyFfDn5Gs+92NSwkk7pgdEUXrmeh7QF7/AmxDVPtgp2L+hHPQlXIfU3z+q0rP4aNYtqB nA== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 3a1th2rgps-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 26 Jul 2021 13:02:04 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 26 Jul
 2021 18:47:01 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Mon, 26 Jul 2021 18:47:01 +0100
Received: from vitaly-Inspiron-5415.ad.cirrus.com (unknown [198.90.238.32])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id A2F0D46E;
        Mon, 26 Jul 2021 17:47:00 +0000 (UTC)
From:   Vitaly Rodionov <vitalyr@opensource.cirrus.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH 05/27] ALSA: hda/cs8409: Reduce HS pops/clicks for Cyborg
Date:   Mon, 26 Jul 2021 18:46:18 +0100
Message-ID: <20210726174640.6390-6-vitalyr@opensource.cirrus.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210726174640.6390-1-vitalyr@opensource.cirrus.com>
References: <20210726174640.6390-1-vitalyr@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 1s65iEfK6BD5jQaGg6HGKQAcfCF7r4kB
X-Proofpoint-GUID: 1s65iEfK6BD5jQaGg6HGKQAcfCF7r4kB
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 clxscore=1015
 suspectscore=0 impostorscore=0 mlxlogscore=955 lowpriorityscore=0
 spamscore=0 malwarescore=0 bulkscore=0 phishscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107260105
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Binding <sbinding@opensource.cirrus.com>

Enable HSBIAS_SENSE_EN for Cyborg during jack detect to reduce
pops and clicks.
Do not enable this for Warlock/Bullseye, as it causes ESD issues.

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
---
 sound/pci/hda/patch_cs8409.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/patch_cs8409.c b/sound/pci/hda/patch_cs8409.c
index e4319a0b9cf6..1745f8b188c6 100644
--- a/sound/pci/hda/patch_cs8409.c
+++ b/sound/pci/hda/patch_cs8409.c
@@ -390,8 +390,14 @@ static void cs8409_cs42l42_enable_jack_detect(struct hda_codec *codec)
 
 	mutex_lock(&spec->cs8409_i2c_mux);
 
-	/* Set TIP_SENSE_EN for analog front-end of tip sense. */
-	cs8409_i2c_write(codec, CS42L42_I2C_ADDR, 0x1b70, 0x0020, 1);
+	/* Set TIP_SENSE_EN for analog front-end of tip sense.
+	 * Additionally set HSBIAS_SENSE_EN for some variants.
+	 */
+	if (codec->fixup_id == CS8409_WARLOCK || codec->fixup_id == CS8409_BULLSEYE)
+		cs8409_i2c_write(codec, CS42L42_I2C_ADDR, 0x1b70, 0x0020, 1);
+	else
+		cs8409_i2c_write(codec, CS42L42_I2C_ADDR, 0x1b70, 0x00a0, 1);
+
 	/* Clear WAKE# */
 	cs8409_i2c_write(codec, CS42L42_I2C_ADDR, 0x1b71, 0x0001, 1);
 	/* Wait ~2.5ms */
-- 
2.25.1

