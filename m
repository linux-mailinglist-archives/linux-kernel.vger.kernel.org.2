Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44A4F3E981C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 20:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231981AbhHKS6w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 14:58:52 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:57416 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231788AbhHKS6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 14:58:40 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 17B9h6hL011884;
        Wed, 11 Aug 2021 13:57:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=0irTFWQL67m85a6kEoQsMYC2q1CMkSKfTSdWd2XyQZ0=;
 b=SXKb5nnEVNXjJ5mH5hO3pJS5ZNASs+l7qyYy5sjuEAh6qtDdjvbOi5DLRR0G2nNJrrT4
 vIip+43yWMHV96YnSR+xhs1Ag/FDu3UnYvDasR4gTVyQtX6FwyPUDROtUP/yW6n3x9/q
 9YywUKYWkozmFeVhFstVgA6es12V7nyJ4sRARTaPEwc2MeChtWA2qbQIIv4GdWVM2r1A
 JRMCFujAKS25tAv24v7aSZDRam7t+AuSvb7T8rMt90WqRte7Kg6urINGMl/puQMCJqbs
 zPe7eOEG7RRc5msFrYqMsx3He6U3y7P/mAsCO6RJZn19sVwlEBxt18ed1Ao6Z213rYXt Rg== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 3acc5ngnt3-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 11 Aug 2021 13:57:29 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Wed, 11 Aug
 2021 19:57:27 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.12 via Frontend
 Transport; Wed, 11 Aug 2021 19:57:27 +0100
Received: from vitaly-Inspiron-5415.ad.cirrus.com (unknown [198.90.238.180])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 685E045D;
        Wed, 11 Aug 2021 18:57:27 +0000 (UTC)
From:   Vitaly Rodionov <vitalyr@opensource.cirrus.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH v4 07/27] ALSA: hda/cs8409: Disable unsolicited responses during suspend
Date:   Wed, 11 Aug 2021 19:56:34 +0100
Message-ID: <20210811185654.6837-8-vitalyr@opensource.cirrus.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210811185654.6837-1-vitalyr@opensource.cirrus.com>
References: <20210811185654.6837-1-vitalyr@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: VgxL7tiLAC3ZxD_ka5f5qNkL95svY5WW
X-Proofpoint-GUID: VgxL7tiLAC3ZxD_ka5f5qNkL95svY5WW
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 phishscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 impostorscore=0
 malwarescore=0 adultscore=0 mlxlogscore=999 mlxscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108110130
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Binding <sbinding@opensource.cirrus.com>

Ensure unsolicited responses cannot occur whilst the sub codecs are
being disabled.

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
---

Changes in v2:
- No changes

Changes in v3:
- No changes

Changes in v4:
- No changes

 sound/pci/hda/patch_cs8409.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/sound/pci/hda/patch_cs8409.c b/sound/pci/hda/patch_cs8409.c
index 1745f8b188c6..4906d2913603 100644
--- a/sound/pci/hda/patch_cs8409.c
+++ b/sound/pci/hda/patch_cs8409.c
@@ -563,12 +563,26 @@ static void cs8409_jack_unsol_event(struct hda_codec *codec, unsigned int res)
 	}
 }
 
+/* Enable/Disable Unsolicited Response for gpio(s) 3,4 */
+static void cs8409_enable_ur(struct hda_codec *codec, int flag)
+{
+	/* GPIO4 INT# and GPIO3 WAKE# */
+	snd_hda_codec_write(codec, CS8409_PIN_AFG, 0, AC_VERB_SET_GPIO_UNSOLICITED_RSP_MASK,
+			    flag ? CS8409_CS42L42_INT : 0);
+
+	snd_hda_codec_write(codec, CS8409_PIN_AFG, 0, AC_VERB_SET_UNSOLICITED_ENABLE,
+			    flag ? AC_UNSOL_ENABLED : 0);
+
+}
+
 #ifdef CONFIG_PM
 /* Manage PDREF, when transition to D3hot */
 static int cs8409_suspend(struct hda_codec *codec)
 {
 	struct cs8409_spec *spec = codec->spec;
 
+	cs8409_enable_ur(codec, 0);
+
 	mutex_lock(&spec->cs8409_i2c_mux);
 	/* Power down CS42L42 ASP/EQ/MIX/HP */
 	cs8409_i2c_write(codec, CS42L42_I2C_ADDR, 0x1101, 0xfe, 1);
@@ -582,18 +596,6 @@ static int cs8409_suspend(struct hda_codec *codec)
 }
 #endif
 
-/* Enable/Disable Unsolicited Response for gpio(s) 3,4 */
-static void cs8409_enable_ur(struct hda_codec *codec, int flag)
-{
-	/* GPIO4 INT# and GPIO3 WAKE# */
-	snd_hda_codec_write(codec, CS8409_PIN_AFG, 0, AC_VERB_SET_GPIO_UNSOLICITED_RSP_MASK,
-			    flag ? CS8409_CS42L42_INT : 0);
-
-	snd_hda_codec_write(codec, CS8409_PIN_AFG, 0, AC_VERB_SET_UNSOLICITED_ENABLE,
-			    flag ? AC_UNSOL_ENABLED : 0);
-
-}
-
 /* Vendor specific HW configuration
  * PLL, ASP, I2C, SPI, GPIOs, DMIC etc...
  */
-- 
2.25.1

