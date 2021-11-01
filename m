Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E83F441500
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 09:07:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231489AbhKAIKD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 04:10:03 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:62892 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231486AbhKAIKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 04:10:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1635754048; x=1667290048;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aZmHkkZf73KvGooq49A6E2ZVCnfxaS3fQI/Km25LJkI=;
  b=m3xSd3y53P3i7qT7UoF7qv1zyr7fomkJTWG+m+F5WIghZ+ss6825WeWn
   zqkdH3NCQAWLmPvL0kJ4w3V/rcRzY4wPvrd57MtYZ1s7O9DEOOOpGBXLy
   m0uD467bNyyeF6v80KXXXS7EHQuAxnzBBuAKMB+rIZY1eg9xexh5aOTaF
   EoPtslTPeF7u1WnMZrpPznVpfHpWqDiqRIJg8lbeEWpNuqSiAZes/BmMO
   qTZdJB+WbxBFzBZufiobicEXDhGqFzBCUKg0mobA+0s67+cI3ZFp0GboE
   9MKjl5gV8TIPbKzu08H7CZpvRqpU9nlwFP2RJkgWx+TiWboAB+EyLmB4Y
   A==;
IronPort-SDR: GUdC4fWoOP0Cb1OxUGiGn1hFyh6Y0zfMFRLhd9/rAcuYU1lMkLGvE7V1Hun6hTxav+aI25aWuw
 WtnQRi/U07/ocp4B9XUWmXJtaiB9lKUi+/y0TaluBHFwiy2HaHUvk0ncCosjrtgLzbNdhLSPeC
 4kARxbBObzOw9QhEBGrLCWlLVy9itmm+qAG25GgdUlTtrau1nr1i3b+FyONKOyVqMlOTIbi55W
 M60atTlhES8pWJJ4gYhIbaDCtkP7yUoWBTC8TEg5cc1zAVZt2C96OSLs5Y4CUSztNM1k0SC61R
 fyGSTnb6YqxTqs8hVxSMBRzZ
X-IronPort-AV: E=Sophos;i="5.87,198,1631602800"; 
   d="scan'208";a="137558396"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Nov 2021 01:07:27 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 1 Nov 2021 01:07:27 -0700
Received: from soft-dev3-1.microsemi.net (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Mon, 1 Nov 2021 01:07:25 -0700
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh+dt@kernel.org>, <nicolas.ferre@microchip.com>,
        <kavyasree.kotagiri@microchip.com>, <eugen.hristev@microchip.com>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: [RFC PATCH v3 2/4] dt-bindings: clock: lan966x: Extend for clock gate support
Date:   Mon, 1 Nov 2021 09:08:43 +0100
Message-ID: <20211101080845.3343836-3-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211101080845.3343836-1-horatiu.vultur@microchip.com>
References: <20211101080845.3343836-1-horatiu.vultur@microchip.com>
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

