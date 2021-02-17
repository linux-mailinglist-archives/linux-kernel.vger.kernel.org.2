Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F05AC31D8D5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 12:51:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbhBQLut (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 06:50:49 -0500
Received: from mx2.suse.de ([195.135.220.15]:33490 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231717AbhBQLtG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 06:49:06 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 922E5B7E8;
        Wed, 17 Feb 2021 11:48:24 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com
Cc:     linux-rpi-kernel@lists.infradead.org, phil@raspberrypi.com,
        wahrenst@gmx.net, mripard@kernel.org, eric@anholt.net,
        robh@kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Subject: [PATCH v3 03/15] dt-bindings: soc: bcm: bcm2835-pm: Add support for bcm2711
Date:   Wed, 17 Feb 2021 12:47:58 +0100
Message-Id: <20210217114811.22069-4-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210217114811.22069-1-nsaenzjulienne@suse.de>
References: <20210217114811.22069-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new compatible string for BCM2711 and the option to provide a
third reg property for the board's new RPiVid ASB.

In BCM2711 the new RPiVid ASB took over V3D, which is our only consumer
of this driver so far. The old ASB is still be present with ISP and H264
bits but no V3D.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Reviewed-by: Rob Herring <robh@kernel.org>

---

Changes since v2:
 - Correct names s/argon/rpivid/

 .../devicetree/bindings/soc/bcm/brcm,bcm2835-pm.yaml  | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-pm.yaml b/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-pm.yaml
index 837963e9f219..0dd264f80fb3 100644
--- a/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-pm.yaml
+++ b/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-pm.yaml
@@ -19,19 +19,22 @@ allOf:
 properties:
   compatible:
     items:
-      - const: brcm,bcm2835-pm
+      - enum:
+          - brcm,bcm2835-pm
+          - brcm,bcm2711-pm
       - const: brcm,bcm2835-pm-wdt
 
   reg:
     minItems: 1
-    maxItems: 2
+    maxItems: 3
 
   reg-names:
     minItems: 1
-    maxItems: 2
+    maxItems: 3
     items:
       - const: pm
       - const: asb
+      - const: rpivid_asb
 
   "#power-domain-cells":
     const: 1
@@ -74,7 +77,7 @@ examples:
         #reset-cells = <1>;
         reg = <0x7e100000 0x114>,
               <0x7e00a000 0x24>;
-        reg-names = "pm", "asb";
+        reg-names = "pm", "asb", "rpivid_asb";
         clocks = <&clocks BCM2835_CLOCK_V3D>,
         	 <&clocks BCM2835_CLOCK_PERI_IMAGE>,
         	 <&clocks BCM2835_CLOCK_H264>,
-- 
2.30.0

