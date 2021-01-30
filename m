Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3910309435
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jan 2021 11:16:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232206AbhA3KQY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 05:16:24 -0500
Received: from lnfm1.sai.msu.ru ([93.180.26.255]:57582 "EHLO lnfm1.sai.msu.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232036AbhA3KPV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 05:15:21 -0500
Received: from dragon.sai.msu.ru (dragon.sai.msu.ru [93.180.26.172])
        by lnfm1.sai.msu.ru (8.14.1/8.12.8) with ESMTP id 10UAAqmE015160;
        Sat, 30 Jan 2021 13:10:57 +0300
Received: from oak.local (unknown [83.167.113.121])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by dragon.sai.msu.ru (Postfix) with ESMTPSA id 74A7077FB;
        Sat, 30 Jan 2021 13:10:53 +0300 (MSK)
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
Subject: [PATCH] hwmon: lm75: Use zero lm75_type for lm75
Date:   Sat, 30 Jan 2021 13:10:38 +0300
Message-Id: <20210130101038.26331-1-matwey@sai.msu.ru>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a logical flaw in lm75_probe() function introduced in

    e97a45f1b460 ("hwmon: (lm75) Add OF device ID table")

Note, that of_device_get_match_data() returns NULL when no match
found. This is the case when OF node exists but has unknown
compatible line, while the module is still loaded via i2c
detection.

arch/powerpc/boot/dts/fsl/p2041rdb.dts:

    lm75b@48 {
    	compatible = "nxp,lm75a";
    	reg = <0x48>;
    };

In this case, the sensor is mistakenly considered as ADT75 variant.
The simplest way to handle this issue is to make the LM75 code
zero.

Fixes: e97a45f1b460 ("hwmon: (lm75) Add OF device ID table")
Signed-off-by: Matwey V. Kornilov <matwey@sai.msu.ru>
---
 drivers/hwmon/lm75.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/lm75.c b/drivers/hwmon/lm75.c
index e447febd121a..3aa7f9454f57 100644
--- a/drivers/hwmon/lm75.c
+++ b/drivers/hwmon/lm75.c
@@ -25,12 +25,12 @@
  */
 
 enum lm75_type {		/* keep sorted in alphabetical order */
+	lm75 = 0,		/* except of lm75 which is default fallback */
 	adt75,
 	ds1775,
 	ds75,
 	ds7505,
 	g751,
-	lm75,
 	lm75a,
 	lm75b,
 	max6625,
-- 
2.26.2

