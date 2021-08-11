Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCD403E986A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 21:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231699AbhHKTNT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 15:13:19 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:51748 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231646AbhHKTNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 15:13:16 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 17B9hd02013981;
        Wed, 11 Aug 2021 14:12:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=Dq0oAn1cMIbGfVXOudW2sRnTXcb2n86CQUdvFbyDZpM=;
 b=M6nVjcCvCUrXNIB7thQoshdfccjsom5bnpMUIrTyDsmszpfTX4AF1hlmZzlXI3XxYZvh
 M6oMtW8cwHioqOIrhnK8N0szsaqQn/k2rBL2rjGueRnGTo3PePzvZOIPQjbj61YxMfiY
 cvhvMJ/vTWNIlZtjqNfeGHgUev/nMChU50hGt5BIcLsZOJaeK9wspkKZg8bwTnaF9Cvj
 1zNsB7e0RSDMZ+oda6PXqr4+ksF3utstJjYyQqdnxbr16IUmVGtHV7PlwZ0ux6vaIeBE
 tdl5LvshOBnbDBFPRNpuRm/vTrG2+sLN6Eu/LmrVmpcypq0B2CeWAAeiPSduUS2LQ5/r JQ== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 3acc5ngpgw-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 11 Aug 2021 14:12:40 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Wed, 11 Aug
 2021 19:57:32 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.12 via Frontend
 Transport; Wed, 11 Aug 2021 19:57:32 +0100
Received: from vitaly-Inspiron-5415.ad.cirrus.com (unknown [198.90.238.180])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id C061946E;
        Wed, 11 Aug 2021 18:57:31 +0000 (UTC)
From:   Vitaly Rodionov <vitalyr@opensource.cirrus.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH v4 22/27] ALSA: hda/cs8409: Enable Full Scale Volume for Line Out Codec on Dolphin
Date:   Wed, 11 Aug 2021 19:56:49 +0100
Message-ID: <20210811185654.6837-23-vitalyr@opensource.cirrus.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210811185654.6837-1-vitalyr@opensource.cirrus.com>
References: <20210811185654.6837-1-vitalyr@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: nuwXTraLZNKbDV1wsAtNKD_e1PlM_-Bs
X-Proofpoint-GUID: nuwXTraLZNKbDV1wsAtNKD_e1PlM_-Bs
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 phishscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 impostorscore=0
 malwarescore=0 adultscore=0 mlxlogscore=999 mlxscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108110132
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Binding <sbinding@opensource.cirrus.com>

Headphones codec will keep reduced maximum volume.
Line Out codec will have increased maximum volume.

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
---

Changes in v2:
- No changes

Changes in v3:
- No changes

Changes in v4:
- No changes

 sound/pci/hda/patch_cs8409-tables.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/patch_cs8409-tables.c b/sound/pci/hda/patch_cs8409-tables.c
index 6453a7ec3856..a39b2c20f61c 100644
--- a/sound/pci/hda/patch_cs8409-tables.c
+++ b/sound/pci/hda/patch_cs8409-tables.c
@@ -300,10 +300,10 @@ static const struct cs8409_i2c_param dolphin_c0_init_reg_seq[] = {
 	{ 0x2901, 0x01 },
 	{ 0x1101, 0x0A },
 	{ 0x1102, 0x84 },
+	{ 0x2001, 0x03 },
 	{ 0x2301, 0x00 },
 	{ 0x2303, 0x00 },
 	{ 0x2302, 0x3f },
-	{ 0x2001, 0x03 },
 	{ 0x1B75, 0xB6 },
 	{ 0x1B73, 0xC2 },
 	{ 0x1129, 0x01 },
@@ -356,10 +356,10 @@ static const struct cs8409_i2c_param dolphin_c1_init_reg_seq[] = {
 	{ 0x2901, 0x00 },
 	{ 0x1101, 0x0E },
 	{ 0x1102, 0x84 },
+	{ 0x2001, 0x01 },
 	{ 0x2301, 0x00 },
 	{ 0x2303, 0x00 },
 	{ 0x2302, 0x3f },
-	{ 0x2001, 0x03 },
 	{ 0x1B75, 0xB6 },
 	{ 0x1B73, 0xC2 },
 	{ 0x1129, 0x01 },
-- 
2.25.1

