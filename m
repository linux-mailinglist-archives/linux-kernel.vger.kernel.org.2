Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EDCC30F732
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 17:09:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237707AbhBDQFK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 11:05:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237644AbhBDQDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 11:03:35 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D89ECC061786
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 08:02:53 -0800 (PST)
Date:   Thu, 04 Feb 2021 16:02:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612454572;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/Lc8bH8oc21NBkKqtZPQiVARpeAaGnd3cEVnPfZd6tk=;
        b=VHt5GXXFO37ToI0LmeG5znNjNHD/XB5n1PBy7+tvXUmswnQn+32snRQl7lYcx8Dhrf0GNa
        1Sjbr7h/hKqpK9kI0gjEHdDIccClJHRXWcR54LhXLv9SWQq/s+LpmMTEWeVRVpEunqF9B7
        2/Jmhrc8ppl/EvDfmwCbKBld549tfbwPajPiZnAyottj/fZ2GC0Bt5YowRghlqSNot8SJn
        P6Hzzf+GD/U1oy/MWoqZ5cCNWFJpVBaBYV5EtgtGhjBtkW0ej5lxB4UpjJDCN0UBwClZqB
        5JDYbX+wjc0c0H2xP1LlZBW/5CbD8yvZMP5OruBURgpOXj24C2uVk/j06gTrRw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612454572;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/Lc8bH8oc21NBkKqtZPQiVARpeAaGnd3cEVnPfZd6tk=;
        b=09sYCntS+dEVjM6FIPwt8kqqFFHUOk8R+iJBFxemyug83CRbC6dTBCi6eXXzaRnT258F8x
        CiopXiznGCJCxNAQ==
From:   "irqchip-bot for Bert Vermeulen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] dt-bindings: interrupt-controller: Add
 Realtek RTL838x/RTL839x support
Cc:     Rob Herring <robh@kernel.org>, Bert Vermeulen <bert@biot.com>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20210122204224.509124-2-bert@biot.com>
References: <20210122204224.509124-2-bert@biot.com>
MIME-Version: 1.0
Message-ID: <161245457125.23325.218481363344614797.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     4a2b92a5d3519fc2c1edda4d4aa0e05bff41e8de
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/4a2b92a5d3519fc2c1edda4d4aa0e05bff41e8de
Author:        Bert Vermeulen <bert@biot.com>
AuthorDate:    Fri, 22 Jan 2021 21:42:23 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Thu, 04 Feb 2021 10:36:15 

dt-bindings: interrupt-controller: Add Realtek RTL838x/RTL839x support

Document the binding for the Realtek RTL838x/RTL839x interrupt controller.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Bert Vermeulen <bert@biot.com>
[maz: Add a commit message, as the author couldn't be bothered...]
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20210122204224.509124-2-bert@biot.com
---
 Documentation/devicetree/bindings/interrupt-controller/realtek,rtl-intc.yaml | 57 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/realtek,rtl-intc.yaml

diff --git a/Documentation/devicetree/bindings/interrupt-controller/realtek,rtl-intc.yaml b/Documentation/devicetree/bindings/interrupt-controller/realtek,rtl-intc.yaml
new file mode 100644
index 0000000..9e76fff
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/realtek,rtl-intc.yaml
@@ -0,0 +1,57 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/realtek,rtl-intc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Realtek RTL SoC interrupt controller devicetree bindings
+
+maintainers:
+  - Birger Koblitz <mail@birger-koblitz.de>
+  - Bert Vermeulen <bert@biot.com>
+  - John Crispin <john@phrozen.org>
+
+properties:
+  compatible:
+    const: realtek,rtl-intc
+
+  "#interrupt-cells":
+    const: 1
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  interrupt-controller: true
+
+  "#address-cells":
+    const: 0
+
+  interrupt-map:
+    description: Describes mapping from SoC interrupts to CPU interrupts
+
+required:
+  - compatible
+  - reg
+  - "#interrupt-cells"
+  - interrupt-controller
+  - "#address-cells"
+  - interrupt-map
+
+additionalProperties: false
+
+examples:
+  - |
+    intc: interrupt-controller@3000 {
+      compatible = "realtek,rtl-intc";
+      #interrupt-cells = <1>;
+      interrupt-controller;
+      reg = <0x3000 0x20>;
+      #address-cells = <0>;
+      interrupt-map =
+              <31 &cpuintc 2>,
+              <30 &cpuintc 1>,
+              <29 &cpuintc 5>;
+    };
