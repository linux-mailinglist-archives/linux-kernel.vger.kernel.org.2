Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA1630D550
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 09:36:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232807AbhBCIfV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 03:35:21 -0500
Received: from mail-vi1eur05on2127.outbound.protection.outlook.com ([40.107.21.127]:18976
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232710AbhBCIfT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 03:35:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oMSaw8RLcZJm9XYHNqMf2KzDd81eAW+gaxUofxMfmE+kIwzbv605J9vXej0nreYQUmFRZFH0lmSKF8r7J6+c0EJo2R/4q8tBqxfrlwD39CLlFPnUqr5PguYMLdZ4SDtL/YjAEZ9vXUXzvbqUB++VRd7daVuKLNVI9Sq0MmFQF6uMyoOa/1NBbZOIBeHSB2mUtN7nX0c/eS/0OBec3NXtSj+KbFPw9jDIII9oT3CSkoA2x8e8X/Kjjc0FQ93Xb/t8zpPd8OpEalT/GOISnvI/jSphTHefuSB1UEQAvXnGo3YEB2sCIbq3BMbO7JQEgqffe0ambI/QYTZf8AzD0HHS9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cbm+6OHG7Hsit5rbDiWNzN9vof6WsnRbTnD2nK9A3Kc=;
 b=C0JBXo+yjpuXempAeitDypxw66W7gO7kSaO9zWmGprIgzMmrCq5F4x18SoPKeOrNvh0oGsB3DV80gAwSg4MLfevUnHuTSFYQP+QP4gkZacsoPjLzusqE2zZLClMuwQQpoLpfV1ZB9gYhDyoLuXXdnnpt1ZREgArAz2a2UoQ6ROOjvmOFjLCTn07QmEHBLjAOZRef4s7GZ3SaY9xBxUtVbpEixassHG2bAI28pMbVHi/LneIMHehYWSEPAaay6AMRxmJulPbJ42Yh3cqGqynphPZQ8ouo7SvZGYDdVJuLVRKhIi0aUrQR2fUhzoBK730wIh3g53dSMD8EUCiUTAwDIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 62.153.209.162) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=schleissheimer.de; dmarc=none action=none
 header.from=schleissheimer.de; dkim=fail (no key for signature)
 header.d=schleissheimer.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=schleissheimer.onmicrosoft.com; s=selector1-schleissheimer-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cbm+6OHG7Hsit5rbDiWNzN9vof6WsnRbTnD2nK9A3Kc=;
 b=E+qkE5Wx6fBBO9htEm/YfITeuEoAi846KOyHz+Wyamg5EJvqZUjJ7xaiJ0vmin3rynrCyleUT0iURq55xciIDAjR8Hv/R03apcXt9d6+a/BM8KP7a+vJUizg1/gFZqIcbAE+BpbSbQgClsf3wE5+pQYBT5HUsqH5sFuVFFLFEv0=
