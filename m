Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C7413E9813
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 20:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231675AbhHKS60 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 14:58:26 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:28416 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231376AbhHKS6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 14:58:11 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 17BIq9wm001296;
        Wed, 11 Aug 2021 13:57:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=5jnB3URc/lqQB/u4LImc/OnsziVGgIt9tqrDvrD8PTQ=;
 b=jRVxxu/IwtVgyGk7Uz+HEts4CqN4DqlDnxEEVxO4akjpugD2iWFx1yB3B+PpZxMl8WEI
 du4W1ZfNxBALDiOMH4vwlIRaEr/t+rRU1eGb10Zzzu9CI9+1kG6OuKevpad4xD5/Tsbs
 0LUwPxsqGmWZza+5sWfVV6YN2YmxkFdD+qVA4DKVBXz4/8sqqGU10rwo9cJOnNENI/qL
 a0c7vdHjV68JPu428XHjMcY3elLoW8mL++PTSFkdcdIZLMVfhFYN4A2f7wzR5UtBgkDn
 bc4uGwBmdE4ijWuLYCNSAr0bmOVY+t7REZhBHje4QwI/xP/+e2tgIbFdxtQIROG0CUfW QA== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 3acgjkra4r-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 11 Aug 2021 13:57:32 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Wed, 11 Aug
 2021 19:57:27 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.12 via Frontend
 Transport; Wed, 11 Aug 2021 19:57:27 +0100
Received: from vitaly-Inspiron-5415.ad.cirrus.com (unknown [198.90.238.180])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id CCF612A9;
        Wed, 11 Aug 2021 18:57:26 +0000 (UTC)
From:   Vitaly Rodionov <vitalyr@opensource.cirrus.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH v4 05/27] ALSA: hda/cs8409: Reduce HS pops/clicks for Cyborg
Date:   Wed, 11 Aug 2021 19:56:32 +0100
Message-ID: <20210811185654.6837-6-vitalyr@opensource.cirrus.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210811185654.6837-1-vitalyr@opensource.cirrus.com>
References: <20210811185654.6837-1-vitalyr@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: QXeWisXNXaUnP83EYetlcGOWjE9GKdF2
X-Proofpoint-ORIG-GUID: QXeWisXNXaUnP83EYetlcGOWjE9GKdF2
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 impostorscore=0
 mlxlogscore=933 suspectscore=0 phishscore=0 adultscore=0 mlxscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108110130
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

Changes in v2:
- No changes

Changes in v3:
- No changes

Changes in v4:
- No changes

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

