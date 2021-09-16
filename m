Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 981EA40D6F4
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 11:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237719AbhIPKAV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 06:00:21 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:39294 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237200AbhIPJ7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 05:59:07 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18G6UqLC017886;
        Thu, 16 Sep 2021 04:57:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=ha17yogEQU4qUFAR7cWFbPaW839EX045J1Xb9CypQhc=;
 b=U42uK82d138PV2FiMjHB6SQYsz7P0lo0o6uQCs/khVjit7ufPu780IaTutRJFJkj4BDa
 cbqZN86wAxKnY6XZdqQ8r/M6ViuyYD7kbbba83Oi9F1+xSg5UNzHEy7rG2n77R6xZWwg
 k4GoVerwuGm3jZz2Ncvj6HoXxQfnTFwH2gbNKjwmq9th5CwdkKV7xFeAD/YR5ov6nhzX
 bDVTr3hd031wa90RiyBQstmuHT2NQ23Kpleu1Bvhwk7Omnvzjw5DIZ54//NTceE2Ssl9
 1pXyzA2bp9jChVMW0kOGO+PkSzRbqcoZCJQr8PCFpex4Dx6T1a0GyoTlmaoljyVV27kI Yw== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 3b3wfv0b8u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 16 Sep 2021 04:57:02 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Thu, 16 Sep
 2021 10:57:01 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.12 via Frontend
 Transport; Thu, 16 Sep 2021 10:57:01 +0100
Received: from vitaly-Inspiron-5415.ad.cirrus.com (unknown [198.90.238.230])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 19C96B15;
        Thu, 16 Sep 2021 09:57:00 +0000 (UTC)
From:   Vitaly Rodionov <vitalyr@opensource.cirrus.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH] ALSA: hda/cs8409: Setup Dolphin Headset Mic as Phantom Jack
Date:   Thu, 16 Sep 2021 10:56:46 +0100
Message-ID: <20210916095646.7631-1-vitalyr@opensource.cirrus.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 9eaEMjPcBWfdvc6H-_2mCOrYJ3a9_56S
X-Proofpoint-ORIG-GUID: 9eaEMjPcBWfdvc6H-_2mCOrYJ3a9_56S
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Binding <sbinding@opensource.cirrus.com>

Dell's requirement to have headset mic as phantom jack on this
specific dolphin hardware platform.

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
---
 sound/pci/hda/patch_cs8409.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/pci/hda/patch_cs8409.c b/sound/pci/hda/patch_cs8409.c
index 3c7ef55d016e..31ff11ab868e 100644
--- a/sound/pci/hda/patch_cs8409.c
+++ b/sound/pci/hda/patch_cs8409.c
@@ -1207,6 +1207,9 @@ void dolphin_fixups(struct hda_codec *codec, const struct hda_fixup *fix, int ac
 		snd_hda_jack_add_kctl(codec, DOLPHIN_LO_PIN_NID, "Line Out", true,
 				      SND_JACK_HEADPHONE, NULL);
 
+		snd_hda_jack_add_kctl(codec, DOLPHIN_AMIC_PIN_NID, "Microphone", true,
+				      SND_JACK_MICROPHONE, NULL);
+
 		cs8409_fix_caps(codec, DOLPHIN_HP_PIN_NID);
 		cs8409_fix_caps(codec, DOLPHIN_LO_PIN_NID);
 		cs8409_fix_caps(codec, DOLPHIN_AMIC_PIN_NID);
-- 
2.25.1

