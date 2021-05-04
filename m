Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D414F3730B1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 21:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232541AbhEDTV7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 15:21:59 -0400
Received: from mail-0301.mail-europe.com ([188.165.51.139]:59452 "EHLO
        mail-03.mail-europe.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S232504AbhEDTV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 15:21:58 -0400
X-Greylist: delayed 37951 seconds by postgrey-1.27 at vger.kernel.org; Tue, 04 May 2021 15:21:57 EDT
Date:   Tue, 04 May 2021 19:20:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1620156059;
        bh=hPN9j0nF1AQgM6cAsZDixp19IElNYSJ0wg7fViCdyB0=;
        h=Date:To:From:Cc:Reply-To:Subject:From;
        b=A9qhvxX2TE6AkNYqZY73Rg0aM45HJH6nqpWLhbwtPjN3zEmA+EQDKQiZNOKhY6rh2
         MaEvSH3naAkrtk8sgTaD4WnauKugRPywXxjfQR/zGShdgp7G4FFv8GJYYcZTdw/JK2
         OiFZuz3QuJjR7H8c4D1t1jJZvPMAgu1b9aBAwu6A=
To:     "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
From:   Yassine Oudjana <y.oudjana@protonmail.com>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "phone-devel@vger.kernel.org" <phone-devel@vger.kernel.org>,
        "~postmarketos/upstreaming@lists.sr.ht" 
        <~postmarketos/upstreaming@lists.sr.ht>
Reply-To: Yassine Oudjana <y.oudjana@protonmail.com>
Subject: [PATCH v2 2/2] dt-bindings: input: Add binding for cypress-sf
Message-ID: <BmgtYLgM0FI0tmBcQQLEPss7D2v0jW1Ci8LWeLLd3g@cp3-web-020.plabs.ch>
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

Add a device tree binding for Cypress StreetFighter.

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
---
 .../devicetree/bindings/input/cypress-sf.yaml | 61 +++++++++++++++++++
 1 file changed, 61 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/cypress-sf.yaml

diff --git a/Documentation/devicetree/bindings/input/cypress-sf.yaml b/Docu=
mentation/devicetree/bindings/input/cypress-sf.yaml
new file mode 100644
index 000000000000..14689daf6567
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/cypress-sf.yaml
@@ -0,0 +1,61 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/cypress-sf.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Cypress StreetFighter touchkey controller
+
+maintainers:
+  - Yassine Oudjana <y.oudjana@protonmail.com>
+
+allOf:
+  - $ref: input.yaml#
+
+properties:
+  compatible:
+    const: cypress,sf3155
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  avdd-supply:
+    description: Regulator for AVDD analog voltage
+
+  vdd-supply:
+    description: Regulator for VDD digital voltage
+
+  linux,keycodes:
+    minItems: 1
+    maxItems: 8
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - avdd-supply
+  - vdd-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/input/input.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+        #address-cells =3D <1>;
+        #size-cells =3D <0>;
+
+        touchkey@28 {
+                compatible =3D "cypress,sf3155";
+                reg =3D <0x28>;
+                interrupt-parent =3D <&msmgpio>;
+                interrupts =3D <77 IRQ_TYPE_EDGE_FALLING>;
+                avdd-supply =3D <&vreg_l6a_1p8>;
+                vdd-supply =3D <&vdd_3v2_tp>;
+                linux,keycodes =3D <KEY_BACK KEY_MENU>;
+        };
+    };
--=20
2.31.1


