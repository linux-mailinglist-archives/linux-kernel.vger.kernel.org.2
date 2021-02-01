Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3030E30A597
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 11:41:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233326AbhBAKk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 05:40:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233281AbhBAKjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 05:39:05 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A36F9C0617A7;
        Mon,  1 Feb 2021 02:37:49 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id f16so12169817wmq.5;
        Mon, 01 Feb 2021 02:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y4HDfAIXn4csaJdLWtNsEmq7IQCGJl8To6HPJWasocw=;
        b=KDyMx9ldojQIM8AwkDVYF8F1ETlxUKunw92WGM4JluCVPQT9YLW+qKb3DCCNyzOIEw
         NP4PtcLXRr3lHSJyC1yTWAfnHvtTD4Ap/wDHG6AdbHLck8aVffJXZlWGdeKoOq1aPjjm
         d5YIQa99intc7jlL6wVD4JMbtMmRYvYSl47idsrQEFyuIhjgewEewXTLXYIBcQVAkVI4
         0Nx0wYogCKbwJzV0llHwUADc9lRSDCmM0cDD4i3/1sQ5Y1KPaKmvzpC0/TDtwYzoip+M
         sXRexM2tIl1DLv3NpYQcfeQ/Q0R5RPGe51z6W+/6ThTyRf3Zxff+5AeviBAEyHHMO/K1
         QZlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y4HDfAIXn4csaJdLWtNsEmq7IQCGJl8To6HPJWasocw=;
        b=RXcIsz/vxiJOOBNsXRDtVLMRAtrdeS4D06+OFCsVn8J0h2i/+zDUvY0jveYdEZ+6tA
         m0FRIjO9TEzIySzBSyIf7q5yH+Y40Eg7S/5+4FjUKWfTMjEAdTaVSB/pAJnWglQLG5OK
         ILiR7NSThfxhye/ZoMvcavPOEtGATt/WeTnExuex3oWxLgjfglm8EhrS9jFmBKXQ5+wg
         4v8mHPuUjiMQrgyM+qOieicRC905JtodcK/9klyDsM994LOtcRIzla6h3VavcNZw87IE
         8pMDNxJhujSs4X+gB6eiMjaVHM4W0EG6fmHkV/+QnJ/m1W7fqfB40DjWb0e8jJBRWjfR
         bBzQ==
X-Gm-Message-State: AOAM533xbFXyoECD6GIreUhvPHQPQTVgK5/Al6aBU6biPRH+/EC7WpFo
        JWMNkqT0Lztlw4DMFs1xcVL9j3KsHTg=
X-Google-Smtp-Source: ABdhPJwnmYdI8hHeNi9Yhcx2VLE+xn7/xCz3CN08L3cPwx5ZZ0HUnj7/Ym4SfDktzPrKQoBLNeqXzQ==
X-Received: by 2002:a7b:c76e:: with SMTP id x14mr1297910wmk.17.1612175868447;
        Mon, 01 Feb 2021 02:37:48 -0800 (PST)
Received: from localhost (178-169-161-196.razgrad.ddns.bulsat.com. [178.169.161.196])
        by smtp.gmail.com with ESMTPSA id m18sm2243760wmq.1.2021.02.01.02.37.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Feb 2021 02:37:47 -0800 (PST)
From:   Iskren Chernev <iskren.chernev@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Iskren Chernev <iskren.chernev@gmail.com>
Subject: [PATCH v2 1/2] dt-bindings: panel: Add Samsung S6E3FA2 panel
Date:   Mon,  1 Feb 2021 12:37:10 +0200
Message-Id: <20210201103712.1619585-1-iskren.chernev@gmail.com>
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
OK, miraculously the panel turns on and off now, so the simple-panel can
graduate into its own driver.

v1: https://lkml.org/lkml/2020/12/30/293

Changes in v2:
- move bindings to separate file, add 2 regulators
- add standalone panel driver

 .../display/panel/samsung,s6e3fa2.yaml        | 62 +++++++++++++++++++
 1 file changed, 62 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/samsung,s6e3fa2.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/samsung,s6e3fa2.yaml b/Documentation/devicetree/bindings/display/panel/samsung,s6e3fa2.yaml
new file mode 100644
index 000000000000..a759150bd539
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/samsung,s6e3fa2.yaml
@@ -0,0 +1,62 @@
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
+    dsi@fd922800 {
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

