Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A36A38E66F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 14:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232410AbhEXMSY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 08:18:24 -0400
Received: from mx4.securetransport.de ([178.254.6.145]:38358 "EHLO
        mx4.securetransport.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231969AbhEXMSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 08:18:23 -0400
Received: from mail.dh-electronics.com (business-24-134-97-169.pool2.vodafone-ip.de [24.134.97.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx4.securetransport.de (Postfix) with ESMTPSA id E1DCF7201B1;
        Mon, 24 May 2021 14:06:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
        s=dhelectronicscom; t=1621857996;
        bh=wR5m3pbatZZrpyCn/nOoDkXkVnEDm6B6QbUt2U8ZtSg=;
        h=From:To:CC:Subject:Date:From;
        b=I9+Ag5vNUCUoxN86CTAct3CHfhcRWsNNqpk9bHHzw8eQGfyZHYbbHcrG0yJ/8nJp3
         l0RD5enyyQjNsRgMeGPkuXvUxo6thgJYozXkedSYDo1ya9bANaeBQqPh6uZhwyqQmi
         1aQV4+tQsRbN+AEb+yAvlqPXm88H6P+OX8wawaAACivHqgBNKIDE81PFF704x5rPpB
         r4xrM/UahyoJgvwvcDRgl2TLTDI1zGwdao39k6I4N/9Y3MhVEdicDGZDmoe/9UFFvb
         tbLWbRXBzK4m773NAXel/rlqoDlf9G/TnLI7SmG6NI28vJkj0oqdWiiwZqx2ceRGKl
         DmClmLiP2AfUw==
Received: from DHPWEX01.DH-ELECTRONICS.ORG (2001:470:76a7:2::30) by
 DHPWEX01.DH-ELECTRONICS.ORG (2001:470:76a7:2::30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.858.12; Mon, 24 May 2021 14:06:24 +0200
Received: from localhost.localdomain (172.16.51.17) by
 DHPWEX01.DH-ELECTRONICS.ORG (10.64.2.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.858.12
 via Frontend Transport; Mon, 24 May 2021 14:06:23 +0200
From:   Christoph Niedermaier <cniedermaier@dh-electronics.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        <linux-arm-kernel@lists.infradead.org>, <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, <kernel@dh-electronics.com>
Subject: [PATCH] dt-bindings: arm: fsl: Add DHCOM PicoITX and DHCOM DRC02 boards
Date:   Mon, 24 May 2021 14:03:52 +0200
Message-ID: <20210524120352.6475-1-cniedermaier@dh-electronics.com>
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

