Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB6D53903F6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 16:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233985AbhEYOeB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 10:34:01 -0400
Received: from mx4.securetransport.de ([178.254.6.145]:50860 "EHLO
        mx4.securetransport.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233956AbhEYOdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 10:33:54 -0400
Received: from mail.dh-electronics.com (business-24-134-97-169.pool2.vodafone-ip.de [24.134.97.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx4.securetransport.de (Postfix) with ESMTPSA id D37C5720099;
        Tue, 25 May 2021 16:31:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
        s=dhelectronicscom; t=1621953120;
        bh=leIHsw5pYE+E9JkKXRTt82KXzvlrjcOFUWzLZWwxUBE=;
        h=From:To:CC:Subject:Date:From;
        b=Sd45jOzRAss9Grz3AQ1dJb2YQ2V5OPMgPQxvD3KzV1SCgTkoFnA8ZxQkZoUYkco+V
         JRSkvMeIzVwrBWT+KvUR7a+0/c7X6WoFZhGm3mo62LksvhX2R4rfUYGJem3+3fu3Mk
         c7hOPML0tF3si2nNmJtoAEg7K26O/GUCsY8ZGx5F4NIihh4R1Sr617tbS5eBYLeUEv
         zwkav+Snev04UuT5tXsMTKNNqt+pToxI4cQqjRJ1Hp/+a+4A4s3ll5iVcynuTsNy1W
         GnMlYUSlxl2vwmAGraaRhXO1bZ0JMD/25++4SU2QAt2I9iFlCuvLDPS+oC3YWV3yyB
         PF3RvCOnpwdew==
Received: from DHPWEX01.DH-ELECTRONICS.ORG (2001:470:76a7:2::30) by
 DHPWEX01.DH-ELECTRONICS.ORG (2001:470:76a7:2::30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.858.12; Tue, 25 May 2021 16:31:47 +0200
Received: from localhost.localdomain (172.16.51.17) by
 DHPWEX01.DH-ELECTRONICS.ORG (10.64.2.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.858.12
 via Frontend Transport; Tue, 25 May 2021 16:31:46 +0200
From:   Christoph Niedermaier <cniedermaier@dh-electronics.com>
To:     <devicetree@vger.kernel.org>
CC:     Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, <kernel@dh-electronics.com>
Subject: [PATCH V2] dt-bindings: arm: fsl: Add DHCOM PicoITX and DHCOM DRC02 boards
Date:   Tue, 25 May 2021 16:30:01 +0200
Message-ID: <20210525143001.9298-1-cniedermaier@dh-electronics.com>
X-Mailer: git-send-email 2.11.0
X-klartext: yes
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DH electronics DHCOM PicoITX and DHCOM DRC02 boards.

Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: robh+dt@kernel.org
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: kernel@dh-electronics.com
To: devicetree@vger.kernel.org
---
V2: Remove line with fsl,imx6s on the DRC02 Board
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index fce2a8670b49..3c4ff79a3be7 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -407,6 +407,12 @@ properties:
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
@@ -458,6 +464,12 @@ properties:
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

