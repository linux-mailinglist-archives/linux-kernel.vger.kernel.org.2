Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F78D42BEBA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 13:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbhJMLPa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 07:15:30 -0400
Received: from mx1.tq-group.com ([93.104.207.81]:61892 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229653AbhJMLP2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 07:15:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1634123606; x=1665659606;
  h=from:to:cc:subject:date:message-id;
  bh=YdPfzhsWATxi0+bolJORemf2+qX9sc7j17ozhvVkqHU=;
  b=OnYexdAR7Hqx93bvcoVRy0z+gqRjo1vzGTqsKxEGLHFfvy5I4vxhxAdH
   Q27PBvqy2qYDjDunAG1RpAjvdXkbAoNK4O6JoXClYgPv40NggIWLwcpF2
   YkXJrAzLL2ss3oxa24h2T9uJo7semn1y5OvT+iiYd6cC0iZ+6XVCiO8jH
   1xX+C8bdmCT0wXFodi7DOA2ChK6FSlTjQjEHwSlBJm1oviNTA4xAmLBLK
   YHI9qTcDn/w0Ddls1hglWIiJaDrjd4aLrVaiNaQqb8cUYnHf3hVdCeTJR
   5lh2uCDZOCRTRkpbSmZ3OzvKCZXMR/RpadZdDaheKyj5QPtbNFzOmJnbQ
   g==;
X-IronPort-AV: E=Sophos;i="5.85,370,1624312800"; 
   d="scan'208";a="20020840"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 13 Oct 2021 13:13:24 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Wed, 13 Oct 2021 13:13:24 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Wed, 13 Oct 2021 13:13:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1634123604; x=1665659604;
  h=from:to:cc:subject:date:message-id;
  bh=YdPfzhsWATxi0+bolJORemf2+qX9sc7j17ozhvVkqHU=;
  b=K5zDbdR6QZUaFYftsHGBD0rWaq08Ob1YiF0hXoD3IDty2szLUcpNPWe2
   zKAIXuRvstodXxxzvBb6M04KQvj7B4xR/yT6MYiPB5b4jIn8gS/ZUtEL3
   sdULL0KZ3ITOmjuPtCyIS00meOWmRxB12jJ3Sa69Ch0EmLUjUAhgm70Nb
   ojvTUxA3eHoxtfI4b+XRy6SYbLjgdTBssaHCC2y/ndquUvacC9Pc9vIHh
   7jbhFvEOoAI0BYXGAZUukhK2hf1CQCw5c0qhQXq+q1KvDnemyIKpAnDKM
   Dnsc4XcGydgSa0rOlMJV0vgMaeTk/HDhhPbodpofz7c+vcocbNBN+TbzL
   w==;
X-IronPort-AV: E=Sophos;i="5.85,370,1624312800"; 
   d="scan'208";a="20020839"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 13 Oct 2021 13:13:24 +0200
Received: from schifferm-ubuntu4.tq-net.de (schifferm-ubuntu4.tq-net.de [10.121.48.12])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 9714F280065;
        Wed, 13 Oct 2021 13:13:24 +0200 (CEST)
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
Subject: [PATCH 1/3] dt-bindings: arm: fsl: add TQ-Systems boards based on i.MX6Q/QP/DL
Date:   Wed, 13 Oct 2021 13:12:00 +0200
Message-Id: <20211013111202.6231-1-matthias.schiffer@ew.tq-group.com>
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
---
 .../devicetree/bindings/arm/fsl.yaml          | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index f08d77b4a1f0..a48e48e524c2 100644
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

