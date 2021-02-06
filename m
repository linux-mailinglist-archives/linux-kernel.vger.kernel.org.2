Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2815311C74
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 10:53:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbhBFJxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Feb 2021 04:53:24 -0500
Received: from lnfm1.sai.msu.ru ([93.180.26.255]:39747 "EHLO lnfm1.sai.msu.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229587AbhBFJxB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Feb 2021 04:53:01 -0500
Received: from dragon.sai.msu.ru (dragon.sai.msu.ru [93.180.26.172])
        by lnfm1.sai.msu.ru (8.14.1/8.12.8) with ESMTP id 1169pgBO029781;
        Sat, 6 Feb 2021 12:51:47 +0300
Received: from oak.local (unknown [83.167.113.121])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by dragon.sai.msu.ru (Postfix) with ESMTPSA id 72B5A6D827;
        Sat,  6 Feb 2021 12:51:43 +0300 (MSK)
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
Subject: [PATCH v4 3/4] hwmon: lm75: Add ti,lm75 to of_match list
Date:   Sat,  6 Feb 2021 12:51:20 +0300
Message-Id: <20210206095121.20625-4-matwey@sai.msu.ru>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210206095121.20625-1-matwey@sai.msu.ru>
References: <2588ea5c-630e-6509-689d-4c8fea358e9b@roeck-us.net>
 <20210206095121.20625-1-matwey@sai.msu.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, armada-388-helios4.dts and nuvoton-npcm730-kudo.dts use
"ti,lm75" compatible string.

TI LM75A/B are compatible with original LM75A

https://www.ti.com/lit/ds/symlink/lm75a.pdf
https://www.ti.com/lit/ds/symlink/lm75b.pdf

Signed-off-by: Matwey V. Kornilov <matwey@sai.msu.ru>
---
 Documentation/devicetree/bindings/hwmon/lm75.yaml | 1 +
 drivers/hwmon/lm75.c                              | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/hwmon/lm75.yaml b/Documentation/devicetree/bindings/hwmon/lm75.yaml
index 8c3848f4c277..721e77ce4390 100644
--- a/Documentation/devicetree/bindings/hwmon/lm75.yaml
+++ b/Documentation/devicetree/bindings/hwmon/lm75.yaml
@@ -32,6 +32,7 @@ properties:
       - st,stds75
       - st,stlm75
       - microchip,tcn75
+      - ti,lm75
       - ti,tmp100
       - ti,tmp101
       - ti,tmp105
diff --git a/drivers/hwmon/lm75.c b/drivers/hwmon/lm75.c
index 9c54c7d86771..3e4374aa2f99 100644
--- a/drivers/hwmon/lm75.c
+++ b/drivers/hwmon/lm75.c
@@ -750,6 +750,10 @@ static const struct of_device_id __maybe_unused lm75_of_match[] = {
 		.compatible = "microchip,tcn75",
 		.data = (void *)tcn75
 	},
+	{
+		.compatible = "ti,lm75",
+		.data = (void *)lm75a
+	},
 	{
 		.compatible = "ti,tmp100",
 		.data = (void *)tmp100
-- 
2.26.2

