Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FABB37A072
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 09:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbhEKHN5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 03:13:57 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:36284 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbhEKHNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 03:13:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1620717166; x=1652253166;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=D1JleMTnSO1ymCUdXh/+hDEDMbLr8UzAtT0hHDbs/TM=;
  b=j7SEgFlonMsJWksy4bEizeL9MM4E42HEQB1UQsBY1TS5VgWnLxaibhoh
   v9ikj3PaweKpTZtDU4zBEwJ25Byqjc+wgef4azVFM0C8TF3DET0ou0wT+
   UbBnFk15dvl6PtGjYww5sPadMi/iPo42UmsBvqWRagtsv2D/6LZ2wKXS7
   +ztgKNzJi9/T0mSzT72IHCIOsb5lnubvpHP5aeklPt4TiDLfVswpkZvjw
   jpMh/T7Gzw4IKb3CLqjlMjYoRy5SQryQ6eHh7LDjwgGmSnFQppeJk4GWs
   uxWj/7wxkce94xQhxNXTKPmWSTozw/0xPbZa8CoSNXtO+B/XCmn640Wzx
   g==;
IronPort-SDR: U1wcL16wsUcFPGnZ+c2LFMisb+Y0E+3rqgCPM/aSODXfWAAJ/O4hqnh6Dlb6GtSJzMV9Tem+j1
 1CG6q4BcCf3QKpF/vt89DI6OjhNOkOFRVjhzqA3w4pMNHWtGzivgmx7eHzSKGu8lqXhr2/OYFj
 hIo4blqIl91FUgYbLRQQ/jJHp3DMqadRQaH+4WCPKyCJVbroZEtisXJzEsLuNv8k85pO1s05YN
 6hI5KTz91/p0bV4V5499ZwFnJxIBNAqliTofX/2rknWbaZDAFoioMmjP7lM4Fpk8axFoMWL0SU
 ZKc=
X-IronPort-AV: E=Sophos;i="5.82,290,1613458800"; 
   d="scan'208";a="121163380"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 May 2021 00:12:39 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 11 May 2021 00:12:39 -0700
Received: from ROB-ULT-M18282.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Tue, 11 May 2021 00:12:33 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <robh+dt@kernel.org>, <nicolas.ferre@microchip.com>
CC:     <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>,
        <soc@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <claudiu.beznea@microchip.com>,
        <codrin.ciubotariu@microchip.com>,
        "Eugen Hristev" <eugen.hristev@microchip.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2 1/4] dt-bindings: ARM: at91: document sama7g5ek board
Date:   Tue, 11 May 2021 10:12:20 +0300
Message-ID: <20210511071223.71379-1-eugen.hristev@microchip.com>
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

