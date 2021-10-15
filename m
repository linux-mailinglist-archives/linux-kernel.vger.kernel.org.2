Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B3CB42F3BC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 15:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239892AbhJONju (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 09:39:50 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:56010 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S240013AbhJONil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 09:38:41 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19F4c2t2023483;
        Fri, 15 Oct 2021 08:36:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=dZAgC/Rt9qiMgH13szDcBCCiLkk5iVRhXXBnSYgZmNk=;
 b=HIo9mrU6PJmx5T+Tt+rzNI3B0txrQPUfq21P9Az0EycaiqKGSAc/13n225/02i79huMq
 XoRfAmaGETNiI3jFATG2oMg+CdkTXlkPQ14vaZFYjZ4qnSjPCtaQROtuVr00d0xe0pct
 +NVfPUYLhVxo+avOGQc8+gWXrVRa4S730SBiSk0t8D6ZrDRAbv1wxJ/pfdMg8rPVSUVu
 SeT+tbaQ0M/OJarRCadfROUJsgZVPWDyc10q2QxpR1fUr472vKjSfOcW6QMHnqhjdPsk
 DQLwmgdzv4qabD9x/KvLwyd4fkfD3Vwg+I9idti/6kzLUNroCg3fqE5lzU3HV8ZxkXeH Kg== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 3bq1gagp5v-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 15 Oct 2021 08:36:26 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 15 Oct
 2021 14:36:24 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.7 via Frontend
 Transport; Fri, 15 Oct 2021 14:36:24 +0100
Received: from AUSNPC0LSNW1-debian.cirrus.com (AUSNPC0LSNW1.ad.cirrus.com [198.61.65.254])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id F1A8711DA;
        Fri, 15 Oct 2021 13:36:23 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 08/16] ASoC: cs42l42: Reset and power-down on driver remove()
Date:   Fri, 15 Oct 2021 14:36:11 +0100
Message-ID: <20211015133619.4698-9-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211015133619.4698-1-rf@opensource.cirrus.com>
References: <20211015133619.4698-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Ce7s5-7Zf4TaXYo3ZYuPwDgxZtZhWw8q
X-Proofpoint-GUID: Ce7s5-7Zf4TaXYo3ZYuPwDgxZtZhWw8q
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Driver remove() should assert RESET and disable the supplies.
Previously this assumed that calling pm_runtime_suspend() would result
in a call to cs42l42_runtime_suspend() to power-down. This isn't
guaranteed - pm_runtime can be disabled.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Fixes: 2b869e0ea598 ("ASoC: cs42l42: Remove power if the driver is being removed")
---
 sound/soc/codecs/cs42l42.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/codecs/cs42l42.c b/sound/soc/codecs/cs42l42.c
index 420e16563c45..cf1f68474d21 100644
--- a/sound/soc/codecs/cs42l42.c
+++ b/sound/soc/codecs/cs42l42.c
@@ -2131,6 +2131,9 @@ static int cs42l42_i2c_remove(struct i2c_client *i2c_client)
 	pm_runtime_suspend(&i2c_client->dev);
 	pm_runtime_disable(&i2c_client->dev);
 
+	gpiod_set_value_cansleep(cs42l42->reset_gpio, 0);
+	regulator_bulk_disable(ARRAY_SIZE(cs42l42->supplies), cs42l42->supplies);
+
 	return 0;
 }
 
-- 
2.11.0

