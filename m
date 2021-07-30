Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB5B3DBC0F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 17:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240001AbhG3PUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 11:20:33 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:39470 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S239752AbhG3PTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 11:19:41 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 16UELBKi004490;
        Fri, 30 Jul 2021 10:19:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=SsFLSnzjZ1fMNZj2qyH1OFSOeebrqaHmwBP+1BvnjNY=;
 b=EJV4U3PTruzcLTUsWDsvX008ZQYstnYQPVy+7on9os29EdSsJ8elUboP+a3nX151QVRp
 ab8ypMcwx3SElgcMblSqobRFI3AEoFSIU+7nxPe1FLcndDn03t6Ya8GuEMW9dUwGUhM9
 jOWEIJvi8p1My4vFgYb9NxApMxgi7Pw9FoQrvEwjPAVZYdjymiRPrIwSLZEb65QSkSu8
 KkgACaq1hN07OxFbT28c3vASkwQkCw8mPHgxukgifFQVmO456WahCUnsQjXFqNMODmM3
 cslZi476e6F3uyrZp98TjJ8x3DZ8AiEDUdGw0PCkdyuaaFfpJul59KgUU3NyyucmBEl5 1Q== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 3a41wd181m-11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 30 Jul 2021 10:19:22 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 30 Jul
 2021 16:19:11 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Fri, 30 Jul 2021 16:19:11 +0100
Received: from vitaly-Inspiron-5415.ad.cirrus.com (unknown [198.90.238.32])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 5A6B32BA;
        Fri, 30 Jul 2021 15:19:11 +0000 (UTC)
From:   Vitaly Rodionov <vitalyr@opensource.cirrus.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH v3 19/27] ALSA: hda/cs8409: Support multiple sub_codecs for Suspend/Resume/Unsol events
Date:   Fri, 30 Jul 2021 16:18:36 +0100
Message-ID: <20210730151844.7873-20-vitalyr@opensource.cirrus.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210730151844.7873-1-vitalyr@opensource.cirrus.com>
References: <20210730151844.7873-1-vitalyr@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: L_3Mi8aOWv7Jp1Bo-vtN2NCpEgxf38c3
X-Proofpoint-ORIG-GUID: L_3Mi8aOWv7Jp1Bo-vtN2NCpEgxf38c3
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 impostorscore=0
 spamscore=0 clxscore=1015 mlxscore=0 mlxlogscore=999 lowpriorityscore=0
 malwarescore=0 phishscore=0 bulkscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2107300102
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Binding <sbinding@opensource.cirrus.com>

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
---

Changes in v2:
- No changes

Changes in v3:
- No changes

 sound/pci/hda/patch_cs8409.c | 41 ++++++++++++++++++++++++------------
 1 file changed, 28 insertions(+), 13 deletions(-)

diff --git a/sound/pci/hda/patch_cs8409.c b/sound/pci/hda/patch_cs8409.c
index 4b4f4dc54617..8b048ff12eb7 100644
--- a/sound/pci/hda/patch_cs8409.c
+++ b/sound/pci/hda/patch_cs8409.c
@@ -375,16 +375,21 @@ static int cs8409_build_controls(struct hda_codec *codec)
 	return 0;
 }
 
-/* Enable/Disable Unsolicited Response for gpio(s) 3,4 */
+/* Enable/Disable Unsolicited Response */
 static void cs8409_enable_ur(struct hda_codec *codec, int flag)
 {
-	/* GPIO4 INT# and GPIO3 WAKE# */
+	struct cs8409_spec *spec = codec->spec;
+	unsigned int ur_gpios = 0;
+	int i;
+
+	for (i = 0; i < spec->num_scodecs; i++)
+		ur_gpios |= spec->scodecs[i]->irq_mask;
+
 	snd_hda_codec_write(codec, CS8409_PIN_AFG, 0, AC_VERB_SET_GPIO_UNSOLICITED_RSP_MASK,
-			    flag ? CS8409_CS42L42_INT : 0);
+			    flag ? ur_gpios : 0);
 
 	snd_hda_codec_write(codec, CS8409_PIN_AFG, 0, AC_VERB_SET_UNSOLICITED_ENABLE,
 			    flag ? AC_UNSOL_ENABLED : 0);
