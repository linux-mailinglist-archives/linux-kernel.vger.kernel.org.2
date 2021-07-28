Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DF603D8F5B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 15:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236706AbhG1NpE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 09:45:04 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:13998 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236345AbhG1Noq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 09:44:46 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 16S5XUqv014335;
        Wed, 28 Jul 2021 08:44:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=Izz3irDLw9ridFa0yxcyJ6oQcr6PnOZtkxVd2bTNjHg=;
 b=C8pYZX7KjY8GGool9Vvx+62uhmpgefc/1o1biSoyEnNZs8TIvvvb3m/iaNdEMXfiPdPM
 zOzriK4BMjjq/5fasTC/cpWTehGMx8UPaOOkQPiCd5eHuD2ePRX65Uu7H98f8YpGlzZ9
 U6tlRZx5bFBpWigIuTV6znLGsnx42RwZn5yGyvLGEIdLoEQNyZMmmwUu/rdrxGQ/ysj0
 ombXh8bTU1mqABKxMCCUnzJYEROlno8JspSYFbAjKUx1qWCqPFmHF8qfhqtzVBQfD2Vf
 0tOfj4T+LeL+P0zTI1k1qCezOUy0g9bOG08lIqet5cDQO+bd9LqgJQWVKfKVekz1589/ ow== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 3a30q20fx9-11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 28 Jul 2021 08:44:39 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Wed, 28 Jul
 2021 14:44:34 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Wed, 28 Jul 2021 14:44:34 +0100
Received: from vitaly-Inspiron-5415.ad.cirrus.com (unknown [198.90.238.32])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 856AF45D;
        Wed, 28 Jul 2021 13:44:34 +0000 (UTC)
From:   Vitaly Rodionov <vitalyr@opensource.cirrus.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>,
        Lucas Tanure <tanureal@opensource.cirrus.com>
Subject: [PATCH v2 15/27] ALSA: hda/cs8409: Avoid re-setting the same page as the last access
Date:   Wed, 28 Jul 2021 14:43:56 +0100
Message-ID: <20210728134408.369396-16-vitalyr@opensource.cirrus.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210728134408.369396-1-vitalyr@opensource.cirrus.com>
References: <20210728134408.369396-1-vitalyr@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 8imKXchv3ZHRFLggP38sUx_7PxIzOdL2
X-Proofpoint-GUID: 8imKXchv3ZHRFLggP38sUx_7PxIzOdL2
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 adultscore=0 clxscore=1015 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2107280077
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lucas Tanure <tanureal@opensource.cirrus.com>

Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>

Changes in v2:
- No changes

---
 sound/pci/hda/patch_cs8409.c | 124 +++++++++++++++++++----------------
 sound/pci/hda/patch_cs8409.h |   2 +
 2 files changed, 71 insertions(+), 55 deletions(-)

diff --git a/sound/pci/hda/patch_cs8409.c b/sound/pci/hda/patch_cs8409.c
index bd43c42d5c74..31c9f1a3aeaa 100644
--- a/sound/pci/hda/patch_cs8409.c
+++ b/sound/pci/hda/patch_cs8409.c
@@ -147,18 +147,37 @@ static void cs8409_set_i2c_dev_addr(struct hda_codec *codec, unsigned int addr)
 	}
 }
 
+/**
+ * cs8409_i2c_set_page - CS8409 I2C set page register.
+ * @codec: the codec instance
+ * @i2c_reg: Page register
+ *
+ * Returns negative on error.
+ */
+static int cs8409_i2c_set_page(struct hda_codec *codec, unsigned int i2c_reg)
+{
+	struct cs8409_spec *spec = codec->spec;
+
+	if (spec->paged && (spec->last_page != (i2c_reg >> 8))) {
+		cs8409_vendor_coef_set(codec, CS8409_I2C_QWRITE, i2c_reg >> 8);
+		if (cs8409_i2c_wait_complete(codec) < 0)
+			return -EIO;
+		spec->last_page = i2c_reg >> 8;
+	}
+
+	return 0;
+}
+
 /**
  * cs8409_i2c_read - CS8409 I2C Read.
  * @codec: the codec instance
  * @i2c_address: I2C Address
  * @i2c_reg: Register to read
- * @paged: Is a paged transaction
  *
  * CS8409 I2C Read.
  * Returns negative on error, otherwise returns read value in bits 0-7.
  */
