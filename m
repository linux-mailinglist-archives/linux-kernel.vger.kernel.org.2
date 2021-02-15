Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D17F331B8FB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 13:20:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbhBOMTr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 07:19:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbhBOMSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 07:18:45 -0500
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11DB7C061788;
        Mon, 15 Feb 2021 04:18:05 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: hector@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id EAA184249A;
        Mon, 15 Feb 2021 12:17:58 +0000 (UTC)
From:   Hector Martin <marcan@marcan.st>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Hector Martin <marcan@marcan.st>, Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Tony Lindgren <tony@atomide.com>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Stan Skowronek <stan@corellium.com>,
        Alexander Graf <graf@amazon.com>,
        Will Deacon <will@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 05/25] dt-bindings: timer: arm,arch_timer: Add interrupt-names support
Date:   Mon, 15 Feb 2021 21:16:53 +0900
Message-Id: <20210215121713.57687-6-marcan@marcan.st>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210215121713.57687-1-marcan@marcan.st>
References: <20210215121713.57687-1-marcan@marcan.st>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Not all platforms provide the same set of timers/interrupts, and Linux
only needs one (plus kvm/guest ones); some platforms are working around
this by using dummy fake interrupts. Implementing interrupt-names allows
the devicetree to specify an arbitrary set of available interrupts, so
the timer code can pick the right one.

This also adds the hyp-virt timer/interrupt, which was previously not
expressed in the fixed 4-interrupt form.

Signed-off-by: Hector Martin <marcan@marcan.st>
---
 .../devicetree/bindings/timer/arm,arch_timer.yaml  | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/timer/arm,arch_timer.yaml b/Documentation/devicetree/bindings/timer/arm,arch_timer.yaml
index 2c75105c1398..ebe9b0bebe41 100644
--- a/Documentation/devicetree/bindings/timer/arm,arch_timer.yaml
+++ b/Documentation/devicetree/bindings/timer/arm,arch_timer.yaml
@@ -34,11 +34,25 @@ properties:
               - arm,armv8-timer
 
   interrupts:
+    minItems: 1
+    maxItems: 5
     items:
       - description: secure timer irq
       - description: non-secure timer irq
       - description: virtual timer irq
       - description: hypervisor timer irq
+      - description: hypervisor virtual timer irq
+
+  interrupt-names:
+    minItems: 1
+    maxItems: 5
+    items:
+      enum:
+        - phys-secure
+        - phys
+        - virt
+        - hyp-phys
+        - hyp-virt
 
   clock-frequency:
     description: The frequency of the main counter, in Hz. Should be present
-- 
2.30.0

