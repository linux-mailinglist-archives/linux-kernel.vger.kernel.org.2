Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D38073541AA
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 13:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234979AbhDELlp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 07:41:45 -0400
Received: from mail-lj1-f176.google.com ([209.85.208.176]:39713 "EHLO
        mail-lj1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234952AbhDELlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 07:41:44 -0400
Received: by mail-lj1-f176.google.com with SMTP id u4so12386471ljo.6;
        Mon, 05 Apr 2021 04:41:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0HEOdPNwVv2E05Sdh6EgrN12s70clVLqjzJqZiAHUHQ=;
        b=ORUZxHgFYP1XtZh/mt6oBpwNwU9+hKiNv5+7+c+smvl4bpCsrJBgpUPgpmiWvHMDSA
         civHcL43fQ/EwyYDYuM4qltPnwoMNqonGiojP70mMJknxNhftC6lxUgA12w4qX+VCLAV
         Usye43Kv+5LkPWHl28hAON/mnXSLnmllTxfoa5K6o5cQO8QvGims73R8t3fVm25nDOZu
         GOa4Tjr1IsYFdKntDFa7eira5s7aDeAWX2m9o26Pi02kYv0bkNXsOCHXDofxJWYcUxVz
         +sI6GYaEkvIABSKFOneELPPx28gwrUA+kjGJ77b0X1oVre2Xw2jtkXpdE3vwSoWwhTs6
         AZCA==
X-Gm-Message-State: AOAM533tzd07Q5SrpQYDZLx1JstIBDrVVSrRkZnQPPpzutioijK7f4AR
        qKdb3hw0f4uwJyIz0An2eDM=
X-Google-Smtp-Source: ABdhPJypRMQOwyhi8nbcZ2A/wJCidvhwC4y5kR6vdh+UcsvvBXDJx16T/l3RZ4Txe/d/jlYSteempQ==
X-Received: by 2002:a2e:b0f2:: with SMTP id h18mr15413981ljl.396.1617622896936;
        Mon, 05 Apr 2021 04:41:36 -0700 (PDT)
Received: from localhost.localdomain (dc7vkhyyyyyyyyyyyyydy-3.rev.dnainternet.fi. [2001:14ba:16e2:8300::6])
        by smtp.gmail.com with ESMTPSA id k18sm1754170lfm.88.2021.04.05.04.41.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Apr 2021 04:41:36 -0700 (PDT)
Date:   Mon, 5 Apr 2021 14:41:30 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-power@fi.rohmeurope.com
Subject: [PATCH v6 04/16] dt_bindings: regulator: Add ROHM BD71815 PMIC
 regulators
Message-ID: <9e6c8c1ed13c50af3dec32b7d3d30ad1c5058604.1617616855.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1617616855.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1617616855.git.matti.vaittinen@fi.rohmeurope.com>
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
