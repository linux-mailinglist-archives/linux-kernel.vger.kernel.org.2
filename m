Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 722AF3E9869
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 21:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231133AbhHKTNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 15:13:17 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:63730 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231605AbhHKTNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 15:13:15 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 17B9hd05013981;
        Wed, 11 Aug 2021 14:12:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=tAGn6pVi9o1qiLueUKyeFz8u0HK0oeRoruIzeE+wL8k=;
 b=ab7ToA32u/5HdCb7atyoE95I00O0l+3eMo5bFX4U2dCFZ2AKlibotv0rlw2/Ii/d+/SR
 FTV05w3RLfTfVeLvZRfKjffu/DShuP2R1Y66M/ra84RMAw/ElPz+s34vH6okyLPYkAFq
 8SrjhITFGTr600uaOw27qkn7uTFJ54Wc4IstAEGeshpwkUWtHk88uud4KnjAjXjoCPxt
 qDA9bZf0gcQYvMR/AbiF93+4XG8Hi/DQ7vsoji3HEyH4mckc9ObZufSUYAl+0hjJuM3h
 YC3uIGkgmXrrV+NXvttLsrDCI9ac/GWzYCrSsQy/xAxzP1KfqA+EUGhmfkT2PprBFJu1 zA== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 3acc5ngpgw-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 11 Aug 2021 14:12:42 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Wed, 11 Aug
 2021 19:57:32 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.12 via Frontend
 Transport; Wed, 11 Aug 2021 19:57:32 +0100
Received: from vitaly-Inspiron-5415.ad.cirrus.com (unknown [198.90.238.180])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 98CBB45D;
        Wed, 11 Aug 2021 18:57:32 +0000 (UTC)
From:   Vitaly Rodionov <vitalyr@opensource.cirrus.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH v4 25/27] ALSA: hda/cs8409: Remove unnecessary delays
Date:   Wed, 11 Aug 2021 19:56:52 +0100
Message-ID: <20210811185654.6837-26-vitalyr@opensource.cirrus.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210811185654.6837-1-vitalyr@opensource.cirrus.com>
References: <20210811185654.6837-1-vitalyr@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Fps13D_fBALcbtnv7soQyb5kmhrWW5oh
X-Proofpoint-GUID: Fps13D_fBALcbtnv7soQyb5kmhrWW5oh
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 phishscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 impostorscore=0
 malwarescore=0 adultscore=0 mlxlogscore=982 mlxscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108110132
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Binding <sbinding@opensource.cirrus.com>

Since delays when starting jack detection after initialization
have been reduced/removed, it is necessary to add back in an extra
20ms delay after the init sequence to allow the CS42L42 to power up
correctly.

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
---

Changes in v2:
- No changes

Changes in v3:
- No changes

Changes in v4:
- No changes

 sound/pci/hda/patch_cs8409.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/sound/pci/hda/patch_cs8409.c b/sound/pci/hda/patch_cs8409.c
index 9f6c51a5835a..b528c8353b3c 100644
--- a/sound/pci/hda/patch_cs8409.c
+++ b/sound/pci/hda/patch_cs8409.c
@@ -541,12 +541,10 @@ static void cs42l42_run_jack_detect(struct sub_codec *cs42l42)
 	cs8409_i2c_write(cs42l42, 0x1b74, 0x07);
 	cs8409_i2c_write(cs42l42, 0x131b, 0xFD);
 	cs8409_i2c_write(cs42l42, 0x1120, 0x80);
-	/* Wait ~110ms*/
-	usleep_range(110000, 200000);
+	/* Wait ~100us*/
+	usleep_range(100, 200);
 	cs8409_i2c_write(cs42l42, 0x111f, 0x77);
 	cs8409_i2c_write(cs42l42, 0x1120, 0xc0);
-	/* Wait ~10ms */
-	usleep_range(10000, 25000);
 }
 
 static int cs42l42_handle_tip_sense(struct sub_codec *cs42l42, unsigned int reg_ts_status)
@@ -653,6 +651,7 @@ static void cs42l42_resume(struct sub_codec *cs42l42)
 
 	/* Initialize CS42L42 companion codec */
 	cs8409_i2c_bulk_write(cs42l42, cs42l42->init_seq, cs42l42->init_seq_num);
+	usleep_range(20000, 25000);
 
 	/* Clear interrupts, by reading interrupt status registers */
 	cs8409_i2c_bulk_read(cs42l42, irq_regs, ARRAY_SIZE(irq_regs));
@@ -927,7 +926,6 @@ void cs8409_cs42l42_fixups(struct hda_codec *codec, const struct hda_fixup *fix,
 		 * Run immediately after init.
 		 */
 		cs42l42_run_jack_detect(spec->scodecs[CS8409_CODEC0]);
-		usleep_range(100000, 150000);
 		break;
 	default:
 		break;
@@ -1122,10 +1120,8 @@ void dolphin_fixups(struct hda_codec *codec, const struct hda_fixup *fix, int ac
 		 * been already plugged in.
 		 * Run immediately after init.
 		 */
-		for (i = 0; i < spec->num_scodecs; i++) {
+		for (i = 0; i < spec->num_scodecs; i++)
 			cs42l42_run_jack_detect(spec->scodecs[i]);
-			usleep_range(100000, 150000);
-		}
 
 		break;
 	default:
-- 
2.25.1

