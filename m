Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBFC438FD72
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 11:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232038AbhEYJKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 05:10:08 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:43702 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231129AbhEYJKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 05:10:07 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14P97IsF008620;
        Tue, 25 May 2021 04:08:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=7n422p9T8ghaKphmBMkPMyz4RAQHIKos1LOT1rXV8BE=;
 b=Lcqsfn2JvZF8g681/Kr4pknlNx/6EQ7yAQ2s7CT4ypxflbL62BUTbaqb4n8vy9k2OuAl
 MB4gpl9daGLFESCFGxRZdZFrloqu1xKPvxzisxLXQlrXvYw176rFzexFg0oVEeI3fzoR
 Z9o3kMjo4euEcjKUo9MH8VSW+9ohmP+8jY/8NVaNvZ3emevbwfcXX1Wct5PbQkxYFy10
 6F9Plhg9qoX94lgxZc1MB2ZasnxTN0ciwLeS2vixmIIRJ96n43g8+6sw3mW3+p+eVgDg
 MtJkeE00tOggj0rFv3RuL3Fl+Iqi5+6Ihzgxp4fTxi8bTQGB3twm9+s8F6QipBLsG5x4 fw== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 38r28v1khx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 25 May 2021 04:08:26 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 25 May
 2021 10:08:25 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Tue, 25 May 2021 10:08:25 +0100
Received: from aryzen.ad.cirrus.com (unknown [198.61.64.177])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 0F49E11D7;
        Tue, 25 May 2021 09:08:25 +0000 (UTC)
From:   Lucas Tanure <tanureal@opensource.cirrus.com>
To:     James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>,
        Lucas Tanure <tanureal@opensource.cirrus.com>
Subject: [PATCH 3/4] ASoC: cs42l42: Add support for 2400000 Bit clock
Date:   Tue, 25 May 2021 10:08:21 +0100
Message-ID: <20210525090822.64577-3-tanureal@opensource.cirrus.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210525090822.64577-1-tanureal@opensource.cirrus.com>
References: <20210525090822.64577-1-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: keDRonjLfUDAHRTY5s3FWFEhr43NuFVT
X-Proofpoint-GUID: keDRonjLfUDAHRTY5s3FWFEhr43NuFVT
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 suspectscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 mlxscore=0
 lowpriorityscore=0 mlxlogscore=999 bulkscore=0 impostorscore=0
 adultscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105250061
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for 2.4MHz clock source

Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
---
 sound/soc/codecs/cs42l42.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/cs42l42.c b/sound/soc/codecs/cs42l42.c
index 07223b5fb2d6..8260de81b56c 100644
--- a/sound/soc/codecs/cs42l42.c
+++ b/sound/soc/codecs/cs42l42.c
@@ -599,6 +599,7 @@ struct cs42l42_pll_params {
 static const struct cs42l42_pll_params pll_ratio_table[] = {
 	{ 1536000, 0, 1, 0x00, 0x7D, 0x000000, 0x03, 0x10, 12000000, 125, 2},
 	{ 2304000, 0, 1, 0x00, 0x55, 0xC00000, 0x02, 0x10, 12288000,  85, 2},
+	{ 2400000, 0, 1, 0x00, 0x50, 0x000000, 0x03, 0x10, 12000000,  80, 2},
 	{ 2822400, 0, 1, 0x00, 0x40, 0x000000, 0x03, 0x10, 11289600, 128, 1},
 	{ 3000000, 0, 1, 0x00, 0x40, 0x000000, 0x03, 0x10, 12000000, 128, 1},
 	{ 3072000, 0, 1, 0x00, 0x3E, 0x800000, 0x03, 0x10, 12000000, 125, 1},
-- 
2.31.1

