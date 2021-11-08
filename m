Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08829449A86
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 18:10:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241440AbhKHRMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 12:12:52 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:43653 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232922AbhKHRMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 12:12:51 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id CACBA5C01B0;
        Mon,  8 Nov 2021 12:09:58 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 08 Nov 2021 12:09:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm2; bh=Ac01M78HVVhymN796EnmiJqYFD
        Y+9Lkga4k+OMsqtcI=; b=QQVqrjxJksTewDwfJheHFr7xtjwamMCBS0l65m8gsB
        2lGzelknadwD0QORItBLsASN5QEeOThV7YPupyo5nZ5Q+AFL0jVwwpE7XkJKNu+w
        fG5LvdZdg7SsgRhx3aadMMmvKfp8YmqD4s2IEmDb2VMXi9AeM4Mi0ML3SJJ7SkYX
        QXVO3gmb4Zr5xWxZxRKITVKQbWYwgdLJzH3HNm5qrvPZynD+X5G1eqj1VGlAznEu
        R7ypo2EGed15YoHtgUpT10r+hyqpcBZWiBBDJQGSb+9IChotof00tgCmhSEkP2zo
        AowVQzQO7mcZ+JUCnDsN/ZV2YD4hhK4aoPDrCxsKpdlA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=Ac01M78HVVhymN796
        EnmiJqYFDY+9Lkga4k+OMsqtcI=; b=kSZa2Z/rrFyJenUy9r41JyLPg8DsnpP4J
        P/+MLjt05xA76fAFLIjhp+wIPwFtywFGHioqvuKov5vYN6a32hN0TA/v5i/n5RmW
        KCbJ8/b3nQDneJYmdzIEFFZHERgZzF7MKhUh4/PL2I/F+uq05GuQ6/ut/+H8fUFn
        lJVxxRFr7DXouF10jOR64XyDfBGVYsAuZVvAfr/HiVDJ/iSJTicCC4rqqy+TK0G9
        XWLICHx7OK9ITcmv+cS6rlLWFvXYRWUeaQuhJ7angc2JVschOO9gsEGgWUO3p3/4
        +uQhyf1LY6pCYNM0IMjm8GNrxFm96rxNN3naPH8YJ2OBqEfXeAH/A==
X-ME-Sender: <xms:5VmJYWlbogFi9hzr9Qho6IQUW12wDIwO49AGVRsz7hg4JMOVghveJA>
    <xme:5VmJYd1dAyvIxX-QhmYXLaqvkeXksUrLn_5zRFWhzdkN30adDiYe8BgSgpSVhcBOw
    JWfIb5mxUbxBgunrJQ>
X-ME-Received: <xmr:5VmJYUrd33tj7zZ9OfGLjF9RhIo4U8OevfIvD1vHW1skN0kKqWswb6wCrxsFk5YcnnkPvPdAZ7O8OfTaHsMLee5o3GscFpM5zoQp9cOyxDeQzogAPAVVobWy23oX5Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddruddvgdeliecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepufhvvghnucfrvght
    vghruceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrghtthgvrhhnpe
    efjefgjeelveelledtiefhteetfeevudejledvieelvdejffeujeejtefgkedvudenucff
    ohhmrghinhepuggvvhhitggvthhrvggvrdhorhhgpdhgihhthhhusgdrtghomhenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsvhgvnhesshhv
    vghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:5lmJYakgPVABaUlvC6EfD2UNd98YJR665TdAQOQwinNbHfWIz6Ub6Q>
    <xmx:5lmJYU2CbvvyU_kVkPfxzZQJsY5Tsij64cLc_BuBUNrWoKC8xgySgQ>
    <xmx:5lmJYRtFAb2Q2Wa-MrQRDZMCkhq6lIyZ2ij2bE6PQapFxT5pQaxrEg>
    <xmx:5lmJYVKsyHCZMozgWgZ_URZbP_sV3RtcZSO9Tc1efVtWNukcLmGnKg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Nov 2021 12:09:56 -0500 (EST)
From:   Sven Peter <sven@svenpeter.dev>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Sven Peter <sven@svenpeter.dev>, Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hector Martin <marcan@marcan.st>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: usb: Add Apple dwc3 bindings
Date:   Mon,  8 Nov 2021 18:09:45 +0100
Message-Id: <20211108170946.49689-1-sven@svenpeter.dev>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Apple Silicon SoCs such as the M1 have multiple USB controllers based on
the Synopsys DesignWare USB3 controller.
References to the ATC PHY required for SuperSpeed are left out for now
until support has been upstreamed as well.

Signed-off-by: Sven Peter <sven@svenpeter.dev>
---
v1 -> v2:
 - added apple,dwc3 bindings instead of a property for the reset quirk
   as requested by robh

I think I have to use GPL-2.0 for this binding since it's based
on and references snps,dwc3.yaml which is also only GPL-2.0.
Otherwise I'd be fine with the usual GPL/BSD dual license as well.

 .../devicetree/bindings/usb/apple,dwc3.yaml   | 64 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 65 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/apple,dwc3.yaml

diff --git a/Documentation/devicetree/bindings/usb/apple,dwc3.yaml b/Documentation/devicetree/bindings/usb/apple,dwc3.yaml
new file mode 100644
index 000000000000..fb3b3489e6b2
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/apple,dwc3.yaml
@@ -0,0 +1,64 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/usb/apple,dwc3.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Apple Silicon DWC3 USB controller
+
+maintainers:
+  - Sven Peter <sven@svenpeter.dev>
+
+description:
+  On Apple Silicon SoCs such as the M1 each Type-C port has a corresponding
+  USB controller based on the Synopsys DesignWare USB3 controller.
+
+  The common content of this binding is defined in snps,dwc3.yaml.
+
+allOf:
+  - $ref: snps,dwc3.yaml#
+
+select:
+  properties:
+    compatible:
+      contains:
+        const: apple,dwc3
+  required:
+    - compatible
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - apple,t8103-dwc3
+          - apple,t6000-dwc3
+      - const: apple,dwc3
+      - const: snps,dwc3
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/apple-aic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    usb@82280000 {
+      compatible = "apple,t8103-dwc3", "apple,dwc3", "snps,dwc3";
+      reg = <0x82280000 0x10000>;
+      interrupts = <AIC_IRQ 777 IRQ_TYPE_LEVEL_HIGH>;
+
+      dr_mode = "otg";
+      usb-role-switch;
+      role-switch-default-mode = "host";
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 3b79fd441dde..03e7cc48877a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1724,6 +1724,7 @@ T:	git https://github.com/AsahiLinux/linux.git
 F:	Documentation/devicetree/bindings/arm/apple.yaml
 F:	Documentation/devicetree/bindings/interrupt-controller/apple,aic.yaml
 F:	Documentation/devicetree/bindings/pinctrl/apple,pinctrl.yaml
+F:	Documentation/devicetree/bindings/usb/apple,dwc3.yaml
 F:	arch/arm64/boot/dts/apple/
 F:	drivers/irqchip/irq-apple-aic.c
 F:	include/dt-bindings/interrupt-controller/apple-aic.h
-- 
2.25.1

