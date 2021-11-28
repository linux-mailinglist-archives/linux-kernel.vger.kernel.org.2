Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1C64460601
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Nov 2021 12:59:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357371AbhK1MCM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 07:02:12 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:52238 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1357251AbhK1MAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 07:00:11 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1ASBmlIa001661;
        Sun, 28 Nov 2021 05:56:11 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=Ki+QojrxDU5JUpAcdyetKCTFr00V0YhLcue4lnkDJsQ=;
 b=gg0ecbHVxCfge1E4sBslc3ZSGhyCTBFrbPEt6HYB8oY2v9iXzQScTNj1Dv1LWENkBZF0
 aeXBmUmmKp/VxmPCbzEyblsfIAC0VlZA59ubv7RfNa0XRdiCWcWTawiPc9qa7d9e4v/u
 RqprHU70IS6Jgem3QD1jCLX0vMvo26sW+XLMSsRqcxOoUOrJ92mtnpymKGKca6IkeP8J
 c3A7LqHz5eNVOZLbQ+5lWK6tKJ+TGA4v2EhPbXOrsKbZ88QizzSENWZquiKVvs2EBabg
 FTAewZPGa/8be4+2rg+9tIEufDREdgDxVKtKDSsTJLfhJhBwBdQ1ioBjPcRaergNOcYf JA== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3ckjy80v9w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sun, 28 Nov 2021 05:56:10 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Sun, 28 Nov
 2021 11:56:08 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Sun, 28 Nov 2021 11:56:08 +0000
Received: from vitaly-Inspiron-5415.ad.cirrus.com (unknown [198.90.238.68])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 37E3F2A9;
        Sun, 28 Nov 2021 11:55:59 +0000 (UTC)
From:   Vitaly Rodionov <vitalyr@opensource.cirrus.com>
To:     Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>,
        Stefan Binding <sbinding@opensource.cirrus.com>,
        Vitaly Rodionov <vitalyr@opensource.cirrus.com>,
        Lucas Tanure <tanureal@opensource.cirrus.com>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] ALSA: hda/cs8409: Set PMSG_ON earlier inside cs8409 driver
Date:   Sun, 28 Nov 2021 11:55:58 +0000
Message-ID: <20211128115558.71683-1-vitalyr@opensource.cirrus.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: _FR5QcA7hi8KulKl7QlPQ4CygCn93E8L
X-Proofpoint-GUID: _FR5QcA7hi8KulKl7QlPQ4CygCn93E8L
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Binding <sbinding@opensource.cirrus.com>

For cs8409, it is required to run Jack Detect on resume.
Jack Detect on cs8409+cs42l42 requires an interrupt from
cs42l42 to be sent to cs8409 which is propogated to the driver
via an unsolicited event.
However, the hda_codec drops unsolicited events if the power_state
is not set to PMSG_ON. Which is set at the end of the resume call.
This means there is a race condition between setting power_state
to PMSG_ON and receiving the interrupt.
To solve this, we can add an API to set the power_state earlier
and call that before we start Jack Detect.
This does not cause issues, since we know inside our driver that
we are already initialized, and ready to handle the unsolicited
events.

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
---
 sound/pci/hda/hda_local.h    | 8 ++++++++
 sound/pci/hda/patch_cs8409.c | 5 +++++
 2 files changed, 13 insertions(+)

diff --git a/sound/pci/hda/hda_local.h b/sound/pci/hda/hda_local.h
index 4662a47add7e..96f78daf90f0 100644
--- a/sound/pci/hda/hda_local.h
+++ b/sound/pci/hda/hda_local.h
@@ -439,6 +439,14 @@ int snd_hda_codec_set_pin_target(struct hda_codec *codec, hda_nid_t nid,
 #define for_each_hda_codec_node(nid, codec) \
 	for ((nid) = (codec)->core.start_nid; (nid) < (codec)->core.end_nid; (nid)++)
 
+/* Set the codec power_state flag to indicate to allow unsol event handling;
+ * see hda_codec_unsol_event() in hda_bind.c.  Calling this might confuse the
+ * state tracking, so use with care.
+ */
+static inline void snd_hda_codec_allow_unsol_events(struct hda_codec *codec) {
+	codec->core.dev.power.power_state = PMSG_ON;
+}
+
 /*
  * get widget capabilities
  */
diff --git a/sound/pci/hda/patch_cs8409.c b/sound/pci/hda/patch_cs8409.c
index 31ff11ab868e..039b9f2f8e94 100644
--- a/sound/pci/hda/patch_cs8409.c
+++ b/sound/pci/hda/patch_cs8409.c
@@ -750,6 +750,11 @@ static void cs42l42_resume(struct sub_codec *cs42l42)
 	if (cs42l42->full_scale_vol)
 		cs8409_i2c_write(cs42l42, 0x2001, 0x01);
 
+	/* we have to explicitly allow unsol event handling even during the
+	 * resume phase so that the jack event is processed properly
+	 */
+	snd_hda_codec_allow_unsol_events(cs42l42->codec);
+
 	cs42l42_enable_jack_detect(cs42l42);
 }
 
-- 
2.25.1

