Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F36E3E9816
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 20:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231686AbhHKS6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 14:58:34 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:11230 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231366AbhHKS6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 14:58:11 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 17BIq9wn001296;
        Wed, 11 Aug 2021 13:57:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=xfa2OwnEbVFut/pIa+Pgnjs+ro+nCNRCTpvPrEKonw0=;
 b=Qwq1Sd5Kn1JO2A1jpvQPFr+WYondFd5QtnQu+hf7wWrm/TkDW3gQtVZoYxyCyS1fF4ww
 AnpyWj8ph1gnj0TpTbGaYy8QYaEWBPyO6gMsqUjmPOHdF7FZhz4y7G7yYGCaWPkQfuKJ
 GoF2o3/6AItTYZxxbXzRYyrxZ5K/yfeYUmYvXwrB7ZpuRXNlF40VF2hNXSjA5tiYOCFD
 eUH48OwwaUsHLDR4tIhXDB2/ajLhPUucw9HI5iqjeOxQJVaOPuRCJGwg8YbJRYS4LtPk
 JoJ0i2CshlIsC3srrJoyxz+X5OK6WKZAojDXmc1kmrxjRsWuxhhmfcFXtFkaKvoI+Aqy lA== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 3acgjkra4r-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 11 Aug 2021 13:57:32 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Wed, 11 Aug
 2021 19:57:28 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.12 via Frontend
 Transport; Wed, 11 Aug 2021 19:57:28 +0100
Received: from vitaly-Inspiron-5415.ad.cirrus.com (unknown [198.90.238.180])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 3C05945D;
        Wed, 11 Aug 2021 18:57:28 +0000 (UTC)
From:   Vitaly Rodionov <vitalyr@opensource.cirrus.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH v4 10/27] ALSA: hda/cs8409: Simplify CS42L42 jack detect.
Date:   Wed, 11 Aug 2021 19:56:37 +0100
Message-ID: <20210811185654.6837-11-vitalyr@opensource.cirrus.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210811185654.6837-1-vitalyr@opensource.cirrus.com>
References: <20210811185654.6837-1-vitalyr@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: Z5XOP0KlYAmBuWC9Y7qPYm_aEglonpyG
X-Proofpoint-ORIG-GUID: Z5XOP0KlYAmBuWC9Y7qPYm_aEglonpyG
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 impostorscore=0
 mlxlogscore=816 suspectscore=0 phishscore=0 adultscore=0 mlxscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108110130
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Binding <sbinding@opensource.cirrus.com>

Cleanup interrupt masks.
Remove unnecessary read/writes.
Ensure Tip Sense/Type Detection interrupts are enabled/disabled
when needed.

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
---

Changes in v2:
- No changes

Changes in v3:
- No changes

Changes in v4:
- No changes

 sound/pci/hda/patch_cs8409.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/sound/pci/hda/patch_cs8409.c b/sound/pci/hda/patch_cs8409.c
index f4401c1e8572..4ad832f5c4ba 100644
--- a/sound/pci/hda/patch_cs8409.c
+++ b/sound/pci/hda/patch_cs8409.c
@@ -406,10 +406,8 @@ static void cs8409_cs42l42_enable_jack_detect(struct hda_codec *codec)
 	cs8409_i2c_write(codec, CS42L42_I2C_ADDR, 0x1b71, 0x00C0, 1);
 	/* Clear interrupts status */
 	cs8409_i2c_read(codec, CS42L42_I2C_ADDR, 0x130f, 1);
-	cs8409_i2c_read(codec, CS42L42_I2C_ADDR, 0x1b7b, 1);
 	/* Enable interrupt */
-	cs8409_i2c_write(codec, CS42L42_I2C_ADDR, 0x1320, 0x03, 1);
-	cs8409_i2c_write(codec, CS42L42_I2C_ADDR, 0x1b79, 0x00, 1);
+	cs8409_i2c_write(codec, CS42L42_I2C_ADDR, 0x1320, 0xF3, 1);
 
 	mutex_unlock(&spec->cs8409_i2c_mux);
 }
@@ -424,11 +422,13 @@ static void cs8409_cs42l42_run_jack_detect(struct hda_codec *codec)
 	/* Clear interrupts */
 	cs8409_i2c_read(codec, CS42L42_I2C_ADDR, 0x1308, 1);
 	cs8409_i2c_read(codec, CS42L42_I2C_ADDR, 0x1b77, 1);
+	cs8409_i2c_write(codec, CS42L42_I2C_ADDR, 0x1320, 0xFF, 1);
+	cs8409_i2c_read(codec, CS42L42_I2C_ADDR, 0x130f, 1);
 
 	cs8409_i2c_write(codec, CS42L42_I2C_ADDR, 0x1102, 0x87, 1);
 	cs8409_i2c_write(codec, CS42L42_I2C_ADDR, 0x1f06, 0x86, 1);
 	cs8409_i2c_write(codec, CS42L42_I2C_ADDR, 0x1b74, 0x07, 1);
-	cs8409_i2c_write(codec, CS42L42_I2C_ADDR, 0x131b, 0x01, 1);
+	cs8409_i2c_write(codec, CS42L42_I2C_ADDR, 0x131b, 0xFD, 1);
 	cs8409_i2c_write(codec, CS42L42_I2C_ADDR, 0x1120, 0x80, 1);
 	/* Wait ~110ms*/
 	usleep_range(110000, 200000);
@@ -487,9 +487,6 @@ static void cs8409_jack_unsol_event(struct hda_codec *codec, unsigned int res)
 	reg_hs_status = cs8409_i2c_read(codec, CS42L42_I2C_ADDR, 0x1124, 1);
 	reg_ts_status = cs8409_i2c_read(codec, CS42L42_I2C_ADDR, 0x130f, 1);
 
-	/* Clear interrupts, by reading interrupt status registers */
-	cs8409_i2c_read(codec, CS42L42_I2C_ADDR, 0x1b7b, 1);
-
 	mutex_unlock(&spec->cs8409_i2c_mux);
 
 	/* If status values are < 0, read error has occurred. */
@@ -499,6 +496,11 @@ static void cs8409_jack_unsol_event(struct hda_codec *codec, unsigned int res)
 	/* HSDET_AUTO_DONE */
 	if (reg_cdc_status & CS42L42_HSDET_AUTO_DONE) {
 
+		mutex_lock(&spec->cs8409_i2c_mux);
+		/* Disable HSDET_AUTO_DONE */
+		cs8409_i2c_write(codec, CS42L42_I2C_ADDR, 0x131b, 0xFF, 1);
+		mutex_unlock(&spec->cs8409_i2c_mux);
+
 		type = ((reg_hs_status & CS42L42_HSTYPE_MASK) + 1);
 		/* CS42L42 reports optical jack as type 4
 		 * We don't handle optical jack
@@ -521,6 +523,11 @@ static void cs8409_jack_unsol_event(struct hda_codec *codec, unsigned int res)
 			}
 		}
 
+		mutex_lock(&spec->cs8409_i2c_mux);
+		/* Re-Enable Tip Sense Interrupt */
+		cs8409_i2c_write(codec, CS42L42_I2C_ADDR, 0x1320, 0xF3, 1);
+		mutex_unlock(&spec->cs8409_i2c_mux);
+
 	} else {
 		/* TIP_SENSE INSERT/REMOVE */
 		switch (reg_ts_status) {
-- 
2.25.1

