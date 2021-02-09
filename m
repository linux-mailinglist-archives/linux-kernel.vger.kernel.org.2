Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44EE0314FA7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 14:01:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbhBINBk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 08:01:40 -0500
Received: from mx2.suse.de ([195.135.220.15]:41978 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230210AbhBINBX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 08:01:23 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BBD8FAF50;
        Tue,  9 Feb 2021 13:00:40 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     f.fainelli@gmail.com, linux-kernel@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com
Cc:     linux-rpi-kernel@lists.infradead.org, phil@raspberrypi.com,
        wahrenst@gmx.net, linux-arm-kernel@lists.infradead.org,
        mripard@kernel.org, eric@anholt.net,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [RFC/PATCH v2 02/16] dt-bindings: soc: bcm: bcm2835-pm: Introduce reg-names
Date:   Tue,  9 Feb 2021 13:58:58 +0100
Message-Id: <20210209125912.3398-3-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210209125912.3398-1-nsaenzjulienne@suse.de>
References: <20210209125912.3398-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Anticipating the introduction of BCM2711, of which we'll need to support
its new Argon ASB, introduce reg-names into bcm2835-pm's binding. This
will help to have a consistent mapping between resources and their
meaning.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 .../devicetree/bindings/soc/bcm/brcm,bcm2835-pm.yaml  | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-pm.yaml b/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-pm.yaml
index 8bc65e5f62a7..1dbe3657c690 100644
--- a/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-pm.yaml
+++ b/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-pm.yaml
@@ -26,8 +26,13 @@ properties:
   reg:
     minItems: 1
     maxItems: 2
-    description: Specifies base physical address and size of the two register
-                 ranges, "PM" and "ASYNC_BRIDGE" in that order.
+
+  reg-names:
+    minItems: 1
+    maxItems: 2
+    items:
+      - const: pm
+      - const: rpivid_asb
 
   "#power-domain-cells":
     const: 1
@@ -54,6 +59,7 @@ properties:
 required:
   - compatible
   - reg
+  - reg-names
   - "#power-domain-cells"
   - "#reset-cells"
   - clocks
@@ -70,6 +76,7 @@ examples:
         #reset-cells = <1>;
         reg = <0x7e100000 0x114>,
               <0x7e00a000 0x24>;
+        reg-names = "pm", "rpivid_asb";
         clocks = <&clocks BCM2835_CLOCK_V3D>,
         	 <&clocks BCM2835_CLOCK_PERI_IMAGE>,
         	 <&clocks BCM2835_CLOCK_H264>,
-- 
2.30.0

