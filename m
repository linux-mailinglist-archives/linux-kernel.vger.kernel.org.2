Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F7C73BE8BF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 15:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231643AbhGGNbu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 09:31:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231493AbhGGNbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 09:31:48 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3D9EC061574;
        Wed,  7 Jul 2021 06:29:08 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id y2so1058231plc.8;
        Wed, 07 Jul 2021 06:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=GWETO3gmH4q+0KXXO1NcIFMA0qtQJbq8/KhChR8fUrU=;
        b=uTTXOQSRBEespNz2yCt2rcI/bIciRKnW/P/EM0AnHcXZyPH3XJBmrZHj/a6rnbMMHs
         XC52hHvtoFXdsHcrMdyfyxQbs7oDMsdwK4blnnmtNkfnfrpVc9iDik/ySSmi6ZVzXU7m
         Eeeox2gGwoWDWAoY4NNTWEm+OvHJ/kxWeNIRsKEyGOc3zIdXkpjcqdKwOiiHyTcHLDUt
         1cifUkss0dwXLmTysBOVU/B2k/+CP5zoyvGIiN/c6k6iND3dcuILMQ0r69TtxRkrrjNw
         lR8oDbL62nji/Ge/Nws/vMj1OC4HEsbBkFjGMjzF4FoFPU6gCDnO59fAQzI+QEv9EXrk
         Lg1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GWETO3gmH4q+0KXXO1NcIFMA0qtQJbq8/KhChR8fUrU=;
        b=mKUebBQ/zFt1LzJCDg49c22hV7A3H3SOuabXGfgz9WrqioHLuVMncWHhEW/islj0vg
         NT+z7q5N6j2wp+yQ6YXcz4RgNlcStmA5E2EjESs8tTF09v7E7M3Ah08WV89QCbToeXuW
         l5U2Gh9vG4VzLXHxRFxmVHsuhjP04GQYLjN6VwfACyLxLhZ4FSJuddthQMBXeT7cOOqc
         ab9JbQX1FqBSJpkUsT+7nWaef2jI6ABEc/S15Yf6aVB3pZGTNRtj9MH2mHMwI3UkYowG
         eED5EGyxMHyFevvgdQ3EIjuP3r/R16uqmHYdTQONtuuXyRd8KFaT2jMEtAO4jgS3jW4K
         oRFw==
X-Gm-Message-State: AOAM530BR2RkuBKiISvzO9pJPbY/8bGvOOmegJau27Lt6rDbeiQhWq9T
        M2PUk3fWDU3iG6KlrZ+OqA0J3aYNXNXa0Q==
X-Google-Smtp-Source: ABdhPJwdsQoMcL9nzWeDvHCgKpKy/BmrOjNtdNANPdGbNG4OWxHCRdDfmU7m4cbqLU8NTE1ndxl3SA==
X-Received: by 2002:a17:902:d890:b029:129:1282:fd3b with SMTP id b16-20020a170902d890b02901291282fd3bmr21629485plz.84.1625664548132;
        Wed, 07 Jul 2021 06:29:08 -0700 (PDT)
Received: from localhost.lan (p1284205-ipngn14601marunouchi.tokyo.ocn.ne.jp. [153.205.193.205])
        by smtp.gmail.com with ESMTPSA id r29sm19577810pfq.177.2021.07.07.06.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jul 2021 06:29:07 -0700 (PDT)
Received: from x2.lan (localhost [127.0.0.1])
        by localhost.lan (Postfix) with ESMTPSA id 76A4D902A2B;
        Wed,  7 Jul 2021 13:29:05 +0000 (GMT)
From:   Vincent Pelletier <plr.vincent@gmail.com>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Support Opensource <support.opensource@diasemi.com>,
        Lee Jones <lee.jones@linaro.org>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Opensource [Steve Twiss]" <stwiss.opensource@diasemi.com>
Subject: [PATCH v3 3/3] Documentation: hwmon: New information for DA9063
Date:   Wed,  7 Jul 2021 13:25:04 +0000
Message-Id: <31e410523358f7069c36eb981ab96613346ffe37.1625662290.git.plr.vincent@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <c06db13bb5076a8ee48e38a74caf3b81e4a2d1f8.1625662290.git.plr.vincent@gmail.com>
References: <c06db13bb5076a8ee48e38a74caf3b81e4a2d1f8.1625662290.git.plr.vincent@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Opensource [Steve Twiss]" <stwiss.opensource@diasemi.com>

Addition of HWMON documentation for the DA9063 driver.

Signed-off-by: Opensource [Steve Twiss] <stwiss.opensource@diasemi.com>

