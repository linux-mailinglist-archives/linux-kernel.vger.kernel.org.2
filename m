Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D43D340DE98
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 17:50:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240244AbhIPPvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 11:51:13 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:59435 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239976AbhIPPuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 11:50:55 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailnew.nyi.internal (Postfix) with ESMTP id 77AF5580E7D;
        Thu, 16 Sep 2021 11:49:34 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 16 Sep 2021 11:49:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=BNA7XueGS4Ecj
        Jpb+FohU751G4Q7+7zTT639WGDJM7g=; b=WLnhqLOXsryMiXOAprTv33BBt27e2
        GM684KPYillnTvvMgWZB5QdXqboVi4k4ZdX4Ky8plYHdh2IqxUZ1d8cOWhxHOS4U
        oov0BhPhiD2AH1AgxU4BlSi3jpmxmgppX8sQX+mA6QOOSexBSgPL66aSz0kF7SWl
        Z0wgLt1bZbT/PKV2kVLEPQ6/ux6/spSUw8LNAQDQj3PgeMd6EeKDyofyDxoSO7fi
        mVuKt/ZO1SXj7xN221Q/uoZZG96t3yzGJb0DSdGleSmTEBBcqeeNojcEJtc5Eu1V
        vUt4CMWfOX/b3M+tHietSfTcKHta1guZxRiskKjsCDRrKEB7zCPmNu0NQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=BNA7XueGS4EcjJpb+FohU751G4Q7+7zTT639WGDJM7g=; b=JDCTqI4F
        d66G9QzRTzEum0XYlmwkgbJW23OTEnFk56mpJhEdir67JdixorUijkbixJXa5cU8
        e/YFHScsA+1JFcNridJGnXl/TVFMNoKKGRScvMY/SnjQ67JpHhoqMy7qs05cdpOb
        sq+/Oy/A4xrnImnokdE0cOlBoDp3kCPGFJGo8g6CF1kQEpSrjPl0Kwc6AI12YSOJ
        PHcwIuR/2YyMYDH2oZoGiIH1n5NfRbkD9XkHwNNHToYQORcvAqQ4OR1G2m3lqM9m
        b0hT2Ovc0STY3nMv2ZUQevtgvFQIuXuKxHvDFVtAPhwrOrw3GvYiolNn7k6dVEsI
        P1uV0Rr6NZmTvQ==
X-ME-Sender: <xms:jWdDYaU1gC0QhJ6qlTe2hCIuubbq9dRZ5JopxwDf62lpydWUwl8Q-A>
    <xme:jWdDYWkx22FyF3F3RjTwDkMawMrbE1VsEoDXZloRaXNA_nAVYR6or0Eq1-Gh-PFU9
    DmjyPTGQvPE2r239Ew>
X-ME-Received: <xmr:jWdDYea35CpTFrHC6x96nCzVk5YEiVun7aLyg5qJOUw2rTioMQqS427EW9QYHQUBkWVvHPm-2cAIGFLQJUhQgbTGtjFNR4Y7BfZrSYs7B5ZwkGqqlHrEfkwjskxRCQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudehgedgkeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefuvhgvnhcu
    rfgvthgvrhcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrfgrthhtvg
    hrnheptefgjedtjeejffelleejleehtdetvedujeelhffgieehgeduueehhfegueeuhfdv
    necuffhomhgrihhnpeguvghvihgtvghtrhgvvgdrohhrghdpohhfthgtrdhnvghtpdhgih
    hthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpehsvhgvnhesshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:jWdDYRVdhgG-YGmEGVPeoY10-NN17kFgPS9gYVhh4765Kur9gNy_qw>
    <xmx:jWdDYUlEdp-T2crhmV3yQFTojAigiri7ST1uSTBP0YfWukZm3WOV0g>
    <xmx:jWdDYWdF5-hEWPFBRONgduAqbhgDpKSrN4cV3GJzHEiBEoA4NYPeog>
    <xmx:jmdDYdd6CkvFGt5w0n2RqmFCH0dxhHhzO53A_b5XxvwfKAtjqQJ9dg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Sep 2021 11:49:31 -0400 (EDT)
