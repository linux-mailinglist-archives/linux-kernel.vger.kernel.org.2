Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BABAA402B2E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 16:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344862AbhIGO4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 10:56:38 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:57005 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344375AbhIGO4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 10:56:31 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 2994C580E94;
        Tue,  7 Sep 2021 10:55:25 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 07 Sep 2021 10:55:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=s5RoFGayuv7lj
        w9jyx+KFmGAlL1NLShQA4u/5VnW4IM=; b=kE1ijEYL4y7xBtiN7VabPEDRRxXmw
        OhkxadPT/wfGFmzhocdnJX4uMcyohN6Hhh1RlmelUdJErjqilkiGGIhYh57wOq4t
        Nh5FNgBFCEXbqoLywb2ME8Y+64K4RDKCDIl0ilSVfn0KdZQdFxwKN68flWemaZGF
        hhrDDzbwllD2Jnk9CjtaswMv/ZwYn5zjPrH5NIn2j0jBNSTI+2qTkNDgeI7QjRp2
        ouAXl/deOVHYyMqqm7vBGlQw20GqFx385MztVo7lRZZKqUlBWx3yYDHRHcVcaahH
        IR4FRyPIIUaos8Rt4BAJeOKDPMHMmXhVrm2dUCrqcDfxg6DrKqG60PW4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=s5RoFGayuv7ljw9jyx+KFmGAlL1NLShQA4u/5VnW4IM=; b=XTCRXoqm
        BmEqIsYnZSvdt2NNR3+DQzWmU7IS7lOjgwkVlWPw+OwqMpeuc8HGrYMvuLPwsJJM
        ijYSHmKQKj5x6Cbz2WQHz2Z573pVqDyZruTU5p4GEw9JxDRgohevmPlvib1GcNby
        SDgERi3R4AidJ/kIt1f2HaX4ahxz3mAlVg51CPsrfN/veQR1OpjC+MmyjEKQirpq
        3GHZzhkJZ4JV/1A7diABbSFtz1NQaR8tVcgZS79tAftZIJkSGwy+epr+q6yLEc3U
        5ydzGalodAK+MKHZ6x5OGy/Z2ciZdpz+w28Vz4m7BQdhSZo52jWHapGOMvSMcBdv
        av8vxUvNOw7nRw==
X-ME-Sender: <xms:XH03YddFszWle64B1CuW65h4aPW3aqx59qy_rSBq92nPj8lYwejtKg>
    <xme:XH03YbMCPgpmILtQouf1qBAT801w_2VU2Edi3VF_R8UOkzbT1OQhM2SEiGtx3jYxs
    Ul02s_p_KJZhrAVxhA>
X-ME-Received: <xmr:XH03YWhQOMFmUcKaqAd8ERaQkd5usn2Zw1e3QW5d2PVT6dolcHOY3Mk65tkuuKK3yAuc3u-JCBb6OnH_Z4U6uZasN2b7fqtOYIXO5jKEH62bVKzoMSC5u2hZ9XMeCw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudefhedgkeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefuvhgvnhcu
    rfgvthgvrhcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrfgrthhtvg
    hrnheptefgjedtjeejffelleejleehtdetvedujeelhffgieehgeduueehhfegueeuhfdv
    necuffhomhgrihhnpeguvghvihgtvghtrhgvvgdrohhrghdpohhfthgtrdhnvghtpdhgih
    hthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpehsvhgvnhesshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:XH03YW8Y-3E6l4bKgdr5WxlCrqEtH1m2HyxYZ3FQYDjjAzNrY3oV7g>
    <xmx:XH03YZvldCQ2MonkD_SPL1XYyt9GLYJwyu6GxGY6r3Ui9sf9iAc-tw>
    <xmx:XH03YVGh2SEmEq8-K_CLXOBahdu8Opjlm9fEbF4MHrpO1AKvp4GhjA>
    <xmx:XX03YfIyU7ZHWL5L__OSBYfdEsr1ulzyYp9sfBRPxtSa4k1Ao5vemA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Sep 2021 10:55:23 -0400 (EDT)
From:   Sven Peter <sven@svenpeter.dev>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     Sven Peter <sven@svenpeter.dev>, Rob Herring <robh+dt@kernel.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Hector Martin <marcan@marcan.st>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Stan Skowronek <stan@corellium.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] dt-bindings: mailbox: Add Apple mailbox bindings
Date:   Tue,  7 Sep 2021 16:55:00 +0200
Message-Id: <20210907145501.69161-3-sven@svenpeter.dev>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20210907145501.69161-1-sven@svenpeter.dev>
References: <20210907145501.69161-1-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Apple mailbox controller are found on the M1 and are used for
communication with various co-processors.

Signed-off-by: Sven Peter <sven@svenpeter.dev>
---
 .../bindings/mailbox/apple,mailbox.yaml       | 81 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 82 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml

diff --git a/Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml b/Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml
new file mode 100644
index 000000000000..360d8a162cc5
--- /dev/null
+++ b/Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml
@@ -0,0 +1,81 @@
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
+          ASC mailboxes are the most common variant found on the M1.
+        items:
+          - const: apple,t8103-asc-mailbox
+
+      - description:
+          M3 mailboxes are an older variant with a slightly different MMIO
+          interface still found on the M1.
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

