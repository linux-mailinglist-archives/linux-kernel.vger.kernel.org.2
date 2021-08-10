Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B18AA3E7C8C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 17:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243564AbhHJPkv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 11:40:51 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:42872 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243372AbhHJPin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 11:38:43 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 17A75fJP008310;
        Tue, 10 Aug 2021 10:38:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=qzvlKgJespRUedNIeq1fve2TKFRXG8vS3eQ0J6/hgy8=;
 b=qS9rMEQMtYl+YdJuja+4kbjkBqOogEnXfZHjvSawOOZ875KvlvsuJDsBu7ImpTM48gEV
 SxVW+qD0J2J4z4nrpN92+NXus/9BK7iT1LoMYCsA+JQvaXdATdXNcqxlJZm+p5gFeLlA
 O5ABnJ84zbgPvcGxwRlOYss2HciIKhIumB48Ypmi4S/Bb9xR6gezPwd+1tbLf615tset
 ikvw+NAp7tEnmAU+DsEHI/X8c8TbfO9VO24wnzi9UkBaFdxwQqMWr/pf14n/3SmdjAOC
 G9WRCzWdKK78/yPze+lc0vPLC9mAz0mPMmyP49HGGVo+SIh+LNGan/hWlRNy5QwxatDs Xw== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 3abmrkgkf6-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 10 Aug 2021 10:38:05 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Tue, 10 Aug
 2021 16:38:03 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.12 via Frontend
 Transport; Tue, 10 Aug 2021 16:38:03 +0100
Received: from AUSNPC0LSNW1-debian.cirrus.com (AUSNPC0LSNW1.ad.cirrus.com [198.61.64.221])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 8E1D546E;
        Tue, 10 Aug 2021 15:38:03 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 04/12] ASoC: cs42l42: Don't reconfigure the PLL while it is running
Date:   Tue, 10 Aug 2021 16:37:51 +0100
Message-ID: <20210810153759.24333-5-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210810153759.24333-1-rf@opensource.cirrus.com>
References: <20210810153759.24333-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: mTAyoRH8qLTBDN6MmPAfFNTYDN0T_OFj
X-Proofpoint-ORIG-GUID: mTAyoRH8qLTBDN6MmPAfFNTYDN0T_OFj
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0 adultscore=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 mlxlogscore=963 mlxscore=0 phishscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108100099
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cs42l42_pcm_hw_params() must only configure the PLL if this is the first
stream to become active, otherwise it will be overwriting the registers
while the PLL is running.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Fixes: 43fc357199f9 ("ASoC: cs42l42: Set clock source for both ways of stream")
---
 sound/soc/codecs/cs42l42.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cs42l42.c b/sound/soc/codecs/cs42l42.c
index 5dc3a30272a4..1893d3694570 100644
--- a/sound/soc/codecs/cs42l42.c
+++ b/sound/soc/codecs/cs42l42.c
@@ -884,7 +884,11 @@ static int cs42l42_pcm_hw_params(struct snd_pcm_substream *substream,
 		break;
 	}
 
-	return cs42l42_pll_config(component);
+	/* Configure the PLL if this is the first active stream */
+	if (!cs42l42->stream_use)
+		return cs42l42_pll_config(component);
+	else
+		return 0;
 }
 
 static int cs42l42_set_sysclk(struct snd_soc_dai *dai,
-- 
2.11.0

