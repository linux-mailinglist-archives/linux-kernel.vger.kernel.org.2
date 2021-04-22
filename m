Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39BAF368129
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 15:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236292AbhDVNIN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 09:08:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236327AbhDVNID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 09:08:03 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 801ABC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 06:07:27 -0700 (PDT)
Date:   Thu, 22 Apr 2021 13:07:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1619096844;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+5a5SBUljhw4afvjmJTFE6m6sN5wVeSO/0Vrem3pb3Q=;
        b=YE644ejDz4CPEvFwbZQiWGpndE1H4tXXD8/eodDjQ4n53yQ1wD5fFyCjLG/iTXEmIET18G
        oPvPiXVoCDi/Lu+RjH7YHL6WoLr5GI73LtyDSQehfSysoa2b0+NtCysCEooOfBO7uvMZpj
        LcmCxQLpeiYyDW2PwRZ1J9f6yjUEemGmuDai7bml9pWmVzwRCUGdcuV9sVIlM+WjoKS84V
        ChPGP/C0j9eaI3uyjjdiTyXOE/ijk8xIpeT7iVHb1/mfNDVPyLG8FlO5K5SEKSvJhw8z5z
        SkF1nR2B2Tgus+PVUzEqxSaBqRG5eQbOs3EsAQQYzpsSGE+Z6eRbKzGmZcUYlQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1619096844;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+5a5SBUljhw4afvjmJTFE6m6sN5wVeSO/0Vrem3pb3Q=;
        b=VaNQFtgjpbMgGExDcORlvdTfK0oRoxNNvF2ituBwR9gHrHALP5UcVQ9cmPkL9EFnwsqnZe
        r3zMYP8/KefHhiBA==
From:   "irqchip-bot for Thomas Bogendoerfer" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] dt-bindings: interrupt-controller: Add
 IDT 79RC3243x Interrupt Controller
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20210421142606.23188-2-tsbogend@alpha.franken.de>
References: <20210421142606.23188-2-tsbogend@alpha.franken.de>
MIME-Version: 1.0
Message-ID: <161909684415.29796.17151809601219336094.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     f0d37ead8d308e59ff5837bb6e3e65c9137a3bb6
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/f0d37ead8d308e59ff5837bb6e3e65c9137a3bb6
Author:        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
AuthorDate:    Wed, 21 Apr 2021 16:26:05 +02:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Thu, 22 Apr 2021 13:56:57 +01:00

dt-bindings: interrupt-controller: Add IDT 79RC3243x Interrupt Controller

Document DT bindings for IDT 79RC3243x Interrupt Controller.

Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20210421142606.23188-2-tsbogend@alpha.franken.de
---
 Documentation/devicetree/bindings/interrupt-controller/idt,3243x-pic.yaml | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/idt,3243x-pic.yaml

diff --git a/Documentation/devicetree/bindings/interrupt-controller/idt,3243x-pic.yaml b/Documentation/devicetree/bindings/interrupt-controller/idt,3243x-pic.yaml
new file mode 100644
index 0000000..2d7dd34
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/idt,3243x-pic.yaml
@@ -0,0 +1,48 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/idt,3243x-pic.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: IDT 79RC3243x Interrupt Controller Device Tree Bindings
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
+    const: idt,3243x-pci
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
+        compatible = "idt,3243x-pic";
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
