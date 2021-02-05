Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 518BE310C4E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 14:58:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231718AbhBEN5K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 08:57:10 -0500
Received: from mx2.suse.de ([195.135.220.15]:56280 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231575AbhBENxk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 08:53:40 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 97A71AE55;
        Fri,  5 Feb 2021 13:52:58 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     f.fainelli@gmail.com, Saenz Julienne <nsaenzjulienne@suse.de>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     phil@raspberrypi.com, wahrenst@gmx.net,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org
Subject: [RFC/PATCH 02/11] dt-bindings: soc: bcm: brcm,bcm2835-pm: Add support for bcm2711
Date:   Fri,  5 Feb 2021 14:52:38 +0100
Message-Id: <20210205135249.2924-3-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210205135249.2924-1-nsaenzjulienne@suse.de>
References: <20210205135249.2924-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new compatible string for bcm2711 and the option to provide a
third reg property for the board's new Argon ASB.

The new Argon ASB took over V3D, which is our only consumer of this
driver so far. The old ASB is still be present with ISP and H264 bits
but no V3D.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 .../devicetree/bindings/soc/bcm/brcm,bcm2835-pm.yaml       | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-pm.yaml b/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-pm.yaml
index 5e0555fc0666..a1f2e25e68db 100644
--- a/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-pm.yaml
+++ b/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-pm.yaml
@@ -21,13 +21,14 @@ properties:
     items:
       - enum:
           - brcm,bcm2835-pm
+          - brcm,bcm2711-pm
       - const: brcm,bcm2835-pm-wdt
 
   reg:
     minItems: 1
-    maxItems: 2
-    description: Specifies base physical address and size of the two register
-                 ranges, "PM" and "ASYNC_BRIDGE" in that order.
+    maxItems: 3
+    description: Specifies base physical address and size of the register
+                 ranges, "PM", "ASYNC_BRIDGE" and "ARGON_BRIDGE" in that order.
 
   "#power-domain-cells":
     const: 1
-- 
2.30.0

