Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD7636A19B
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Apr 2021 16:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233591AbhDXOeA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Apr 2021 10:34:00 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:62462 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230211AbhDXOdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Apr 2021 10:33:42 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13OERRe6030110;
        Sat, 24 Apr 2021 09:32:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=tkqkIyDvYUWv1SwOIRs0yDOJhnvdtYMmy19ZwEA3M9g=;
 b=OuDU8wCw/M/OkdNDR594kQHr3991LX3AtfwKwtvGcxfJRuvsadzWcVIhfK7MbXQlFe8q
 gb2yPum1SfzfeOrsc2lPrINV9JPRtJXbd8WMzs20ANEKL8CBwlUqi0zeB+DelJgUIUOd
 5i/kx3W2nf7wEuTt8UVIQo9pCm2hZsc8kVaPl77GMigct05o5gd4fpYj2sAF9lY/9L7W
 13tueFCKXkaU/HiRtl+fAKxQHEstnWJdJMUD2ShGf6C2Qg/gPisa6UHlfNEUq+1/lhRc
 2adHEceI7oV/Phw5bmxE+ovxbPtjDOKy3f+3ja94+XnbHceI5U06lWfk8NgmP6dIp2m4 Qg== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 384frs094u-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sat, 24 Apr 2021 09:32:46 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Sat, 24 Apr
 2021 15:32:45 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Sat, 24 Apr 2021 15:32:45 +0100
Received: from vitaly-Inspiron-5415.ad.cirrus.com (unknown [198.90.238.200])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id A908211D7;
        Sat, 24 Apr 2021 14:32:44 +0000 (UTC)
From:   Vitaly Rodionov <vitalyr@opensource.cirrus.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>,
        Stefan Binding <sbinding@opensource.cirrus.com>,
        You-Sheng Yang <vicamo.yang@canonical.com>
Subject: [PATCH v1 1/2] ALSA: hda/cirrus: Set Initial DMIC volume for Bullseye to 16%
Date:   Sat, 24 Apr 2021 15:32:43 +0100
Message-ID: <20210424143244.639125-2-vitalyr@opensource.cirrus.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210424143244.639125-1-vitalyr@opensource.cirrus.com>
References: <20210424143244.639125-1-vitalyr@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: EVCrsmFZXW8O40leVLezP6CJ-3csFL4N
X-Proofpoint-GUID: EVCrsmFZXW8O40leVLezP6CJ-3csFL4N
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1011 spamscore=0 phishscore=0
 lowpriorityscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0 adultscore=0
 bulkscore=0 suspectscore=0 impostorscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104240107
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Binding <sbinding@opensource.cirrus.com>

Tested on DELL Inspiron-3505, DELL Inspiron-3501, DELL Inspiron-3500

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
BugLink: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1923557
Reported-and-tested-by: You-Sheng Yang <vicamo.yang@canonical.com>
---
 sound/pci/hda/patch_cirrus.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/pci/hda/patch_cirrus.c b/sound/pci/hda/patch_cirrus.c
index 5d57096b3a95..d6cf93b7483c 100644
--- a/sound/pci/hda/patch_cirrus.c
+++ b/sound/pci/hda/patch_cirrus.c
@@ -2172,6 +2172,10 @@ static void cs8409_cs42l42_fixups(struct hda_codec *codec,
 			(get_wcaps(codec, CS8409_CS42L42_AMIC_PIN_NID) | AC_WCAP_UNSOL_CAP));
 		break;
 	case HDA_FIXUP_ACT_PROBE:
+
+		if (codec->fixup_id == CS8409_BULLSEYE)
+			snd_hda_codec_amp_init_stereo(codec, CS8409_CS42L42_DMIC_ADC_PIN_NID,
+					HDA_INPUT, 0, 0xff, 0x19);
 		snd_hda_gen_add_kctl(&spec->gen,
 			NULL, &cs8409_cs42l42_hp_volume_mixer);
 		snd_hda_gen_add_kctl(&spec->gen,
-- 
2.25.1

