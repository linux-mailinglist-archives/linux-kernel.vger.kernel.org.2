Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AD5D430872
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Oct 2021 13:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245572AbhJQLng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Oct 2021 07:43:36 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:51533 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245558AbhJQLnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Oct 2021 07:43:15 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.nyi.internal (Postfix) with ESMTP id 25CDA5809FE;
        Sun, 17 Oct 2021 07:41:06 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Sun, 17 Oct 2021 07:41:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=z9rtM6rBfWq4o
        TkLpB2GBB5Bp0ue9u8/PQZ5AjQ4pqs=; b=gTWXGXTaLoYAopNgHvtnu59Tfp2X3
        tDFs1DHNDEmwHbMvMJUrrC39leGDhSKPTVuWkof6xYqkQVi+El1kmJv7xNW5P5cF
        fZNl7akfP+oV1rJY+CUxP5R8NV4jwTZ0oVPS0FzrPpOhCBPUSW794Fm6lmBo9ByO
        Xs/+Q2x13W+UQ/0QJqJzvpqDxx2+Mlgs7Q5pDZPDhV7TCb99RkpbQcXl5M/ffDWs
        0nI5Tw9W7UbokvBt9e/jobQNVrJaOhja7L70x+t1YqJ7yuzLVAVMiyI8psQmmCnA
        IksE4insZbORdfFIofJd6QZZvsJBVGD2JoVayfJOGU/1woean6SUTfITw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=z9rtM6rBfWq4oTkLpB2GBB5Bp0ue9u8/PQZ5AjQ4pqs=; b=nx/6UFzG
        fmr+mp+9HxjrZSPmO8C3CX+R/nso/4xV1qaSyNET3VLTqBB/D1PYZ9z1zAzpy2nx
        AjA5qjjEtCeW0w959Ns86LYn2U5kf7qHSjjzDUr6rKDPVZ9Awdg9trKADZQFuTQT
        BgYZnbE1XjiXwY6FPguIXPVVz1Y7aZFmnT4GZ0jq44tx7WrKaTvcEgO30NccHCBo
        WcGofZjumaJ9Jjv6i0Dj/hpMYsiwwJBpTJ7TQZp8hUx9sS/PtDjXpisKh34boRuU
        dUo2HPgmk4MKs3TmNiflaQ1lQAv9Shofl6CvCzwoI7s9bEzhfD3OcmzrdjZMMVbo
        g5mSCp9bVwVrbA==
X-ME-Sender: <xms:0gtsYd6z-kSr3c0167qy0eDitnfIRfNzfSUBM2JtKcFdRSqs-xNqFA>
    <xme:0gtsYa4l9jhoZiqxFdLLpVn6H6Vs5RzKWmxZhQL2Jo02i7xUPhmyvyxaxLGlxdXwI
    mAueYaC4oF6gJvTigE>
X-ME-Received: <xmr:0gtsYUe3cP7ezqs3D9WPbxYZlFuztAMtCj2nGbxbTKWMTXJjCwwtpjL458ZUr3wOCykzaUJIeV6GnAaXTnMZfxSx-S37BU1-wV_qalgt-sZYXkEvhlxdKQQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrvddukedggedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefuvhgvnhcu
    rfgvthgvrhcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrfgrthhtvg
    hrnheptefgjedtjeejffelleejleehtdetvedujeelhffgieehgeduueehhfegueeuhfdv
    necuffhomhgrihhnpeguvghvihgtvghtrhgvvgdrohhrghdpohhfthgtrdhnvghtpdhgih
    hthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpehsvhgvnhesshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:0gtsYWI__2Z8Ub-UQZDRg6o0-x6mOivaZvglOl78iUD2kH9eTlPd5w>
    <xmx:0gtsYRLNO9TqDzxgWtxPJ4CxPrVD1ac1JNUHu6WvRKWEO7JTYV7i4Q>
    <xmx:0gtsYfwYM0EeaEVFQt4JmdwmGGA6d8D6S0J0rKmst2W4T8QmfALSYQ>
    <xmx:0gtsYbxi8QSt0fiQa7sEf9PFA5j_4YpIsSDYulTAKyb6CXsgD4_wTg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 17 Oct 2021 07:41:04 -0400 (EDT)
From:   Sven Peter <sven@svenpeter.dev>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     Sven Peter <sven@svenpeter.dev>, Rob Herring <robh+dt@kernel.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Hector Martin <marcan@marcan.st>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Stan Skowronek <stan@corellium.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Mark Kettenis <kettenis@openbsd.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v3 1/2] dt-bindings: mailbox: Add Apple mailbox bindings
Date:   Sun, 17 Oct 2021 13:40:53 +0200
Message-Id: <20211017114054.67737-2-sven@svenpeter.dev>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20211017114054.67737-1-sven@svenpeter.dev>
References: <20211017114054.67737-1-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Apple mailbox controller are found on the M1 and are used for
communication with various co-processors.

Reviewed-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
Reviewed-by: Mark Kettenis <kettenis@openbsd.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Sven Peter <sven@svenpeter.dev>
---
 .../bindings/mailbox/apple,mailbox.yaml       | 79 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 80 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml

diff --git a/Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml b/Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml
new file mode 100644
index 000000000000..d488a4173072
--- /dev/null
+++ b/Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml
@@ -0,0 +1,79 @@
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
index a4a0c2baaf27..be83d20a33ef 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1723,6 +1723,7 @@ C:	irc://irc.oftc.net/asahi-dev
 T:	git https://github.com/AsahiLinux/linux.git
 F:	Documentation/devicetree/bindings/arm/apple.yaml
 F:	Documentation/devicetree/bindings/interrupt-controller/apple,aic.yaml
+F:	Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml
 F:	Documentation/devicetree/bindings/pinctrl/apple,pinctrl.yaml
 F:	arch/arm64/boot/dts/apple/
 F:	drivers/irqchip/irq-apple-aic.c
-- 
2.25.1

