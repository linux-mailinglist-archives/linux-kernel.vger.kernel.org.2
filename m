Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 301A53B53D4
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jun 2021 16:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231278AbhF0Oj7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Jun 2021 10:39:59 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:46313 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231189AbhF0Ojx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jun 2021 10:39:53 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailnew.nyi.internal (Postfix) with ESMTP id 76F8B580708;
        Sun, 27 Jun 2021 10:37:29 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Sun, 27 Jun 2021 10:37:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=zjKOSKJOLRXxE
        vp9vWIrYnPwlGb51esD71NNHk1QI88=; b=dG6VBXyBYtc/OpLWTLLnj2Qxw6lG6
        J8mO4ATEh+pwa+Q+F/rYZtX7OOtgd8hpZJ0U8IBo9GfVIvqW+1XFCCLDnRXXFVD8
        pvdEEZAk6SmBtVgbDjHsJcq/Gjb9PWjh2NFd74y5PtyAIpjZjE0iG+ogAEg7NMQC
        vtJR4KCkCNw1fIgYsAiVdz+odx/cy9j8okMbbl0r27LawSwVeAhvpeNK9wSkxjjV
        J1Mpos/iO2dIV/MR81LR6Xk1RKpx0HlxUf10H8dcBpMx0hfhtWFUkriF/d0P0qqt
        BQ07UThsk38ioDYhfxX9xQUYCk2QVLHa2zs1ZCiAKCINbU9JCFqxz9LMg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=zjKOSKJOLRXxEvp9vWIrYnPwlGb51esD71NNHk1QI88=; b=E/8SALpV
        Oe9O1AKtLIj8sU3pJMt0YukeRbOKat+h1gQtDBAd1UEVkxM5z3Es3XXfxeyL/YBf
        bsjUnPA7yRlk54AWPIEyWVBW0oiDEgauL/jpm3RnP4bzJPsApZ/NbOTp8kVM7O+x
        kKispA+EGBFZY27ZSZJ2XX0XcHOm2C/vxgbVBNi1TLWjmJoyaifoZklkOciok7A4
        DpeWkgUN8nTlEYHGYpuE9mVx1bD3uyN+3PuNTjThrlnPJKysZ8zhM1ZkecmhWzLE
        08h8Tlj/1omtbmDayTmEoDrpJet8RrjKrQXkbCWTMdwILsSYSvf2VqSKJnXvHPp/
        l75m4Cnjbh9+KQ==
X-ME-Sender: <xms:KY3YYDZXOA3OJm0quaaHOIa57d3XItWrhK_BfAZhQ2V4dA5mjs00_w>
    <xme:KY3YYCbCFcEexQTqyvGcvgJ7Zi7ddQmtmV1uoFvVZAbVK8dmRc8bgtvu62w7yBMgD
    0O1AYvlZy7FeKwBO60>
X-ME-Received: <xmr:KY3YYF8mGqlkrutkvJDwy2RFI2eEd_aw1bLHWZgTLBXsRROfXBPqmKelBwvlxDir25q5Xnfn24bBvMw3RsSX0jhcsJI35SalhoeWcl9HRYbwBPSlthdADd2gCUMkPw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfeehvddgjeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefuvhgvnhcu
    rfgvthgvrhcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrfgrthhtvg
    hrnhephfefffejvdekleeitdffiefhhfffveffieejteefhedutdfgffeftdejhedtteeh
    necuffhomhgrihhnpeguvghvihgtvghtrhgvvgdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsvhgvnhesshhvvghnphgvthgvrhdr
    uggvvh
X-ME-Proxy: <xmx:KY3YYJocE4XvNGPJNtFbBHzihplU6bPjaBxJUl-rAOn-5hT3BWrhBw>
    <xmx:KY3YYOpNEftgiz4HBW4Rj4PqZNAHIZ5N9mDNpLDwvzLHerJ5I9KFAw>
    <xmx:KY3YYPQE_bIvkb9kerEZzU7EJCeVN80-0DFJsW4sHe9MrfiJLviNVQ>
    <xmx:KY3YYB8yWeEdtlVny_97Lbo-qccA7vCVbX5vrkAr82e9P72b9ZsyZA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 27 Jun 2021 10:37:26 -0400 (EDT)
From:   Sven Peter <sven@svenpeter.dev>
To:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Sven Peter <sven@svenpeter.dev>, Arnd Bergmann <arnd@kernel.org>,
        devicetree@vger.kernel.org, Hector Martin <marcan@marcan.st>,
        linux-kernel@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Stan Skowronek <stan@corellium.com>,
        linux-arm-kernel@lists.infradead.org,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        iommu@lists.linux-foundation.org, Alexander Graf <graf@amazon.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Rob Herring <robh+dt@kernel.org>, r.czerwinski@pengutronix.de,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v4 2/3] dt-bindings: iommu: add DART iommu bindings
Date:   Sun, 27 Jun 2021 16:34:04 +0200
Message-Id: <20210627143405.77298-3-sven@svenpeter.dev>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20210627143405.77298-1-sven@svenpeter.dev>
References: <20210627143405.77298-1-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DART (Device Address Resolution Table) is the iommu found on Apple
ARM SoCs such as the M1.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Sven Peter <sven@svenpeter.dev>
---
 .../devicetree/bindings/iommu/apple,dart.yaml | 81 +++++++++++++++++++
 MAINTAINERS                                   |  6 ++
 2 files changed, 87 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iommu/apple,dart.yaml

diff --git a/Documentation/devicetree/bindings/iommu/apple,dart.yaml b/Documentation/devicetree/bindings/iommu/apple,dart.yaml
new file mode 100644
index 000000000000..94aa9e9afa59
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
+    dart1: iommu@82f80000 {
+      compatible = "apple,t8103-dart";
+      reg = <0x82f80000 0x4000>;
+      interrupts = <1 781 4>;
+      #iommu-cells = <1>;
+    };
+
+    master1 {
+      iommus = <&dart1 0>;
+    };
+
+  - |+
+    dart2a: iommu@82f00000 {
+      compatible = "apple,t8103-dart";
+      reg = <0x82f00000 0x4000>;
+      interrupts = <1 781 4>;
+      #iommu-cells = <1>;
+    };
+    dart2b: iommu@82f80000 {
+      compatible = "apple,t8103-dart";
+      reg = <0x82f80000 0x4000>;
+      interrupts = <1 781 4>;
+      #iommu-cells = <1>;
+    };
+
+    master2 {
+      iommus = <&dart2a 0>, <&dart2b 1>;
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 8c5ee008301a..29e5541c8f21 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1240,6 +1240,12 @@ L:	linux-input@vger.kernel.org
 S:	Odd fixes
 F:	drivers/input/mouse/bcm5974.c
 
+APPLE DART IOMMU DRIVER
+M:	Sven Peter <sven@svenpeter.dev>
+L:	iommu@lists.linux-foundation.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/iommu/apple,dart.yaml
+
 APPLE SMC DRIVER
 M:	Henrik Rydberg <rydberg@bitmath.org>
 L:	linux-hwmon@vger.kernel.org
-- 
2.25.1

