Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89D4F3DBBF7
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 17:19:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239557AbhG3PTb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 11:19:31 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:59044 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S239320AbhG3PTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 11:19:30 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 16UELBKd004490;
        Fri, 30 Jul 2021 10:19:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=SY3gWby+jsBVNB3sOjtEiZnHHv37iz01pUDXfInWjtM=;
 b=PsY6R2Bnyv9bTeNgr8azqwhJ3IpzWvkMm6qJth9os+ud6S0sGMlguJKv594jk2JkMec8
 ddSHJ3pG5Xru85YUNFyT2RuljO3Vx8ebYwITOzXMHxQ/QNyiXOaH/9prI1wzrvRNawjR
 S4yrKMK07gX7SGl5iIRr81Zm7w91LQfFDrMgFqYUgEHLzD6r9HnKnx9WFd3JI2jnmCYU
 gMN5SChACKyIpD1kVKee9EJKVP4T73vhvT7DrB/vHmByHkESmr++PIFnth4vs33HC4TV
 f6VUpq2YhYSo4dgkKKVtRBQ+r5EY2i3JcKGGMMlAsXyX1NpbCxs/8ngO77AcInunhkG3 rA== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 3a41wd181m-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 30 Jul 2021 10:19:18 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 30 Jul
 2021 16:19:08 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Fri, 30 Jul 2021 16:19:08 +0100
Received: from vitaly-Inspiron-5415.ad.cirrus.com (unknown [198.90.238.32])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 6D61A46E;
        Fri, 30 Jul 2021 15:19:08 +0000 (UTC)
From:   Vitaly Rodionov <vitalyr@opensource.cirrus.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>,
        Lucas Tanure <tanureal@opensource.cirrus.com>
Subject: [PATCH v3 08/27] ALSA: hda/cs8409: Disable unsolicited response for the first boot
Date:   Fri, 30 Jul 2021 16:18:25 +0100
Message-ID: <20210730151844.7873-9-vitalyr@opensource.cirrus.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210730151844.7873-1-vitalyr@opensource.cirrus.com>
References: <20210730151844.7873-1-vitalyr@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: gJ3H8hOzuS3Le2_v9QZBZOXz0HrGS6Ph
X-Proofpoint-ORIG-GUID: gJ3H8hOzuS3Le2_v9QZBZOXz0HrGS6Ph
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 impostorscore=0
 spamscore=0 clxscore=1015 mlxscore=0 mlxlogscore=999 lowpriorityscore=0
 malwarescore=0 phishscore=0 bulkscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2107300102
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lucas Tanure <tanureal@opensource.cirrus.com>

The subsequence suspend and remuse have their enable/disable
unsolicited responses at the correct place already

Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
---

Changes in v2:
- No changes

Changes in v3:
- No changes

 sound/pci/hda/patch_cs8409.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/pci/hda/patch_cs8409.c b/sound/pci/hda/patch_cs8409.c
index 4906d2913603..2ed07ab3f47e 100644
--- a/sound/pci/hda/patch_cs8409.c
+++ b/sound/pci/hda/patch_cs8409.c
@@ -621,9 +621,6 @@ static void cs8409_cs42l42_hw_init(struct hda_codec *codec)
 		for (; seq_bullseye->nid; seq_bullseye++)
 			cs8409_vendor_coef_set(codec, seq_bullseye->cir, seq_bullseye->coeff);
 
-	/* Disable Unsolicited Response during boot */
-	cs8409_enable_ur(codec, 0);
-
 	/* Reset CS42L42 */
 	cs8409_cs42l42_reset(codec);
 
@@ -795,6 +792,8 @@ void cs8409_cs42l42_fixups(struct hda_codec *codec, const struct hda_fixup *fix,
 					      HDA_INPUT, 0, 0xff, 0x19);
 		snd_hda_gen_add_kctl(&spec->gen, NULL, &cs8409_cs42l42_hp_volume_mixer);
 		snd_hda_gen_add_kctl(&spec->gen, NULL, &cs8409_cs42l42_amic_volume_mixer);
+		/* Disable Unsolicited Response during boot */
+		cs8409_enable_ur(codec, 0);
 		cs8409_cs42l42_hw_init(codec);
 		snd_hda_codec_set_name(codec, "CS8409/CS42L42");
 		break;
-- 
2.25.1