-static int cs8409_i2c_read(struct hda_codec *codec, unsigned int i2c_address, unsigned int i2c_reg,
-			   unsigned int paged)
+static int cs8409_i2c_read(struct hda_codec *codec, unsigned int i2c_address, unsigned int i2c_reg)
 {
 	struct cs8409_spec *spec = codec->spec;
 	unsigned int i2c_reg_data;
@@ -170,13 +189,10 @@ static int cs8409_i2c_read(struct hda_codec *codec, unsigned int i2c_address, un
 	cs8409_enable_i2c_clock(codec);
 	cs8409_set_i2c_dev_addr(codec, i2c_address);
 
-	if (paged) {
-		cs8409_vendor_coef_set(codec, CS8409_I2C_QWRITE, i2c_reg >> 8);
-		if (cs8409_i2c_wait_complete(codec) < 0) {
-			codec_err(codec, "%s() Paged Transaction Failed 0x%02x : 0x%04x\n",
-				__func__, i2c_address, i2c_reg);
-			return -EIO;
-		}
+	if (cs8409_i2c_set_page(codec, i2c_reg)) {
+		codec_err(codec, "%s() Paged Transaction Failed 0x%02x : 0x%04x\n",
+			__func__, i2c_address, i2c_reg);
+		return -EIO;
 	}
 
 	i2c_reg_data = (i2c_reg << 8) & 0x0ffff;
@@ -199,13 +215,12 @@ static int cs8409_i2c_read(struct hda_codec *codec, unsigned int i2c_address, un
  * @i2c_address: I2C Address
  * @i2c_reg: Register to write to
  * @i2c_data: Data to write
- * @paged: Is a paged transaction
  *
  * CS8409 I2C Write.
  * Returns negative on error, otherwise returns 0.
  */
 static int cs8409_i2c_write(struct hda_codec *codec, unsigned int i2c_address, unsigned int i2c_reg,
-			    unsigned int i2c_data, unsigned int paged)
+			    unsigned int i2c_data)
 {
 	struct cs8409_spec *spec = codec->spec;
 	unsigned int i2c_reg_data;
@@ -216,13 +231,10 @@ static int cs8409_i2c_write(struct hda_codec *codec, unsigned int i2c_address, u
 	cs8409_enable_i2c_clock(codec);
 	cs8409_set_i2c_dev_addr(codec, i2c_address);
 
-	if (paged) {
-		cs8409_vendor_coef_set(codec, CS8409_I2C_QWRITE, i2c_reg >> 8);
-		if (cs8409_i2c_wait_complete(codec) < 0) {
-			codec_err(codec, "%s() Paged Transaction Failed 0x%02x : 0x%04x\n",
-				__func__, i2c_address, i2c_reg);
-			return -EIO;
-		}
+	if (cs8409_i2c_set_page(codec, i2c_reg)) {
+		codec_err(codec, "%s() Paged Transaction Failed 0x%02x : 0x%04x\n",
+			__func__, i2c_address, i2c_reg);
+		return -EIO;
 	}
 
 	i2c_reg_data = ((i2c_reg << 8) & 0x0ff00) | (i2c_data & 0x0ff);
@@ -302,14 +314,14 @@ int cs8409_cs42l42_volume_put(struct snd_kcontrol *kctrl, struct snd_ctl_elem_va
 		if (chs & BIT(0)) {
 			spec->vol[ofs] = *valp;
 			cs8409_i2c_write(codec, CS42L42_I2C_ADDR, CS8409_CS42L42_REG_HS_VOL_CHA,
-					 -(spec->vol[ofs]) & CS8409_CS42L42_REG_HS_VOL_MASK, 1);
+					 -(spec->vol[ofs]) & CS8409_CS42L42_REG_HS_VOL_MASK);
 		}
 		if (chs & BIT(1)) {
 			ofs++;
 			valp++;
 			spec->vol[ofs] = *valp;
 			cs8409_i2c_write(codec, CS42L42_I2C_ADDR, CS8409_CS42L42_REG_HS_VOL_CHB,
-					 -(spec->vol[ofs]) & CS8409_CS42L42_REG_HS_VOL_MASK, 1);
+					 -(spec->vol[ofs]) & CS8409_CS42L42_REG_HS_VOL_MASK);
 		}
 		mutex_unlock(&spec->cs8409_i2c_mux);
 		break;
@@ -318,7 +330,7 @@ int cs8409_cs42l42_volume_put(struct snd_kcontrol *kctrl, struct snd_ctl_elem_va
 		if (chs & BIT(0)) {
 			spec->vol[ofs] = *valp;
 			cs8409_i2c_write(codec, CS42L42_I2C_ADDR, CS8409_CS42L42_REG_AMIC_VOL,
-					 spec->vol[ofs] & CS8409_CS42L42_REG_AMIC_VOL_MASK, 1);
+					 spec->vol[ofs] & CS8409_CS42L42_REG_AMIC_VOL_MASK);
 		}
 		mutex_unlock(&spec->cs8409_i2c_mux);
 		break;
@@ -344,14 +356,15 @@ static void cs8409_cs42l42_reset(struct hda_codec *codec)
 	usleep_range(10000, 15000);
 
 	spec->cs42l42_suspended = 0;
+	spec->last_page = 0;
 
 	mutex_lock(&spec->cs8409_i2c_mux);
 
 	/* Clear interrupts, by reading interrupt status registers */
-	cs8409_i2c_read(codec, CS42L42_I2C_ADDR, 0x1308, 1);
-	cs8409_i2c_read(codec, CS42L42_I2C_ADDR, 0x1309, 1);
-	cs8409_i2c_read(codec, CS42L42_I2C_ADDR, 0x130A, 1);
-	cs8409_i2c_read(codec, CS42L42_I2C_ADDR, 0x130F, 1);
+	cs8409_i2c_read(codec, CS42L42_I2C_ADDR, 0x1308);
+	cs8409_i2c_read(codec, CS42L42_I2C_ADDR, 0x1309);
+	cs8409_i2c_read(codec, CS42L42_I2C_ADDR, 0x130A);
+	cs8409_i2c_read(codec, CS42L42_I2C_ADDR, 0x130F);
 
 	mutex_unlock(&spec->cs8409_i2c_mux);
 
@@ -368,20 +381,20 @@ static void cs8409_cs42l42_enable_jack_detect(struct hda_codec *codec)
 	 * Additionally set HSBIAS_SENSE_EN for some variants.
 	 */
 	if (codec->fixup_id == CS8409_WARLOCK || codec->fixup_id == CS8409_BULLSEYE)
-		cs8409_i2c_write(codec, CS42L42_I2C_ADDR, 0x1b70, 0x0020, 1);
+		cs8409_i2c_write(codec, CS42L42_I2C_ADDR, 0x1b70, 0x0020);
 	else
-		cs8409_i2c_write(codec, CS42L42_I2C_ADDR, 0x1b70, 0x00a0, 1);
+		cs8409_i2c_write(codec, CS42L42_I2C_ADDR, 0x1b70, 0x00a0);
 
 	/* Clear WAKE# */
-	cs8409_i2c_write(codec, CS42L42_I2C_ADDR, 0x1b71, 0x00C1, 1);
+	cs8409_i2c_write(codec, CS42L42_I2C_ADDR, 0x1b71, 0x00C1);
 	/* Wait ~2.5ms */
 	usleep_range(2500, 3000);
 	/* Set mode WAKE# output follows the combination logic directly */
-	cs8409_i2c_write(codec, CS42L42_I2C_ADDR, 0x1b71, 0x00C0, 1);
+	cs8409_i2c_write(codec, CS42L42_I2C_ADDR, 0x1b71, 0x00C0);
 	/* Clear interrupts status */
-	cs8409_i2c_read(codec, CS42L42_I2C_ADDR, 0x130f, 1);
+	cs8409_i2c_read(codec, CS42L42_I2C_ADDR, 0x130f);
 	/* Enable interrupt */
-	cs8409_i2c_write(codec, CS42L42_I2C_ADDR, 0x1320, 0xF3, 1);
+	cs8409_i2c_write(codec, CS42L42_I2C_ADDR, 0x1320, 0xF3);
 
 	mutex_unlock(&spec->cs8409_i2c_mux);
 }
@@ -394,20 +407,20 @@ static void cs8409_cs42l42_run_jack_detect(struct hda_codec *codec)
 	mutex_lock(&spec->cs8409_i2c_mux);
 
 	/* Clear interrupts */
-	cs8409_i2c_read(codec, CS42L42_I2C_ADDR, 0x1308, 1);
-	cs8409_i2c_read(codec, CS42L42_I2C_ADDR, 0x1b77, 1);
-	cs8409_i2c_write(codec, CS42L42_I2C_ADDR, 0x1320, 0xFF, 1);
-	cs8409_i2c_read(codec, CS42L42_I2C_ADDR, 0x130f, 1);
-
-	cs8409_i2c_write(codec, CS42L42_I2C_ADDR, 0x1102, 0x87, 1);
-	cs8409_i2c_write(codec, CS42L42_I2C_ADDR, 0x1f06, 0x86, 1);
-	cs8409_i2c_write(codec, CS42L42_I2C_ADDR, 0x1b74, 0x07, 1);
-	cs8409_i2c_write(codec, CS42L42_I2C_ADDR, 0x131b, 0xFD, 1);
-	cs8409_i2c_write(codec, CS42L42_I2C_ADDR, 0x1120, 0x80, 1);
+	cs8409_i2c_read(codec, CS42L42_I2C_ADDR, 0x1308);
+	cs8409_i2c_read(codec, CS42L42_I2C_ADDR, 0x1b77);
+	cs8409_i2c_write(codec, CS42L42_I2C_ADDR, 0x1320, 0xFF);
+	cs8409_i2c_read(codec, CS42L42_I2C_ADDR, 0x130f);
+
+	cs8409_i2c_write(codec, CS42L42_I2C_ADDR, 0x1102, 0x87);
+	cs8409_i2c_write(codec, CS42L42_I2C_ADDR, 0x1f06, 0x86);
+	cs8409_i2c_write(codec, CS42L42_I2C_ADDR, 0x1b74, 0x07);
+	cs8409_i2c_write(codec, CS42L42_I2C_ADDR, 0x131b, 0xFD);
+	cs8409_i2c_write(codec, CS42L42_I2C_ADDR, 0x1120, 0x80);
 	/* Wait ~110ms*/
 	usleep_range(110000, 200000);
-	cs8409_i2c_write(codec, CS42L42_I2C_ADDR, 0x111f, 0x77, 1);
-	cs8409_i2c_write(codec, CS42L42_I2C_ADDR, 0x1120, 0xc0, 1);
+	cs8409_i2c_write(codec, CS42L42_I2C_ADDR, 0x111f, 0x77);
+	cs8409_i2c_write(codec, CS42L42_I2C_ADDR, 0x1120, 0xc0);
 	/* Wait ~10ms */
 	usleep_range(10000, 25000);
 
@@ -423,7 +436,7 @@ static void cs8409_cs42l42_reg_setup(struct hda_codec *codec)
 	mutex_lock(&spec->cs8409_i2c_mux);
 
 	for (; seq->addr; seq++)
-		cs8409_i2c_write(codec, CS42L42_I2C_ADDR, seq->addr, seq->reg, 1);
+		cs8409_i2c_write(codec, CS42L42_I2C_ADDR, seq->addr, seq->reg);
 
 	mutex_unlock(&spec->cs8409_i2c_mux);
 
@@ -457,9 +470,9 @@ static void cs8409_jack_unsol_event(struct hda_codec *codec, unsigned int res)
 	mutex_lock(&spec->cs8409_i2c_mux);
 
 	/* Read jack detect status registers */
-	reg_cdc_status = cs8409_i2c_read(codec, CS42L42_I2C_ADDR, 0x1308, 1);
-	reg_hs_status = cs8409_i2c_read(codec, CS42L42_I2C_ADDR, 0x1124, 1);
-	reg_ts_status = cs8409_i2c_read(codec, CS42L42_I2C_ADDR, 0x130f, 1);
+	reg_cdc_status = cs8409_i2c_read(codec, CS42L42_I2C_ADDR, 0x1308);
+	reg_hs_status = cs8409_i2c_read(codec, CS42L42_I2C_ADDR, 0x1124);
+	reg_ts_status = cs8409_i2c_read(codec, CS42L42_I2C_ADDR, 0x130f);
 
 	mutex_unlock(&spec->cs8409_i2c_mux);
 
@@ -472,7 +485,7 @@ static void cs8409_jack_unsol_event(struct hda_codec *codec, unsigned int res)
 
 		mutex_lock(&spec->cs8409_i2c_mux);
 		/* Disable HSDET_AUTO_DONE */
-		cs8409_i2c_write(codec, CS42L42_I2C_ADDR, 0x131b, 0xFF, 1);
+		cs8409_i2c_write(codec, CS42L42_I2C_ADDR, 0x131b, 0xFF);
 		mutex_unlock(&spec->cs8409_i2c_mux);
 
 		type = ((reg_hs_status & CS42L42_HSTYPE_MASK) + 1);
@@ -499,7 +512,7 @@ static void cs8409_jack_unsol_event(struct hda_codec *codec, unsigned int res)
 
 		mutex_lock(&spec->cs8409_i2c_mux);
 		/* Re-Enable Tip Sense Interrupt */
-		cs8409_i2c_write(codec, CS42L42_I2C_ADDR, 0x1320, 0xF3, 1);
+		cs8409_i2c_write(codec, CS42L42_I2C_ADDR, 0x1320, 0xF3);
 		mutex_unlock(&spec->cs8409_i2c_mux);
 
 	} else {
@@ -566,7 +579,7 @@ static int cs8409_suspend(struct hda_codec *codec)
 
 	mutex_lock(&spec->cs8409_i2c_mux);
 	/* Power down CS42L42 ASP/EQ/MIX/HP */
-	cs8409_i2c_write(codec, CS42L42_I2C_ADDR, 0x1101, 0xfe, 1);
+	cs8409_i2c_write(codec, CS42L42_I2C_ADDR, 0x1101, 0xfe);
 	mutex_unlock(&spec->cs8409_i2c_mux);
 
 	spec->cs42l42_suspended = 1;
@@ -622,7 +635,7 @@ static void cs8409_cs42l42_hw_init(struct hda_codec *codec)
 	if (codec->fixup_id == CS8409_WARLOCK || codec->fixup_id == CS8409_CYBORG) {
 		/* FULL_SCALE_VOL = 0 for Warlock / Cyborg */
 		mutex_lock(&spec->cs8409_i2c_mux);
-		cs8409_i2c_write(codec, CS42L42_I2C_ADDR, 0x2001, 0x01, 1);
+		cs8409_i2c_write(codec, CS42L42_I2C_ADDR, 0x2001, 0x01);
 		mutex_unlock(&spec->cs8409_i2c_mux);
 		/* DMIC1_MO=00b, DMIC1/2_SR=1 */
 		cs8409_vendor_coef_set(codec, 0x09, 0x0003);
@@ -631,11 +644,11 @@ static void cs8409_cs42l42_hw_init(struct hda_codec *codec)
 	/* Restore Volumes after Resume */
 	mutex_lock(&spec->cs8409_i2c_mux);
 	cs8409_i2c_write(codec, CS42L42_I2C_ADDR, CS8409_CS42L42_REG_HS_VOL_CHA,
-			 -(spec->vol[1]) & CS8409_CS42L42_REG_HS_VOL_MASK, 1);
+			 -(spec->vol[1]) & CS8409_CS42L42_REG_HS_VOL_MASK);
 	cs8409_i2c_write(codec, CS42L42_I2C_ADDR, CS8409_CS42L42_REG_HS_VOL_CHB,
-			 -(spec->vol[2]) & CS8409_CS42L42_REG_HS_VOL_MASK, 1);
+			 -(spec->vol[2]) & CS8409_CS42L42_REG_HS_VOL_MASK);
 	cs8409_i2c_write(codec, CS42L42_I2C_ADDR, CS8409_CS42L42_REG_AMIC_VOL,
-			 spec->vol[0] & CS8409_CS42L42_REG_AMIC_VOL_MASK, 1);
+			 spec->vol[0] & CS8409_CS42L42_REG_AMIC_VOL_MASK);
 	mutex_unlock(&spec->cs8409_i2c_mux);
 
 	cs8409_cs42l42_enable_jack_detect(codec);
@@ -741,6 +754,7 @@ void cs8409_cs42l42_fixups(struct hda_codec *codec, const struct hda_fixup *fix,
 		spec->cs42l42_hp_jack_in = 0;
 		spec->cs42l42_mic_jack_in = 0;
 		spec->cs42l42_suspended = 1;
+		spec->paged = 1;
 
 		/* Basic initial sequence for specific hw configuration */
 		snd_hda_sequence_write(codec, cs8409_cs42l42_init_verbs);
diff --git a/sound/pci/hda/patch_cs8409.h b/sound/pci/hda/patch_cs8409.h
index c2c208218e34..ee66fd0c01dc 100644
--- a/sound/pci/hda/patch_cs8409.h
+++ b/sound/pci/hda/patch_cs8409.h
@@ -283,6 +283,8 @@ struct cs8409_spec {
 	unsigned int i2c_clck_enabled;
 	unsigned int dev_addr;
 	struct delayed_work i2c_clk_work;
+	unsigned int paged;
+	unsigned int last_page;
 
 	/* verb exec op override */
 	int (*exec_verb)(struct hdac_device *dev, unsigned int cmd, unsigned int flags,
-- 
2.25.1

