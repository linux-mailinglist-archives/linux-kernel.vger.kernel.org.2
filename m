Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52FB53D8F66
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 15:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236751AbhG1Nqe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 09:46:34 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:9248 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236577AbhG1Now (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 09:44:52 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 16S5XUqk014335;
        Wed, 28 Jul 2021 08:44:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=/bHZiPhZYlMPqxLNMuV2yaLHw8mxlxJDo0FwPDN8wLc=;
 b=A301stn4qNsZDTzrapUU13nSKLvyUeo1/Wy8XN9/d3xdV7ro8l+Fpx4PdGy+LfYlqwRb
 N5k/fPnCUrlvax/v7F0dMtx87MRTx63dcwAEld60LnuTKhjG4dGwoIyeEsBl/ZiYAS4D
 G9fPacKfTId8JgOckhQzYeUYoCSmAMcbjpchImCmnOpmkSLb5gPUSfySl0ES9n8jpG0g
 wksYDxLqrzE/eF8bXf8EtB/GkiawTbTotdDzTblaytlm1MMq0i7fA5ReYwIlnRjrHkJ5
 x9QBLtj5wYvoOWA3q5SQVHi5jkw+35wcetZDnZoeBm76AfpZpVW4jY/tafrwyI8JRWMv bw== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 3a30q20fxa-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 28 Jul 2021 08:44:33 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Wed, 28 Jul
 2021 14:44:31 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Wed, 28 Jul 2021 14:44:31 +0100
Received: from vitaly-Inspiron-5415.ad.cirrus.com (unknown [198.90.238.32])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 6514845D;
        Wed, 28 Jul 2021 13:44:31 +0000 (UTC)
From:   Vitaly Rodionov <vitalyr@opensource.cirrus.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH v2 06/27] ALSA: hda/cs8409: Disable unnecessary Ring Sense for Cyborg/Warlock/Bullseye
Date:   Wed, 28 Jul 2021 14:43:47 +0100
Message-ID: <20210728134408.369396-7-vitalyr@opensource.cirrus.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210728134408.369396-1-vitalyr@opensource.cirrus.com>
References: <20210728134408.369396-1-vitalyr@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 7uSNYk1ptsPOWHMKE0iJJ0KEb-pJq3rq
X-Proofpoint-GUID: 7uSNYk1ptsPOWHMKE0iJJ0KEb-pJq3rq
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 adultscore=0 clxscore=1015 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2107280077
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Binding <sbinding@opensource.cirrus.com>

Also remove unnecessary repeated register writes.

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>

Changes in v2:
- No changes

---
 sound/pci/hda/patch_cs8409-tables.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/pci/hda/patch_cs8409-tables.c b/sound/pci/hda/patch_cs8409-tables.c
index 91b6a5b2824a..07d3ae28c105 100644
--- a/sound/pci/hda/patch_cs8409-tables.c
+++ b/sound/pci/hda/patch_cs8409-tables.c
@@ -153,11 +153,9 @@ const struct cs8409_i2c_param cs42l42_init_reg_seq[] = {
 	{ 0x1121, 0xF3 },
 	{ 0x1103, 0x20 },
 	{ 0x1105, 0x00 },
-	{ 0x1112, 0xC0 },
+	{ 0x1112, 0x00 },
 	{ 0x1113, 0x80 },
 	{ 0x1C03, 0xC0 },
-	{ 0x1105, 0x00 },
-	{ 0x1112, 0xC0 },
 	{ 0x1101, 0x02 },
 	{ 0x1316, 0xff },
 	{ 0x1317, 0xff },
-- 
2.25.1

