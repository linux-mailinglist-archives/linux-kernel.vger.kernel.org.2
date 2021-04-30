Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D936E36FA68
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 14:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232432AbhD3Mgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 08:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232328AbhD3MgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 08:36:22 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE800C061348
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 05:35:29 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id a4so11641606ejk.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 05:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KDQBYbM7HXMZFTesh6PlprpTxhf7UowLSjGjy7RFSWo=;
        b=M1/4WFchbemJs63V5CScpuwlBM3mkoQqhLQSOm8P8AHZHAy9FM6TkIWpHkFKBk+sVs
         v7pagiPQLLoowSD2ax4Lzf6MV5CJASaDSgFCI9WDPrWNHt7UZZCimg7y8w+Cv96UHmb7
         v6cleL0KaFz+m9K7rQpqN1fQ4/9/daoZ1o6kvQIh1HA5hwHqnkltCwJlKkAK1CsnCJ/1
         9TupZDt1/Oinpo6EZPxUvsEkkpDXqCHUHuHhVgTdraJlb4Vfu9j8OKIfv6GNIRIOw81O
         EsobQ1l+yjZ7h+MijUsY2nCg/UHfjFBM7NSmi4cUEGwry1stZTg6ocPLFEhkjcqIoOpb
         6wOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KDQBYbM7HXMZFTesh6PlprpTxhf7UowLSjGjy7RFSWo=;
        b=pAVpc5ynAv4snIKxO1g45gKHlTJ0TXz505jebwqw/Vi/cjMDp0ZThdoMQOtGN0BB3I
         QK4jPfUmaBWPTDWnbX9Dew/QsI/a5khsENSoTZ4/qKhHmx1T7pjAjnAWPgtgzsfPDNs1
         Y9Z7HDCnrBywlD1Txear6RoYxOWUK6Wh58m/2vXHI+v9V+jZJAOANV1glWfdRBPc4yjN
         yIp2DT98nm06cwF3feYz/A/EHl/IDeL500Ws42m9Ej/GqXagKXoK81hVlOvgZzPA5Wou
         NQ42L0RWJF/GqEbH8u07Rdlkwf7XDt6deOeHXZFVaZEBZiwl9lPROvwC58yVn2c97oP7
         hWmQ==
X-Gm-Message-State: AOAM5337uNVOKw6FC27xxgzXVFS5kqCJrfja609EIqIjPKfzBBPwgVC6
        9ux4fbl5t7TqKdYKVOF0GNxt/Q==
X-Google-Smtp-Source: ABdhPJzviriv9V3GeCgo9rSUitIUOcEjs2xNWPfe/AL43zNEkj1RGEP4jwP08JE9C/nhZIy07gRj8Q==
X-Received: by 2002:a17:906:5d13:: with SMTP id g19mr4179389ejt.206.1619786128374;
        Fri, 30 Apr 2021 05:35:28 -0700 (PDT)
Received: from localhost.localdomain (dh207-97-15.xnet.hr. [88.207.97.15])
        by smtp.googlemail.com with ESMTPSA id d15sm1822988ejj.42.2021.04.30.05.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 05:35:28 -0700 (PDT)
From:   Robert Marko <robert.marko@sartura.hr>
To:     lee.jones@linaro.org, robh+dt@kernel.org, linus.walleij@linaro.org,
        bgolaszewski@baylibre.com, jdelvare@suse.com, linux@roeck-us.net,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-hwmon@vger.kernel.org
Cc:     luka.perkov@sartura.hr, jmp@epiphyte.org, pmenzel@molgen.mpg.de,
        buczek@molgen.mpg.de, Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH 5/6] dt-bindings: mfd: Add Delta TN48M CPLD drivers bindings
Date:   Fri, 30 Apr 2021 14:35:10 +0200
Message-Id: <20210430123511.116057-5-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210430123511.116057-1-robert.marko@sartura.hr>
References: <20210430123511.116057-1-robert.marko@sartura.hr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding document for the Delta TN48M CPLD drivers.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 .../bindings/mfd/delta,tn48m-cpld.yaml        | 59 +++++++++++++++++++
 1 file changed, 59 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/delta,tn48m-cpld.yaml

diff --git a/Documentation/devicetree/bindings/mfd/delta,tn48m-cpld.yaml b/Documentation/devicetree/bindings/mfd/delta,tn48m-cpld.yaml
new file mode 100644
index 000000000000..7d81943d3d27
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/delta,tn48m-cpld.yaml
@@ -0,0 +1,59 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/delta,tn48m-cpld.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Delta Networks TN48M CPLD controller
+
+maintainers:
+  - Robert Marko <robert.marko@sartura.hr>
+
+description: |
+  Lattice CPLD onboard the TN48M switches is used for system
+  management.
+
+  It provides information about the hardware model, revision,
+  PSU status etc.
+
+  It is also being used as a GPIO expander for the SFP slots.
+
+properties:
+  compatible:
+    const: delta,tn48m-cpld
+
+  reg:
+    description:
+      I2C device address.
+    maxItems: 1
+
+  gpio-controller: true
+
+  "#gpio-cells":
+    const: 2
+    description:
+      The first cell is the pin number and the second cell is used to specify
+      the gpio active state.
+
+required:
+  - compatible
+  - reg
+  - gpio-controller
+  - "#gpio-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        cpld@41 {
+            compatible = "delta,tn48m-cpld";
+            reg = <0x41>;
+
+            gpio-controller;
+            #gpio-cells = <2>;
+        };
+    };
-- 
2.31.1

