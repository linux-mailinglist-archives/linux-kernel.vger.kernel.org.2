Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CDAD39C609
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 07:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbhFEFa2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Jun 2021 01:30:28 -0400
Received: from mx3.molgen.mpg.de ([141.14.17.11]:47079 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229660AbhFEFa1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jun 2021 01:30:27 -0400
Received: from localhost.localdomain (ip5f5aeece.dynamic.kabel-deutschland.de [95.90.238.206])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 7552461E64762;
        Sat,  5 Jun 2021 07:28:37 +0200 (CEST)
From:   Paul Menzel <pmenzel@molgen.mpg.de>
To:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>
Cc:     Madhava Reddy Siddareddygari <msiddare@cisco.com>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] hwmon: (pmbus_core) Check adapter PEC support
Date:   Sat,  5 Jun 2021 07:27:02 +0200
Message-Id: <20210605052700.541455-1-pmenzel@molgen.mpg.de>
X-Mailer: git-send-email 2.32.0.rc2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Madhava Reddy Siddareddygari <msiddare@cisco.com>

Currently, for Packet Error Checking (PEC) only the controller
is checked for support. This causes problems on the cisco-8000
platform where a SMBUS transaction errors are observed. This is
because PEC has to be enabled only if both controller and
adapter support it.

Added code to check PEC capability for adapter and enable it
only if both controller and adapter supports PEC.

Signed-off-by: Madhava Reddy Siddareddygari <msiddare@cisco.com>
[Upstream from SONiC https://github.com/Azure/sonic-linux-kernel/pull/215]
Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
---
v2: Do not revert check introduced by commit e5befc02 (hwmon: (pmbus)
    Add a PMBUS_NO_CAPABILITY platform data flag).

 drivers/hwmon/pmbus/pmbus_core.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
index bbd745178147..2fd0fec59d4f 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -2214,11 +2214,15 @@ static int pmbus_init_common(struct i2c_client *client, struct pmbus_data *data,
 		data->has_status_word = true;
 	}
 
-	/* Enable PEC if the controller supports it */
+	/* Enable PEC if the controller and bus supports it */
 	if (!(data->flags & PMBUS_NO_CAPABILITY)) {
 		ret = i2c_smbus_read_byte_data(client, PMBUS_CAPABILITY);
-		if (ret >= 0 && (ret & PB_CAPABILITY_ERROR_CHECK))
-			client->flags |= I2C_CLIENT_PEC;
+		if (ret >= 0 && (ret & PB_CAPABILITY_ERROR_CHECK)) {
+			if (i2c_check_functionality(client->adapter,
+						I2C_FUNC_SMBUS_PEC)) {
+				client->flags |= I2C_CLIENT_PEC;
+			}
+		}
 	}
 
 	/*
-- 
2.32.0.rc2

