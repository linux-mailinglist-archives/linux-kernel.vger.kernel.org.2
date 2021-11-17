Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F84A4549B3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 16:15:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236370AbhKQPSq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 10:18:46 -0500
Received: from marcansoft.com ([212.63.210.85]:33188 "EHLO mail.marcansoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233940AbhKQPSR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 10:18:17 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: hector@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 5367041F5F;
        Wed, 17 Nov 2021 15:15:15 +0000 (UTC)
From:   Hector Martin <marcan@marcan.st>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sven Peter <sven@svenpeter.dev>
Cc:     Hector Martin <marcan@marcan.st>,
        =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] usb: typec: tipd: Fix initialization sequence for cd321x
Date:   Thu, 18 Nov 2021 00:14:50 +0900
Message-Id: <20211117151450.207168-3-marcan@marcan.st>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211117151450.207168-1-marcan@marcan.st>
References: <20211117151450.207168-1-marcan@marcan.st>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The power state switch needs to happen first, as that
kickstarts the firmware into normal mode.

Signed-off-by: Hector Martin <marcan@marcan.st>
---
 drivers/usb/typec/tipd/core.c | 33 ++++++++++++++++-----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
index 4da5a0b2aed2..6d27a5b5e3ca 100644
--- a/drivers/usb/typec/tipd/core.c
+++ b/drivers/usb/typec/tipd/core.c
@@ -707,6 +707,7 @@ static int tps6598x_probe(struct i2c_client *client)
 	u32 conf;
 	u32 vid;
 	int ret;
+	u64 mask1;
 
 	tps = devm_kzalloc(&client->dev, sizeof(*tps), GFP_KERNEL);
 	if (!tps)
@@ -730,11 +731,6 @@ static int tps6598x_probe(struct i2c_client *client)
 	if (i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
 		tps->i2c_protocol = true;
 
-	/* Make sure the controller has application firmware running */
-	ret = tps6598x_check_mode(tps);
-	if (ret)
-		return ret;
-
 	if (np && of_device_is_compatible(np, "apple,cd321x")) {
 		/* Switch CD321X chips to the correct system power state */
 		ret = cd321x_switch_power_state(tps, TPS_SYSTEM_POWER_STATE_S0);
@@ -742,24 +738,27 @@ static int tps6598x_probe(struct i2c_client *client)
 			return ret;
 
 		/* CD321X chips have all interrupts masked initially */
-		ret = tps6598x_write64(tps, TPS_REG_INT_MASK1,
-					APPLE_CD_REG_INT_POWER_STATUS_UPDATE |
-					APPLE_CD_REG_INT_DATA_STATUS_UPDATE |
-					APPLE_CD_REG_INT_PLUG_EVENT);
-		if (ret)
-			return ret;
+		mask1 = APPLE_CD_REG_INT_POWER_STATUS_UPDATE |
+			APPLE_CD_REG_INT_DATA_STATUS_UPDATE |
+			APPLE_CD_REG_INT_PLUG_EVENT;
 
 		irq_handler = cd321x_interrupt;
 	} else {
 		/* Enable power status, data status and plug event interrupts */
-		ret = tps6598x_write64(tps, TPS_REG_INT_MASK1,
-				       TPS_REG_INT_POWER_STATUS_UPDATE |
-				       TPS_REG_INT_DATA_STATUS_UPDATE |
-				       TPS_REG_INT_PLUG_EVENT);
-		if (ret)
-			return ret;
+		mask1 = TPS_REG_INT_POWER_STATUS_UPDATE |
+			TPS_REG_INT_DATA_STATUS_UPDATE |
+			TPS_REG_INT_PLUG_EVENT;
 	}
 
+	/* Make sure the controller has application firmware running */
+	ret = tps6598x_check_mode(tps);
+	if (ret)
+		return ret;
+
+	ret = tps6598x_write64(tps, TPS_REG_INT_MASK1, mask1);
+	if (ret)
+		return ret;
+
 	ret = tps6598x_read32(tps, TPS_REG_STATUS, &status);
 	if (ret < 0)
 		return ret;
-- 
2.33.0

