Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3635641DC26
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 16:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351885AbhI3OXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 10:23:25 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:43132 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1351840AbhI3OXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 10:23:24 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18U4txao008227;
        Thu, 30 Sep 2021 09:21:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=9T7IUXssVAtD3OmN01m5KXu7rIz2dffdsLsJeMQpJUg=;
 b=Qdbg6XlmTsV2iMxFU9PV3LQl2ZjZpB485GsrR7/luMWUBVJsfJTooljw8kQ0ruN7Ec15
 Ar3CF0joOa5Tkn25tRDTGnaIowxY0265xDzZBXqyn9FhOlwHqPsunaEM5Dttd34U5shE
 dUyzOYVo4OUC+VQ03/7xuzDpfZyi7Sx4oOwsrql8qKXmJ5EU5F3CyaAJvijCujbd2vXW
 RzA3ZZo8IH7VudvSmRzcPjz85CnXy9a0Xttl05QQngv/Qy+CVCqXC04D8wcHffrR3/yG
 S6Fl8ojVnzB1vxj+lRlCj6iFh0GLSaAFdykjrlXMMBn3lKrsdptQDf3deQiR6mLek8AW zQ== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 3bcxjx92xu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 30 Sep 2021 09:21:30 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Thu, 30 Sep
 2021 15:21:28 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.12 via Frontend
 Transport; Thu, 30 Sep 2021 15:21:28 +0100
Received: from simont-vb.lan?044ad.cirrus.com (unknown [198.90.238.180])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 1FD59B13;
        Thu, 30 Sep 2021 14:21:28 +0000 (UTC)
From:   Simon Trimmer <simont@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>,
        Simon Trimmer <simont@opensource.cirrus.com>
Subject: [PATCH] ASoC: soc-component: Remove conditional definition of debugfs data members
Date:   Thu, 30 Sep 2021 15:21:16 +0100
Message-ID: <20210930142116.528878-1-simont@opensource.cirrus.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: o0TTWUg_feZu5rcDiKtsMydRci6C9M4Q
X-Proofpoint-ORIG-GUID: o0TTWUg_feZu5rcDiKtsMydRci6C9M4Q
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This simplification allows the use of the standard kernel pattern of
static inline dummy functions for debugfs code. Most systems will only
have a small number of snd_soc_components so the memory impact is
minimal.

Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
Suggested-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc-component.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/sound/soc-component.h b/include/sound/soc-component.h
index e09a2d108e8c..3a35d149e92f 100644
--- a/include/sound/soc-component.h
+++ b/include/sound/soc-component.h
@@ -227,10 +227,8 @@ struct snd_soc_component {
 	struct snd_compr_stream  *mark_compr_open;
 	void *mark_pm;
 
-#ifdef CONFIG_DEBUG_FS
 	struct dentry *debugfs_root;
 	const char *debugfs_prefix;
-#endif
 };
 
 #define for_each_component_dais(component, dai)\
-- 
2.33.0

