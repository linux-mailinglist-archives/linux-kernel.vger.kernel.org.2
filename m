Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D22F53D6694
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 20:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232594AbhGZRiL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 13:38:11 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:61524 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231207AbhGZRh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 13:37:59 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 16Q9Xco2002242;
        Mon, 26 Jul 2021 13:18:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=jT3ehfJJFnaJFHyQnG+nRsZPrz0bW1wv94KleEgeMRg=;
 b=Ys87cflz9VXPuKeuzgJ2wnmIWDslH9KuMm8+LGQuaeF3fzPQPXrBWauwYxt2Sw0+o9XQ
 aD8gluNwKq8PgrdROaqORVi7Vlr0c5xN/ri4sv4XqRUglsm55MTy4KXctbo9nYlHwaTz
 peXgGNLmafs8pPymTXO8SQQ4fTE/kd8bDMu2a/udBRgVq4WC1WJsP/IuuqkO8KHcaIsR
 1qkRjygrsfjNc8O8/saGyODLEBVyib3EgnbUWhhcD9eALkUxSitDBRWGo3wZEGSvdMWL
 UhOpMveVZnUYIZamn2VlPav9zKW/luLRZNF6KCQbIgBtXFepUj+GRbWlVMzTCgts+1bL Ig== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 3a1th2rhbh-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 26 Jul 2021 13:18:17 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 26 Jul
 2021 18:47:10 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Mon, 26 Jul 2021 18:47:10 +0100
Received: from vitaly-Inspiron-5415.ad.cirrus.com (unknown [198.90.238.32])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 1F2732BA;
        Mon, 26 Jul 2021 17:47:10 +0000 (UTC)
From:   Vitaly Rodionov <vitalyr@opensource.cirrus.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH 20/27] ALSA: hda/cs8409: Add Support to disable jack type detection for CS42L42
Date:   Mon, 26 Jul 2021 18:46:33 +0100
Message-ID: <20210726174640.6390-21-vitalyr@opensource.cirrus.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210726174640.6390-1-vitalyr@opensource.cirrus.com>
References: <20210726174640.6390-1-vitalyr@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: fnplYm_4CbTmei6B9kx9oQhAaX68XPPW
X-Proofpoint-GUID: fnplYm_4CbTmei6B9kx9oQhAaX68XPPW
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 clxscore=1015
 suspectscore=0 impostorscore=0 mlxlogscore=999 lowpriorityscore=0
 spamscore=0 malwarescore=0 bulkscore=0 phishscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107260105
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Binding <sbinding@opensource.cirrus.com>

Some hardware configurations do not support jack type detection.
Instead, for those configurations, only tip detection is supported.

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
---
 sound/pci/hda/patch_cs8409-tables.c |  1 +
 sound/pci/hda/patch_cs8409.c        | 72 ++++++++++++++++-------------
 sound/pci/hda/patch_cs8409.h        |  1 +
 3 files changed, 43 insertions(+), 31 deletions(-)