Received: from AM0PR02CA0128.eurprd02.prod.outlook.com (2603:10a6:20b:28c::25)
 by AM4P190MB0081.EURP190.PROD.OUTLOOK.COM (2603:10a6:200:5f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.23; Wed, 3 Feb
 2021 08:34:24 +0000
Received: from HE1EUR04FT027.eop-eur04.prod.protection.outlook.com
 (2603:10a6:20b:28c:cafe::24) by AM0PR02CA0128.outlook.office365.com
 (2603:10a6:20b:28c::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.19 via Frontend
 Transport; Wed, 3 Feb 2021 08:34:24 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 62.153.209.162)
 smtp.mailfrom=schleissheimer.de; vger.kernel.org; dkim=fail (no key for
 signature) header.d=schleissheimer.de;vger.kernel.org; dmarc=none action=none
 header.from=schleissheimer.de;
Received-SPF: Fail (protection.outlook.com: domain of schleissheimer.de does
 not designate 62.153.209.162 as permitted sender)
 receiver=protection.outlook.com; client-ip=62.153.209.162;
 helo=mail.schleissheimer.de;
Received: from mail.schleissheimer.de (62.153.209.162) by
 HE1EUR04FT027.mail.protection.outlook.com (10.152.27.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3784.11 via Frontend Transport; Wed, 3 Feb 2021 08:34:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=schleissheimer.de; s=dkim1;
        h=Message-Id:Date:Subject:Cc:To:From; bh=cbm+6OHG7Hsit5rbDiWNzN9vof6WsnRbTnD2nK9A3Kc=;
        b=cqz6QM/see/WO+40DQs4kCXVAeiORycvdbFdmVp9EbK4IQf4UGON61ghyjYukbdbht+Uo2FGTP+slmlUfRYcp2KLPpahRPofp/9jld/gCbTdntHc3e6QhM1yap9RBXPCAG2R6xM565mj8tkw4IhGliDSe6QSeyee1vEMYJV4/6w=;
Received: from [192.168.10.165] (port=41938 helo=contiredmine.schleissheimer.de)
        by mail.schleissheimer.de with esmtp (Exim 4.82_1-5b7a7c0-XX)
        (envelope-from <schuchmann@schleissheimer.de>)
        id 1l7Dc4-0001pv-1d; Wed, 03 Feb 2021 09:34:12 +0100
X-CTCH-RefID: str=0001.0A782F17.601A6004.009B,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
From:   Sven Schuchmann <schuchmann@schleissheimer.de>
To:     schuchmann@schleissheimer.de
Cc:     Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        Rob Herring <robh+dt@kernel.org>, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] leds: lp50xx: remove unused regulator
Date:   Wed,  3 Feb 2021 08:34:08 +0000
Message-Id: <20210203083408.2534-1-schuchmann@schleissheimer.de>
X-Mailer: git-send-email 2.17.1
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: ed1a1e27-4a13-4f34-e9ea-08d8c81e8161
X-MS-TrafficTypeDiagnostic: AM4P190MB0081:
X-Microsoft-Antispam-PRVS: <AM4P190MB0081C92D3BF41985AE14171CD8B49@AM4P190MB0081.EURP190.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oo3IEqp7pmkaHYwJvs0p9C9VcmU/m/RqMy8lixrfB7WGsdkCsM6bpfRm7f38a9IfkS8ForhjTw/LzPVa2NnG1e9cuq0h3UctAe4Jur7LjoW5VJi1T0Dx8R2MStd81qvv6lN4yysG0X/ozmuGF+CWX6TfIkkrBMQW8VMQwvpPHx5SQjC+/b5fA3JZdLwsKfHyteWDZqF5oiNsd+8JztkjUXgIib47V/l3T5TB7224R9KGJTlTSmjjAtHN5szhfx78heKMLbkWebpII6EPf2V0iN/olqwbDsXzBhzLLEx39WQLeg0ajoZ3xQSJyozAjojJHeZxjBJd/bJ4Gch0CT/A+F/6AovnrYEAWqu0unDptieqkwlZjS5OiLoNDPLQqWonn5x8el4GQFwfZeLwmmU6jSYMN1fcjh6ybLOMistBpEKD9MswUXEu9qISgBVbdC63c783CwpdaITZSYGNvTvBa0lase3WuY9jFSFWM/9kTp0bwfm05xvT+NHUkec4dr4Ycu71bSvlv/cdA5HQCS3cUGtLYSdfflzPmi0sHnAqqO+PVe/LO/fSYrkDz+aTBE8n31oQmVq+YyT5URTZhALesCrnjYPpXSOqErXM+HwynSJUY3mp538vss7pIguEgtSZGCob6txiHfiiCmlLXlJIUQ==
X-Forefront-Antispam-Report: CIP:62.153.209.162;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.schleissheimer.de;PTR:mail.schleissheimer.de;CAT:NONE;SFS:(346002)(39830400003)(376002)(396003)(136003)(36840700001)(46966006)(8676002)(70206006)(70586007)(37006003)(9786002)(478600001)(2616005)(54906003)(36756003)(7636003)(26005)(5660300002)(7696005)(83380400001)(186003)(356005)(426003)(336012)(82310400003)(7596003)(2906002)(6666004)(34206002)(36860700001)(4326008)(316002)(47076005)(8936002)(1076003);DIR:OUT;SFP:1102;
X-OriginatorOrg: schleissheimer.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2021 08:34:21.7217
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed1a1e27-4a13-4f34-e9ea-08d8c81e8161
X-MS-Exchange-CrossTenant-Id: ba05321a-a007-44df-8805-c7e62d5887b5
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ba05321a-a007-44df-8805-c7e62d5887b5;Ip=[62.153.209.162];Helo=[mail.schleissheimer.de]
X-MS-Exchange-CrossTenant-AuthSource: HE1EUR04FT027.eop-eur04.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4P190MB0081
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The regulator for vled-supply is unused in the driver.
It is just assigned from DT and disabled in lp50xx_remove.
So the code can be removed from the driver.

Part 1 updates the documentation
Part 2 removes the code

Signed-off-by: Sven Schuchmann <schuchmann@schleissheimer.de>

---
 drivers/leds/leds-lp50xx.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/leds/leds-lp50xx.c b/drivers/leds/leds-lp50xx.c
index f13117eed976..b0871495bae3 100644
--- a/drivers/leds/leds-lp50xx.c
+++ b/drivers/leds/leds-lp50xx.c
@@ -11,7 +11,6 @@
 #include <linux/of.h>
 #include <linux/of_gpio.h>
 #include <linux/regmap.h>
-#include <linux/regulator/consumer.h>
 #include <linux/slab.h>
 #include <uapi/linux/uleds.h>
 
@@ -275,7 +274,6 @@ struct lp50xx_led {
 /**
  * struct lp50xx -
  * @enable_gpio: hardware enable gpio
- * @regulator: LED supply regulator pointer
  * @client: pointer to the I2C client
  * @regmap: device register map
  * @dev: pointer to the devices device struct
@@ -286,7 +284,6 @@ struct lp50xx_led {
  */
 struct lp50xx {
 	struct gpio_desc *enable_gpio;
-	struct regulator *regulator;
 	struct i2c_client *client;
 	struct regmap *regmap;
 	struct device *dev;
@@ -462,10 +459,6 @@ static int lp50xx_probe_dt(struct lp50xx *priv)
 		return ret;
 	}
 
-	priv->regulator = devm_regulator_get(priv->dev, "vled");
-	if (IS_ERR(priv->regulator))
-		priv->regulator = NULL;
-
 	device_for_each_child_node(priv->dev, child) {
 		led = &priv->leds[i];
 		ret = fwnode_property_count_u32(child, "reg");
@@ -583,13 +576,6 @@ static int lp50xx_remove(struct i2c_client *client)
 		return ret;
 	}
 
-	if (led->regulator) {
-		ret = regulator_disable(led->regulator);
-		if (ret)
-			dev_err(&led->client->dev,
-				"Failed to disable regulator\n");
-	}
-
 	mutex_destroy(&led->lock);
 
 	return 0;
-- 
2.17.1

