Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0616538CE1C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 21:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238393AbhEUT04 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 15:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234714AbhEUT0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 15:26:45 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC7AAC061574
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 12:25:21 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id u4-20020a05600c00c4b02901774b80945cso7988318wmm.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 12:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IUpZxMNv8nwPbOXuGZx5ywp7pLldARPhu40BNs9tpc8=;
        b=AxZh5dKx5V16u/rO9OQp1AEAdrJa0Tkbq95EcvKZ5xajGf5JoTovxHEUNjosu11+CQ
         wv2EvUFjAAxzBh9QSVJYzA3m1HUfLbDXXCL9KYuz6V/Zd+tCH9qCJbHixRPu00ZG6nis
         NQ3csUt0VhFNiJApoLR+R62LaQUMCZFhnaU51Uwok9KJiRsf0Y3fimy8oqT0Ewn91zgf
         eXo5st7YaKsDnXPYIzMUr5ZmMprJpPdaqgOXjiyW+6BndneVgu2NnhzbV2/v4JeJ6ITJ
         RVUJE26IULkAbjShJrHwWl7x8yX4rLBEZleIQ5n8oBRsDpu6IqIGRtrdNHpKQnEDRnvc
         H6Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IUpZxMNv8nwPbOXuGZx5ywp7pLldARPhu40BNs9tpc8=;
        b=tf7VXv9xSxxXATMvDYtOc/Z140Vx6cenLb3noDpsVctvNHMyzWKfkvkUgbHTyGOQtj
         2w+vb5vgpFj0ohg2I8m9HunUhFc+Oyt3sTim6JdczIMbWXeCUO0ZoxyFU6nIRZl+5K22
         2IO83MIrQK/mEVcb929NOF7QfxwLwjPioDsJTIcBGUcTGIXqKv9h7vUun3MJE3Bys36+
         BpecmGppqzawDR3bGbzLS4262+8bOU8x2QusnTjDvPZqKbxO3989Wyy3jUzcCfh3IYNF
         s20O+HxzBKso53GTsjOIYOpW8w9D2pndC6bgjmNIaPdfuNp2X5E/TsopPOTVLcU+DK5C
         8b2Q==
X-Gm-Message-State: AOAM530yFltRdQPtk4mmpkKyDyuw2uPZ0GOsPWQAZ6cdt7Zg+V7IaoDw
        93fq6QQR8WMatN7x6xN1WUhXQw==
X-Google-Smtp-Source: ABdhPJxKOkqj/EFi3l2CI6tmyvTqRQ9yfrCurUYciL/ubmVxnGaTQT1Zuc+k3vXZX71xJKA/EarJqw==
X-Received: by 2002:a05:600c:4a23:: with SMTP id c35mr10565278wmp.130.1621625120204;
        Fri, 21 May 2021 12:25:20 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id b10sm3657592wrr.27.2021.05.21.12.25.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 12:25:19 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH] dt-bindings: trivial-devices: remove compatible handled by other schema
Date:   Fri, 21 May 2021 19:25:05 +0000
Message-Id: <20210521192505.13441-1-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove gmt,g751 dallas,ds1775 dallas,ds75 maxim,max6625 national,lm75 ti,tmp275
from trivial-devices since there are handled by hwmon/lm75.yaml

Remove skyworks,sky81452 handled by mfd/sky81452.txt
Remove nuvoton,npct601 handled by security/tpm/tpm-i2c.txt
Remove maxim,max1237 handled by iio/adc/maxim,max1238.yaml
Remove adi,adt7461 and adt7461 handled by hwmon/lm90.txt
Remove dlg,da9063 handled by mfd/da9063.txt

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 .../devicetree/bindings/trivial-devices.yaml  | 24 -------------------
 1 file changed, 24 deletions(-)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index 4e92792f9153..d01c4211bda4 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -39,10 +39,6 @@ properties:
           - adi,adp5585-02
             # Analog Devices ADP5589 Keypad Decoder and I/O Expansion
           - adi,adp5589
