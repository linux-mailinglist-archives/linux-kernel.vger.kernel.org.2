Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26C793D6698
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 20:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232959AbhGZRiY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 13:38:24 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:65462 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232481AbhGZRiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 13:38:00 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 16Q9Xco1002242;
        Mon, 26 Jul 2021 13:18:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=0rNnW8Z4b8XiJwqarrmg5DJkatkHbA93go00Slu2yVM=;
 b=aSlVQfB+x8s6Ow9laZ9l/PsFoMBdj8/5AmVdGBLAAaU1H+JlZyDE5KrXswP919VYMQne
 2wXbvC++I6KByqwvu9eVbboXB4FN56/7o7BnUv4NHLWrCzpsreNyG+myOzKCNmYjz8N8
 LGwjMSZR3M9SH265AWc9h1VOXZcQMgyJ3ijQXe59UDDOItuHrPYTkpkkehdI7z6Xy1fj
 eTVJ6C5fJam1wVciHc/WiOv6yqh3UlL/H3EacwnM6e2c38tPm0oAzMv8E5u2gwQ1xq4v
 3qb5MQxdGFeXe9idUb3yUu/ZZovQFDxxweT8RK6KPtIQqhDUkrKexk5gIySruJoTiO/J NQ== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 3a1th2rhbh-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 26 Jul 2021 13:18:16 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 26 Jul
 2021 18:47:10 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Mon, 26 Jul 2021 18:47:10 +0100
Received: from vitaly-Inspiron-5415.ad.cirrus.com (unknown [198.90.238.32])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id AA7D345D;
        Mon, 26 Jul 2021 17:47:09 +0000 (UTC)
From:   Vitaly Rodionov <vitalyr@opensource.cirrus.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH 19/27] ALSA: hda/cs8409: Support multiple sub_codecs for Suspend/Resume/Unsol events
Date:   Mon, 26 Jul 2021 18:46:32 +0100
Message-ID: <20210726174640.6390-20-vitalyr@opensource.cirrus.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210726174640.6390-1-vitalyr@opensource.cirrus.com>
References: <20210726174640.6390-1-vitalyr@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: TG9mJv4bwLZneN--VwlB1znxOlcxk3qX
X-Proofpoint-GUID: TG9mJv4bwLZneN--VwlB1znxOlcxk3qX
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 clxscore=1015
 suspectscore=0 impostorscore=0 mlxlogscore=999 lowpriorityscore=0
 spamscore=0 malwarescore=0 bulkscore=0 phishscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107260105
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Binding <sbinding@opensource.cirrus.com>

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
---
 sound/pci/hda/patch_cs8409.c | 41 ++++++++++++++++++++++++------------
 1 file changed, 28 insertions(+), 13 deletions(-)

diff --git a/sound/pci/hda/patch_cs8409.c b/sound/pci/hda/patch_cs8409.c
index df65a5908201..8f02724621bd 100644
--- a/sound/pci/hda/patch_cs8409.c
+++ b/sound/pci/hda/patch_cs8409.c
@@ -364,16 +364,21 @@ static int cs8409_build_controls(struct hda_codec *codec)
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
@@ -605,6 +610,8 @@ static int cs42l42_jack_unsol_event(struct sub_codec *cs42l42)
 
 static void cs42l42_resume(struct sub_codec *cs42l42)
 {
+	struct hda_codec *codec = cs42l42->codec;
+	unsigned int gpio_data;
 	struct cs8409_i2c_param irq_regs[] = {
 		{ 0x1308, 0x00 },
 		{ 0x1309, 0x00 },
@@ -612,6 +619,12 @@ static void cs42l42_resume(struct sub_codec *cs42l42)
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
@@ -637,10 +650,18 @@ static void cs42l42_resume(struct sub_codec *cs42l42)
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
 
@@ -691,13 +712,12 @@ static void cs8409_cs42l42_jack_unsol_event(struct hda_codec *codec, unsigned in
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
 
@@ -736,11 +756,6 @@ static void cs8409_cs42l42_hw_init(struct hda_codec *codec)
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

