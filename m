Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 346F542F3BA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 15:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239879AbhJONjr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 09:39:47 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:18414 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S240007AbhJONik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 09:38:40 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19F4c2t9023483;
        Fri, 15 Oct 2021 08:36:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=aBpw0d20DRnWWu9PeyeVhaGhQO5L+Do26fHPjKofpaI=;
 b=Vi+T/3JIxzSwyAbuljivL2Rc27EQCPy2xyjWNiGYp561fgqJw9JXxYG08eHF9cX7JjrZ
 4ZbxVDWdjO1fHfqyXz2k5zJbLvzPfR/eI5hp/SG4xE4yV/8DQk4Lxcljocfhy9wQeDE9
 /EFM51XnLlqpo2XC63r6/utrA+mKVQUDZtWz1ftPRAE86VRFW8rnRkrpES3g2yqHq9H4
 c+9L3/IvVRV6EoEFjfvTFZGq1vtSeKkG3Kgpkzm1zDx+yd8IW0CUTNLEo/IpndTZ2P/1
 n8l1LE2VFXxoYg5pVp+eNge1VcUL9YxDToDcbEld36/+W9tPjrcvElM4yoAL9Ex4uX0g XQ== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 3bq1gagp5v-11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 15 Oct 2021 08:36:30 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 15 Oct
 2021 14:36:26 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.7 via Frontend
 Transport; Fri, 15 Oct 2021 14:36:26 +0100
Received: from AUSNPC0LSNW1-debian.cirrus.com (AUSNPC0LSNW1.ad.cirrus.com [198.61.65.254])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id E0C1311DA;
        Fri, 15 Oct 2021 13:36:25 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 15/16] ASoC: cs42l42: Fix WARN in remove() if running without an interrupt
Date:   Fri, 15 Oct 2021 14:36:18 +0100
Message-ID: <20211015133619.4698-16-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211015133619.4698-1-rf@opensource.cirrus.com>
References: <20211015133619.4698-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: ohW8abaAw_NE3c0NMb_TywtXb4lnyOPD
X-Proofpoint-GUID: ohW8abaAw_NE3c0NMb_TywtXb4lnyOPD
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver must free the IRQ in remove() to prevent the potential race
where an IRQ starts to be handled while the driver is being removed but
devres has not yet called free_irq(). However, the driver can run without
an interrupt but devm_free_irq() will hit a WARN() if no devres-managed
interrupt was ever created.

Fix this by only attempting to create the interrupt handler if the hardware
config specified an interrupt, and failing probe() if the interrupt could
not be created. This means that in cs42l42_remove() an interrupt must have
been registered if the irq number is valid and therefore it is safe to call
devm_free_irq().

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/soc/codecs/cs42l42.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/sound/soc/codecs/cs42l42.c b/sound/soc/codecs/cs42l42.c
index 8e4a43c5a120..8f0c58097d64 100644
--- a/sound/soc/codecs/cs42l42.c
+++ b/sound/soc/codecs/cs42l42.c
@@ -2081,17 +2081,21 @@ static int cs42l42_i2c_probe(struct i2c_client *i2c_client,
 	gpiod_set_value_cansleep(cs42l42->reset_gpio, 1);
 	usleep_range(CS42L42_BOOT_TIME_US, CS42L42_BOOT_TIME_US * 2);
 
-	/* Request IRQ */
-	ret = devm_request_threaded_irq(&i2c_client->dev,
-			i2c_client->irq,
-			NULL, cs42l42_irq_thread,
-			IRQF_ONESHOT | IRQF_TRIGGER_LOW,
-			"cs42l42", cs42l42);
-	if (ret == -EPROBE_DEFER)
-		goto err_disable;
-	else if (ret != 0)
-		dev_err(&i2c_client->dev,
-			"Failed to request IRQ: %d\n", ret);
+	/* Request IRQ if one was specified */
+	if (i2c_client->irq) {
+		ret = devm_request_threaded_irq(&i2c_client->dev,
+						i2c_client->irq,
+						NULL, cs42l42_irq_thread,
+						IRQF_ONESHOT | IRQF_TRIGGER_LOW,
+						"cs42l42", cs42l42);
+		if (ret == -EPROBE_DEFER) {
+			goto err_disable;
+		} else if (ret != 0) {
+			dev_err(&i2c_client->dev,
+				"Failed to request IRQ: %d\n", ret);
+			goto err_disable;
+		}
+	}
 
 	/* initialize codec */
 	devid = cirrus_read_device_id(cs42l42->regmap, CS42L42_DEVID_AB);
@@ -2163,7 +2167,9 @@ static int cs42l42_i2c_remove(struct i2c_client *i2c_client)
 {
 	struct cs42l42_private *cs42l42 = i2c_get_clientdata(i2c_client);
 
-	devm_free_irq(&i2c_client->dev, i2c_client->irq, cs42l42);
+	if (i2c_client->irq)
+		devm_free_irq(&i2c_client->dev, i2c_client->irq, cs42l42);
+
 	pm_runtime_suspend(&i2c_client->dev);
 	pm_runtime_disable(&i2c_client->dev);
 
-- 
2.11.0

