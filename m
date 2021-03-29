Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF0EA34D088
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 14:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231468AbhC2Myo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 08:54:44 -0400
Received: from mail-lf1-f42.google.com ([209.85.167.42]:40640 "EHLO
        mail-lf1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231574AbhC2MyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 08:54:21 -0400
Received: by mail-lf1-f42.google.com with SMTP id a198so18260922lfd.7;
        Mon, 29 Mar 2021 05:54:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0HEOdPNwVv2E05Sdh6EgrN12s70clVLqjzJqZiAHUHQ=;
        b=s/QVcph5ex7AVmJtS9eFuzxrbJmIaRcdCgFMmFUPZ09gItaYhYB4yDf3c4fzJ4GjOw
         ydhnpr0aBHzvlKCOdcfSNg77O+hI2GN4Ckky7+fJl8lqP59cC/0FVzy6XmYcCzu3ftXW
         1/hs7ilGlNDehQx2lLIYbCAgkLnxWGcM0SjUrmV5G4kUwuZLTVnJ9zBojN7DQclUlcDH
         7/1mS2P58TG2c4b/tg6tezG6Ep+//dsjb0mFQKDsUo9aD1sD2V/0kReSVeAXMV16vJ6d
         oChT67DHCMMAljYLoSYFU4toJXOH0C82cC6jfocAQU41ufPTlua3SNNhTZxJgH4w1pDb
         1A6g==
X-Gm-Message-State: AOAM532XP89/TjkaPfegrKUVX43JFllJAs8NSk/40ePj0d7a17pc3iNY
        npScZKFTO+8s25RWlrq2eWk=
X-Google-Smtp-Source: ABdhPJwtbIgCnZmkaBPsWdMW6WUa5t15cGL66ZW0SWXC25wvhnIDsbCF4ZdSBQol9M44Dq5UcGyJ4A==
X-Received: by 2002:a05:6512:2016:: with SMTP id a22mr16472091lfb.645.1617022459139;
        Mon, 29 Mar 2021 05:54:19 -0700 (PDT)
Received: from localhost.localdomain (dc7vkhyyyyyyyyyyyyyby-3.rev.dnainternet.fi. [2001:14ba:16e2:8300::2])
        by smtp.gmail.com with ESMTPSA id q7sm1910387lfc.260.2021.03.29.05.54.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 05:54:18 -0700 (PDT)
Date:   Mon, 29 Mar 2021 15:54:12 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-power@fi.rohmeurope.com
Subject: [PATCH v5 04/19] dt_bindings: regulator: Add ROHM BD71815 PMIC
 regulators
Message-ID: <714dca49b2aef4896eec13673a43bef0b2551b5f.1617020713.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1617020713.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1617020713.git.matti.vaittinen@fi.rohmeurope.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding documentation for regulators on ROHM BD71815 PMIC.
5 bucks, 7 LDOs and a boost for LED.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
No Changes since v3
 .../regulator/rohm,bd71815-regulator.yaml     | 116 ++++++++++++++++++
 1 file changed, 116 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/rohm,bd71815-regulator.yaml

diff --git a/Documentation/devicetree/bindings/regulator/rohm,bd71815-regulator.yaml b/Documentation/devicetree/bindings/regulator/rohm,bd71815-regulator.yaml
new file mode 100644
index 000000000000..7d0adb74a396
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/rohm,bd71815-regulator.yaml
@@ -0,0 +1,116 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/rohm,bd71815-regulator.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ROHM BD71815 Power Management Integrated Circuit regulators
+
+maintainers:
+  - Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
+
+description: |
+  This module is part of the ROHM BD718215 MFD device. For more details
+  see Documentation/devicetree/bindings/mfd/rohm,bd71815-pmic.yaml.
+
+  The regulator controller is represented as a sub-node of the PMIC node
+  on the device tree.
+
+  The valid names for BD71815 regulator nodes are
+  buck1, buck2, buck3, buck4, buck5,
+  ldo1, ldo2, ldo3, ldo4, ldo5,
+  ldodvref, ldolpsr, wled
+
+properties:
+  wled:
+    type: object
+    description:
+      properties for wled regulator
+    $ref: regulator.yaml#
+
+    properties:
+      regulator-name:
+        const: wled
+
+patternProperties:
+  "^((ldo|buck)[1-5]|ldolpsr|ldodvref)$":
+    type: object
+    description:
+      Properties for single LDO/BUCK regulator.
+    $ref: regulator.yaml#
+
+    properties:
+      regulator-name:
+        pattern: "^((ldo|buck)[1-5]|ldolpsr|ldodvref)$"
+        description:
+          should be "ldo1", ..., "ldo5", "buck1", ..., "buck5" and "ldolpsr"
+          for ldolpsr regulator, "ldodvref" for ldodvref reglator.
+
+      rohm,vsel-gpios:
+        description:
+          GPIO used to control ldo4 state (when ldo4 is controlled by GPIO).
+
+      rohm,dvs-run-voltage:
+        description:
+          PMIC "RUN" state voltage in uV when PMIC HW states are used. See
+          comments below for bucks/LDOs which support this. 0 means
+          regulator should be disabled at RUN state.
+        $ref: "/schemas/types.yaml#/definitions/uint32"
+        minimum: 0
+        maximum: 3300000
+
+      rohm,dvs-snvs-voltage:
+        description:
+          Whether to keep regulator enabled at "SNVS" state or not.
+          0 means regulator should be disabled at SNVS state, non zero voltage
+          keeps regulator enabled. BD71815 does not change voltage level
+          when PMIC transitions to SNVS.SNVS voltage depends on the previous
+          state (from which the PMIC transitioned to SNVS).
+        $ref: "/schemas/types.yaml#/definitions/uint32"
+        minimum: 0
+        maximum: 3300000
+
+      rohm,dvs-suspend-voltage:
+        description:
+          PMIC "SUSPEND" state voltage in uV when PMIC HW states are used. See
+          comments below for bucks/LDOs which support this. 0 means
+          regulator should be disabled at SUSPEND state.
+        $ref: "/schemas/types.yaml#/definitions/uint32"
+        minimum: 0
+        maximum: 3300000
+
+      rohm,dvs-lpsr-voltage:
+        description:
+          PMIC "LPSR" state voltage in uV when PMIC HW states are used. See
+          comments below for bucks/LDOs which support this. 0 means
+          regulator should be disabled at LPSR state.
+        $ref: "/schemas/types.yaml#/definitions/uint32"
+        minimum: 0
+        maximum: 3300000
+
+        # Bucks 1 and 2 support giving separate voltages for operational states
+        # (RUN /CLEAN according to data-sheet) and non operational states
+        # (LPSR/SUSPEND). The voltage is automatically changed when HW
+        # state changes. Omitting these properties from bucks 1 and 2 leave
+        # buck voltages to not be toggled by HW state. Enable status may still
+        # be toggled by state changes depending on HW default settings.
+        #
+        # Bucks 3-5 and ldos 1-5 support setting the RUN state voltage here.
+        # Given RUN voltage is used at all states if regulator is enabled at
+        # given state.
+        # Values given for other states are regarded as enable/disable at
+        # given state (see below).
+        #
+        # All regulators except WLED support specifying enable/disable status
+        # for each of the HW states (RUN/SNVS/SUSPEND/LPSR). HW defaults can
+        # be overridden by setting voltage to 0 (regulator disabled at given
+        # state) or non-zero (regulator enabled at given state). Please note
+        # that setting non zero voltages for bucks 1/2 will also enable voltage
+        # changes according to state change.
+
+    required:
+      - regulator-name
+
+    unevaluatedProperties: false
+
+additionalProperties: false
-- 
2.25.4


-- 
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes. Just then he vanished ~~~
Simon says - in Latin please.
~~~ "non cogito me" dixit Rene Descarte, deinde evanescavit ~~~
Thanks to Simon Glass for the translation =] 
