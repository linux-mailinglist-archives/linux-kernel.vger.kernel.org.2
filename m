Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B48FB342D9E
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 16:22:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbhCTPUq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Mar 2021 11:20:46 -0400
Received: from mail-40134.protonmail.ch ([185.70.40.134]:25322 "EHLO
        mail-40134.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbhCTPUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Mar 2021 11:20:18 -0400
Date:   Sat, 20 Mar 2021 15:20:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
        s=protonmail3; t=1616253616;
        bh=GOagsrEw4SsLChHE8bqUY6XXHswLBJsU8M1xRpDR/Ds=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=KeSAi5xxj8JV35umMvuVdhLCnkXdNmc1FJg13DceRY9y+ke3LFGuKi940tD9QfctT
         9cz7qsJouqCq2S7gqnwS2yysEs145gQe7Visufh2rB5j1KEpKoJxuY9dE5cxXueRGZ
         mwE95gf7pZaGSAeRxFX8dF4/O76TDSxwm/US4tOevxHYeZwjJpGXIZNQCTMI1I5dW+
         Y6lUFwnyUnE5HzboyzKtYBXz+2V4UPOHmT4OnpMfANF5FosIDgQf2yshTj32Q0Wuoo
         93iccrC3DxKRvbNZQkhPX0MIplCxahVX/bvRusvQjYuaaheeQVZWtcb6lzTIOD5tER
         xovotgbJ8Bb3A==
To:     iommu@lists.linux-foundation.org
From:   Sven Peter <sven@svenpeter.dev>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Hector Martin <marcan@marcan.st>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Marc Zyngier <maz@kernel.org>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Stan Skowronek <stan@corellium.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Sven Peter <sven@svenpeter.dev>
Reply-To: Sven Peter <sven@svenpeter.dev>
Subject: [PATCH 2/3] dt-bindings: iommu: add DART iommu bindings
Message-ID: <20210320151903.60759-3-sven@svenpeter.dev>
In-Reply-To: <20210320151903.60759-1-sven@svenpeter.dev>
References: <20210320151903.60759-1-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DART (Device Address Resolution Table) is the iommu found on Apple
ARM SoCs such as the M1.

Signed-off-by: Sven Peter <sven@svenpeter.dev>
---
 .../bindings/iommu/apple,t8103-dart.yaml      | 82 +++++++++++++++++++
 MAINTAINERS                                   |  6 ++
 2 files changed, 88 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iommu/apple,t8103-dar=
t.yaml

diff --git a/Documentation/devicetree/bindings/iommu/apple,t8103-dart.yaml =
b/Documentation/devicetree/bindings/iommu/apple,t8103-dart.yaml
new file mode 100644
index 000000000000..2ec2d905a2ea
--- /dev/null
+++ b/Documentation/devicetree/bindings/iommu/apple,t8103-dart.yaml
@@ -0,0 +1,82 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iommu/apple,t8103-dart.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Apple DART IOMMU Implementation
+
+maintainers:
+  - Sven Peter <sven@svenpeter.dev>
+
+description: |+
+  Apple SoCs may contain an implementation of their Device Address
+  Resolution Table which provides a mandatory layer of address
+  translations for various masters external to the CPU.
+
+  Each DART instance is capable of handling up to 16 masters
+  mapped to up tp 16 different virtual address spaces with
+  page-level read/write access control flags.
+
+  This DART IOMMU also raises interrupts in response to various
+  fault conditions.
+
+properties:
+  compatible:
+    const: apple,t8103-dart
+
+  reg:
+    const: 1
+
+  interrupts:
+    const: 1
+
+  clocks:
+    maxItems: 1
+
+  '#iommu-cells':
+    const: 1
+    description:
+      The number of the master connected to this DART.
+
+required:
+  - compatible
+  - reg
+  - '#iommu-cells'
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |+
+    dart1: dart1@382f80000 {
+      compatible =3D "apple,t8103-dart";
+      reg =3D <0x3 0x82f80000 0x0 0x4000>;
+      interrupt-parent =3D <&aic>;
+      interrupts =3D <AIC_IRQ 781 IRQ_TYPE_LEVEL_HIGH>;
+      #iommu-cells =3D <1>;
+    };
+
+    master1 {
+      iommus =3D <&dart1 0>;
+    };
+
+  - |+
+    usb_dart0: usb_dart0@382f80000 {
+      compatible =3D "apple,t8103-dart";
+      reg =3D <0x3 0x82f80000 0x0 0x4000>;
+      interrupt-parent =3D <&aic>;
+      interrupts =3D <AIC_IRQ 781 IRQ_TYPE_LEVEL_HIGH>;
+      #iommu-cells =3D <1>;
+    };
+
+    usbdrd_dwc3_0: dwc3@382280000 {
+      compatible =3D "snps,dwc3";
+      reg =3D <0x3 0x82280000 0x0 0x100000>;
+      interrupt-parent =3D <&aic>;
+      interrupts =3D <AIC_IRQ 777 IRQ_TYPE_LEVEL_HIGH>;
+      iommus =3D <&usb_dart0 1>;
+      #address-cells =3D <1>;
+      #size-cells =3D <0>;
+      dr_mode =3D "peripheral";
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index d5e4d93a536a..1f9a4f2de88b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1236,6 +1236,12 @@ L:=09linux-input@vger.kernel.org
 S:=09Odd fixes
 F:=09drivers/input/mouse/bcm5974.c

+APPLE DART IOMMU DRIVER
+M:=09Sven Peter <sven@svenpeter.dev>
+L:=09iommu@lists.linux-foundation.org
+S:=09Maintained
+F:=09Documentation/devicetree/bindings/iommu/apple,t8103-dart.yaml
+
 APPLE SMC DRIVER
 M:=09Henrik Rydberg <rydberg@bitmath.org>
 L:=09linux-hwmon@vger.kernel.org
--
2.25.1


