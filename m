Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 373483D6643
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 20:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232792AbhGZRWx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 13:22:53 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:6828 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232691AbhGZRWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 13:22:50 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 16Q2DYdD012545;
        Mon, 26 Jul 2021 13:03:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=Cp3NlvdMk8wemPj+X+S+3eh8cq4mVFAFgGHWw5DH2Gw=;
 b=AxhiOa/NKufhY7P8jEZS+ZPcEz0GEhc2kH9/8wkN6zkpRJZAhoyoICXiv4uRLz4+LG1y
 0yYBGuEjUbrK9026CJgFy3scj6zlF9WNATN3pLV/+QNhMkPza+YNIPBiPutWGKkt0NTB
 a0Pn3D88MGgfsG+MK1xba16/lHl+czuQYDO48WjElzztKrnUEHU69HjySLarsayvtjdC
 m81Ap40umdKkVUAXuXkDJSQ/xhB9p/8GBpRlWlNZOfaS/3Bo5z1+Wt9qj3db1dLIDIHl
 OIKzlrhk6vdLE1qWu3YZrk356r4lSwdKRY5aTt0x5Kw7k+042JxauxWBOK/4v9jMJkBN cw== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 3a17cvhhau-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 26 Jul 2021 13:03:12 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 26 Jul
 2021 18:47:12 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Mon, 26 Jul 2021 18:47:12 +0100
Received: from vitaly-Inspiron-5415.ad.cirrus.com (unknown [198.90.238.32])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 053EC45D;
        Mon, 26 Jul 2021 17:47:11 +0000 (UTC)
From:   Vitaly Rodionov <vitalyr@opensource.cirrus.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH 25/27] ALSA: hda/cs8409: Remove unnecessary delays
Date:   Mon, 26 Jul 2021 18:46:38 +0100
Message-ID: <20210726174640.6390-26-vitalyr@opensource.cirrus.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210726174640.6390-1-vitalyr@opensource.cirrus.com>
References: <20210726174640.6390-1-vitalyr@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 2HPrh417MjQPQDx42shYg__lSuRNvo_T
X-Proofpoint-ORIG-GUID: 2HPrh417MjQPQDx42shYg__lSuRNvo_T
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 priorityscore=1501
 malwarescore=0 bulkscore=0 adultscore=0 impostorscore=0 mlxlogscore=999
 spamscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107260105
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
 sound/pci/hda/patch_cs8409.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/sound/pci/hda/patch_cs8409.c b/sound/pci/hda/patch_cs8409.c
index e0ea27124985..54780b008547 100644
--- a/sound/pci/hda/patch_cs8409.c
+++ b/sound/pci/hda/patch_cs8409.c
@@ -517,12 +517,10 @@ static void cs42l42_run_jack_detect(struct sub_codec *cs42l42)
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
@@ -629,6 +627,7 @@ static void cs42l42_resume(struct sub_codec *cs42l42)
 
 	/* Initialize CS42L42 companion codec */
 	cs8409_i2c_bulk_write(cs42l42, cs42l42->init_seq, cs42l42->init_seq_num);
+	usleep_range(20000, 25000);
 
 	/* Clear interrupts, by reading interrupt status registers */
 	cs8409_i2c_bulk_read(cs42l42, irq_regs, ARRAY_SIZE(irq_regs));
@@ -888,7 +887,6 @@ void cs8409_cs42l42_fixups(struct hda_codec *codec, const struct hda_fixup *fix,
 		 * Run immediately after init.
 		 */
 		cs42l42_run_jack_detect(spec->scodecs[CS8409_CODEC0]);
-		usleep_range(100000, 150000);
 		break;
 	default:
 		break;
@@ -1083,10 +1081,8 @@ void dolphin_fixups(struct hda_codec *codec, const struct hda_fixup *fix, int ac
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

