Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 548684123FB
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 20:28:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379333AbhITS3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 14:29:04 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:51038
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347961AbhITSWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 14:22:48 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id CDD113F335
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 18:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632162080;
        bh=eGQQ7dYmcpFV9zW7MpsysSvE4mW3gJe5kyomQB9AukM=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=K/64nZ0PiwYpxiH9h2GRkJ4ZSbg3sQExAk94L6ZfJNd5kDjix5blH2JQsCTlps7jW
         T++7c1FKwu6dKg92LuSwbEeR50q4QUTykWtsYEyJyPk1IAyAd/+8uxpsD/uL1A1IPx
         wgrRWUUNsSInIorVBVTQbF4GEQ51+lRdTCgJH2ldK2dQpeZJGMXfHGO1ZZERPPCdOq
         l5tmRopdXvN7NK2LGd+r72b4at5l1e8qDJ+lvizDFZTXu62aMS0p+Ky7O0qx2q3b+i
         UdBro0T1Vz74LDi6g7YtviJtarMqkQNcYrHpo9IyvSHQFOavps/HWjGFbzgAC8cbfs
         m8hXklSjh5YsA==
Received: by mail-wr1-f71.google.com with SMTP id r5-20020adfb1c5000000b0015cddb7216fso6805008wra.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 11:21:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eGQQ7dYmcpFV9zW7MpsysSvE4mW3gJe5kyomQB9AukM=;
        b=POk1mRvv0r03o5sXlQ66TyaivYBZlC1eg8T4WQwwFKjRxhFffBFLWx3hB7v9uO7+qW
         6f8Xf233c2aaI9TYKNxkbQ2KcWeBXz8NPVdRpH0P2jE/zGD9JKu3EADY91z9yRLTdU3+
         DOj+T+vhYThZZ0TOVcHKj+N/C+Hrf3d9lt7KOXvYSgR8CHofGNTePajHTSvHtnmcb6og
         3jBrcFSnQSzuUNqP6OfKxg1900qERBmWbPJUAvF6r/YwHRjAsQavzT5zQffoRplKMV/C
         7Q9Z3i8/kbaa0NoaEtidTQ2y4q+piBShlgknbJcU1eG2SluRdvMkwbuUKdnnt2lCrc8q
         zerg==
X-Gm-Message-State: AOAM5314VMaKcBarxLZV53sfNZcmwLB35i3h2ZSjxnuvz292iQIhsAQT
        MSHvTlKP/ekXoy0ait6bpdOyxfeZnqergf2OpfYb4jG3ZD1q4ipup/Qbyiv8iWmJ/lwBQkirJHR
        Ww1zTJfzHmKrasJFwvzqNmZfwSz6h2XHRFagTkdmqvw==
X-Received: by 2002:a5d:46cb:: with SMTP id g11mr30487394wrs.60.1632162080275;
        Mon, 20 Sep 2021 11:21:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy9QLB/vF0OW+no2KLoWsLNenmxvOnOmtn3xw4taGpu+PChddhW0z+WzdSWDWSPaX0pjC+NYQ==
X-Received: by 2002:a5d:46cb:: with SMTP id g11mr30487376wrs.60.1632162080081;
        Mon, 20 Sep 2021 11:21:20 -0700 (PDT)
Received: from kozik-lap.lan (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id e5sm10515285wrd.1.2021.09.20.11.21.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 11:21:19 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Jiri Kosina <trivial@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] dt-bindings: hwmon: lm70: move to trivial devices
Date:   Mon, 20 Sep 2021 20:21:09 +0200
Message-Id: <20210920182114.339419-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The lm70 thermometer bindings are trivial, so like many other I2C/SPI
temperature sensors can be integrated into trivial devices bindings.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 .../devicetree/bindings/hwmon/lm70.txt        | 22 -------------------
 .../devicetree/bindings/trivial-devices.yaml  |  8 +++++++
 2 files changed, 8 insertions(+), 22 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/hwmon/lm70.txt

diff --git a/Documentation/devicetree/bindings/hwmon/lm70.txt b/Documentation/devicetree/bindings/hwmon/lm70.txt
deleted file mode 100644
index ea417a0d32af..000000000000
--- a/Documentation/devicetree/bindings/hwmon/lm70.txt
+++ /dev/null
@@ -1,22 +0,0 @@
-* LM70/TMP121/LM71/LM74 thermometer.
-
-Required properties:
-- compatible: one of
-		"ti,lm70"
-		"ti,tmp121"
-		"ti,tmp122"
-		"ti,lm71"
-		"ti,lm74"
-
-See Documentation/devicetree/bindings/spi/spi-bus.txt for more required and
-optional properties.
-
-Example:
-
-spi_master {
-	temperature-sensor@0 {
-		compatible = "ti,lm70";
-		reg = <0>;
-		spi-max-frequency = <1000000>;
-	};
-};
diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index 1eb4ce7dcdfd..183ee0da22c6 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -303,8 +303,13 @@ properties:
           - ti,hdc1050
             # Temperature and humidity sensor with i2c interface
           - ti,hdc1080
+            # Thermometer with SPI interface
+          - ti,lm70
+          - ti,lm71
             # Temperature sensor with 2-wire interface
           - ti,lm73
+            # Thermometer with SPI interface
+          - ti,lm74
             # Temperature sensor with integrated fan control
           - ti,lm96000
             # I2C Touch-Screen Controller
@@ -313,6 +318,9 @@ properties:
           - ti,tmp102
             # Low Power Digital Temperature Sensor with SMBUS/Two Wire Serial Interface
           - ti,tmp103
+            # Thermometer with SPI interface
+          - ti,tmp121
+          - ti,tmp122
             # Digital Temperature Sensor
           - ti,tmp275
             # TI Dual channel DCAP+ multiphase controller TPS53676 with AVSBus
-- 
2.30.2

