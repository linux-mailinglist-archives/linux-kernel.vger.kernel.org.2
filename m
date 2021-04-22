Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 527CE3682F8
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 17:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237528AbhDVPIM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 11:08:12 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39118 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233106AbhDVPIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 11:08:11 -0400
Date:   Thu, 22 Apr 2021 15:07:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1619104055;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0bqr8Cy8KNr1TVYFbjnknn8Dd6HrwI1rXmonHfNsXOU=;
        b=G1S0yvhYsw8uDT/M0NnJmArNwDXdUcR4YlHP9N6AqOO4kKE/EIcnaZsjJHwxO6+4ADzTlH
        vxHRsx2cJ9THWLEIOh2CMAJqW0Bg6R8jMXsGGseckxUXQADXZGJNg7evZqKsJ5cKPQ3K+H
        rRwZCnXzdeDdACF0BN4Isujo16629ciZns0mbvERk6NieudRDcSSMoGjgwAYc84u/qINB9
        AuNQOR/5KoaOUkGwjUpMclYMEQ5GxOVSkCqMi4LB+4cHvGSwAQtQmMDaX9jkAkjIyV+CyQ
        V/7Qoj2Dmiiq0wuFb17xchsy76SB6EWy/QfcHljn0yqHJRHo5Vnkrk/oModNFg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1619104055;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0bqr8Cy8KNr1TVYFbjnknn8Dd6HrwI1rXmonHfNsXOU=;
        b=gdt5na23ekR+/3Tbqo/Ua0zt/eGcVMNZ2X6HeYp4TfudIDOTRU+UFn5yiOkVaI+up1UgCm
        xaupG3mw7/aQpwDQ==
From:   "irqchip-bot for Thomas Bogendoerfer" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] dt-bindings: interrupt-controller: Add
 IDT 79RC3243x Interrupt Controller
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20210422145330.73452-2-tsbogend@alpha.franken.de>
References: <20210422145330.73452-2-tsbogend@alpha.franken.de>
MIME-Version: 1.0
Message-ID: <161910405471.29796.8134967997389488726.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     05d7bf817019890e4d049e0b851940c596adbd9b
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/05d7bf817019890e4d049e0b851940c596adbd9b
Author:        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
AuthorDate:    Thu, 22 Apr 2021 16:53:29 +02:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Thu, 22 Apr 2021 16:03:18 +01:00

dt-bindings: interrupt-controller: Add IDT 79RC3243x Interrupt Controller

Document DT bindings for IDT 79RC3243x Interrupt Controller.

Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20210422145330.73452-2-tsbogend@alpha.franken.de
---
 Documentation/devicetree/bindings/interrupt-controller/idt,32434-pic.yaml | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/idt,32434-pic.yaml

diff --git a/Documentation/devicetree/bindings/interrupt-controller/idt,32434-pic.yaml b/Documentation/devicetree/bindings/interrupt-controller/idt,32434-pic.yaml
new file mode 100644
index 0000000..df5d8d1
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/idt,32434-pic.yaml
@@ -0,0 +1,48 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/idt,32434-pic.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: IDT 79RC32434 Interrupt Controller Device Tree Bindings
+
+maintainers:
+  - Thomas Bogendoerfer <tsbogend@alpha.franken.de>
+
+allOf:
+  - $ref: /schemas/interrupt-controller.yaml#
+
+properties:
+  "#interrupt-cells":
+    const: 1
+
+  compatible:
+    const: idt,32434-pic
+
+  reg:
+    maxItems: 1
+
+  interrupt-controller: true
+
+required:
+  - "#interrupt-cells"
+  - compatible
+  - reg
+  - interrupt-controller
+
+additionalProperties: false
+
+examples:
+  - |
+    idtpic3: interrupt-controller@3800c {
+        compatible = "idt,32434-pic";
+        reg = <0x3800c 0x0c>;
+
+        interrupt-controller;
+        #interrupt-cells = <1>;
+
+        interrupt-parent = <&cpuintc>;
+        interrupts = <3>;
+    };
+
+...
