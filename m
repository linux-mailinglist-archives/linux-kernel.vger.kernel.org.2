Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C67C53BC448
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 02:02:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbhGFAFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 20:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbhGFAFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 20:05:08 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE4ACC061760;
        Mon,  5 Jul 2021 17:02:29 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id x3so2562130pll.5;
        Mon, 05 Jul 2021 17:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=rS9/KX2AUiC/aLX/vHmrh7KcSB+1jwtHLy+1OkCgEjM=;
        b=rQvp5qxyAZ3QPeB4e7cu+TNGmYPoLee1BvGkC+yENUYhnhJWr5yUmzi5o0bKL65sXX
         gmJpTfu6hYAv/iiAvpvjAOooMWGzvQUNlpOlTk4RNJgJgdVWBRIL2kHAJ+jYOoYYVJ2J
         6FzQDwWX28/CpZAhVrjUvqXiTn5A1iXolZwq5bOQ44ljWJxPSyldrExgYyG2BBFxpWvr
         bfWwQTRkuKIVACqa0dkk7VamkK3ARa4jMUQnll+RO0P4v3kZstVUaF+qS94YxfRmP0bP
         u9YJkpRILSl3TMuqK5jc9lag4VG1ZNid2NdMJsdh5dvUZEFVX0qVWXk1NZMDRcDBIBuC
         jG/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rS9/KX2AUiC/aLX/vHmrh7KcSB+1jwtHLy+1OkCgEjM=;
        b=mTZZn3W62aAKSUmEELHpCo+8I7AupuAyYuz1vbe0eYT9EN4vDA77iGLWtjp8nz0S4w
         lF1y65FHSm1i9fRrrNjPRVBXBHR4VhygWdxkhkis0+zi25aI9c8bROE7jBYX4vHg/tU2
         xkPy5Q7UxpRypR8TECVE/ZtAT9sC0SxylGCgEYiWsOv+rwpmff/2LibAOobLZWsLRnv7
         MnCSVk7fppwG1qGYQj39ReRkNoVM2HwNcnOVV1hw7Mfxnmjp0DINWXb1XwLxbyXaxkM/
         RJgScpo+yBwedfX6AmxDAMsu9XIZBZzdNDenx5vVDFzLt2uNJE6NgSMaZNp90d8yu0k4
         WboA==
X-Gm-Message-State: AOAM530w1vRfnRny910FsL2R19o5AZWOLhN/3KBbhqeqUce/njrao5ue
        /UsWBtTglezwjh/ovcooyhI=
X-Google-Smtp-Source: ABdhPJzpyBkCyFekN13HD7vmVwlAsfbGBRHSTrvfPMCPElD6JtWqLmnhNTkVVRa1GdNjJjNgQvpnUA==
X-Received: by 2002:a17:90a:ea88:: with SMTP id h8mr17694154pjz.147.1625529748969;
        Mon, 05 Jul 2021 17:02:28 -0700 (PDT)
Received: from localhost.lan (p1284205-ipngn14601marunouchi.tokyo.ocn.ne.jp. [153.205.193.205])
        by smtp.gmail.com with ESMTPSA id u24sm14359456pfm.200.2021.07.05.17.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 17:02:28 -0700 (PDT)
Received: from x2.lan (localhost [127.0.0.1])
        by localhost.lan (Postfix) with ESMTPSA id 10968902A2B;
        Tue,  6 Jul 2021 00:02:26 +0000 (GMT)
From:   Vincent Pelletier <plr.vincent@gmail.com>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Support Opensource <support.opensource@diasemi.com>,
        Lee Jones <lee.jones@linaro.org>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Opensource [Steve Twiss]" <stwiss.opensource@diasemi.com>
Subject: [PATCH 3/3] Documentation: hwmon: New information for DA9063
Date:   Tue,  6 Jul 2021 00:01:57 +0000
Message-Id: <aef8227a9ac7246791bf3f086008e2d381ddd463.1625529219.git.plr.vincent@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <1182ccb1b0bac9276967f4a11d971bd135c611f2.1625529219.git.plr.vincent@gmail.com>
References: <1182ccb1b0bac9276967f4a11d971bd135c611f2.1625529219.git.plr.vincent@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Opensource [Steve Twiss]" <stwiss.opensource@diasemi.com>

Addition of HWMON documentation for the DA9063 driver.

Signed-off-by: Opensource [Steve Twiss] <stwiss.opensource@diasemi.com>

Updated temperature formula, as of datasheet rev 2.3.

Signed-off-by: Vincent Pelletier <plr.vincent@gmail.com>
---
Originally submitted by Steve Twiss in 2014:
  https://marc.info/?l=linux-kernel&m=139560868209856&w=2

 Documentation/hwmon/da9063 | 67 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)
 create mode 100644 Documentation/hwmon/da9063

diff --git a/Documentation/hwmon/da9063 b/Documentation/hwmon/da9063
new file mode 100644
index 000000000000..879f1d0fb3e4
--- /dev/null
+++ b/Documentation/hwmon/da9063
@@ -0,0 +1,67 @@
+
+Kernel driver da9063-hwmon
+==========================
+
+Supported chips:
+ * Dialog Semiconductor DA9063 PMIC
+    Prefix: 'da9063'
+    Datasheet:
+	http://www.dialog-semiconductor.com/products/power-management/DA9063
+
+Authors: S Twiss <stwiss.opensource@diasemi.com>
+
+Description
+-----------
+
+The DA9063 PMIC provides a general purpose ADC with 10 bits of resolution.
+It uses track and hold circuitry with an analogue input multiplexer which
+allows the conversion of up to 9 different inputs.
+
+ Channel  0: VSYS_RES	measurement of the system VDD (2.5 - 5.5V)
+ Channel  1: ADCIN1_RES	high impedance input (0 - 2.5V)
+ Channel  2: ADCIN2_RES	high impedance input (0 - 2.5V)
+ Channel  3: ADCIN3_RES	high impedance input (0 - 2.5V)
+ Channel  4: Tjunc	measurement of internal temperature sensor
+ Channel  5: VBBAT	measurement of the backup battery voltage (0 - 5.0V)
+ Channel  6: N/A	Reserved
+ Channel  7: N/A	Reserved
+ Channel  8: MON1_RES	group 1 internal regulators voltage (0 - 5.0V)
+ Channel  9: MON2_RES	group 2 internal regulators voltage (0 - 5.0V)
+ Channel 10: MON3_RES	group 3 internal regulators voltage (0 - 5.0V)
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
+Channel 4 (Tjunc) will be used to measure the output of the internal
+temperature sensor. The ADC measurement result and the T_OFFSET value can
+be used by the host to calculate the internal junction temperature
+
+	Tjunc = -0.398 * (ADC - T_OFFSET) + 330;
+
+The junction temperature attribute is supported by the driver.
-- 
2.32.0

