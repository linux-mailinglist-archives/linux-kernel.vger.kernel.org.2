Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A12C3767E5
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 17:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236420AbhEGP2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 11:28:22 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:26374 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231540AbhEGP2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 11:28:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1620401242; x=1651937242;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=pTkesFyIpyVjzbe9acZLbxNURxPk51YCjjVT18Qv9e4=;
  b=G8qLmzplWUiaQX1iUTnUozpe5W0h+xh8dymxNB3AeYbxljS4isCxsuD8
   ig6e5C0YUIZmjRBEBMKlK5Sxc9nsnWh8ac1JNGu49VXoagLrMwZO+IDEE
   hLFcwQjJcX6OVWXmLoNSZ0HARxkgZ20ABhatwr5DSkYdVLr1/7hz4CnkC
   AT0r7SCk0o7mZ8dNkOwxHQJD2mE/qzTdigARd6t4ikoPYAJn0LvQdD7IY
   Ee2tW4QRU0s8K1U6in4hH9tF4d4O7sQr85FjSDMHebe7yEQJKzM7DX3tX
   AZVvo99VXvlNrRbJ1IswBaND+elOpACBwOokPIf2pdD6iGgEffX6R6TsF
   g==;
IronPort-SDR: RAcbIj8AgNfwgWnESOIzDLR23C2fnPVbi/fLcbsqfmriWVuQr6u2h4dyO0KVEnM9T043Nyj8sX
 KFcMzU7cpMSudF+oX3MVCSpCsMHHCNiGOmV6aGgihZ6tqtKqWvFEk9aPOMpV/2kJgU5hNNqztY
 6Ns26dFGYPV+Pnyy026zTbLytbXes6W+iLJuEKJoaDP/NQepwwpkTMHdAQLI/8IE2q6pRaFusv
 gGtSjgqL9Tx5sF2v47Dp4CIOqadP6ydF14oezJi8BhtBZRqPo+EM3ikVxiRCLpt7s46rP4T4iv
 Y8M=
X-IronPort-AV: E=Sophos;i="5.82,281,1613458800"; 
   d="scan'208";a="119335494"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 May 2021 08:27:21 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 7 May 2021 08:27:20 -0700
Received: from ROB-ULT-M18282.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Fri, 7 May 2021 08:27:16 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <robh+dt@kernel.org>, <nicolas.ferre@microchip.com>
CC:     <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>,
        <soc@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <claudiu.beznea@microchip.com>,
        <codrin.ciubotariu@microchip.com>,
        "Eugen Hristev" <eugen.hristev@microchip.com>
Subject: [PATCH 1/4] dt-bindings: ARM: at91: document sama7g5ek board
Date:   Fri, 7 May 2021 18:26:52 +0300
Message-ID: <20210507152655.182558-1-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the SAMA7G5 Evaluation Kit based on sama7g5 SoC.

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