From:   Sven Peter <sven@svenpeter.dev>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     Sven Peter <sven@svenpeter.dev>, Rob Herring <robh+dt@kernel.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Hector Martin <marcan@marcan.st>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Stan Skowronek <stan@corellium.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Mark Kettenis <kettenis@openbsd.org>
Subject: [PATCH v2 1/2] dt-bindings: mailbox: Add Apple mailbox bindings
Date:   Thu, 16 Sep 2021 17:49:10 +0200
Message-Id: <20210916154911.3168-2-sven@svenpeter.dev>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20210916154911.3168-1-sven@svenpeter.dev>
References: <20210916154911.3168-1-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Apple mailbox controller are found on the M1 and are used for
communication with various co-processors.

Reviewed-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
Reviewed-by: Mark Kettenis <kettenis@openbsd.org>
Signed-off-by: Sven Peter <sven@svenpeter.dev>
---
 .../bindings/mailbox/apple,mailbox.yaml       | 84 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 85 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml

diff --git a/Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml b/Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml
new file mode 100644
index 000000000000..79b0cef08232
--- /dev/null
+++ b/Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml
@@ -0,0 +1,84 @@
+# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mailbox/apple,mailbox.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Apple Mailbox Controller
+
+maintainers:
+  - Hector Martin <marcan@marcan.st>
+  - Sven Peter <sven@svenpeter.dev>
+
+description:
+  The Apple mailbox consists of two FIFOs used to exchange 64+32 bit
+  messages between the main CPU and a co-processor. Multiple instances
+  of this mailbox can be found on Apple SoCs.
+  One of the two FIFOs is used to send data to a co-processor while the other
+  FIFO is used for the other direction.
+  Various clients implement different IPC protocols based on these simple
+  messages and shared memory buffers.
+
+properties:
+  compatible:
+    oneOf:
+      - description:
+          ASC mailboxes are the most common variant found on the M1 used
+          for example for the display controller, the system management
+          controller and the NVMe coprocessor.
+        items:
+          - const: apple,t8103-asc-mailbox
+
+      - description:
+          M3 mailboxes are an older variant with a slightly different MMIO
+          interface still found on the M1. It is used for the Thunderbolt
+          co-processors.
+        items:
+          - const: apple,t8103-m3-mailbox
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    minItems: 4
+    items:
+      - description: send fifo is empty interrupt
+      - description: send fifo is not empty interrupt
+      - description: receive fifo is empty interrupt
+      - description: receive fifo is not empty interrupt
+
+  interrupt-names:
+    minItems: 4
+    items:
+      - const: send-empty
+      - const: send-not-empty
+      - const: recv-empty
+      - const: recv-not-empty
+
+  clocks:
+    description:
+      Reference to the clock gate phandle(s) if required for this mailbox.
+      Optional since not all mailboxes are attached to a clock gate.
+
+  "#mbox-cells":
+    const: 0
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - interrupt-names
+  - "#mbox-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+        mailbox@77408000 {
+                compatible = "apple,t8103-asc-mailbox";
+                reg = <0x77408000 0x4000>;
+                interrupts = <1 583 4>, <1 584 4>, <1 585 4>, <1 586 4>;
+                interrupt-names = "send-empty", "send-not-empty",
+                 "recv-empty", "recv-not-empty";
+                #mbox-cells = <0>;
+        };
diff --git a/MAINTAINERS b/MAINTAINERS
index cad1289793db..47de27282c98 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1720,6 +1720,7 @@ C:	irc://irc.oftc.net/asahi-dev
 T:	git https://github.com/AsahiLinux/linux.git
 F:	Documentation/devicetree/bindings/arm/apple.yaml
 F:	Documentation/devicetree/bindings/interrupt-controller/apple,aic.yaml
+F:	Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml
 F:	Documentation/devicetree/bindings/pinctrl/apple,pinctrl.yaml
 F:	arch/arm64/boot/dts/apple/
 F:	drivers/irqchip/irq-apple-aic.c
-- 
2.25.1

