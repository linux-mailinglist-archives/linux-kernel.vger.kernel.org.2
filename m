Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E568305A6D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 12:55:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237280AbhA0LzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 06:55:00 -0500
Received: from comms.puri.sm ([159.203.221.185]:54354 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237390AbhA0Lua (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 06:50:30 -0500
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 3729DE01AC;
        Wed, 27 Jan 2021 03:49:17 -0800 (PST)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id XSckDmWLb-WQ; Wed, 27 Jan 2021 03:49:16 -0800 (PST)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     laurent.pinchart@ideasonboard.com, robh@kernel.org,
        daniel@ffwll.ch, airlied@linux.ie, stefan@agner.ch
Cc:     kernel@pengutronix.de, linux-imx@nxp.com, kernel@puri.sm,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: [PATCH] dt-bindings: mxsfb: Add interconnect bindings for LCDIF path
Date:   Wed, 27 Jan 2021 12:49:01 +0100
Message-Id: <20210127114901.26259-1-martin.kepplinger@puri.sm>
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add optional interconnect properties for the dram path requests.

Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
---
 Documentation/devicetree/bindings/display/fsl,lcdif.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/fsl,lcdif.yaml b/Documentation/devicetree/bindings/display/fsl,lcdif.yaml
index a4c3064c778c..44d744800a7c 100644
--- a/Documentation/devicetree/bindings/display/fsl,lcdif.yaml
+++ b/Documentation/devicetree/bindings/display/fsl,lcdif.yaml
@@ -50,6 +50,14 @@ properties:
   interrupts:
     maxItems: 1
 
+  interconnects:
+    items:
+      - description: Interconnect path between LCDIF and main memory
+
+  interconnect-names:
+    items:
+      - const: dram
+
   port:
     $ref: /schemas/graph.yaml#/properties/port
     description: The LCDIF output port
-- 
2.20.1

