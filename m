Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 722343FE1C7
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 20:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346773AbhIASIi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 14:08:38 -0400
Received: from mail-4324.protonmail.ch ([185.70.43.24]:31395 "EHLO
        mail-4324.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346752AbhIASIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 14:08:36 -0400
Date:   Wed, 01 Sep 2021 18:07:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1630519656;
        bh=hpiMhb7xaOG5AAFkGBjxr0I36weG/Yx7rV+awK0m7/Y=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=hknCXgjmK2oau81RE8Rr2N5Tq9ls7bQi8KUOFK733CyX/8jF2dehPtMq1Yp7WM+Wb
         ge4Wewyu4PCdF73vIltxlkSw2K3XFXSLIxmiEAPqWcl7ChbXf7NIkt2LhNMDdgYP9K
         dBeYNZDCuiJkxtA/+PPqeAXiash3wNlxQqJ7TzdA=
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>
From:   Yassine Oudjana <y.oudjana@protonmail.com>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        linux-kernel@vger.kernel.org
Reply-To: Yassine Oudjana <y.oudjana@protonmail.com>
Subject: [PATCH 2/2] dt-bindings: display: Add binding for LG.Philips SW43101
Message-ID: <20210901180644.248177-3-y.oudjana@protonmail.com>
In-Reply-To: <20210901180644.248177-1-y.oudjana@protonmail.com>
References: <20210901180644.248177-1-y.oudjana@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a device tree binding for LG.Philips SW43101.

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
---
 .../display/panel/lgphilips,sw43101.yaml      | 52 +++++++++++++++++++
 1 file changed, 52 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/lgphili=
ps,sw43101.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/lgphilips,sw43=
101.yaml b/Documentation/devicetree/bindings/display/panel/lgphilips,sw4310=
1.yaml
new file mode 100644
index 000000000000..da049e9f244e
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/lgphilips,sw43101.yam=
l
@@ -0,0 +1,52 @@
+# SPDX-License-Identifier: BSD-3-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/lgphilips,sw43101.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: LG.Philips SW43101 1080x1920 OLED panel
+
+maintainers:
+  - Yassine Oudjana <y.oudjana@protonmail.com>
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    const: lgphilips,sw43101
+
+  port: true
+  reg: true
+  reset-gpios: true
+
+required:
+  - compatible
+  - reg
+  - reset-gpios
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    dsi {
+        #address-cells =3D <1>;
+        #size-cells =3D <0>;
+
+        panel@0 {
+            compatible =3D "lgphilips,sw43101";
+            reg =3D <0>;
+
+            reset-gpios =3D <&msmgpio 8 GPIO_ACTIVE_LOW>;
+
+            port {
+                panel_in: endpoint {
+                    remote-endpoint =3D <&dsi_out>;
+                };
+            };
+        };
+    };
+
+...
--=20
2.33.0


