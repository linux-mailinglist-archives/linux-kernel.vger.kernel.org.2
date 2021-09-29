Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C69F41C747
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 16:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344678AbhI2OxC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 10:53:02 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:22206 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344650AbhI2OxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 10:53:01 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18T5qbwM025601;
        Wed, 29 Sep 2021 09:51:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=j7CawL2JYw9l4rAzZ4MteugwqrAiecmBigrUjbkw7FU=;
 b=RcOInJ5GtzSGtmI+c11Cutu5Gbc2JhK/J5l3m9tHpUC5+rp8bIFK1XdtdKRJufIhPkKV
 TatQpJ9dvmHRmMqTdfD2Mq2SQtOs1oYD4fERwnIViShbmsMoLm1vWu8fy0rkKU3N0wU0
 0DxdyxnxE5jBdEqvp+i5hb/Opw0t8OCKoDVeAH3yRYsLvunHY3fKLD3EZUha3Itnzwox
 kz7bhZxsp+iHgoclaM5xoQxjR2k6BySk4hbMv+IC8XKy9okLuS1/KAUh8P7+cMSJz5dQ
 VCv2u1lWxL33CaZArAocVW3orkvC2edhrKyw9jXnfrcuPoOBdQ9hAPoNDbpF5Zmf8fPz iA== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 3bc62dhedd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 29 Sep 2021 09:51:09 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Wed, 29 Sep
 2021 15:51:08 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.12 via Frontend
 Transport; Wed, 29 Sep 2021 15:51:08 +0100
Received: from simont-vb.lan?044ad.cirrus.com (unknown [198.90.238.180])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id B33EEB0E;
        Wed, 29 Sep 2021 14:51:01 +0000 (UTC)
From:   Simon Trimmer <simont@opensource.cirrus.com>
To:     <broonie@kernel.org>, <lgirdwood@gmail.com>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>,
        Simon Trimmer <simont@opensource.cirrus.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] ASoC: wm_adsp: Fix compilation when debugfs is disabled
Date:   Wed, 29 Sep 2021 15:50:40 +0100
Message-ID: <20210929145040.793252-1-simont@opensource.cirrus.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: z6ZCttdcZ5e3cCSuIvzrCCfH7IP8fPik
X-Proofpoint-ORIG-GUID: z6ZCttdcZ5e3cCSuIvzrCCfH7IP8fPik
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Guard the use of component->debufs_root against CONFIG_DEBUG_FS

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
---
 sound/soc/codecs/wm_adsp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index f17c749c24c3..03cfaa82b031 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -1028,7 +1028,9 @@ int wm_adsp2_component_probe(struct wm_adsp *dsp, struct snd_soc_component *comp
 	snprintf(preload, ARRAY_SIZE(preload), "%s Preload", dsp->cs_dsp.name);
 	snd_soc_component_disable_pin(component, preload);
 
+#if IS_ENABLED(CONFIG_DEBUG_FS)
 	cs_dsp_init_debugfs(&dsp->cs_dsp, component->debugfs_root);
+#endif
 
 	dsp->component = component;
 
-- 
2.33.0

