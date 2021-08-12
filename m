Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 421DC3EAA49
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 20:35:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234027AbhHLSgU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 14:36:20 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:60854 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233793AbhHLSgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 14:36:17 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 17CG4uIp006578;
        Thu, 12 Aug 2021 13:35:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=61b4RXqMgKyr1+6RvNuIe0j1rQk5345ugt+Gh480xJE=;
 b=DJNNRvLz39oi9rJK2pecOyFBc0Ls80d9wl6Sj/Jrf80HIC9SH0vcc/JcFUs7UIjZRHkG
 GQpmkwwUQf0t4Z0w9D3Hqqh0yUjUP+HdICXfpiOsDSSOubPTh97Ivpaj55RKY36F9neE
 10oSxm4Sqv/bE7PI8XbryjFcpxRZueeTY32GdO2mu0v77iCOuEs4KCbWX7SDawew5UiS
 86iazFDTYmhPX3EMl/MYzDl51Yk12fndWoT1uuPVJUNPsJhIFwfiRDqSXfz7WiqvJOii
 CIOy6d2lgb+At7wQe77G3gV2DMHIGkITNSwegLyJAi55dn92tvnjQglBt3dslTkqNOms Rg== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 3ad6urg6vc-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 12 Aug 2021 13:35:07 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Thu, 12 Aug
 2021 19:35:05 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.12 via Frontend
 Transport; Thu, 12 Aug 2021 19:35:05 +0100
Received: from vitaly-Inspiron-5415.ad.cirrus.com (unknown [198.90.238.180])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id D652B2A9;
        Thu, 12 Aug 2021 18:35:04 +0000 (UTC)
From:   Vitaly Rodionov <vitalyr@opensource.cirrus.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH 2/2] ALSA: hda/cs8409: Prevent pops and clicks during reboot
Date:   Thu, 12 Aug 2021 19:34:33 +0100
Message-ID: <20210812183433.6330-2-vitalyr@opensource.cirrus.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210812183433.6330-1-vitalyr@opensource.cirrus.com>
References: <20210812183433.6330-1-vitalyr@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: diCmEN5a5SdF7Q3iRCYNRd6zPQULU7WE
X-Proofpoint-GUID: diCmEN5a5SdF7Q3iRCYNRd6zPQULU7WE
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 priorityscore=1501
 malwarescore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0
 mlxlogscore=999 clxscore=1015 phishscore=0 adultscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108120120
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Binding <sbinding@opensource.cirrus.com>

During reboot, when the CS42L42 powers down, pops and clicks
may occur due to the codec not being shutdown gracefully.
This can be fixed by going through the suspend sequence,
which shuts down the codec cleanly inside the reboot_notify
hook, which is called on reboot.

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
---
 sound/pci/hda/patch_cs8409.c | 56 ++++++++++++++++++++----------------
 1 file changed, 32 insertions(+), 24 deletions(-)

diff --git a/sound/pci/hda/patch_cs8409.c b/sound/pci/hda/patch_cs8409.c
index 9db16b6292f4..f51fc4a1545a 100644
--- a/sound/pci/hda/patch_cs8409.c
+++ b/sound/pci/hda/patch_cs8409.c
@@ -753,7 +753,6 @@ static void cs42l42_resume(struct sub_codec *cs42l42)
 	cs42l42_enable_jack_detect(cs42l42);
 }
 
-#ifdef CONFIG_PM
 static void cs42l42_suspend(struct sub_codec *cs42l42)
 {
 	struct hda_codec *codec = cs42l42->codec;
@@ -773,6 +772,9 @@ static void cs42l42_suspend(struct sub_codec *cs42l42)
 		{ 0x1101, 0xFF },
 	};
 
+	if (cs42l42->suspended)
+		return;
+
 	cs8409_i2c_bulk_write(cs42l42, cs42l42_pwr_down_seq, ARRAY_SIZE(cs42l42_pwr_down_seq));
 
 	if (read_poll_timeout(cs8409_i2c_read, reg_cdc_status,
@@ -790,7 +792,6 @@ static void cs42l42_suspend(struct sub_codec *cs42l42)
 	gpio_data &= ~cs42l42->reset_gpio;
 	snd_hda_codec_write(codec, CS8409_PIN_AFG, 0, AC_VERB_SET_GPIO_DATA, gpio_data);
 }
-#endif
 
 static void cs8409_free(struct hda_codec *codec)
 {
@@ -803,6 +804,33 @@ static void cs8409_free(struct hda_codec *codec)
 	snd_hda_gen_free(codec);
 }
 
+/* Manage PDREF, when transition to D3hot */
+static int cs8409_cs42l42_suspend(struct hda_codec *codec)
+{
+	struct cs8409_spec *spec = codec->spec;
+	int i;
+
+	cs8409_enable_ur(codec, 0);
+
+	for (i = 0; i < spec->num_scodecs; i++)
+		cs42l42_suspend(spec->scodecs[i]);
+
+	/* Cancel i2c clock disable timer, and disable clock if left enabled */
+	cancel_delayed_work_sync(&spec->i2c_clk_work);
+	cs8409_disable_i2c_clock(codec);
+
+	snd_hda_shutup_pins(codec);
+
+	return 0;
+}
+
+static void cs8409_reboot_notify(struct hda_codec *codec)
+{
+	cs8409_cs42l42_suspend(codec);
+	snd_hda_gen_reboot_notify(codec);
+	codec->patch_ops.free(codec);
+}
+
 /******************************************************************************
  *                   BULLSEYE / WARLOCK / CYBORG Specific Functions
  *                               CS8409/CS42L42
@@ -845,28 +873,6 @@ static void cs8409_cs42l42_jack_unsol_event(struct hda_codec *codec, unsigned in
 	}
 }
 
-#ifdef CONFIG_PM
-/* Manage PDREF, when transition to D3hot */
-static int cs8409_cs42l42_suspend(struct hda_codec *codec)
-{
-	struct cs8409_spec *spec = codec->spec;
-	int i;
-
-	cs8409_enable_ur(codec, 0);
-
-	for (i = 0; i < spec->num_scodecs; i++)
-		cs42l42_suspend(spec->scodecs[i]);
-
-	/* Cancel i2c clock disable timer, and disable clock if left enabled */
-	cancel_delayed_work_sync(&spec->i2c_clk_work);
-	cs8409_disable_i2c_clock(codec);
-
-	snd_hda_shutup_pins(codec);
-
-	return 0;
-}
-#endif
-
 /* Vendor specific HW configuration
  * PLL, ASP, I2C, SPI, GPIOs, DMIC etc...
  */
@@ -910,6 +916,7 @@ static const struct hda_codec_ops cs8409_cs42l42_patch_ops = {
 	.init = cs8409_init,
 	.free = cs8409_free,
 	.unsol_event = cs8409_cs42l42_jack_unsol_event,
+	.reboot_notify = cs8409_reboot_notify,
 #ifdef CONFIG_PM
 	.suspend = cs8409_cs42l42_suspend,
 #endif
@@ -1121,6 +1128,7 @@ static const struct hda_codec_ops cs8409_dolphin_patch_ops = {
 	.init = cs8409_init,
 	.free = cs8409_free,
 	.unsol_event = dolphin_jack_unsol_event,
+	.reboot_notify = cs8409_reboot_notify,
 #ifdef CONFIG_PM
 	.suspend = cs8409_cs42l42_suspend,
 #endif
-- 
2.25.1

