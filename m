Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D10134BB97
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Mar 2021 09:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbhC1HlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Mar 2021 03:41:15 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:44457 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229560AbhC1Hkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Mar 2021 03:40:42 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 73EFF580836;
        Sun, 28 Mar 2021 03:40:42 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Sun, 28 Mar 2021 03:40:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=j4WtA/c99G3MW
        B2xtKbwx07LS76G+wGQ7cjL4klOJIc=; b=xrYi3SfvW8aBnh9hh/PojnH7f5ET7
        PYua1UQ5hZUr/xP6I2ntLUHRvGl2BD6d3KBYId4Mj8QBcJJDyrOc6CeSVvRAO6Zh
        34e+oyHSg40Br8u17I/qlohjprXZ9UZG7sZNmbhj3ltVqd1Ks1+LvJCiMDfuuJdQ
        7Y5iO8fJPzLk3X6FnQTiBUxnZ1p80xrUbynmMoBe9OCPYwK9MMyrsE94rb6a+dTj
        6wIXZtIcdak2e+TyMat7JFrL/87pwjVZuqfxfKm6B6m8Rjk3KMcowu0KWBdGGVSz
        /y+IK6G8HTfvan0gtYRHcqzxqzoxnHtjDJbDsEuYhuMooF2BwP7SmuHSw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=j4WtA/c99G3MWB2xtKbwx07LS76G+wGQ7cjL4klOJIc=; b=OMYAYvBr
        oUItYXlkSL4/itO01lmVEhWwQ+Rr80AAkqwRR3GnVwHamShAf5sRwJszig+SvRP+
        ZoUpMrJrmjuA036Dd4H/xZ0uXz2JfE+lgahkTHdz7qLEg0TRcLrWrNX4iUeyOvSl
        0AcA4mWkX2UOostSZ7VILS0Ft0N4a54kn7FEOe/gEY1bMOvTzWNI0L/FyD/DJVhl
        bossRSoou8s6vlGVcazMXfc2o/F+K0ZxcnTxRcbHRscuSYDeGBlrEhPck2V4dD0k
        29Sfx3r2muEl/MA6oI6YS7HtcAhU/d10Dy2kIR3yench0viSBg+qtqX7lwhxrTh/
        YJn1tssWpy+qxg==
X-ME-Sender: <xms:-TJgYKxIK7g7wbpEJa-mSzR3QkhboDVaPyGmE50FXVo9W6Bu6S5EnA>
    <xme:-TJgYGSVPrxro6tUItWfHm6uyUXMeQW6657seAlIq7hKtztES4oOSsDnhsJmJZxqk
    b9qaCmD0KYK1B4VWh8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudehhedguddutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufhvvghn
    ucfrvghtvghruceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrghtth
    gvrhhnpefhfeffjedvkeeliedtffeihffhffevffeijeetfeehuddtgffffedtjeehtdet
    heenucffohhmrghinhepuggvvhhitggvthhrvggvrdhorhhgnecukfhppedujeeirddule
    elrddvuddtrdduheeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepshhvvghnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:-TJgYMXLbcj4F4qFnoaqGj0F0W9Iqtj9W0wiHy2TOiduKaE6Z9a_-Q>
    <xmx:-TJgYAgtUvDSg8kUE2HJzhDKB0-FoL1FQlVmcA2aS0x2LENqoAAQWA>
    <xmx:-TJgYMAgFtfEkP6ABZo2n3dTgvGEh05QSVHGEDP_Eb5dAR2jpizbfA>
    <xmx:-jJgYI7nw4TFF6bFOn3TaGro9SN0x7qFRVJgul62NtOYMrAgNR7uubZzopM>
Received: from localhost.localdomain (ip-176-199-210-156.hsi06.unitymediagroup.de [176.199.210.156])
        by mail.messagingengine.com (Postfix) with ESMTPA id 8E4E4240057;
        Sun, 28 Mar 2021 03:40:39 -0400 (EDT)