Updated temperature formula, as of datasheet rev 2.3.
Converted to ReStructuredText.

Signed-off-by: Vincent Pelletier <plr.vincent@gmail.com>
---
Changes in v3:
- Reference added to index.rst

Changes in v2:
- ReST-ified

Originally submitted by Steve Twiss in 2014:
  https://marc.info/?l=linux-kernel&m=139560868209856&w=2

 Documentation/hwmon/da9063.rst | 73 ++++++++++++++++++++++++++++++++++
 Documentation/hwmon/index.rst  |  1 +
 2 files changed, 74 insertions(+)
 create mode 100644 Documentation/hwmon/da9063.rst

diff --git a/Documentation/hwmon/da9063.rst b/Documentation/hwmon/da9063.rst
new file mode 100644
index 000000000000..aae69c58a5d6
--- /dev/null
+++ b/Documentation/hwmon/da9063.rst
@@ -0,0 +1,73 @@
+Kernel driver da9063-hwmon
+==========================
+
+Supported chips:
+
+  * Dialog Semiconductor DA9063 PMIC
+
+    Prefix: 'da9063'
+
+    Datasheet: Publicly available at the Dialog Semiconductor website:
+
+	http://www.dialog-semiconductor.com/products/power-management/DA9063
+
+Authors:
+	- S Twiss <stwiss.opensource@diasemi.com>
+	- Vincent Pelletier <plr.vincent@gmail.com>
+
+Description
+-----------
+
+The DA9063 PMIC provides a general purpose ADC with 10 bits of resolution.
+It uses track and hold circuitry with an analogue input multiplexer which
+allows the conversion of up to 9 different inputs:
+
+- Channel  0: VSYS_RES	measurement of the system VDD (2.5 - 5.5V)
+- Channel  1: ADCIN1_RES	high impedance input (0 - 2.5V)
+- Channel  2: ADCIN2_RES	high impedance input (0 - 2.5V)
+- Channel  3: ADCIN3_RES	high impedance input (0 - 2.5V)
+- Channel  4: Tjunc	measurement of internal temperature sensor
+- Channel  5: VBBAT	measurement of the backup battery voltage (0 - 5.0V)
+- Channel  6: N/A	Reserved
+- Channel  7: N/A	Reserved
+- Channel  8: MON1_RES	group 1 internal regulators voltage (0 - 5.0V)
+- Channel  9: MON2_RES	group 2 internal regulators voltage (0 - 5.0V)
+- Channel 10: MON3_RES	group 3 internal regulators voltage (0 - 5.0V)
+
+The MUX selects from and isolates the 9 inputs and presents the channel to
+be measured to the ADC input. When selected, an input amplifier on the VSYS
+channel subtracts the VDDCORE reference voltage and scales the signal to the
+correct value for the ADC.
+
+The analog ADC includes current sources at ADC_IN1, ADC_IN2 and ADC_IN3 to
+support resistive measurements.
+
+Channels 1, 2 and 3 current source capability can be set through the ADC
+thresholds ADC_CFG register and values for ADCIN1_CUR, ADCIN2_CUR and
+ADCIN3_CUR. Settings for ADCIN1_CUR and ADCIN2_CUR are 1.0, 2.0, 10 and
+40 micro Amps. The setting for ADCIN3_CUR is 10 micro Amps.
+
+Voltage Monitoring
+------------------
+
+The manual measurement allows monitoring of the system voltage VSYS, the
+auxiliary channels ADCIN1, ADCIN2 and ADCIN3, and a VBBAT measurement of
+the backup battery voltage (0 - 5.0V). The manual measurements store 10
+bits of ADC resolution.
+
+The manual ADC measurements attributes described above are supported by
+the driver.
+
+The automatic ADC measurement is not supported by the driver.
+
+Temperature Monitoring
+----------------------
+
+Temperatures are sampled by a 10 bit ADC.  Junction temperatures
+are monitored by the ADC channels.
+
+The junction temperature is calculated:
+
+	Degrees celsius = -0.398 * (ADC_RES - T_OFFSET) + 330;
+
+The junction temperature attribute is supported by the driver.
diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
index 9ed60fa84cbe..b3aba6525157 100644
--- a/Documentation/hwmon/index.rst
+++ b/Documentation/hwmon/index.rst
@@ -51,6 +51,7 @@ Hardware Monitoring Kernel Drivers
    corsair-psu
    da9052
    da9055
+   da9063
    dell-smm-hwmon
    dme1737
    drivetemp
-- 
2.32.0

