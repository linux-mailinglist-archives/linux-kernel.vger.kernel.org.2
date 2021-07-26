Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 761923D664F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 20:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233425AbhGZRXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 13:23:19 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:1604 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232938AbhGZRWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 13:22:55 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 16Q2DYdA012545;
        Mon, 26 Jul 2021 13:03:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=FrGl83a9s6FxANcnPVQFiNoOWy5wfmpk2pTp9xtoQtA=;
 b=gt8HXBZKGFPvRyhpHgItp2bhGcgXeJFrVis1QwPiOakLND9k2XlsulcoV4sI/xZOcnng
 wLTr/YGXCUuy0W2nAHo0O/bZ+mUossrWMAl9tfl+sGBkCQoeLpdMs+I+KcV5G0hBSaK3
 L0NVFaCEyQzFYTrN5fe5KD/LZg/vrVG+8Y7yjH+ZItUhBoZoxaWGUfdn5AHD5+oBS4N9
 Xs+ItiUvwtD1i/PC26wDdUCvnLxRUH4ZDSrbZaBqwfwMHzyl92dkmxP2KRjL1klBpRY0
 R0+uydKWQoBD4skqYo+1qBxkmUFP7OZD2QY1c1fKF1x0yo4W3y3KyFirXOpx5FlQHXm6 nA== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 3a17cvhhav-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 26 Jul 2021 13:03:10 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 26 Jul
 2021 18:47:07 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Mon, 26 Jul 2021 18:47:07 +0100
Received: from vitaly-Inspiron-5415.ad.cirrus.com (unknown [198.90.238.32])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 389C445D;
        Mon, 26 Jul 2021 17:47:07 +0000 (UTC)
From:   Vitaly Rodionov <vitalyr@opensource.cirrus.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>,
        Lucas Tanure <tanureal@opensource.cirrus.com>
Subject: [PATCH 13/27] ALSA: hda/cs8409: Dont disable I2C clock between consecutive accesses
Date:   Mon, 26 Jul 2021 18:46:26 +0100
Message-ID: <20210726174640.6390-14-vitalyr@opensource.cirrus.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210726174640.6390-1-vitalyr@opensource.cirrus.com>
References: <20210726174640.6390-1-vitalyr@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: ovwDrrrKIeAWA2ZMoiKC7T9DC7gymhXe
X-Proofpoint-ORIG-GUID: ovwDrrrKIeAWA2ZMoiKC7T9DC7gymhXe
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 priorityscore=1501
 malwarescore=0 bulkscore=0 adultscore=0 impostorscore=0 mlxlogscore=999
 spamscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107260105
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lucas Tanure <tanureal@opensource.cirrus.com>

Only disable I2C clock 25 ms after not being used

Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
---
 sound/pci/hda/patch_cs8409.c | 42 +++++++++++++++++++++++-------------
 sound/pci/hda/patch_cs8409.h |  4 ++++
 2 files changed, 31 insertions(+), 15 deletions(-)

diff --git a/sound/pci/hda/patch_cs8409.c b/sound/pci/hda/patch_cs8409.c
index 08205c19698c..335bcdc69106 100644
--- a/sound/pci/hda/patch_cs8409.c
+++ b/sound/pci/hda/patch_cs8409.c
@@ -53,6 +53,7 @@ static struct cs8409_spec *cs8409_alloc_spec(struct hda_codec *codec)
 	if (!spec)
 		return NULL;
 	codec->spec = spec;
+	spec->codec = codec;
 	codec->power_save_node = 1;
 	snd_hda_gen_spec_init(&spec->gen);
 
@@ -72,21 +73,34 @@ static inline void cs8409_vendor_coef_set(struct hda_codec *codec, unsigned int
 	snd_hda_codec_write(codec, CS8409_PIN_VENDOR_WIDGET, 0, AC_VERB_SET_PROC_COEF, coef);
 }
 
-/**
+/*
+ * cs8409_disable_i2c_clock - Worker that disable the I2C Clock after 25ms without use
+ */
+static void cs8409_disable_i2c_clock(struct work_struct *work)
+{
+	struct cs8409_spec *spec = container_of(work, struct cs8409_spec, i2c_clk_work.work);
+
+	cs8409_vendor_coef_set(spec->codec, 0x0,
+			       cs8409_vendor_coef_get(spec->codec, 0x0) & 0xfffffff7);
+	spec->i2c_clck_enabled = 0;
+}
+
+/*
  * cs8409_enable_i2c_clock - Enable I2C clocks
  * @codec: the codec instance
- * @enable: Enable or disable I2C clocks
- *
  * Enable or Disable I2C clocks.
  */