From:   Sven Peter <sven@svenpeter.dev>
To:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Sven Peter <sven@svenpeter.dev>, Arnd Bergmann <arnd@kernel.org>,
        devicetree@vger.kernel.org, Hector Martin <marcan@marcan.st>,
        linux-kernel@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Stan Skowronek <stan@corellium.com>,
        linux-arm-kernel@lists.infradead.org,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        iommu@lists.linux-foundation.org
Subject: [PATCH v2 2/3] dt-bindings: iommu: add DART iommu bindings
Date:   Sun, 28 Mar 2021 09:40:08 +0200
Message-Id: <20210328074009.95932-3-sven@svenpeter.dev>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20210328074009.95932-1-sven@svenpeter.dev>
References: <20210328074009.95932-1-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DART (Device Address Resolution Table) is the iommu found on Apple
ARM SoCs such as the M1.

Signed-off-by: Sven Peter <sven@svenpeter.dev>
---
 .../devicetree/bindings/iommu/apple,dart.yaml | 81 +++++++++++++++++++
 MAINTAINERS                                   |  6 ++
 2 files changed, 87 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iommu/apple,dart.yaml

diff --git a/Documentation/devicetree/bindings/iommu/apple,dart.yaml b/Documentation/devicetree/bindings/iommu/apple,dart.yaml
new file mode 100644
index 000000000000..c0b43d90c157
--- /dev/null
+++ b/Documentation/devicetree/bindings/iommu/apple,dart.yaml
@@ -0,0 +1,81 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iommu/apple,dart.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Apple DART IOMMU
+
+maintainers:
+  - Sven Peter <sven@svenpeter.dev>
+
+description: |+
+  Apple SoCs may contain an implementation of their Device Address
+  Resolution Table which provides a mandatory layer of address
+  translations for various masters.
+
+  Each DART instance is capable of handling up to 16 different streams
+  with individual pagetables and page-level read/write protection flags.
+
+  This DART IOMMU also raises interrupts in response to various
+  fault conditions.
+
+properties:
+  compatible:
+    const: apple,t8103-dart
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    description:
+      Reference to the gate clock phandle if required for this IOMMU.
+      Optional since not all IOMMUs are attached to a clock gate.
+
+  '#iommu-cells':
+    const: 1
+    description:
+      Has to be one. The single cell describes the stream id emitted by
+      a master to the IOMMU.
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
+    dart1: dart1@82f80000 {
+      compatible = "apple,t8103-dart";
+      reg = <0x82f80000 0x4000>;
+      interrupts = <1 781 4>;
+      #iommu-cells = <1>;
+    };
+
+    master1 {
+      iommus = <&{/dart1} 0>;
+    };
+
+  - |+
+    dart2a: dart2a@82f00000 {
+      compatible = "apple,t8103-dart";
+      reg = <0x82f00000 0x4000>;
+      interrupts = <1 781 4>;
+      #iommu-cells = <1>;
+    };
+    dart2b: dart2@82f80000 {
+      compatible = "apple,t8103-dart";
+      reg = <0x82f80000 0x4000>;
+      interrupts = <1 781 4>;
+      #iommu-cells = <1>;
+    };
+
+    master2 {
+      iommus = <&{/dart2a} 0>, <&{/dart2b} 1>;
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 9ac46317840b..f5397328fa1f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1236,6 +1236,12 @@ L:	linux-input@vger.kernel.org
 S:	Odd fixes
 F:	drivers/input/mouse/bcm5974.c
 
+APPLE DART IOMMU DRIVER
+M:	Sven Peter <sven@svenpeter.dev>
+L:	iommu@lists.linux-foundation.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/iommu/apple,t8103-dart.yaml
+
 APPLE SMC DRIVER
 M:	Henrik Rydberg <rydberg@bitmath.org>
 L:	linux-hwmon@vger.kernel.org
-- 
2.25.1

