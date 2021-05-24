Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDE8538E671
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 14:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232591AbhEXMS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 08:18:27 -0400
Received: from mx3.securetransport.de ([116.203.31.6]:35838 "EHLO
        mx3.securetransport.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232300AbhEXMSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 08:18:23 -0400
X-Greylist: delayed 344 seconds by postgrey-1.27 at vger.kernel.org; Mon, 24 May 2021 08:18:23 EDT
Received: from mail.dh-electronics.com (business-24-134-97-169.pool2.vodafone-ip.de [24.134.97.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx3.securetransport.de (Postfix) with ESMTPSA id 1BBDF5DCCC;
        Mon, 24 May 2021 14:10:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
        s=dhelectronicscom; t=1621858253;
        bh=wR5m3pbatZZrpyCn/nOoDkXkVnEDm6B6QbUt2U8ZtSg=;
        h=From:To:CC:Subject:Date:From;
        b=OX7Q3ikXhX1h/PY/87Q64ilAZI1KuCcwlAfT+4vhspebisUl1t8F8sgnLOBJJWdWM
         rOPi4484IeyI3qTyZoIttgzLMmWNQR1HMZad9pJIvGudKzrEe5wk1dfgxvoqCpUik0
         EtXWKJAJDyTBdbJtYtA6Am61eJTXUnra3qrjXISZHQKw6DxoTKwnBmUZSl4n8r8a3w
         kAnZP1gL3eNSdypEKM7ibv0N6uqsyqpYjiVRDvlUblz4KDAyc7yuqvsWVnvB2vHYUn
         7AX6gMe/vEDqLL4ddTjQOm+WeEHkyEVUifBaLlsEMmLVIFMRH6CnmbVNSEbj24BB2O
         x9n1fNzpWcf7g==
Received: from DHPWEX01.DH-ELECTRONICS.ORG (2001:470:76a7:2::30) by
 DHPWEX01.DH-ELECTRONICS.ORG (2001:470:76a7:2::30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.858.12; Mon, 24 May 2021 14:10:37 +0200
Received: from localhost.localdomain (172.16.51.17) by
 DHPWEX01.DH-ELECTRONICS.ORG (10.64.2.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.858.12
 via Frontend Transport; Mon, 24 May 2021 14:10:37 +0200
From:   Christoph Niedermaier <cniedermaier@dh-electronics.com>
To:     <devicetree@vger.kernel.org>
CC:     Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, <kernel@dh-electronics.com>
Subject: [PATCH] dt-bindings: arm: fsl: Add DHCOM PicoITX and DHCOM DRC02 boards
Date:   Mon, 24 May 2021 14:09:17 +0200
Message-ID: <20210524120917.6573-1-cniedermaier@dh-electronics.com>
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
 Documentation/devicetree/bindings/arm/fsl.yaml | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index fce2a8670b49..afbdea078abb 100644
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
@@ -458,6 +464,13 @@ properties:
           - const: toradex,colibri_imx6dl          # Colibri iMX6 Module
           - const: fsl,imx6dl
 
+      - description: i.MX6S DHCOM DRC02 Board
+        items:
+          - const: dh,imx6s-dhcom-drc02
+          - const: dh,imx6s-dhcom-som
+          - const: fsl,imx6s
+          - const: fsl,imx6dl
+
       - description: i.MX6SL based Boards
         items:
           - enum:
-- 
2.11.0

