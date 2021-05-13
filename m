Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 475F437F2E1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 08:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbhEMGPU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 02:15:20 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:64751 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbhEMGPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 02:15:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1620886448; x=1652422448;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=D1JleMTnSO1ymCUdXh/+hDEDMbLr8UzAtT0hHDbs/TM=;
  b=NEIu+8Ao79PFb2o43AmGcO4Hz/y4+i2OBEUxUzt8nBeaF2HXjfDH905c
   PpY+lFgeWv2qVqulsAEPMgRXUmPS55admve4Ut/tGkstoAKG19IDA65vK
   DUrRZjQrQX6rUzlIJdtOnKHTJ7agpXMTFmQ6NPofpSwmmlpDrMpcudEzl
   mPGtq0H8ACA4mXkLhmT+fLaQlJOX0xqaVwe68mlyqfANz7IrKSLMnePRg
   tWN0A9aSsCFcTcD78uaE5camil/ucUGoDTZIPVOnQgN8FkCAwsvJc4fxV
   GzPRguOJSuOacZABh3SfP7tIf9Ws7WqI5fG/PWuDMzgjsbZWeGrUZ51J7
   w==;
IronPort-SDR: k15+ZFnGZ06hmMnNi6eCmqkxd3VbO35iPqxDzc1yiAXCcPuzX3axntASUrut/nWmA14tBEUDb+
 IEvDh9swKcQoH//8FoR7201O1yBd5+BJZ4+4D11FSzuleSnoPqkXPVQIU7yPBxEVIS4YmDoLFA
 nL7Ii4bMIt5QnplTVfshBNkrdi9ktZexI/SIR4+0JfnHGPKqw+YyOiqbUUwIiZnmHjFRXUHGiX
 oGqQTFSlpH+K2ev6SLnI7iavsnE8EGRd/HpII0TgSwya0tFGXk6jGcAyMd4LmHdTOmJz+0bq38
 7Rg=
X-IronPort-AV: E=Sophos;i="5.82,296,1613458800"; 
   d="scan'208";a="120906595"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 12 May 2021 23:14:07 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 12 May 2021 23:14:06 -0700
Received: from ROB-ULT-M18282.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Wed, 12 May 2021 23:14:02 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <robh+dt@kernel.org>, <nicolas.ferre@microchip.com>
CC:     <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>,
        <soc@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <claudiu.beznea@microchip.com>,
        <codrin.ciubotariu@microchip.com>,
        "Eugen Hristev" <eugen.hristev@microchip.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v3 1/4] dt-bindings: ARM: at91: document sama7g5ek board
Date:   Thu, 13 May 2021 09:13:51 +0300
Message-ID: <20210513061354.138158-1-eugen.hristev@microchip.com>
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

