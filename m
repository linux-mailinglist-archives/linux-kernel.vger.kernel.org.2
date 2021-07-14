Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 803853C9221
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 22:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232116AbhGNUfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 16:35:25 -0400
Received: from mx4.securetransport.de ([178.254.6.145]:46468 "EHLO
        mx4.securetransport.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231428AbhGNUfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 16:35:24 -0400
X-Greylist: delayed 388 seconds by postgrey-1.27 at vger.kernel.org; Wed, 14 Jul 2021 16:35:24 EDT
Received: from mail.dh-electronics.com (business-24-134-97-169.pool2.vodafone-ip.de [24.134.97.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx4.securetransport.de (Postfix) with ESMTPSA id 00E5072085C;
        Wed, 14 Jul 2021 22:25:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
        s=dhelectronicscom; t=1626294344;
        bh=1ydmi6FFj4AhAPhPs81r+ILQytchAfOzwLRI5g41Z9s=;
        h=From:To:CC:Subject:Date:From;
        b=pEI0ezBw2CLNZH9E6W3Ojn5lnnsM87ZwgfuMIWxee2keHWtibQnD81N+lvbLAc+qe
         PhpZOJcVyqPOIGAVo+1w4g8c2X4L/+CQyT2Cda9cg4ssSymrjXm1TMeUIFbEp9O/CO
         3/gfVhPleVIVYgyde5iGMAO3ptMdJ+quFONKuUCVEvTD/1k6XCwK8PM5cTluYw08gz
         OUVC8teIxYX4n1+ymiZLwXYGX39NCyRtUU9jLJfEr5J9hKhfN7mFCNrAfNQPYioJjS
         8uxjIZJ45g0zTugCnKDa6B8+LoKG/lmk05xhqb9VuoOqcd+Stg89QIXJrr7YDZY4yv
         XktgGdmRR7NXQ==
Received: from DHPWEX01.DH-ELECTRONICS.ORG (2001:470:76a7:2::30) by
 DHPWEX01.DH-ELECTRONICS.ORG (2001:470:76a7:2::30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.858.12; Wed, 14 Jul 2021 22:25:32 +0200
Received: from localhost.localdomain (172.16.51.7) by
 DHPWEX01.DH-ELECTRONICS.ORG (10.64.2.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.858.12
 via Frontend Transport; Wed, 14 Jul 2021 22:25:32 +0200
From:   Christoph Niedermaier <cniedermaier@dh-electronics.com>
To:     <devicetree@vger.kernel.org>
CC:     Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, <kernel@dh-electronics.com>,
        Fabio Estevam <festevam@denx.de>
Subject: [PATCH V3] dt-bindings: arm: fsl: Add DHCOM PicoITX and DHCOM DRC02 boards
Date:   Wed, 14 Jul 2021 22:22:52 +0200
Message-ID: <20210714202252.5898-1-cniedermaier@dh-electronics.com>
X-Mailer: git-send-email 2.11.0
X-klartext: yes
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DH electronics DHCOM PicoITX and DHCOM DRC02 boards. The DHCOM DRC02
device can only house a SOM with iMX6S and not with iMX6DL, due to some
thermal design consideration. But for compatible fsl,imx6dl is chosen,
because fsl,imx6s isn't available, the iMX6S is basically a iMX6DL with
one CPU core disabled and therefore the kernel discerns the iMX6S/iMX6DL
automatically.

Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: robh+dt@kernel.org
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: kernel@dh-electronics.com
Cc: Fabio Estevam <festevam@denx.de>
To: devicetree@vger.kernel.org
---
V2: - Remove line with fsl,imx6s on the DRC02 Board
V3: - Rework of the commit message
    - Add Fabio Estevam to the CC list
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 1c827c1954dc..6eff9e35f9a9 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -418,6 +418,12 @@ properties:
           - const: dfi,fs700e-m60
           - const: fsl,imx6dl
 
+      - description: i.MX6DL DHCOM PicoITX Board
+        items:
+          - const: dh,imx6dl-dhcom-picoitx
+          - const: dh,imx6dl-dhcom-som
+          - const: fsl,imx6dl
+
       - description: i.MX6DL Gateworks Ventana Boards
         items:
           - enum:
@@ -469,6 +475,12 @@ properties:
           - const: toradex,colibri_imx6dl          # Colibri iMX6 Module
           - const: fsl,imx6dl
 
+      - description: i.MX6S DHCOM DRC02 Board
+        items:
+          - const: dh,imx6s-dhcom-drc02
+          - const: dh,imx6s-dhcom-som
+          - const: fsl,imx6dl
+
       - description: i.MX6SL based Boards
         items:
           - enum:
-- 
2.11.0

