Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7610843FC33
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 14:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231638AbhJ2MWz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 08:22:55 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:49353 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231561AbhJ2MWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 08:22:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1635510024; x=1667046024;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aZmHkkZf73KvGooq49A6E2ZVCnfxaS3fQI/Km25LJkI=;
  b=NRAEbNufqftn173LjVQTvnX8pBVb5+TVVRlHJLGvNpviL++ORCmqgPbD
   dOnq9m5qz1ZCkwBWiurJV8YCFXzQXMxyy1b/5Zu4cFG5Yhb3VGEbxi8Ki
   ETxw1G7RxuJO7GEBZuEwZKq3BV9b6go2NGtyA2TyTTOVMf27W+80Bm999
   HF6lEd1Ia6yAgJfxApu/2+sD4Sbpfi19mTxKZG1Q7t1bljQmsoxItK9yK
   SqaRNN55+W2cRfRcAzWAcL5yVc2a+csG/IJLylhKmSWjXUjk1lOxSG77V
   BwkAlOCBJAqq71D3QQwJdXTA5E2poD/vx+bE6T/P+cdTvOA792G3AEqBE
   Q==;
IronPort-SDR: 1ien5sVSzYc86owCKGQTiGsAS/bZt9DEoj+kA48B+QT4WtmcJ11Qdq3+e7GhaFM58Mg+SX9V1W
 Xbyt7WH0VdY0iFWeKfJx8O4JZMWkLhMVkL+lcFkYgPl10G92q6HCvr+H+1EbUKaUsfd6+ViLJB
 wQtcQs4Vy9ihDun7kLzRNnVENz+Flf2hPpKCcXMiNcwFxIbvI2u9pVTT91LPRzkxdgNwIkm/HH
 AI3HEPSLiAuu+EymAYrIpmNU8JvuFS1/zU5Bxt5PHBk4grduueq6O19P7p5ZmNgTvMB+XmKURe
 CE8qJF4c6WDxQ72FZpoHQBcT
X-IronPort-AV: E=Sophos;i="5.87,192,1631602800"; 
   d="scan'208";a="134789059"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Oct 2021 05:20:22 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 29 Oct 2021 05:20:22 -0700
Received: from soft-dev3-1.microsemi.net (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Fri, 29 Oct 2021 05:20:20 -0700
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh+dt@kernel.org>, <nicolas.ferre@microchip.com>,
        <kavyasree.kotagiri@microchip.com>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: [RFC PATCH v2 1/3] dt-bindings: clock: lan966x: Extend for clock gate support
Date:   Fri, 29 Oct 2021 14:19:27 +0200
Message-ID: <20211029121929.2811811-2-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211029121929.2811811-1-horatiu.vultur@microchip.com>
References: <20211029121929.2811811-1-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow to add an optional resource to be able to access the clock gate
registers.

Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 .../devicetree/bindings/clock/microchip,lan966x-gck.yaml       | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/clock/microchip,lan966x-gck.yaml b/Documentation/devicetree/bindings/clock/microchip,lan966x-gck.yaml
index fca83bd68e26..a53c889629da 100644
--- a/Documentation/devicetree/bindings/clock/microchip,lan966x-gck.yaml
+++ b/Documentation/devicetree/bindings/clock/microchip,lan966x-gck.yaml
@@ -19,7 +19,8 @@ properties:
     const: microchip,lan966x-gck
 
   reg:
-    maxItems: 1
+    minItems: 1
+    maxItems: 2
 
   clocks:
     items:
-- 
2.33.0

