Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F4010380519
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 10:22:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233416AbhENIYA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 04:24:00 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:42532 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbhENIX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 04:23:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1620980567; x=1652516567;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=D1JleMTnSO1ymCUdXh/+hDEDMbLr8UzAtT0hHDbs/TM=;
  b=DKJFceLEA0cvW/Ua2ePvuXUPYjhs9ojUc5w2WIic2YBmzpGtaXau/qrG
   rxrJp5RfMa2SPsCLENlGZvUf3zP9o2LRje5dqLfHdwTXrd/bnqF0r4PQ7
   BRvOz8ywhAimOEfpiKkJuG+O689B3cRpRbR6WTGuLpl0DsJT4P0vGoR/o
   fkbrOnU2TMVnuN6kLzWbfzuPL3jSbITlHm3W783Az75iduc1gXfO8C+in
   nOdMeaE5K6n3fJs8AEkEEx5egArlXTyP9TgQVweHC7RheAQLYdzLuvGQF
   bKV8SuQCF8nQxk9Kyv+Nbwj+540JMzdPnD2DQ7f620gbicVlkK46NgpiC
   w==;
IronPort-SDR: vrn929UhSWLJK1sTs+1BY/s6IU0eQoyieGhDAPPIHf6Oc/AhXwRQDTyHZBy+Sr2QJTBXv3OP9h
 n3LPeiSYUglTw6SUUss9DGU4f25DwZ8l0+NlvobTtnWOQ05hPv1D+upBO8GVFzNJ6JIIwy6ul1
 4bUW94fksKKoMQc15Ko36ANlVDQuqmWpR5tzySYiPIY60HeM9A/lO77OxLPwapoHyyAYub5kv5
 tVhEJVAC3D2wLO9jTnYCkaCVSumfMtSjw3cAG/waJmChOShLpW5Y3aORd49sjnsCBQvms2f+/9
 Cbw=
X-IronPort-AV: E=Sophos;i="5.82,299,1613458800"; 
   d="scan'208";a="128041994"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 14 May 2021 01:22:47 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 14 May 2021 01:22:47 -0700
Received: from ROB-ULT-M18282.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Fri, 14 May 2021 01:22:44 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <robh+dt@kernel.org>, <nicolas.ferre@microchip.com>
CC:     <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>,
        <soc@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <claudiu.beznea@microchip.com>,
        <codrin.ciubotariu@microchip.com>, <tudor.ambarus@microchip.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v4 1/4] dt-bindings: ARM: at91: document sama7g5ek board
Date:   Fri, 14 May 2021 11:21:48 +0300
Message-ID: <20210514082151.178571-1-eugen.hristev@microchip.com>
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

