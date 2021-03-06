Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9460032F9C1
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 12:35:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbhCFLf0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Mar 2021 06:35:26 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:47242 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229969AbhCFLew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Mar 2021 06:34:52 -0500
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 126BYc1I006179;
        Sat, 6 Mar 2021 05:34:38 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=cRf/XjXQz0ieQ0iRiFiFBpg2ERGOLP9dk7KoWwpDKnw=;
 b=iVFqXiGtGZWNUVZT2KBT966kR7169uCSlhmB6sR5VPVR7heRxIovGnkQhQBA14KyLWId
 GHyM9xOesgtH9HsgwFV6McOV7SXbtOBw3tAu56FO8IFU1oM1i5o9KiOLY4qk5M5KOMsm
 SWv5sDojJ1F+FpJdegXvUnHD19qrePgqk+9OF7UXX7wLHVqIKi4qDBUgzbQxv6vYEkdW
 bJWlBcZKUX5Fvj1yH3KLoXXWvfUXlgKvj7QNvmJ38REfrHWZKDZw9OhiMtFQFi8nWtva
 WpxfpSjpVgsRdGc9wrV3B72o2iQO9ak5NREh+YuIDohoWyXJx8OcEwQsINxXP/kJbFL8 4Q== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 37471vr316-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sat, 06 Mar 2021 05:34:38 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Sat, 6 Mar 2021
 11:19:34 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2176.2 via Frontend
 Transport; Sat, 6 Mar 2021 11:19:34 +0000
Received: from vitaly-Inspiron-5415.ad.cirrus.com (unknown [198.90.238.45])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 90FC111D7;
        Sat,  6 Mar 2021 11:19:34 +0000 (UTC)
From:   Vitaly Rodionov <vitalyr@opensource.cirrus.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 1/4] ALSA: hda/cirrus: Increase AUTO_CFG_MAX_INS from 8 to 18
Date:   Sat, 6 Mar 2021 11:19:31 +0000
Message-ID: <20210306111934.4832-2-vitalyr@opensource.cirrus.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210306111934.4832-1-vitalyr@opensource.cirrus.com>
References: <20210306111934.4832-1-vitalyr@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 adultscore=0
 malwarescore=0 mlxlogscore=999 impostorscore=0 bulkscore=0
 priorityscore=1501 mlxscore=0 spamscore=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103060070
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to support Cirrus Logic CS8409 HDA bridge on new Dell platforms
it is nessasary to increase AUTO_CFG_MAX_INS and AUTO_CFG_NUM_INPUTS values.
Currently AUTO_CFG_MAX_INS is limited to 8, but Cirrus Logic HDA bridge CS8409
has 18 input pins, 16 ASP receivers and 2 DMIC inputs. We have to increase this
value to 18, so generic code can handle this correctly.

Tested on DELL Inspiron-3505, DELL Inspiron-3501, DELL Inspiron-3500

Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
---

Changes in v3:
- No changes

 sound/pci/hda/hda_auto_parser.h | 2 +-
 sound/pci/hda/hda_local.h       | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/hda_auto_parser.h b/sound/pci/hda/hda_auto_parser.h
index a22ca0e17a08..df63d66af1ab 100644
--- a/sound/pci/hda/hda_auto_parser.h
+++ b/sound/pci/hda/hda_auto_parser.h
@@ -27,7 +27,7 @@ enum {
 };
 
 #define AUTO_CFG_MAX_OUTS	HDA_MAX_OUTS
-#define AUTO_CFG_MAX_INS	8
+#define AUTO_CFG_MAX_INS	18
 
 struct auto_pin_cfg_item {
 	hda_nid_t pin;
diff --git a/sound/pci/hda/hda_local.h b/sound/pci/hda/hda_local.h
index 5beb8aa44ecd..317245a5585d 100644
--- a/sound/pci/hda/hda_local.h
+++ b/sound/pci/hda/hda_local.h
@@ -180,7 +180,7 @@ int snd_hda_create_spdif_in_ctls(struct hda_codec *codec, hda_nid_t nid);
 /*
  * input MUX helper
  */
-#define HDA_MAX_NUM_INPUTS	16
+#define HDA_MAX_NUM_INPUTS	36
 struct hda_input_mux_item {
 	char label[32];
 	unsigned int index;
-- 
2.25.1

