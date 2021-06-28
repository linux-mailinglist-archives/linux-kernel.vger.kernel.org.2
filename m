Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44EDD3B5D89
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 14:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232854AbhF1MHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 08:07:45 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:27197 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232648AbhF1MHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 08:07:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1624881916; x=1656417916;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=D1JleMTnSO1ymCUdXh/+hDEDMbLr8UzAtT0hHDbs/TM=;
  b=ZJ6Os/bUn7Z4tajL1Ma9md2py+wKi3Yc2ceyoxIDsyibtHh4zaWdUQJX
   fBl3ujjFeq0T1OFAp9dRKqjLRiArJF1vDRWkYO06DXIu+grkJiNIsE9Im
   TLj3XEZY76uXr0Ip97965Sz+xi/WGb8qu2xzlKN2NOnD6ot/+uLhygHwR
   H+7v6SjfZc5bSrW73vH/9PyjH9PQ1ee2WKGPEGcBqv8t2Z+WqAi3RC4+S
   OSURo89MJd41HIjf2QgT2W4X6rd3CKmzvkyxykg0nbhr2y/g5EzqPomCH
   u4Us3P/1LTDh/eyuQcx0H33phRVdbIbyQfqRnb/n7I979EWLwVQD3g8QU
   w==;
IronPort-SDR: uwNKe2ztjzkSoZGpMhZPcQBzKONsvPI90wvwmw83jXzu6M4nMLglu7agH0C9ywbvwzXPyenmqn
 jaAJDFCBZXLTazW1z4CaUNSnTS9mc17nEmgYkjq4GhCOGI4A0ld6xftoTTomhKb7Yr76eW1yqO
 DMCPDQORGogJG0SVGNDwIDPQu2RP/GuF+we9bFiaFMtNEFSL4Qnxp44ez8o0ML8xcBYM4kph2s
 QBxxDohXTRE1jZjiwkNDFc1VF/Xi+uklkp56P2AFv2IfVIz6T5uVadpo7PsSm12dZfsCDFB+w7
 ZqA=
X-IronPort-AV: E=Sophos;i="5.83,305,1616482800"; 
   d="scan'208";a="120256120"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Jun 2021 05:05:13 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 28 Jun 2021 05:05:14 -0700
Received: from ROB-ULT-M18282.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Mon, 28 Jun 2021 05:05:11 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <nicolas.ferre@microchip.com>, <robh+dt@kernel.org>
CC:     <alexandre.belloni@bootlin.com>, <soc@kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <ludovic.desroches@microchip.com>,
        <claudiu.beznea@microchip.com>, <codrin.ciubotariu@microchip.com>,
        "Eugen Hristev" <eugen.hristev@microchip.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v5 1/4] dt-bindings: ARM: at91: document sama7g5ek board
Date:   Mon, 28 Jun 2021 15:04:49 +0300
Message-ID: <20210628120452.74408-1-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the SAMA7G5 Evaluation Kit based on sama7g5 SoC.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
 Documentation/devicetree/bindings/arm/atmel-at91.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/atmel-at91.yaml b/Documentation/devicetree/bindings/arm/atmel-at91.yaml
index 6fc5a22ad962..fba071b9af1d 100644
--- a/Documentation/devicetree/bindings/arm/atmel-at91.yaml
+++ b/Documentation/devicetree/bindings/arm/atmel-at91.yaml
@@ -145,6 +145,11 @@ properties:
           - const: atmel,sama5d4
           - const: atmel,sama5
 
+      - items:
+          - const: microchip,sama7g5ek # SAMA7G5 Evaluation Kit
+          - const: microchip,sama7g5
+          - const: microchip,sama7
+
       - items:
           - enum:
               - atmel,sams70j19
-- 
2.25.1

