Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF73C4440EA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 12:56:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231903AbhKCL71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 07:59:27 -0400
Received: from mx1.tq-group.com ([93.104.207.81]:1749 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230304AbhKCL70 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 07:59:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1635940610; x=1667476610;
  h=from:to:cc:subject:date:message-id;
  bh=cjhnmPP4t88UZMMLaFP7ZtwjNBar69LtAKhaM+uSXnc=;
  b=UfLCmL/xkZ2Mxe5G7iTx/wQtudAW0c/VUb+9tFegs8bSKZR5C6C7Y/1t
   XZt9bLWPfoJcAumwj41Wvw/pz/OgBia+eP/JVGBegtoqFXK0FWCO/KZQM
   opjlHpvlBFNLYwUhAghp0svnVW/Py4qmE0huJbpWYd6Pd/BBmcH92n2AO
   RatyxrHLfv0JikSjS27NVtuR87gP4tU28BaCENPpXEShgYLkum3MCEVKu
   IYT2JDTqQR2XJOkTeN9sn+IF5wemxFrhblNlu+P0Rw+cEf9hFDZ5eHyoh
   TcNZ5qoyhtQNBSshqT9zot/R7TW7Hgmejan/GXVNfyasgn9VYNbnd9uF5
   Q==;
X-IronPort-AV: E=Sophos;i="5.87,205,1631570400"; 
   d="scan'208";a="20323803"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 03 Nov 2021 12:56:49 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Wed, 03 Nov 2021 12:56:49 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Wed, 03 Nov 2021 12:56:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1635940609; x=1667476609;
  h=from:to:cc:subject:date:message-id;
  bh=cjhnmPP4t88UZMMLaFP7ZtwjNBar69LtAKhaM+uSXnc=;
  b=e+P3KzFf69Ipq+h4nsYjk6dl0HEzxVbKgxWRaKPhULNPwmvvMR8usCJV
   zsN5dsFVMBQ1AYWe61VHPm454HnCjh/7NQHYFxr1PX4LrA57S5XsZ4CPl
   P0L+8TD1vI2GaBQaMJYXGgt0r4QgPDooqkt9kAZg0uleiTKs1VVLwJW1r
   XPFcJ0SLLF2wOxMm5g5i/xMMSTHuSGnSIYoTE5jOvCoNZfijPNZemPlaD
   UCVideA0J2cR4v0C8VGo1T8fSWcVW8sFOcwbtfTan9skmqZakoiITKiP/
   mOW71HH0uuwKHVqWyQG8MMU9BVJ9YipoRkK0ai3JyT5Y918eaL0UvGh1N
   g==;
X-IronPort-AV: E=Sophos;i="5.87,205,1631570400"; 
   d="scan'208";a="20323800"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 03 Nov 2021 12:56:48 +0100
Received: from schifferm-ubuntu4.tq-net.de (schifferm-ubuntu4.tq-net.de [10.121.48.12])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 9F067280065;
        Wed,  3 Nov 2021 12:56:48 +0100 (CET)
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
Subject: [PATCH v2 1/3] dt-bindings: arm: fsl: add TQ-Systems boards based on i.MX6Q/QP/DL
Date:   Wed,  3 Nov 2021 12:56:16 +0100
Message-Id: <20211103115618.13927-1-matthias.schiffer@ew.tq-group.com>
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

