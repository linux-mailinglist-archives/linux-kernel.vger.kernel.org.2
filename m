Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22EAA426A0D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 13:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242943AbhJHLp5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 07:45:57 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:65436 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243468AbhJHLoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 07:44:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1633693331; x=1665229331;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=piSrfSWZYNaHQ8NaybCQJKC/qjLwORsGAJLYIc8A40A=;
  b=p1/RLsGJ+FgqksIN9o3msi+jYGcKXdGt2BzR7SPm6hrTV5kC1D4ImWWH
   WU+xN8GiKtMrEj5EGjyO2QSrWkZJPgczNfnEFkwXsCF1W/EjJNl3TGEhd
   nav4icwwEiZ2K3WjyDvR/NzBD1kos0WuijLDLV2xmDRgD+qAjJTTnCzyo
   4p9W8BDiZyF8yw7l29opn6i/XmU1/VFGsoKLrGmtOa1+qUk+TlNKaBUr/
   iLqdXZIf6pHu+rM05F3y+PNUc7S6IZ83KVLsHF7staV4JLJSeJYwOPhKi
   dW3yQ5YDQ4Cl684Ve2wYN2NiYDZz9ONSp2sPeA78MtoZNrSqnGEyE2mdJ
   A==;
IronPort-SDR: pcvvAKGcyIUnHpsYCt1fzTxUb+OY/Nn+vqps41DgbER3xhrlIK1FCyA4JcQmW5/Ysx41X+YZ8G
 oBtBtNdlC74stfcMBKAyMN8EjGG2RUFl3xO+vOCqiJt5fKSwptjtOsrWERWMytITDN98PfVvdY
 ZqaPHJeK+SMJzJkpq5YeWupQ5kiYQdW6Ziqp5TZ29bpVysOT7dRtHHv4az3PT6IicjEE8hQjqc
 LdZvA+UTVMMgg18ZlqH9jpaiKxFoLdjnczikcbsgcW2OHR0jnGKG0fOV3bgppz2pUSmGVxwcEt
 EX+cESWDzz5dcB3NTGQ3qvGA
X-IronPort-AV: E=Sophos;i="5.85,357,1624345200"; 
   d="scan'208";a="147282310"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Oct 2021 04:42:10 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 8 Oct 2021 04:42:10 -0700
Received: from soft-dev3-1.microsemi.net (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Fri, 8 Oct 2021 04:42:08 -0700
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     <p.zabel@pengutronix.de>, <robh+dt@kernel.org>,
        <lars.povlsen@microchip.com>, <Steen.Hegelund@microchip.com>,
        <UNGLinuxDriver@microchip.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: [PATCH 1/2] dt-bindings: reset: Add lan966x support
Date:   Fri, 8 Oct 2021 13:43:29 +0200
Message-ID: <20211008114330.1328713-2-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211008114330.1328713-1-horatiu.vultur@microchip.com>
References: <20211008114330.1328713-1-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds support for lan966x.

Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 .../devicetree/bindings/reset/microchip,rst.yaml       | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/reset/microchip,rst.yaml b/Documentation/devicetree/bindings/reset/microchip,rst.yaml
index 370579aeeca1..ab7d9cb25b3f 100644
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
@@ -37,6 +41,10 @@ properties:
     $ref: "/schemas/types.yaml#/definitions/phandle"
     description: syscon used to access CPU reset
 
+  cuphy-syscon:
+    $ref: "/schemas/types.yaml#/definitions/phandle"
+    description: syscon used to access CuPHY
+
 required:
   - compatible
   - reg
-- 
2.33.0

