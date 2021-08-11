Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7AD93E980D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 20:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231342AbhHKS6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 14:58:11 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:54502 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229991AbhHKS6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 14:58:09 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 17B9h6hK011884;
        Wed, 11 Aug 2021 13:57:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=h8lmfXUa4ggC7S4+zqJfEJ28HJ1BS63L210AiS34Kpw=;
 b=N29B5S0io/Q6k52Is6c7XF39MfO29Bh4qbFI0ZvdgnVMxUWeci8OnoRS81S1pnBaySjT
 1PkoqWl8YrrgI6rbuHztJ9QdnIB8TEIJ82Zoc+IrfPP5tSVUoxeyvPyRmhEax+1sBdte
 xInAERYGvqDs0vO35frCbTL0//wbS2ZCInPTMKwQ6FiORv17hTeJXJXtRP+zyEIwhg01
 jAeHk/Ng8Z0QjxSY9n353Hf9AiAt1iFT3dcCozRWbSAfyn5Htw9Tj8j5FSFS4+vP3tS/
 IbBVrsFnniDwcmpv7EnPIOz71fgSwlfm5+TCU+7c1XOZA9D2zaGEOI1USFcsDX6j/uBI 9w== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 3acc5ngnt3-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 11 Aug 2021 13:57:29 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Wed, 11 Aug
 2021 19:57:27 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.12 via Frontend
 Transport; Wed, 11 Aug 2021 19:57:27 +0100
Received: from vitaly-Inspiron-5415.ad.cirrus.com (unknown [198.90.238.180])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 1A00946E;
        Wed, 11 Aug 2021 18:57:27 +0000 (UTC)
From:   Vitaly Rodionov <vitalyr@opensource.cirrus.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH v4 06/27] ALSA: hda/cs8409: Disable unnecessary Ring Sense for Cyborg/Warlock/Bullseye
Date:   Wed, 11 Aug 2021 19:56:33 +0100
Message-ID: <20210811185654.6837-7-vitalyr@opensource.cirrus.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210811185654.6837-1-vitalyr@opensource.cirrus.com>
References: <20210811185654.6837-1-vitalyr@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: H039NpZ2VSbXnTSDj6qEjsv-0DsST97w
X-Proofpoint-GUID: H039NpZ2VSbXnTSDj6qEjsv-0DsST97w
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 phishscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 impostorscore=0
 malwarescore=0 adultscore=0 mlxlogscore=999 mlxscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108110130
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Binding <sbinding@opensource.cirrus.com>

Also remove unnecessary repeated register writes.

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
---

Changes in v2:
- No changes

Changes in v3:
- No changes

Changes in v4:
- No changes

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