-
 }
 
 static void cs8409_fix_caps(struct hda_codec *codec, unsigned int nid)
@@ -616,6 +621,8 @@ static int cs42l42_jack_unsol_event(struct sub_codec *cs42l42)
 
 static void cs42l42_resume(struct sub_codec *cs42l42)
 {
+	struct hda_codec *codec = cs42l42->codec;
+	unsigned int gpio_data;
 	struct cs8409_i2c_param irq_regs[] = {
 		{ 0x1308, 0x00 },
 		{ 0x1309, 0x00 },
@@ -623,6 +630,12 @@ static void cs42l42_resume(struct sub_codec *cs42l42)
 		{ 0x130F, 0x00 },
 	};
 
+	/* Bring CS42L42 out of Reset */
+	gpio_data = snd_hda_codec_read(codec, CS8409_PIN_AFG, 0, AC_VERB_GET_GPIO_DATA, 0);
+	gpio_data |= cs42l42->reset_gpio;
+	snd_hda_codec_write(codec, CS8409_PIN_AFG, 0, AC_VERB_SET_GPIO_DATA, gpio_data);
+	usleep_range(10000, 15000);
+
 	cs42l42->suspended = 0;
 
 	/* Initialize CS42L42 companion codec */
@@ -648,10 +661,18 @@ static void cs42l42_resume(struct sub_codec *cs42l42)
 #ifdef CONFIG_PM
 static void cs42l42_suspend(struct sub_codec *cs42l42)
 {
+	struct hda_codec *codec = cs42l42->codec;
+	unsigned int gpio_data;
+
 	/* Power down CS42L42 ASP/EQ/MIX/HP */
 	cs8409_i2c_write(cs42l42, 0x1101, 0xfe);
 	cs42l42->suspended = 1;
 	cs42l42->last_page = 0;
+
+	/* Put CS42L42 into Reset */
+	gpio_data = snd_hda_codec_read(codec, CS8409_PIN_AFG, 0, AC_VERB_GET_GPIO_DATA, 0);
+	gpio_data &= ~cs42l42->reset_gpio;
+	snd_hda_codec_write(codec, CS8409_PIN_AFG, 0, AC_VERB_SET_GPIO_DATA, gpio_data);
 }
 #endif
 
@@ -710,13 +731,12 @@ static void cs8409_cs42l42_jack_unsol_event(struct hda_codec *codec, unsigned in
 static int cs8409_cs42l42_suspend(struct hda_codec *codec)
 {
 	struct cs8409_spec *spec = codec->spec;
+	int i;
 
 	cs8409_enable_ur(codec, 0);
 
-	cs42l42_suspend(spec->scodecs[CS8409_CODEC0]);
-
-	/* Assert CS42L42 RTS# line */
-	snd_hda_codec_write(codec, CS8409_PIN_AFG, 0, AC_VERB_SET_GPIO_DATA, 0);
+	for (i = 0; i < spec->num_scodecs; i++)
+		cs42l42_suspend(spec->scodecs[i]);
 
 	snd_hda_shutup_pins(codec);
 
@@ -755,11 +775,6 @@ static void cs8409_cs42l42_hw_init(struct hda_codec *codec)
 	if (codec->fixup_id == CS8409_WARLOCK || codec->fixup_id == CS8409_CYBORG)
 		cs8409_vendor_coef_set(codec, 0x09, 0x0003);
 
-	/* Release RTS# line */
-	snd_hda_codec_write(codec, CS8409_PIN_AFG, 0, AC_VERB_SET_GPIO_DATA, CS8409_CS42L42_RESET);
-	/* wait ~10ms */
-	usleep_range(10000, 15000);
-
 	cs42l42_resume(cs42l42);
 
 	/* Enable Unsolicited Response */
-- 
2.25.1

