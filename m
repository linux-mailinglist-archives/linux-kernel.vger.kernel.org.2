Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4F04433180
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 10:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234780AbhJSItD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 04:49:03 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:58236 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbhJSItA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 04:49:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1634633207; x=1666169207;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BtLsDtl4QQydHeks4hNGCZXUEQEYW7NJ27WOZcxg0w0=;
  b=IbWJskhNCPvYG8Fk/ko6Ec1fWhwbMf/sZ+zVkFJWVZpRaZB+NvabN4wO
   hTTOXnydWhELQJcmWyjutyi0FwFk0LNg/EoZcBNrsOEjfiTm0vdlmBJ5H
   Ekdh8FnBuImOWxK4azEdjstwYEb5Lva8SBcsaMtjyaYRyvQWRU2E9QswI
   oBIi8kPqrGReGbN2Kg0rAD+8aX2UqcWI9bmo5bRMzp1257hYb3nbTlJ2l
   0c7AIjJCCw+stzkQ9ygh0Ry7DApmq0LfFU/ZBLxuznYHp9/EHDQEY3MEl
   QaOk38on/ZgbthcNuzdd5RqB8SLbBHJc8vlR/tsgxT0sKzLDYfJRJ0IFM
   w==;
IronPort-SDR: WRN/CC0W70Wos9hAIyRY7bb1NlrezDYVnAspt1lBA+D6PbHDLr3dBvP7AGQChFDEda0F4cNolv
 i9UM/3NrGDzkQscZgm6SBNNeG+fePoZPCPqYIZW1CkvO2RN3q0i4EYFxpMq4sBB3A+IRNIPlx2
 XvJHX/itE22QJMY4qg0TEqptuWgxGQZhJKg5PeJ/PND8t84PglCY730RN8jHMbi1sdAmZWypDb
 bZb6H19M2xaJS6NF/su7HBwqPOfIFsrIS6F9RGwUkEjJXScHiBuLCjd0ckJLIMouIkTunJVdy6
 kDaqfOwVai4MOXP11a4QSFtO
X-IronPort-AV: E=Sophos;i="5.85,383,1624345200"; 
   d="scan'208";a="133556978"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 Oct 2021 01:46:47 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 19 Oct 2021 01:46:47 -0700
Received: from soft-dev3-1.microsemi.net (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 19 Oct 2021 01:46:45 -0700
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>, <robh+dt@kernel.org>
CC:     <nicolas.ferre@microchip.com>, <kavyasree.kotagiri@microchip.com>,
        <eugen.hristev@microchip.com>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: [RFC PATCH 1/3] dt-bindings: clock: lan966x: Extend for clock gate support
Date:   Tue, 19 Oct 2021 10:44:47 +0200
Message-ID: <20211019084449.1411060-2-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211019084449.1411060-1-horatiu.vultur@microchip.com>
References: <20211019084449.1411060-1-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is required to add a new resource to be able to access the clock gate
registers. Now that we have 2 resources, add also reg-names property to
make more clear.

Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 .../bindings/clock/microchip,lan966x-gck.yaml       | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/microchip,lan966x-gck.yaml b/Documentation/devicetree/bindings/clock/microchip,lan966x-gck.yaml
index fca83bd68e26..047c77e049f1 100644
--- a/Documentation/devicetree/bindings/clock/microchip,lan966x-gck.yaml
+++ b/Documentation/devicetree/bindings/clock/microchip,lan966x-gck.yaml
@@ -19,7 +19,14 @@ properties:
     const: microchip,lan966x-gck
 
   reg:
-    maxItems: 1
+    items:
+      - description: core registers
+      - description: gate registers
+
+  reg-names:
+    items:
+      - const: core
+      - const: gate
 
   clocks:
     items:
@@ -39,6 +46,7 @@ properties:
 required:
   - compatible
   - reg
+  - reg-names
   - clocks
   - clock-names
   - '#clock-cells'
@@ -52,6 +60,7 @@ examples:
         #clock-cells = <1>;
         clocks = <&cpu_clk>, <&ddr_clk>, <&sys_clk>;
         clock-names = "cpu", "ddr", "sys";
-        reg = <0xe00c00a8 0x38>;
+        reg = <0xe00c00a8 0x38>, <0xe00c02cc 0x4>;
+        reg-names = "core", "gate";
     };
 ...
-- 
2.33.0

