Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BD173D8F6E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 15:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236695AbhG1NrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 09:47:05 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:62614 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236384AbhG1Now (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 09:44:52 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 16S5XUql014335;
        Wed, 28 Jul 2021 08:44:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=7vkQIoBquMVVKjTnWMLcfqhODSdY1nfkUHZ8S3dlJNU=;
 b=d9pnkH+7ffix3IWdWH010Ic8bKdngFB2dA+SCbqaeTvLP6NkyBQo6wyGilY4jibb0aYC
 vh9B5hnM0RUAfofGWA4+HnV+SFMIhhez0FBD+UC7yk8ce7uFCqin04tljGkCQoANOoQm
 ZnujysMtaxHE6BZ1wvmUqvdP1pFzZeskXpVnw7FSwkajM5DkTxb1+kuTooRopYI3Dnvi
 OjkZCwxiWgLbBRiSPbMIVNp3APcaAZcxy0AvjgwpENpRkdQI3YO2OGWUCFJjyUuAeKDA
 nT7xF4SJOE4jg15oAJoprXuj0OBNb+NVpm1JrSBMSdbTxneyQEbglcsGQ494MICSbPeI 8A== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 3a30q20fx9-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 28 Jul 2021 08:44:34 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Wed, 28 Jul
 2021 14:44:31 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Wed, 28 Jul 2021 14:44:31 +0100
Received: from vitaly-Inspiron-5415.ad.cirrus.com (unknown [198.90.238.32])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id B64482BA;
        Wed, 28 Jul 2021 13:44:30 +0000 (UTC)
From:   Vitaly Rodionov <vitalyr@opensource.cirrus.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH v2 04/27] ALSA: hda/cs8409: Mask all CS42L42 interrupts on initialization
Date:   Wed, 28 Jul 2021 14:43:45 +0100
Message-ID: <20210728134408.369396-5-vitalyr@opensource.cirrus.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210728134408.369396-1-vitalyr@opensource.cirrus.com>
References: <20210728134408.369396-1-vitalyr@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Zcjs7wkf_Pl7XmigpfZXZF_1GOEyjkCJ
X-Proofpoint-GUID: Zcjs7wkf_Pl7XmigpfZXZF_1GOEyjkCJ
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 adultscore=0 clxscore=1015 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2107280077
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Binding <sbinding@opensource.cirrus.com>

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>

Changes in v2:
- No changes

---
 sound/pci/hda/patch_cs8409-tables.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/sound/pci/hda/patch_cs8409-tables.c b/sound/pci/hda/patch_cs8409-tables.c
index 5766433325a9..91b6a5b2824a 100644
--- a/sound/pci/hda/patch_cs8409-tables.c
+++ b/sound/pci/hda/patch_cs8409-tables.c
@@ -159,6 +159,18 @@ const struct cs8409_i2c_param cs42l42_init_reg_seq[] = {
 	{ 0x1105, 0x00 },
 	{ 0x1112, 0xC0 },
 	{ 0x1101, 0x02 },
+	{ 0x1316, 0xff },
+	{ 0x1317, 0xff },
+	{ 0x1318, 0xff },
+	{ 0x1319, 0xff },
+	{ 0x131a, 0xff },
+	{ 0x131b, 0xff },
+	{ 0x131c, 0xff },
+	{ 0x131e, 0xff },
+	{ 0x131f, 0xff },
+	{ 0x1320, 0xff },
+	{ 0x1b79, 0xff },
+	{ 0x1b7a, 0xff },
 	{} /* Terminator */
 };
 
-- 
2.25.1

