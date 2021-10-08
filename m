Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0671426A0C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 13:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241977AbhJHLpw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 07:45:52 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:34002
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243294AbhJHLnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 07:43:40 -0400
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id BF1A63FFFD
        for <linux-kernel@vger.kernel.org>; Fri,  8 Oct 2021 11:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1633693218;
        bh=ot49W0BLovtQBZiy0mCJysagJRdZUZ8sfEESkGMXTWw=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=EBsfQim4dP10pdw2TmCpbdhHLybsHBZVayqWxqH1otSlYqYlvmUlCTjJXuagHDr9k
         Z7d48wSb0LGEYDj0J9ug4+S5KeecYGSFrPeRfN7Ap26fp714tFICf5yaGQ5lFWnwwB
         FqSdlh+ar7mfaSWkVNn8zsfwtV2NwAonxAfSbSl/lN73j6Yo7nSPugYvEfkYPy3esX
         DXiffjAnJqaWpQBPU0KK2dILtEv1PNxrmC3wm95eeughGK2bFaGa3pvRdAF9QRz0sn
         +zChQlR/ewIXZh/MqzX4qbTjv68W5jBu/etcNMNw+rH8g/E5w0nmcqZMUvJcYe3YmM
         EKjKIIZ9TjG1Q==
Received: by mail-ed1-f72.google.com with SMTP id p13-20020a056402044d00b003db3256e4f2so8992023edw.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Oct 2021 04:40:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ot49W0BLovtQBZiy0mCJysagJRdZUZ8sfEESkGMXTWw=;
        b=n+doTv2P1iaHrAtbFl/zBh965jcGA1IV7o6JKUQtI5CkPPJSERSNQl0TF1d3Iul++c
         HvKMhxqXp6pa0vnCpZw8cKxCo8f7hmggLIFPc5AdmC3ZJJnu7ti0UY0w3JFKO8d0exNp
         C5ktBQm0cVYUReawH2a95UXvebzqEqtJ59ja+grSWW7H+qqo2SaTn4Vwobcm6j/Nl7cE
         yQMfmCXG1J0PwxE4+RhxxZ4+D2b6ZuIyrKU12Gb8ASi/KiWb+juIeEeJqDmmFjn78hQH
         1ufH9UOki1/IzL42SA7bsVJ2+xhr6MktN9NHEy1FCcKY75pezQjPfs6PBErYmqoXDBQV
         4W1g==
X-Gm-Message-State: AOAM533jP49Q/zqP8X8TNJ/NlV68Z3esuSomCn6GEun7WmR9Yej9ksnW
        CNipeP19Vd89pgF1kw3M6N6Ej8G5g0QJmVQIH6RxmjtDvoMHpXxiki5PkN7HY9ZzehY6x3N9Upy
        sDwGeGp0imKH3sGh+nw9gLlGIBziWqt6vBZhUMyFj0w==
X-Received: by 2002:a05:6402:485:: with SMTP id k5mr14153353edv.257.1633693218390;
        Fri, 08 Oct 2021 04:40:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy4QuirGm9nppb97oQk+JI8N+A0wj7clDGbcRopxUW7YNhpFXnCX8Vk/nDDFlgNN8xc/QtNFQ==
X-Received: by 2002:a05:6402:485:: with SMTP id k5mr14153335edv.257.1633693218246;
        Fri, 08 Oct 2021 04:40:18 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-186-13.adslplus.ch. [188.155.186.13])
        by smtp.gmail.com with ESMTPSA id c17sm901437edu.11.2021.10.08.04.40.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 04:40:17 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Cc:     Sam Protsenko <semen.protsenko@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v4 08/10] dt-bindings: mfd: samsung,s2mpa01: convert to dtschema
Date:   Fri,  8 Oct 2021 13:39:30 +0200
Message-Id: <20211008113931.134847-5-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211008113723.134648-1-krzysztof.kozlowski@canonical.com>
References: <20211008113723.134648-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the MFD part of Samsung S2MPA01 PMIC to DT schema format.
Previously the bindings were mostly in mfd/samsung,sec-core.txt.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/mfd/samsung,s2mpa01.yaml         | 91 +++++++++++++++++++
 1 file changed, 91 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/samsung,s2mpa01.yaml

diff --git a/Documentation/devicetree/bindings/mfd/samsung,s2mpa01.yaml b/Documentation/devicetree/bindings/mfd/samsung,s2mpa01.yaml
new file mode 100644
index 000000000000..017befdf8adb
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/samsung,s2mpa01.yaml
@@ -0,0 +1,91 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/samsung,s2mpa01.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Samsung S2MPA01 Power Management IC
+
+maintainers:
+  - Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
+
+description: |
+  This is a part of device tree bindings for S2M and S5M family of Power
+  Management IC (PMIC).
+
+  The Samsung S2MPA01 is a Power Management IC which includes voltage
+  and current regulators, RTC, clock outputs and other sub-blocks.
+
+properties:
+  compatible:
+    const: samsung,s2mpa01-pmic
+
+  interrupts:
+    maxItems: 1
+
+  reg:
+    maxItems: 1
+
+  regulators:
+    $ref: ../regulator/samsung,s2mpa01.yaml
+    description:
+      List of child nodes that specify the regulators.
+
+  wakeup-source: true
+
+required:
+  - compatible
+  - reg
+  - regulators
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        pmic@66 {
+            compatible = "samsung,s2mpa01-pmic";
+            reg = <0x66>;
+
+            regulators {
+                ldo1_reg: LDO1 {
+                    regulator-name = "VDD_ALIVE";
+                    regulator-min-microvolt = <1000000>;
+                    regulator-max-microvolt = <1000000>;
+                };
+
+                ldo2_reg: LDO2 {
+                    regulator-name = "VDDQ_MMC2";
+                    regulator-min-microvolt = <2800000>;
+                    regulator-max-microvolt = <2800000>;
+                    regulator-always-on;
+                };
+
+                // ...
+
+                buck1_reg: BUCK1 {
+                    regulator-name = "vdd_mif";
+                    regulator-min-microvolt = <950000>;
+                    regulator-max-microvolt = <1350000>;
+                    regulator-always-on;
+                    regulator-boot-on;
+                };
+
+                buck2_reg: BUCK2 {
+                    regulator-name = "vdd_arm";
+                    regulator-min-microvolt = <950000>;
+                    regulator-max-microvolt = <1350000>;
+                    regulator-always-on;
+                    regulator-boot-on;
+                    regulator-ramp-delay = <50000>;
+                };
+
+                // ...
+            };
+        };
+    };
-- 
2.30.2

