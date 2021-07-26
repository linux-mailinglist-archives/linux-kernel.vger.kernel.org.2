Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C4553D664E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 20:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231965AbhGZRXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 13:23:17 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:7126 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232935AbhGZRWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 13:22:55 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 16Q2DYd9012545;
        Mon, 26 Jul 2021 13:03:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=F80RpzeJeS7KPtF4JW66rFbC/r+Vn/lgQDSKYOpYAy8=;
 b=AOHoyuuzVExKn69AO24Wh7T1mjwj0TI7z2uh23KJuCK7pH8XXtPX4gHEveHUXvLfIdWa
 +6cva2uDvYdcjGhqILXxAFamfxY4LVMTzOFssGiRlNdBRtdbWgCQ5fdliov7vJCcfrm6
 r0HdCgwmZIeeGkV5exMmzA3xOetWjezEPw1KtT0IJhUdosX6LqmtHlkqBPy8oObUrbOL
 YfEXQ3AwcNLWky1kJEE1KHGsLSkJFAVclj4D/+PbFJgnNfUHhVAn2oy7prJQiJbSNfKP
 etc7WiFQdPTR07PStKktG2v4dczGsEVPVwI83EayETO6ghTNCbospppFqcHDzdnhQxTs qA== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 3a17cvhhau-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 26 Jul 2021 13:03:10 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 26 Jul
 2021 18:47:07 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Mon, 26 Jul 2021 18:47:07 +0100
Received: from vitaly-Inspiron-5415.ad.cirrus.com (unknown [198.90.238.32])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id A401C2BA;
        Mon, 26 Jul 2021 17:47:07 +0000 (UTC)
From:   Vitaly Rodionov <vitalyr@opensource.cirrus.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>,
        Lucas Tanure <tanureal@opensource.cirrus.com>
Subject: [PATCH 14/27] ALSA: hda/cs8409: Avoid setting the same I2C address for every access
Date:   Mon, 26 Jul 2021 18:46:27 +0100
Message-ID: <20210726174640.6390-15-vitalyr@opensource.cirrus.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210726174640.6390-1-vitalyr@opensource.cirrus.com>
References: <20210726174640.6390-1-vitalyr@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: keJGBBqOOWKzrkn2D2qf6z9XajuVgR-f
X-Proofpoint-ORIG-GUID: keJGBBqOOWKzrkn2D2qf6z9XajuVgR-f
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 priorityscore=1501
 malwarescore=0 bulkscore=0 adultscore=0 impostorscore=0 mlxlogscore=994
 spamscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107260105
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lucas Tanure <tanureal@opensource.cirrus.com>

Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
---
 sound/pci/hda/patch_cs8409.c | 19 +++++++++++++++++--
 sound/pci/hda/patch_cs8409.h |  1 +
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/patch_cs8409.c b/sound/pci/hda/patch_cs8409.c
index 335bcdc69106..474b6750e9b4 100644
--- a/sound/pci/hda/patch_cs8409.c
+++ b/sound/pci/hda/patch_cs8409.c
@@ -128,6 +128,21 @@ static int cs8409_i2c_wait_complete(struct hda_codec *codec)
 	return -1;
 }
 
+/**
+ * cs8409_set_i2c_dev_addr - Set i2c address for transaction
+ * @codec: the codec instance
+ * @addr: I2C Address
+ */
+static void cs8409_set_i2c_dev_addr(struct hda_codec *codec, unsigned int addr)
+{
+	struct cs8409_spec *spec = codec->spec;
+
+	if (spec->dev_addr != addr) {
+		cs8409_vendor_coef_set(codec, CS8409_I2C_ADDR, addr);
+		spec->dev_addr = addr;
+	}
+}
+
 /**
  * cs8409_i2c_read - CS8409 I2C Read.
  * @codec: the codec instance
@@ -149,7 +164,7 @@ static int cs8409_i2c_read(struct hda_codec *codec, unsigned int i2c_address, un
 		return -EPERM;
 
 	cs8409_enable_i2c_clock(codec);
-	cs8409_vendor_coef_set(codec, CS8409_I2C_ADDR, i2c_address);
+	cs8409_set_i2c_dev_addr(codec, i2c_address);
 
 	if (paged) {
 		cs8409_vendor_coef_set(codec, CS8409_I2C_QWRITE, i2c_reg >> 8);
@@ -195,7 +210,7 @@ static int cs8409_i2c_write(struct hda_codec *codec, unsigned int i2c_address, u
 		return -EPERM;
 
 	cs8409_enable_i2c_clock(codec);
-	cs8409_vendor_coef_set(codec, CS8409_I2C_ADDR, i2c_address);
+	cs8409_set_i2c_dev_addr(codec, i2c_address);
 
 	if (paged) {
 		cs8409_vendor_coef_set(codec, CS8409_I2C_QWRITE, i2c_reg >> 8);
diff --git a/sound/pci/hda/patch_cs8409.h b/sound/pci/hda/patch_cs8409.h
index 542582c213d2..c2c208218e34 100644
--- a/sound/pci/hda/patch_cs8409.h
+++ b/sound/pci/hda/patch_cs8409.h
@@ -281,6 +281,7 @@ struct cs8409_spec {
 
 	struct mutex cs8409_i2c_mux;
 	unsigned int i2c_clck_enabled;
+	unsigned int dev_addr;
 	struct delayed_work i2c_clk_work;
 
 	/* verb exec op override */
-- 
2.25.1