diff --git a/sound/pci/hda/patch_cs8409-tables.c b/sound/pci/hda/patch_cs8409-tables.c
index 117c70536ff0..be9feb84aaa2 100644
--- a/sound/pci/hda/patch_cs8409-tables.c
+++ b/sound/pci/hda/patch_cs8409-tables.c
@@ -246,6 +246,7 @@ struct sub_codec cs8409_cs42l42_codec = {
 	.mic_jack_in = 0,
 	.paged = 1,
 	.suspended = 1,
+	.no_type_dect = 0,
 };
 
 /******************************************************************************
diff --git a/sound/pci/hda/patch_cs8409.c b/sound/pci/hda/patch_cs8409.c
index 8f02724621bd..081e348b16ef 100644
--- a/sound/pci/hda/patch_cs8409.c
+++ b/sound/pci/hda/patch_cs8409.c
@@ -535,6 +535,39 @@ static void cs42l42_run_jack_detect(struct sub_codec *cs42l42)
 	usleep_range(10000, 25000);
 }
 
+static int cs42l42_handle_tip_sense(struct sub_codec *cs42l42, unsigned int reg_ts_status)
+{
+	int status_changed = 0;
+
+	/* TIP_SENSE INSERT/REMOVE */
+	switch (reg_ts_status) {
+	case CS42L42_JACK_INSERTED:
+		if (!cs42l42->hp_jack_in) {
+			if (cs42l42->no_type_dect) {
+				status_changed = 1;
+				cs42l42->hp_jack_in = 1;
+				cs42l42->mic_jack_in = 0;
+			} else {
+				cs42l42_run_jack_detect(cs42l42);
+			}
+		}
+		break;
+
+	case CS42L42_JACK_REMOVED:
+		if (cs42l42->hp_jack_in || cs42l42->mic_jack_in) {
+			status_changed = 1;
+			cs42l42->hp_jack_in = 0;
+			cs42l42->mic_jack_in = 0;
+		}
+		break;
+	default:
+		/* jack in transition */
+		break;
+	}
+
+	return status_changed;
+}
+
 static int cs42l42_jack_unsol_event(struct sub_codec *cs42l42)
 {
 	int status_changed = 0;
@@ -559,10 +592,13 @@ static int cs42l42_jack_unsol_event(struct sub_codec *cs42l42)
 		cs8409_i2c_write(cs42l42, 0x131b, 0xFF);
 
 		type = ((reg_hs_status & CS42L42_HSTYPE_MASK) + 1);
-		/* CS42L42 reports optical jack as type 4
-		 * We don't handle optical jack
-		 */
-		if (type != 4) {
+
+		if (cs42l42->no_type_dect) {
+			status_changed = cs42l42_handle_tip_sense(cs42l42, reg_ts_status);
+		} else if (type == 4) {
+			/* Type 4 not supported	*/
+			status_changed = cs42l42_handle_tip_sense(cs42l42, CS42L42_JACK_REMOVED);
+		} else {
 			if (!cs42l42->hp_jack_in) {
 				status_changed = 1;
 				cs42l42->hp_jack_in = 1;
@@ -572,37 +608,11 @@ static int cs42l42_jack_unsol_event(struct sub_codec *cs42l42)
 				status_changed = 1;
 				cs42l42->mic_jack_in = 1;
 			}
-		} else {
-			if (cs42l42->hp_jack_in || cs42l42->mic_jack_in) {
-				status_changed = 1;
-				cs42l42->hp_jack_in = 0;
-				cs42l42->mic_jack_in = 0;
-			}
 		}
-
 		/* Re-Enable Tip Sense Interrupt */
 		cs8409_i2c_write(cs42l42, 0x1320, 0xF3);
-
 	} else {
-		/* TIP_SENSE INSERT/REMOVE */
-		switch (reg_ts_status) {
-		case CS42L42_JACK_INSERTED:
-			cs42l42_run_jack_detect(cs42l42);
-			break;
-
-		case CS42L42_JACK_REMOVED:
-			if (cs42l42->hp_jack_in || cs42l42->mic_jack_in) {
-				status_changed = 1;
-				cs42l42->hp_jack_in = 0;
-				cs42l42->mic_jack_in = 0;
-			}
-			break;
-
-		default:
-			/* jack in transition */
-			status_changed = 0;
-			break;
-		}
+		status_changed = cs42l42_handle_tip_sense(cs42l42, reg_ts_status);
 	}
 
 	return status_changed;
diff --git a/sound/pci/hda/patch_cs8409.h b/sound/pci/hda/patch_cs8409.h
index 817df295d594..a105c3c9023d 100644
--- a/sound/pci/hda/patch_cs8409.h
+++ b/sound/pci/hda/patch_cs8409.h
@@ -285,6 +285,7 @@ struct sub_codec {
 	unsigned int last_page;
 	unsigned int hsbias_hiz;
 	unsigned int full_scale_vol:1;
+	unsigned int no_type_dect:1;
 
 	s8 vol[CS42L42_VOLUMES];
 };
-- 
2.25.1

