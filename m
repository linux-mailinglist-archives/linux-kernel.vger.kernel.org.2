Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC1A03E980A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 20:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbhHKS6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 14:58:06 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:23464 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229655AbhHKS6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 14:58:05 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 17B9h6hN011884;
        Wed, 11 Aug 2021 13:57:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=QRPmsHwtdf9sopUR0LSezE2c8KAdAxe6YRd8r6DQJNg=;
 b=hwbv8SgRVZOaOaKJMPMZSFr8Bvt86lUYRIThuqtZ2EdKs9s0I71XDy4SbHq4Y16zVJnY
 GwaPjxtCdjUkcyeEsdl36oz3aur6Oe9lNyI9ADteWIL74uIirn5AuYxkTsyOG2HPX3AE
 YLil8hHuiQsMF6QbPyp5QnywHS1zSnQLjB/aGfZP0uP57kYS3jt2p1pQLk3/vmlMu7gP
 en5so7eW5kSX6IC0OB6o6LYQ8vyz5nthXaG2M9GcXSZaJ69MC+I6cZ5H3kCnRBBGrbOP
 yzXU4ZxS1s1xccwp1o1N0/GCdwaQyWCYJ7/Kj1zxXxgZMO4aLKowifoyH+2lBIg8MKmK Ow== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 3acc5ngnt3-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 11 Aug 2021 13:57:31 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Wed, 11 Aug
 2021 19:57:28 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.12 via Frontend
 Transport; Wed, 11 Aug 2021 19:57:28 +0100
Received: from vitaly-Inspiron-5415.ad.cirrus.com (unknown [198.90.238.180])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id E84F446E;
        Wed, 11 Aug 2021 18:57:27 +0000 (UTC)
From:   Vitaly Rodionov <vitalyr@opensource.cirrus.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH v4 09/27] ALSA: hda/cs8409: Mask CS42L42 wake events
Date:   Wed, 11 Aug 2021 19:56:36 +0100
Message-ID: <20210811185654.6837-10-vitalyr@opensource.cirrus.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210811185654.6837-1-vitalyr@opensource.cirrus.com>
References: <20210811185654.6837-1-vitalyr@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 0b8XlqRU0qV1F2XTzMltqpQMTfVo30um
X-Proofpoint-GUID: 0b8XlqRU0qV1F2XTzMltqpQMTfVo30um
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 phishscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 impostorscore=0
 malwarescore=0 adultscore=0 mlxlogscore=984 mlxscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108110130
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Binding <sbinding@opensource.cirrus.com>

Wake events are not needed for jack detect.

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
---

Changes in v2:
- No changes

Changes in v3:
- No changes

Changes in v4:
- No changes

 sound/pci/hda/patch_cs8409.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/patch_cs8409.c b/sound/pci/hda/patch_cs8409.c
index 2ed07ab3f47e..f4401c1e8572 100644
--- a/sound/pci/hda/patch_cs8409.c
+++ b/sound/pci/hda/patch_cs8409.c
@@ -399,11 +399,11 @@ static void cs8409_cs42l42_enable_jack_detect(struct hda_codec *codec)
 		cs8409_i2c_write(codec, CS42L42_I2C_ADDR, 0x1b70, 0x00a0, 1);
 
 	/* Clear WAKE# */
-	cs8409_i2c_write(codec, CS42L42_I2C_ADDR, 0x1b71, 0x0001, 1);
+	cs8409_i2c_write(codec, CS42L42_I2C_ADDR, 0x1b71, 0x00C1, 1);
 	/* Wait ~2.5ms */
 	usleep_range(2500, 3000);
 	/* Set mode WAKE# output follows the combination logic directly */
-	cs8409_i2c_write(codec, CS42L42_I2C_ADDR, 0x1b71, 0x0020, 1);
+	cs8409_i2c_write(codec, CS42L42_I2C_ADDR, 0x1b71, 0x00C0, 1);
 	/* Clear interrupts status */
 	cs8409_i2c_read(codec, CS42L42_I2C_ADDR, 0x130f, 1);
 	cs8409_i2c_read(codec, CS42L42_I2C_ADDR, 0x1b7b, 1);
-- 
2.25.1

