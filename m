Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B14530CA5B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 19:46:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233601AbhBBSqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 13:46:05 -0500
Received: from lnfm1.sai.msu.ru ([93.180.26.255]:38478 "EHLO lnfm1.sai.msu.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233738AbhBBSm0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 13:42:26 -0500
Received: from dragon.sai.msu.ru (dragon.sai.msu.ru [93.180.26.172])
        by lnfm1.sai.msu.ru (8.14.1/8.12.8) with ESMTP id 112IboMk011289;
        Tue, 2 Feb 2021 21:37:55 +0300
Received: from oak.local (unknown [83.167.113.121])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by dragon.sai.msu.ru (Postfix) with ESMTPSA id 28E9A18B18;
        Tue,  2 Feb 2021 21:37:52 +0300 (MSK)
From:   "Matwey V. Kornilov" <matwey@sai.msu.ru>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Javier Martinez Canillas <javier@osg.samsung.com>,
        linux-hwmon@vger.kernel.org (open list:HARDWARE MONITORING),
        linux-kernel@vger.kernel.org (open list)
Cc:     matwey.kornilov@gmail.com,
        "Matwey V. Kornilov" <matwey@sai.msu.ru>,
        linux-hwmon@vger.kernel.org (open list:HARDWARE MONITORING),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3] hwmon: lm75: Handle broken device nodes gracefully
Date:   Tue,  2 Feb 2021 21:37:37 +0300
Message-Id: <20210202183737.28747-1-matwey@sai.msu.ru>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210202142113.5456-1-matwey@sai.msu.ru>
References: <20210202142113.5456-1-matwey@sai.msu.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a logical flaw in lm75_probe() function introduced in

    commit e97a45f1b460 ("hwmon: (lm75) Add OF device ID table")

Note, that of_device_get_match_data() returns NULL when no match
is found. This is the case when OF node exists but has unknown
compatible line, while the module is still loaded via i2c
detection.

arch/powerpc/boot/dts/fsl/p2041rdb.dts:

    lm75b@48 {
    	compatible = "nxp,lm75a";
    	reg = <0x48>;
    };

In this case, the sensor is mistakenly considered as ADT75 variant.

Fixes: e97a45f1b460 ("hwmon: (lm75) Add OF device ID table")
Signed-off-by: Matwey V. Kornilov <matwey@sai.msu.ru>
---
 Changes since v2:
 * fixed typo in the message
 * fixed brackets

 drivers/hwmon/lm75.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/lm75.c b/drivers/hwmon/lm75.c
index e447febd121a..53882c334a0d 100644
--- a/drivers/hwmon/lm75.c
+++ b/drivers/hwmon/lm75.c
@@ -561,10 +561,17 @@ static int lm75_probe(struct i2c_client *client)
 	int status, err;
 	enum lm75_type kind;
 
-	if (client->dev.of_node)
-		kind = (enum lm75_type)of_device_get_match_data(&client->dev);
-	else
+	if (dev->of_node) {
+		const struct of_device_id *match =
+			of_match_device(dev->driver->of_match_table, dev);
+
+		if (!match)
+			return -ENODEV;
+
+		kind = (enum lm75_type)(match->data);
+	} else {
 		kind = i2c_match_id(lm75_ids, client)->driver_data;
+	}
 
 	if (!i2c_check_functionality(client->adapter,
 			I2C_FUNC_SMBUS_BYTE_DATA | I2C_FUNC_SMBUS_WORD_DATA))
-- 
2.26.2

