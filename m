Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB03330AD2A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 17:55:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231668AbhBAQyw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 11:54:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231613AbhBAQyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 11:54:17 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1216CC061573;
        Mon,  1 Feb 2021 08:53:35 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id m1so10505082wml.2;
        Mon, 01 Feb 2021 08:53:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CkmdVzgNbNrIaaF20+A1gXu1TaJvHR1vrtcVh0MWaj8=;
        b=Sa0x2A5sCoxsagip1yKOtVtJUhS6O2APA0VMshlVpCWK3yA6a8PQK0PKSiztYswM0Q
         /6vKdJ+nnspAa3ZwthiKiZ4tMqTzCWJL4iHdauHyYNig8CbO9hb3QnE4KgSeufSltK3j
         r1Nh3qgJkEoDT8czHd83aImvm8GjE0NBLdCmtFh1C2TR0+FlyKAD/vzfHxEW8V5Y/+PM
         b+nNXY/aW3PWCIKsLGzkrqwZ3A3//gYodrlHeOs9tMNgZzC/29AHEi3V/8gtX81Sp19d
         e0wd6f8T2j1lfNrf4n8u506htnju1pNP1TitxF18PSASxUS7CHss3TaOVPiauf6xfWuG
         d6zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CkmdVzgNbNrIaaF20+A1gXu1TaJvHR1vrtcVh0MWaj8=;
        b=HScMJVpUdLCLRaTMrRdw370kKdpY1CuAvwFqAPVwnqa0X+BK1dN1ePEQppeBrPiP1m
         A+uJjCLX99Pdm3VwwG7FoVX9IyQvaHZKwlemoqL3SWasKV63RPLo2vpX/Hgwg8kIQvrH
         GCtiPQp8WYtk8ZWexSIfwBA0c9QKN3mhQH5aeM5YDSLqlIN6Xk6ud/3cqNLFdHgYtDYZ
         T+XUvU0DmXyM+02nCBCG4qo9wAb+2opFPOOjfx+ADnYBnZhbHg8TUXKSjhUhPcSFeCKN
         XBmy9wk4trU8rPbgE7kdy2PYfwxtKZcH+KGkW+6OSEglMwalU5q07eApC3uQQTPb9LEj
         ajJg==
X-Gm-Message-State: AOAM533Wxq7mUVw43HgjqG4nlesNQd5hsRgpgUS/VUynnel8OT95iVd/
        d4E0JS7ig7abJ5MHfS+AM5Q=
X-Google-Smtp-Source: ABdhPJwL/oyWhS2IOVT3OkuLeII6y6CxfbUrkxFI5N3fZy8o1bHz5oUwfDqgwG6r7Sc1bGBwmCN/8g==
X-Received: by 2002:a7b:c09a:: with SMTP id r26mr16118185wmh.64.1612198413859;
        Mon, 01 Feb 2021 08:53:33 -0800 (PST)
Received: from localhost (178-169-161-196.razgrad.ddns.bulsat.com. [178.169.161.196])
        by smtp.gmail.com with ESMTPSA id r12sm27749156wrp.13.2021.02.01.08.53.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Feb 2021 08:53:33 -0800 (PST)
From:   Iskren Chernev <iskren.chernev@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Iskren Chernev <iskren.chernev@gmail.com>
Subject: [PATCH v3 1/2] dt-bindings: panel: Add Samsung S6E3FA2 panel
Date:   Mon,  1 Feb 2021 18:53:05 +0200
Message-Id: <20210201165307.51443-1-iskren.chernev@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Samsung S6E3FA2 AMOLED cmd LCD panel is used on the Samsung Galaxy
S5 (klte).

Signed-off-by: Iskren Chernev <iskren.chernev@gmail.com>
---
Add a simple generated panel driver that supports on/off and the corresponding
binding documentation.

Changes in v3:
- fix dt_binding_check issue with missing include
- fix panel type (cmd) in kconfig description

Changes in v2:
- move bindings to separate file, add 2 regulators
- add standalone panel driver

v1: https://lkml.org/lkml/2020/12/30/293
v2: https://lkml.org/lkml/2021/2/1/313

 .../display/panel/samsung,s6e3fa2.yaml        | 64 +++++++++++++++++++
 1 file changed, 64 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/samsung,s6e3fa2.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/samsung,s6e3fa2.yaml b/Documentation/devicetree/bindings/display/panel/samsung,s6e3fa2.yaml
new file mode 100644
index 000000000000..c751ad589480
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/samsung,s6e3fa2.yaml
@@ -0,0 +1,64 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/samsung,s6e3fa2.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Samsung s6e3fa2 AMOLED CMD LCD panel
+
+maintainers:
+  - Iskren Chernev <iskren.chernev@gmail.com>
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    const: samsung,s6e3fa2
+
+  reg: true
+  reset-gpios: true
+  port: true
+
+  iovdd-supply:
+    description: IOVDD regulator
+
+  vddr-supply:
+    description: VDDR regulator
+
+required:
+  - compatible
+  - reset-gpios
+  - iovdd-supply
+  - vddr-supply
+  - port
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    /* from Samsung Galaxy S5 klte */
+    #include <dt-bindings/gpio/gpio.h>
+
+    dsi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        panel@0 {
+            compatible = "samsung,s6e3fa2";
+            reg = <0>;
+
+            reset-gpios = <&pma8084_gpios 17 GPIO_ACTIVE_LOW>;
+
+            iovdd-supply = <&pma8084_lvs4>;
+            vddr-supply = <&vreg_panel>;
+
+            port {
+                panel_in: endpoint {
+                    remote-endpoint = <&dsi0_out>;
+                };
+            };
+        };
+    };
+
+...

base-commit: fd821bf0ed9a7db09d2e007df697f4d9ecfda99a
--
2.30.0

