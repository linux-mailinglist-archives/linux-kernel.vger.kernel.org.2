Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 612E5311C73
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 10:53:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbhBFJxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Feb 2021 04:53:10 -0500
Received: from lnfm1.sai.msu.ru ([93.180.26.255]:39746 "EHLO lnfm1.sai.msu.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229507AbhBFJxA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Feb 2021 04:53:00 -0500
Received: from dragon.sai.msu.ru (dragon.sai.msu.ru [93.180.26.172])
        by lnfm1.sai.msu.ru (8.14.1/8.12.8) with ESMTP id 1169pfA7029779;
        Sat, 6 Feb 2021 12:51:46 +0300
Received: from oak.local (unknown [83.167.113.121])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by dragon.sai.msu.ru (Postfix) with ESMTPSA id 9527A2CCA0;
        Sat,  6 Feb 2021 12:51:42 +0300 (MSK)
From:   "Matwey V. Kornilov" <matwey@sai.msu.ru>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        linux-hwmon@vger.kernel.org (open list:HARDWARE MONITORING),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Matwey V. Kornilov" <matwey@sai.msu.ru>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS)
Subject: [PATCH v4 2/4] hwmon: lm75: Add nxp,lm75a to of_match list
Date:   Sat,  6 Feb 2021 12:51:19 +0300
Message-Id: <20210206095121.20625-3-matwey@sai.msu.ru>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210206095121.20625-1-matwey@sai.msu.ru>
References: <2588ea5c-630e-6509-689d-4c8fea358e9b@roeck-us.net>
 <20210206095121.20625-1-matwey@sai.msu.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NXP LM75A is compatible with original LM75A while it has improved
11-bit precision.

https://www.nxp.com/docs/en/data-sheet/LM75A.pdf

Signed-off-by: Matwey V. Kornilov <matwey@sai.msu.ru>
---
 Documentation/devicetree/bindings/hwmon/lm75.yaml |  1 +
 drivers/hwmon/lm75.c                              | 11 +++++++++++
 2 files changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/hwmon/lm75.yaml b/Documentation/devicetree/bindings/hwmon/lm75.yaml
index aec8edd1e0c6..8c3848f4c277 100644
--- a/Documentation/devicetree/bindings/hwmon/lm75.yaml
+++ b/Documentation/devicetree/bindings/hwmon/lm75.yaml
@@ -22,6 +22,7 @@ properties:
       - national,lm75
       - national,lm75a
       - national,lm75b
+      - nxp,lm75a
       - maxim,max6625
       - maxim,max6626
       - maxim,max31725
diff --git a/drivers/hwmon/lm75.c b/drivers/hwmon/lm75.c
index 08cde1c446db..9c54c7d86771 100644
--- a/drivers/hwmon/lm75.c
+++ b/drivers/hwmon/lm75.c
@@ -33,6 +33,7 @@ enum lm75_type {		/* keep sorted in alphabetical order */
 	lm75,
 	lm75a,
 	lm75b,
+	nxp_lm75,
 	max6625,
 	max6626,
 	max31725,
@@ -182,6 +183,11 @@ static const struct lm75_params device_params[] = {
 		.default_resolution = 11,
 		.default_sample_time = MSEC_PER_SEC / 10,
 	},
+	[nxp_lm75] = {
+		.default_resolution = 11,
+		.default_sample_time = MSEC_PER_SEC / 10,
+		.resolution_limits = 9,
+	},
 	[max6625] = {
 		.default_resolution = 9,
 		.default_sample_time = MSEC_PER_SEC / 7,
@@ -644,6 +650,7 @@ static const struct i2c_device_id lm75_ids[] = {
 	{ "lm75", lm75, },
 	{ "lm75a", lm75a, },
 	{ "lm75b", lm75b, },
+	{ "nxp_lm75a", nxp_lm75, },
 	{ "max6625", max6625, },
 	{ "max6626", max6626, },
 	{ "max31725", max31725, },
@@ -703,6 +710,10 @@ static const struct of_device_id __maybe_unused lm75_of_match[] = {
 		.compatible = "national,lm75b",
 		.data = (void *)lm75b
 	},
+	{
+		.compatible = "nxp,lm75a",
+		.data = (void *)nxp_lm75
+	},
 	{
 		.compatible = "maxim,max6625",
 		.data = (void *)max6625
-- 
2.26.2

