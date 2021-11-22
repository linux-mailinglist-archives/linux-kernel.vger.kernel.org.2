Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C64A458D92
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 12:38:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239200AbhKVLlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 06:41:24 -0500
Received: from mx1.tq-group.com ([93.104.207.81]:50749 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234018AbhKVLlX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 06:41:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1637581097; x=1669117097;
  h=from:to:cc:subject:date:message-id;
  bh=t/rze9xdI84xVAJw6tK8qVvKR78qTYRvwhl3DPX83go=;
  b=BMURZ9IbV6imli/0wCU4wiT7k68j7OWlA9aTFiF7sgVpFbvH4MOw+BP2
   iVlD6VRX0G51z+kGPSSFdUYzE3p3rGV0exbIp0Prj5itg40sOll2RK9VR
   APGTjd1+L2W56V5ZWkfXSVbW/PTCYcBpziivzXZnG2mbAX5a6j8IRCBtW
   ZLqN3Wtm9lW/tJcb4wlprXO4xUz9XRiB650EUVY2eUsEtHYClKED7x5dB
   cnSvFMiE+2HJtMeoSgQkTlZv/+jsy91dL/T229x+k6ursguczRSZ5mjtH
   vG511S2YiAcB/jJegNc7Nir7m1nOy6mwD5GizS4zu94OkE/NSDd4EnPNJ
   Q==;
X-IronPort-AV: E=Sophos;i="5.87,254,1631570400"; 
   d="scan'208";a="20593896"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 22 Nov 2021 12:38:15 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Mon, 22 Nov 2021 12:38:15 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Mon, 22 Nov 2021 12:38:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1637581095; x=1669117095;
  h=from:to:cc:subject:date:message-id;
  bh=t/rze9xdI84xVAJw6tK8qVvKR78qTYRvwhl3DPX83go=;
  b=E3XG6NKBKMSLTVlGaj4QQNnItJosmItqnuE8bU06AaFTUTy2Hv8FmPzb
   /+uT80eXcoLu5EIvYcgtirjTJgTYBjRe1yUKcKLeFIMxjsBpN091/tA93
   0b/JwT9FhsjjqdXW5Ofq9QXMKxfINQ4ax7qvlmpGZEs1whIZ0ciJtI20B
   2BkwcRoWLIo6RXQoYO+tthP0sVePRNi6v3LnI6zxVYcdRiGddwubwusTH
   ZkIEz+5XNjKExXU/6ysCJTGjTdY2IcyftCx0hFq3pPkaan+Omx34uri5Y
   kC5k2yPJBd8tkFxUCzXICX1L3Fvm7wdXchgHGnzlvyjXs63z7/uv9FBa0
   g==;
X-IronPort-AV: E=Sophos;i="5.87,254,1631570400"; 
   d="scan'208";a="20593895"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 22 Nov 2021 12:38:15 +0100
Received: from schifferm-ubuntu4.tq-net.de (schifferm-ubuntu4.tq-net.de [10.121.48.12])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 86824280065;
        Mon, 22 Nov 2021 12:38:15 +0100 (CET)
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Markus Niebel <Markus.Niebel@ew.tq-group.com>
Subject: [PATCH v3 1/3] dt-bindings: arm: fsl: add TQ-Systems boards based on i.MX6Q/QP/DL
Date:   Mon, 22 Nov 2021 12:37:38 +0100
Message-Id: <20211122113740.2348-1-matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The TQ-Systems MBa6x mainboard can be used with TQMa6 variants with
i.MX6Q/QP/DL SoCs (TQMa6Q/QP/DL). The TQMa6Q and DL exist in two variants:
The newer variants "A" have a hardware workaround for Erratum ERR006687,
while variants "B" are missing such a workaround, so it needs to be
handled in software. The erratum was fixed in i.MX6QP, so no "A" variant
of the TQMa6QP exists.

Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---

v2: no changes, added Reviewed-by from v1
v3: no changes

 .../devicetree/bindings/arm/fsl.yaml          | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 0b595b26061f..57b003f4eff1 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -323,6 +323,20 @@ properties:
           - const: toradex,apalis_imx6q
           - const: fsl,imx6q
 
+      - description: TQ-Systems TQMa6Q SoM (variant A) on MBa6x
+        items:
+          - const: tq,imx6q-mba6x-a
+          - const: tq,mba6a               # Expected by bootloader, to be removed in the future
+          - const: tq,imx6q-tqma6q-a
+          - const: fsl,imx6q
+
+      - description: TQ-Systems TQMa6Q SoM (variant B) on MBa6x
+        items:
+          - const: tq,imx6q-mba6x-b
+          - const: tq,mba6b               # Expected by bootloader, to be removed in the future
+          - const: tq,imx6q-tqma6q-b
+          - const: fsl,imx6q
+
       - description: i.MX6QP based Boards
         items:
           - enum:
@@ -344,6 +358,13 @@ properties:
           - const: phytec,imx6qdl-pcm058  # PHYTEC phyCORE-i.MX6
           - const: fsl,imx6qp
 
+      - description: TQ-Systems TQMa6QP SoM on MBa6x
+        items:
+          - const: tq,imx6qp-mba6x-b
+          - const: tq,mba6b               # Expected by bootloader, to be removed in the future
+          - const: tq,imx6qp-tqma6qp-b
+          - const: fsl,imx6qp
+
       - description: i.MX6DL based Boards
         items:
           - enum:
@@ -482,6 +503,20 @@ properties:
           - const: dh,imx6s-dhcom-som
           - const: fsl,imx6dl
 
+      - description: TQ-Systems TQMa6DL SoM (variant A) on MBa6x
+        items:
+          - const: tq,imx6dl-mba6x-a
+          - const: tq,mba6a               # Expected by bootloader, to be removed in the future
+          - const: tq,imx6dl-tqma6dl-a
+          - const: fsl,imx6dl
+
+      - description: TQ-Systems TQMa6DL SoM (variant B) on MBa6x
+        items:
+          - const: tq,imx6dl-mba6x-b
+          - const: tq,mba6b               # Expected by bootloader, to be removed in the future
+          - const: tq,imx6dl-tqma6dl-b
+          - const: fsl,imx6dl
+
       - description: i.MX6SL based Boards
         items:
           - enum:
-- 
2.17.1

