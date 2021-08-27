Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B4543F9877
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 13:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245031AbhH0Leo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 07:34:44 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:32410 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244978AbhH0Len (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 07:34:43 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 17R81B0C012251;
        Fri, 27 Aug 2021 06:33:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=Le4te/e9isuWycyqZrcYYaONLdHszU7lSnZZrBkyn8g=;
 b=n1wFxKxu0eGhWzh5OCTtZ5sPPaC/Ts9+6IcMGCDGDxocd4KzZqIGqc9u0F8BRsyXgEP9
 4GGTALt0xKBkmRzP4N6rdX8MgPTgHRNT7AxAGFtiD5Mt8RWnL/jnXOahQiSnedl2rwGK
 qgmrYcZtuz06BxVHXclV2FOTFHp1uqnknY5BD+Ayt/4ZkoUOjGPyG6Yr1V7O7n9QBSMQ
 dl1tB/GDJvI3d9C0BvSjb5DMIVNIMc+JKrvS25swmkdE+nkcmNdwfODwMTQvcWinBden
 lRJTZD3HWmuM8D1hUMnHvZIIPtWn65Wc9ZywS9GmfLKDAsxSV/M5cZqZhf8tvo49R/ry HA== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 3apv5sg7fa-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 27 Aug 2021 06:33:08 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Fri, 27 Aug
 2021 12:03:01 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.12 via Frontend
 Transport; Fri, 27 Aug 2021 12:03:01 +0100
Received: from vitaly-Inspiron-5415.ad.cirrus.com (unknown [198.90.238.186])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 5712846E;
        Fri, 27 Aug 2021 11:03:01 +0000 (UTC)
From:   Vitaly Rodionov <vitalyr@opensource.cirrus.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH 2/2] ALSA: hda/cs8409: Initialize Codec only in init fixup.
Date:   Fri, 27 Aug 2021 12:02:52 +0100
Message-ID: <20210827110252.5361-2-vitalyr@opensource.cirrus.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210827110252.5361-1-vitalyr@opensource.cirrus.com>
References: <20210827110252.5361-1-vitalyr@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 6eawfstDClbsJ7B6N6n2XcMhn2MQ4Sdv
X-Proofpoint-GUID: 6eawfstDClbsJ7B6N6n2XcMhn2MQ4Sdv
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Binding <sbinding@opensource.cirrus.com>

It is not necessary to initialize the codec during both probe and inside
the init fixup.

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
---
 sound/pci/hda/patch_cs8409.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/pci/hda/patch_cs8409.c b/sound/pci/hda/patch_cs8409.c
index 805441b7bf86..3c7ef55d016e 100644
--- a/sound/pci/hda/patch_cs8409.c
+++ b/sound/pci/hda/patch_cs8409.c
@@ -1024,7 +1024,6 @@ void cs8409_cs42l42_fixups(struct hda_codec *codec, const struct hda_fixup *fix,
 				&cs42l42_adc_volume_mixer);
 		/* Disable Unsolicited Response during boot */
 		cs8409_enable_ur(codec, 0);
-		cs8409_cs42l42_hw_init(codec);
 		snd_hda_codec_set_name(codec, "CS8409/CS42L42");
 		break;
 	case HDA_FIXUP_ACT_INIT:
@@ -1229,7 +1228,6 @@ void dolphin_fixups(struct hda_codec *codec, const struct hda_fixup *fix, int ac
 		kctrl->private_value = HDA_COMPOSE_AMP_VAL_OFS(DOLPHIN_HP_PIN_NID, 3, CS8409_CODEC1,
 				       HDA_OUTPUT, CS42L42_VOL_DAC) | HDA_AMP_VAL_MIN_MUTE;
 		cs8409_enable_ur(codec, 0);
-		dolphin_hw_init(codec);
 		snd_hda_codec_set_name(codec, "CS8409/CS42L42");
 		break;
 	case HDA_FIXUP_ACT_INIT:
-- 
2.25.1

