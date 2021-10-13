Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 057A242B94A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 09:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238551AbhJMHir (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 03:38:47 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:41383 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238540AbhJMHiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 03:38:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1634110603; x=1665646603;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=r/j05pZT6RVtypcAy9TGjXr8UI+4Pvzm+ooFWOQ52Ng=;
  b=JZc3znmbNjUo91qD1+3F/GrpHeZLCOjyda0mHtsYXVDpB8H76bSdycuv
   kUoKkR+sis9mmPUFxlM7yv6cSo4gU/vLZ58ClRA4vShKZg+c2f4g8BhWc
   zv6Ih1+RTipSorcYLmgk0EHKP6fNbt9TroidYEaFhT7RMT8Answ1J/p3s
   Vehcme3ORvkmLJiiW1WU0gxii8bOpsDtt0HcDiZEfZcyMbeG0BO67RohJ
   T6esVrIZrOZus2xo1yeAQQyK28RsJt/Qt9kgBQDdXVC8a3MW6tQb8sFXO
   3gTyKxdyHXjcgms8PcmH1UCpuDI7pLY6tOL1PZul9XWloY2pSM12PGt2j
   Q==;
IronPort-SDR: qd0kPh4MO17ds07qa7Ex8ovF4mNtR686zy4ZsRPkpQBP3eqQqHvBXuEtV3rxASCx853sz4lrgk
 uRKG+2/9Kto/O6FYIAPIQdZ4t2XTNaB4mpev9KPE85PG3rogSD++OAUl2ZZiXGn6vp3J4QbLRG
 DQ2R+mFMu+WiQiPvpzWRrvLjO3IMeYcs/XqNZmep24FMPvuSCMMVbTs4mr1JH4W7JBwu/sGeTV
 /TSOYd+TD4hL5vLYxGAUyoBkPFnC/RTVCdWYd1w1H67zXSk77Gy1+hYk83ytaLee0UikspwvGU
 iznDUzQ/oa9bC5R5+BLnLTzH
X-IronPort-AV: E=Sophos;i="5.85,369,1624345200"; 
   d="scan'208";a="147898400"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Oct 2021 00:36:42 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 13 Oct 2021 00:36:42 -0700
Received: from soft-dev3-1.microsemi.net (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Wed, 13 Oct 2021 00:36:40 -0700
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     <p.zabel@pengutronix.de>, <robh+dt@kernel.org>, <andrew@lunn.ch>,
        <lars.povlsen@microchip.com>, <Steen.Hegelund@microchip.com>,
        <UNGLinuxDriver@microchip.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: [PATCH v3 1/2] dt-bindings: reset: Add lan966x support
Date:   Wed, 13 Oct 2021 09:38:06 +0200
Message-ID: <20211013073807.2282230-2-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211013073807.2282230-1-horatiu.vultur@microchip.com>
References: <20211013073807.2282230-1-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds support for lan966x.

Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 .../devicetree/bindings/reset/microchip,rst.yaml   | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/reset/microchip,rst.yaml b/Documentation/devicetree/bindings/reset/microchip,rst.yaml
index 370579aeeca1..fb170ed2c57a 100644
--- a/Documentation/devicetree/bindings/reset/microchip,rst.yaml
+++ b/Documentation/devicetree/bindings/reset/microchip,rst.yaml
@@ -20,7 +20,11 @@ properties:
     pattern: "^reset-controller@[0-9a-f]+$"
 
   compatible:
-    const: microchip,sparx5-switch-reset
+    oneOf:
+      - items:
+          - const: microchip,sparx5-switch-reset
+      - items:
+          - const: microchip,lan966x-switch-reset
 
   reg:
     items:
@@ -37,6 +41,14 @@ properties:
     $ref: "/schemas/types.yaml#/definitions/phandle"
     description: syscon used to access CPU reset
 
+  cuphy-syscon:
+    $ref: "/schemas/types.yaml#/definitions/phandle"
+    description: syscon used to access CuPHY
+
+  phy-reset-gpios:
+    description: used for release of reset of the external PHY
+    maxItems: 1
+
 required:
   - compatible
   - reg
-- 
2.33.0

