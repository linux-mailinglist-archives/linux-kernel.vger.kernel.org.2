Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15BB63BD8BC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 16:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233016AbhGFOqV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 10:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233014AbhGFOqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 10:46:05 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 621FBC05BD14;
        Tue,  6 Jul 2021 07:34:56 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id f20so11743189pfa.1;
        Tue, 06 Jul 2021 07:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=WYmJLY9bc2BaxeUu/qUZgzgqMbq0sZhiO+uLD5KZhTI=;
        b=ZNkrNEr4KGmj/2fbW0eQVTlsGzbWi+ILb/P7fMlYTTx3z8cJ4p3qPVCAK5AtpSjjkG
         qmFt8s4FqTZquMymHNcfGjyBL39NROLfYMUK6QayOInSZxdscwD8o4f+srDi7tonnvDk
         bdX0W38B6Rm0Y4UxV/T774m12JqoN/OC5O5ZpBZflMzHywoiIgKG4z2alTqAPqKGfmyG
         lZtuy+PahUk7bVkk7A1Q7UdFqt1NU8jlGa25x5hB9beiJLpkKdVCaJav4eGlxl84H5R7
         BDdhxWcTv4wuO5vUiZFs8gJ5bIhrpL2AbLKKNUoPc9pJc8StWdgnzeGQo3hV0S8Ewznq
         Dw4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WYmJLY9bc2BaxeUu/qUZgzgqMbq0sZhiO+uLD5KZhTI=;
        b=icWV8e4VPtKle9fieclclzzZbOj1v1UReprMNA0xb3ENjtheNQ4yIvD9fPntvjwHwI
         WnBCI4rCW9ja+krr66NtOFeETB1Era6yTWUvXtHd7wFySZCWOqU/4I5J+V83k9Xa9yZi
         XZX24e7v/akdIpM15Pi5y4wDZAQuP8hiyuj1foxHCgMAa6YFz2XRUpbwrzoB+ZFFIxNS
         g5iv21WQ5biFjGzcMmqFCoWlMTrYmhk73+wwsZp5q8dgbleVIr2Z0iGaZf88+VBbUX6F
         ijLhPmTQACffHaWnWKuXxyXtnpAyISzDlAN8OlZIb3jbHRsnSrUo9MZLKE22hc8iGWqI
         aLvA==
X-Gm-Message-State: AOAM533VpiDT3Iohl01fNffjio5kIkIzPHe74rWHFfE1BWZgXqQ1LEsU
        8JaKRIDGeZlORW9RvdNQMR3aZDNjIbCSwSM8q4s=
X-Google-Smtp-Source: ABdhPJxEIhdcXf+hrUDe0sA7qtmyBbbwvJXcsFj8Gz6ye56LODeb0rpJ8lI5n8p4reZ8UtNRbgYlHQ==
X-Received: by 2002:a62:37c2:0:b029:2ff:f7dd:1620 with SMTP id e185-20020a6237c20000b02902fff7dd1620mr20773671pfa.33.1625582095926;
        Tue, 06 Jul 2021 07:34:55 -0700 (PDT)
Received: from localhost.lan ([2400:4070:175b:7500::7a7])
        by smtp.gmail.com with ESMTPSA id e2sm19785718pgh.5.2021.07.06.07.34.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 07:34:54 -0700 (PDT)
Received: from x2.lan (localhost [127.0.0.1])
        by localhost.lan (Postfix) with ESMTPSA id 89D18902A2B;
        Tue,  6 Jul 2021 14:34:52 +0000 (GMT)
From:   Vincent Pelletier <plr.vincent@gmail.com>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Support Opensource <support.opensource@diasemi.com>,
        Lee Jones <lee.jones@linaro.org>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Opensource [Steve Twiss]" <stwiss.opensource@diasemi.com>
Subject: [PATCH 3/3] Documentation: hwmon: New information for DA9063
Date:   Tue,  6 Jul 2021 14:34:49 +0000
Message-Id: <089cba74f35e1f7cb07064fa336518d853c8d569.1625581991.git.plr.vincent@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <850a353432cd676f96889cede291232abf58918d.1625581991.git.plr.vincent@gmail.com>
References: <850a353432cd676f96889cede291232abf58918d.1625581991.git.plr.vincent@gmail.com>
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
Changes in v2:
- ReST-ified

Originally submitted by Steve Twiss in 2014:
  https://marc.info/?l=linux-kernel&m=139560868209856&w=2

 Documentation/hwmon/da9063.rst | 73 ++++++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)
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
-- 
2.32.0

