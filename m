Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 161764352EF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 20:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbhJTStj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 14:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbhJTSt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 14:49:28 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3034C061749
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 11:47:13 -0700 (PDT)
Date:   Wed, 20 Oct 2021 18:47:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634755631;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YaVpYQ3Zw456HVsdZwDzAcT9y1ZujogonmbNB9xEW4o=;
        b=4MDjn4QtwENESR5zULa0Lz7jHE7aN0qo1wErSSUzJXp1RfZKUY/tOcm/AbwU+gyZmn+5zx
        tp/rougCEycvxngAP/LvZOv4RYtcNIfx7oAGNyJkMIPHhz8zGCMEiRCIVuSzA7BcJau4pP
        L34rNzqEqCRCCrPaC5d+V5/E2mtoLQq/zim1V2mtO/ZWmu6UUMmeE0kQpeGBaqZRwlLQeA
        4k46Q8aKVpNCA5uLXqEvnfQOFzxZhUJSSd1OLQ4YLctwLXLWq+RXXLi4/WLY/9C4v9RU8D
        ZTqvrDyOvsF9ou6kg28RKbThUsNe6GWmJMUA46M0iIlKb1pg4fQ26eSKo3witw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634755631;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YaVpYQ3Zw456HVsdZwDzAcT9y1ZujogonmbNB9xEW4o=;
        b=N5pYk3w2gOKqcWdRT34IxNYFAbcxXwCL7W1DXp+Wcwu0J0XHzGxb+9YjsDxRhZEmpa5VuU
        0hCfhEM4zC4szFDA==
From:   "irqchip-bot for Claudiu Beznea" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] dt-bindings: microchip,eic: Add bindings
 for the Microchip EIC
Cc:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>,
        tglx@linutronix.de
In-Reply-To: <20210927063657.2157676-2-claudiu.beznea@microchip.com>
References: <20210927063657.2157676-2-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Message-ID: <163475563007.25758.18040964941864637055.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     36179af21cc812ccac37678b1c8114856876fb3f
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/36179af21cc812ccac37678b1c8114856876fb3f
Author:        Claudiu Beznea <claudiu.beznea@microchip.com>
AuthorDate:    Mon, 27 Sep 2021 09:36:56 +03:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Wed, 20 Oct 2021 19:40:34 +01:00

dt-bindings: microchip,eic: Add bindings for the Microchip EIC

Add DT bindings for Microchip External Interrupt Controller.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20210927063657.2157676-2-claudiu.beznea@microchip.com
---
 Documentation/devicetree/bindings/interrupt-controller/microchip,eic.yaml | 73 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 73 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/microchip,eic.yaml

diff --git a/Documentation/devicetree/bindings/interrupt-controller/microchip,eic.yaml b/Documentation/devicetree/bindings/interrupt-controller/microchip,eic.yaml
new file mode 100644
index 0000000..5000388
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/microchip,eic.yaml
@@ -0,0 +1,73 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/microchip,eic.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip External Interrupt Controller
+
+maintainers:
+  - Claudiu Beznea <claudiu.beznea@microchip.com>
+
+description:
+  This interrupt controller is found in Microchip SoCs (SAMA7G5) and provides
+  support for handling up to 2 external interrupt lines.
+
+properties:
+  compatible:
+    enum:
+      - microchip,sama7g5-eic
+
+  reg:
+    maxItems: 1
+
+  interrupt-controller: true
+
+  '#interrupt-cells':
+    const: 2
+    description:
+      The first cell is the input IRQ number (between 0 and 1), the second cell
+      is the trigger type as defined in interrupt.txt present in this directory.
+
+  interrupts:
+    description: |
+      Contains the GIC SPI IRQs mapped to the external interrupt lines. They
+      should be specified sequentially from output 0 to output 1.
+    minItems: 2
+    maxItems: 2
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    const: pclk
+
+required:
+  - compatible
+  - reg
+  - interrupt-controller
+  - '#interrupt-cells'
+  - interrupts
+  - clocks
+  - clock-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/at91.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    eic: interrupt-controller@e1628000 {
+      compatible = "microchip,sama7g5-eic";
+      reg = <0xe1628000 0x100>;
+      interrupt-parent = <&gic>;
+      interrupt-controller;
+      #interrupt-cells = <2>;
+      interrupts = <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>,
+                   <GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>;
+      clocks = <&pmc PMC_TYPE_PERIPHERAL 37>;
+      clock-names = "pclk";
+    };
+
+...
