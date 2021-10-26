Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B55743B2C2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 14:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236099AbhJZNAA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 09:00:00 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:7554 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236076AbhJZM76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 08:59:58 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19Q8sshc024219;
        Tue, 26 Oct 2021 07:57:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=D/NsoehfT+y2ksi5yUQ330zicOFqX9TpEDxQN+UK6KQ=;
 b=Wgs78cGVYCcOSOtN2GVa7EOvju901nPVec8Kd58Ynt2a7xmtjiaqCGs6q/p/qVxkdT+2
 1+RtK/2dtFbHFrMXeQHLURN48mOezFGYKQHlj8GOPWV58e/6xOQ59kTTFV+fb1nA4vpx
 swTVvnShjwde9x9qMOaylxB8BZeUy9AKRfJ5REhDqBN2PjRdNvPZ7weMKpgk/6R6E9mw
 KOPvPN5hkJz1vYooVz8QfV/tHYMqkeIGY+tW8djINv8QYyLm+7IUWJuaJOa0ANpiCKPV
 Ct5wMxJARe+/v+ibgd/OVLz/gt3LeqAuhNSyAIiCmVH/+T+PHWr+DheASQC9qJ786Ltv hQ== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 3bx4fx0rf2-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 26 Oct 2021 07:57:28 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Tue, 26 Oct
 2021 13:57:25 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.7 via Frontend
 Transport; Tue, 26 Oct 2021 13:57:25 +0100
Received: from AUSNPC0LSNW1-debian.cirrus.com (AUSNPC0LSNW1.ad.cirrus.com [198.61.65.32])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 71C2F11DB;
        Tue, 26 Oct 2021 12:57:25 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 2/2] ASoC: cs42l42: free_irq() before powering-down on probe() fail
Date:   Tue, 26 Oct 2021 13:57:22 +0100
Message-ID: <20211026125722.10220-3-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211026125722.10220-1-rf@opensource.cirrus.com>
References: <20211026125722.10220-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: KHOYPb8xBrFSvRJKrnF6sMjDydp0e0rA
X-Proofpoint-ORIG-GUID: KHOYPb8xBrFSvRJKrnF6sMjDydp0e0rA
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Relying on devm to free the irq handler on probe failure leaves a
small window of opportunity for an interrupt to become pending and
then the handler to run after the chip has been reset and powered
off.

For safety cs42l42_probe() should free the irq in the error path.
As the irq is now disabled by the driver in probe() and remove()
there is no point allocating it as a devres-managed item, so
convert to plain non-devres.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/soc/codecs/cs42l42.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/cs42l42.c b/sound/soc/codecs/cs42l42.c
index dc12842ee6e1..1029f6b3eb48 100644
--- a/sound/soc/codecs/cs42l42.c
+++ b/sound/soc/codecs/cs42l42.c
@@ -2078,17 +2078,16 @@ static int cs42l42_i2c_probe(struct i2c_client *i2c_client,
 
 	/* Request IRQ if one was specified */
 	if (i2c_client->irq) {
-		ret = devm_request_threaded_irq(&i2c_client->dev,
-						i2c_client->irq,
-						NULL, cs42l42_irq_thread,
-						IRQF_ONESHOT | IRQF_TRIGGER_LOW,
-						"cs42l42", cs42l42);
+		ret = request_threaded_irq(i2c_client->irq,
+					   NULL, cs42l42_irq_thread,
+					   IRQF_ONESHOT | IRQF_TRIGGER_LOW,
+					   "cs42l42", cs42l42);
 		if (ret == -EPROBE_DEFER) {
-			goto err_disable;
+			goto err_disable_noirq;
 		} else if (ret != 0) {
 			dev_err(&i2c_client->dev,
 				"Failed to request IRQ: %d\n", ret);
-			goto err_disable;
+			goto err_disable_noirq;
 		}
 	}
 
@@ -2158,6 +2157,10 @@ static int cs42l42_i2c_probe(struct i2c_client *i2c_client,
 	regmap_write(cs42l42->regmap, CS42L42_PWR_CTL1, 0xff);
 
 err_disable:
+	if (i2c_client->irq)
+		free_irq(i2c_client->irq, cs42l42);
+
+err_disable_noirq:
 	gpiod_set_value_cansleep(cs42l42->reset_gpio, 0);
 err_disable_noreset:
 	regulator_bulk_disable(ARRAY_SIZE(cs42l42->supplies),
@@ -2170,7 +2173,7 @@ static int cs42l42_i2c_remove(struct i2c_client *i2c_client)
 	struct cs42l42_private *cs42l42 = i2c_get_clientdata(i2c_client);
 
 	if (i2c_client->irq)
-		devm_free_irq(&i2c_client->dev, i2c_client->irq, cs42l42);
+		free_irq(i2c_client->irq, cs42l42);
 
 	/*
 	 * The driver might not have control of reset and power supplies,
-- 
2.11.0

