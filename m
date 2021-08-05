Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BED7D3E18EA
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 17:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242818AbhHEP5Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 11:57:24 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:33136 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242754AbhHEP5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 11:57:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1628179015; x=1659715015;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ba3PMiW36nZ+DW3AnbgSVLgStmXrbfUqHhLyUQwshzg=;
  b=TdjJ/XtHfCvlYBLotvXQ9+gdaG2vIjgV0IKaXe06Zo+hM1e/5FdMjZ6V
   0Kq9w+lI9lrnEB5fdosWV012rSgc7tZXCVzRS4fKQajvyehV3v6aaXyGg
   LCvZOco4sFI/HyCFKJceBTCGfTYRqE9u8gInEEMl3IdFT9CpVnNrs9sRA
   7gdfiLuN5GxK/x6hsnssL5J3ttP9MVCX2P0yj/jYbPwsTmZorFD6c8eXY
   ysk1cxGKFtRUf/sm0PpiOB4T94n3EbJZhLUxGk9WcjBQo+oEvTaeX3Hut
   xGHCzaAxz1GrVbP552PQABb+FdNNfFbbDGt7IKmoP79hosnpCU0LijpXq
   Q==;
IronPort-SDR: smDePm7d2kBBMXYpxVzF4KURZX+MRqBWV9nvdX7urDDOe1i9XVGnpG5DETiyH4tNGQwStfeTdJ
 2iuGCVs1A0Bwjoq8xcusoA04aGQlTz/H81icsuECqVqiA6W1eZjFn3sDfy6VkYqLo2Lz8Vt+Bv
 j/ZtVjEZ0B4A11Vg7aDH/SGboGbnFQ0bH8HCsDa+5zFUx9Alnm19Kb9b+cCrgUh1An92Y3IsLq
 E6bBOY9wyzc4q5Vghd1OCV0U1638QVwIaIPAYu6s3wgSopk5jkVhpmII/VqDVOP5bX5tr5t/ZD
 1z06RoOqasVl/MHEsS/0NE3N
X-IronPort-AV: E=Sophos;i="5.84,296,1620716400"; 
   d="scan'208";a="124734202"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 Aug 2021 08:56:54 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 5 Aug 2021 08:56:54 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Thu, 5 Aug 2021 08:56:32 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>,
        <arnd@arndb.de>, <olof@lixom.net>, <soc@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 3/7] dt-bindings: ARM: at91: document exegin q5xr5 board
Date:   Thu, 5 Aug 2021 18:53:53 +0300
Message-ID: <20210805155357.594414-4-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210805155357.594414-1-claudiu.beznea@microchip.com>
References: <20210805155357.594414-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document Exegin Q5xR5 board.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 Documentation/devicetree/bindings/arm/atmel-at91.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/atmel-at91.yaml b/Documentation/devicetree/bindings/arm/atmel-at91.yaml
index fba071b9af1d..a9ab18510fef 100644
--- a/Documentation/devicetree/bindings/arm/atmel-at91.yaml
+++ b/Documentation/devicetree/bindings/arm/atmel-at91.yaml
@@ -126,6 +126,12 @@ properties:
           - const: atmel,sama5d3
           - const: atmel,sama5
 
+      - description: CalAmp LMU5000 board
+        items:
+          - const: calamp,lmu5000
+          - const: atmel,at91sam9g20
+          - const: atmel,at91sam9
+
       - items:
           - enum:
               - atmel,sama5d31
-- 
2.25.1

