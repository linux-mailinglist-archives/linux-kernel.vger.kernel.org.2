Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB552356C42
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 14:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352264AbhDGMic (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 08:38:32 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36368 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245560AbhDGMiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 08:38:23 -0400
Date:   Wed, 07 Apr 2021 12:38:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1617799093;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B1Sxb6WsvYoU8sZoo43qOwSoINUO+UAUYne+Hmqhqmw=;
        b=DwXjYQPaqTVXdxD5hfhScziscCcdPWM7niU56MrTVlB54jw6b7bL7LZd2Z5vfPnM/deZRl
        UABPX1hp68Udm8Sqc5EojTxtzrJdgmF4JiEpgDc8ws1rl7jUmZRsajAY2Jyw8Efl1AKEj/
        ++y73OFFJcUvOhNh/VFqlIB1Ab7XbFPqjOtzwEn5Nzibo8Fa95myYtQgkZs+xtsccLM0Ad
        52tm0yVYJ49L/utLdXHnS0zO3DuNrzcVjAyQWS51/a51nE23AQxOYv050Bv37IjrkTCzR4
        VCJN2hmuY8hIh+wz5mGGVv5h4Z9zmY2RsoOxXqYPHpg9qL2UlYGUo/V0ggaUjg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1617799093;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B1Sxb6WsvYoU8sZoo43qOwSoINUO+UAUYne+Hmqhqmw=;
        b=Bnebsb7fb+kx5desxdpUgjL5SufPcF4ZK1zdPlNKNdOEiAREPKEAwLCLSegv+z8EJbSvu6
        Z6OPLfmlO01rWNCg==
From:   irqchip-bot for Jonathan =?utf-8?q?Neusch=C3=A4fer?= 
        <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] dt-bindings: interrupt-controller: Add
 nuvoton, wpcm450-aic
Cc:     j.neuschaefer@gmx.net, Rob Herring <robh@kernel.org>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20210406120921.2484986-4-j.neuschaefer@gmx.net>
References: <20210406120921.2484986-4-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Message-ID: <161779909231.29796.15975997465138570266.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqc=
hip:

Commit-ID:     7c18715546203a09f859dac2fe3ea8aceec5f235
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platfo=
rms/7c18715546203a09f859dac2fe3ea8aceec5f235
Author:        Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
AuthorDate:    Tue, 06 Apr 2021 14:09:14 +02:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Wed, 07 Apr 2021 13:26:00 +01:00

dt-bindings: interrupt-controller: Add nuvoton, wpcm450-aic

The WPCM450 AIC ("Advanced Interrupt Controller") is the interrupt
controller found in the Nuvoton WPCM450 SoC and other Winbond/Nuvoton
SoCs.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20210406120921.2484986-4-j.neuschaefer@gmx.net
---
 Documentation/devicetree/bindings/interrupt-controller/nuvoton,wpcm450-aic.y=
aml | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/nu=
voton,wpcm450-aic.yaml

diff --git a/Documentation/devicetree/bindings/interrupt-controller/nuvoton,w=
pcm450-aic.yaml b/Documentation/devicetree/bindings/interrupt-controller/nuvo=
ton,wpcm450-aic.yaml
new file mode 100644
index 0000000..9ce6804
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/nuvoton,wpcm450-=
aic.yaml
@@ -0,0 +1,39 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/nuvoton,wpcm450-aic.=
yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Nuvoton WPCM450 Advanced Interrupt Controller bindings
+
+maintainers:
+  - Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
+
+properties:
+  '#interrupt-cells':
+    const: 2
+
+  compatible:
+    const: nuvoton,wpcm450-aic
+
+  interrupt-controller: true
+
+  reg:
+    maxItems: 1
+
+additionalProperties: false
+
+required:
+  - '#interrupt-cells'
+  - compatible
+  - reg
+  - interrupt-controller
+
+examples:
+  - |
+    aic: interrupt-controller@b8002000 {
+        compatible =3D "nuvoton,wpcm450-aic";
+        reg =3D <0xb8002000 0x1000>;
+        interrupt-controller;
+        #interrupt-cells =3D <2>;
+    };