-static void cs8409_enable_i2c_clock(struct hda_codec *codec, unsigned int enable)
+static void cs8409_enable_i2c_clock(struct hda_codec *codec)
 {
-	unsigned int retval;
-	unsigned int newval;
+	struct cs8409_spec *spec = codec->spec;
+
+	cancel_delayed_work_sync(&spec->i2c_clk_work);
 
-	retval = cs8409_vendor_coef_get(codec, 0x0);
-	newval = (enable) ? (retval | 0x8) : (retval & 0xfffffff7);
-	cs8409_vendor_coef_set(codec, 0x0, newval);
+	if (!spec->i2c_clck_enabled) {
+		cs8409_vendor_coef_set(codec, 0x0, cs8409_vendor_coef_get(codec, 0x0) | 0x8);
+		spec->i2c_clck_enabled = 1;
+	}
+	queue_delayed_work(system_power_efficient_wq, &spec->i2c_clk_work, msecs_to_jiffies(25));
 }
 
 /**
@@ -134,7 +148,7 @@ static int cs8409_i2c_read(struct hda_codec *codec, unsigned int i2c_address, un
 	if (spec->cs42l42_suspended)
 		return -EPERM;
 
-	cs8409_enable_i2c_clock(codec, 1);
+	cs8409_enable_i2c_clock(codec);
 	cs8409_vendor_coef_set(codec, CS8409_I2C_ADDR, i2c_address);
 
 	if (paged) {
@@ -157,8 +171,6 @@ static int cs8409_i2c_read(struct hda_codec *codec, unsigned int i2c_address, un
 	/* Register in bits 15-8 and the data in 7-0 */
 	read_data = cs8409_vendor_coef_get(codec, CS8409_I2C_QREAD);
 
-	cs8409_enable_i2c_clock(codec, 0);
-
 	return read_data & 0x0ff;
 }
 
@@ -182,7 +194,7 @@ static int cs8409_i2c_write(struct hda_codec *codec, unsigned int i2c_address, u
 	if (spec->cs42l42_suspended)
 		return -EPERM;
 
-	cs8409_enable_i2c_clock(codec, 1);
+	cs8409_enable_i2c_clock(codec);
 	cs8409_vendor_coef_set(codec, CS8409_I2C_ADDR, i2c_address);
 
 	if (paged) {
@@ -203,8 +215,6 @@ static int cs8409_i2c_write(struct hda_codec *codec, unsigned int i2c_address, u
 		return -EIO;
 	}
 
-	cs8409_enable_i2c_clock(codec, 0);
-
 	return 0;
 }
 
@@ -705,6 +715,8 @@ void cs8409_cs42l42_fixups(struct hda_codec *codec, const struct hda_fixup *fix,
 		spec->cs42l42_mic_jack_in = 0;
 		spec->cs42l42_suspended = 1;
 
+		INIT_DELAYED_WORK(&spec->i2c_clk_work, cs8409_disable_i2c_clock);
+
 		/* Basic initial sequence for specific hw configuration */
 		snd_hda_sequence_write(codec, cs8409_cs42l42_init_verbs);
 
diff --git a/sound/pci/hda/patch_cs8409.h b/sound/pci/hda/patch_cs8409.h
index bf0e8a4cc4cc..542582c213d2 100644
--- a/sound/pci/hda/patch_cs8409.h
+++ b/sound/pci/hda/patch_cs8409.h
@@ -11,6 +11,7 @@
 
 #include <linux/pci.h>
 #include <sound/tlv.h>
+#include <linux/workqueue.h>
 #include <sound/hda_codec.h>
 #include "hda_local.h"
 #include "hda_auto_parser.h"
@@ -267,6 +268,7 @@ struct cs8409_cir_param {
 
 struct cs8409_spec {
 	struct hda_gen_spec gen;
+	struct hda_codec *codec;
 
 	unsigned int gpio_mask;
 	unsigned int gpio_dir;
@@ -278,6 +280,8 @@ struct cs8409_spec {
 	s8 vol[CS42L42_VOLUMES];
 
 	struct mutex cs8409_i2c_mux;
+	unsigned int i2c_clck_enabled;
+	struct delayed_work i2c_clk_work;
 
 	/* verb exec op override */
 	int (*exec_verb)(struct hdac_device *dev, unsigned int cmd, unsigned int flags,
-- 
2.25.1