-            # +/-1C TDM Extended Temp Range I.C
-          - adi,adt7461
-            # +/-1C TDM Extended Temp Range I.C
-          - adt7461
             # AMS iAQ-Core VOC Sensor
           - ams,iaq-core
             # i2c serial eeprom  (24cxx)
@@ -65,14 +61,10 @@ properties:
           - dallas,ds1631
             # Total-Elapsed-Time Recorder with Alarm
           - dallas,ds1682
-            # Tiny Digital Thermometer and Thermostat
-          - dallas,ds1775
             # CPU Peripheral Monitor
           - dallas,ds1780
             # CPU Supervisor with Nonvolatile Memory and Programmable I/O
           - dallas,ds4510
-            # Digital Thermometer and Thermostat
-          - dallas,ds75
             # 1/4 Brick DC/DC Regulated Power Module
           - delta,q54sj108a2
             # Devantech SRF02 ultrasonic ranger in I2C mode
@@ -83,8 +75,6 @@ properties:
           - devantech,srf10
             # DA9053: flexible system level PMIC with multicore support
           - dlg,da9053
-            # DA9063: system PMIC for quad-core application processors
-          - dlg,da9063
             # DMARD05: 3-axis I2C Accelerometer
           - domintech,dmard05
             # DMARD06: 3-axis I2C Accelerometer
@@ -107,8 +97,6 @@ properties:
           - mps,mp2888
             # Monolithic Power Systems Inc. multi-phase controller mp2975
           - mps,mp2975
-            # G751: Digital Temperature Sensor and Thermal Watchdog with Two-Wire Interface
-          - gmt,g751
             # Infineon IR36021 digital POL buck controller
           - infineon,ir36021
             # Infineon IR38064 Voltage Regulator
@@ -139,8 +127,6 @@ properties:
           - maxim,ds1803-050
             # 100 kOhm digital potentiometer with I2C interface
           - maxim,ds1803-100
-            # Low-Power, 4-/12-Channel, 2-Wire Serial, 12-Bit ADCs
-          - maxim,max1237
             # 10-bit 10 kOhm linear programable voltage divider
           - maxim,max5481
             # 10-bit 50 kOhm linear programable voltage divider
@@ -151,8 +137,6 @@ properties:
           - maxim,max5484
             # PECI-to-I2C translator for PECI-to-SMBus/I2C protocol conversion
           - maxim,max6621
-            # 9-Bit/12-Bit Temperature Sensors with I²C-Compatible Serial Interface
-          - maxim,max6625
             # 3-Channel Remote Temperature Sensor
           - maxim,max31730
             # mCube 3-axis 8-bit digital accelerometer
@@ -235,8 +219,6 @@ properties:
           - miramems,da311
             # Temperature sensor with integrated fan control
           - national,lm63
-            # I2C TEMP SENSOR
-          - national,lm75
             # Serial Interface ACPI-Compatible Microprocessor System Hardware Monitor
           - national,lm80
             # Serial Interface ACPI-Compatible Microprocessor System Hardware Monitor
@@ -247,8 +229,6 @@ properties:
           - national,lm92
             # i2c trusted platform module (TPM)
           - nuvoton,npct501
-            # i2c trusted platform module (TPM2)
-          - nuvoton,npct601
             # Nuvoton Temperature Sensor
           - nuvoton,w83773g
             # OKI ML86V7667 video decoder
@@ -275,8 +255,6 @@ properties:
           - sgx,vz89x
             # Relative Humidity and Temperature Sensors
           - silabs,si7020
-            # Skyworks SKY81452: Six-Channel White LED Driver with Touch Panel Bias Supply
-          - skyworks,sky81452
             # Socionext SynQuacer TPM MMIO module
           - socionext,synquacer-tpm-mmio
             # i2c serial eeprom  (24cxx)
@@ -305,8 +283,6 @@ properties:
           - ti,tmp102
             # Low Power Digital Temperature Sensor with SMBUS/Two Wire Serial Interface
           - ti,tmp103
-            # Digital Temperature Sensor
-          - ti,tmp275
             # TI Dual channel DCAP+ multiphase controller TPS53676 with AVSBus
           - ti,tps53676
             # TI Dual channel DCAP+ multiphase controller TPS53679
-- 
2.26.3

