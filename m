Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 890C0399D19
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 10:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbhFCIwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 04:52:19 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:51425 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229814AbhFCIwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 04:52:16 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 1700A580F08;
        Thu,  3 Jun 2021 04:50:32 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 03 Jun 2021 04:50:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=gGQl9SRxrhirr
        YTrU4b/HJo5lcf3YI1dsRlqz4epgR8=; b=GQyTi/dHgPLwCAtvecYogDZ3jMN+u
        3P5m5hN5SMDYk76wbSeqZfdCwWX+aSKWc/aiaq1sT6ad0Y9ueNznZl8UAhtEfzJF
        1K09MoJsF+ByCTav2nVB40yaoW1siaGgl081YcColXrZzwW3LY/YUDpN1PZfFVFp
        ke/ky84YeiL3guBP5m4kcLCSw+FCyZx1DkhoqUPTmCHcVSBAaE2U5J9yDgWhE9ek
        Ig4gJHRNjyarwZjTFmDI1Eymdqc1oWPWVHYzUdJV0tA77RC3w+b3jMC+7Nkn5F4C
        lCxTHVTlZJUj7qiGpMwWJlf4EW+LSX2Px53jwOQpBp4WU+LIlZYQAALDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=gGQl9SRxrhirrYTrU4b/HJo5lcf3YI1dsRlqz4epgR8=; b=qpHKcacl
        OC+UXWdxt2zLAB+FZjA60l5fIOqL7BpEqnVSdeUWTvIGkz+jz9yS97w6JEaJgTCO
        hrPffxQSIRafemdLJUuVauhqXws1NqbU00le9or//JLXo2aPNhdsRSftRY7mjpom
        Hd1aTqsEyIE6JBHMh2T4P1Xgyrwg1QowVi0fzdMNLfBVCe3+BAz85EzNXlYZbGnq
        LRjBCbuPqPW3s2hjQ5XPpNZNhadDe/Qt5pG/7w8U8ODmCNp+t06D4hW8EI5CdiqD
        Z4cYMdpnNTRE+1nr/EmaUdaDDXYWyFfk0iKn9HpWwD1IMdThQGVe0ADKg30HWbZS
        /HTXhXN0OyUHxQ==
X-ME-Sender: <xms:15e4YJpnwlWI4OmQGbvaUdGcEl4H14K5NwCURwitNCa0pSUHyX_kZg>
    <xme:15e4YLqUyIK3jtJDwOuOJiHpkaVvXHzn6AE41VUM-w2o_BZ6hFFh2oA41jjy3HcrH
    G6ZwX3vOasJOFqfnBg>
X-ME-Received: <xmr:15e4YGPH3kNqD54i5KxTMpH2b5JejcmEBVYeWf6bmMb5jukcM9VMJTOAZVMUPTI_IQqm_9W2Yn5rU7W8qZbrqPl4WUdGUVzGj2AGya_m6Ar2SX5y5JGr6wHIX8TLcA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdelledgtdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefuvhgvnhcu
    rfgvthgvrhcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrfgrthhtvg
    hrnhephfefffejvdekleeitdffiefhhfffveffieejteefhedutdfgffeftdejhedtteeh
    necuffhomhgrihhnpeguvghvihgtvghtrhgvvgdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsvhgvnhesshhvvghnphgvthgvrhdr
    uggvvh
X-ME-Proxy: <xmx:15e4YE5DJfuI36o2bYlbfNI2ouCnFRsLkegV7-tGdmJgC5fYxHu5Bg>
    <xmx:15e4YI6AgVW8YeGRbInecRk27BPe7vNYoLoXQF5_8n7k81kEv_PqFw>
    <xmx:15e4YMjscenrqRb2mFG2vQ7KOzr7lr4fJ9OPGABzI2KaXzb0uTjxGQ>
    <xmx:2Je4YHQ_SQdIpGZ3fO71-TvGndwZCtZMjBofZDa39khkcDO7jyP7UQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Jun 2021 04:50:29 -0400 (EDT)
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
        iommu@lists.linux-foundation.org, Alexander Graf <graf@amazon.com>
Subject: [PATCH v3 2/3] dt-bindings: iommu: add DART iommu bindings
Date:   Thu,  3 Jun 2021 10:50:02 +0200
Message-Id: <20210603085003.50465-3-sven@svenpeter.dev>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20210603085003.50465-1-sven@svenpeter.dev>
References: <20210603085003.50465-1-sven@svenpeter.dev>
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
index 000000000000..db21ca07d121
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
+      iommus = <&{/dart1} 0>;
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
+      iommus = <&{/dart2a} 0>, <&{/dart2b} 1>;
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 673cadd5107a..4373d63f9ccf 100644
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

