Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0270E443E9A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 09:50:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231937AbhKCIxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 04:53:13 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:44039 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231702AbhKCIxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 04:53:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1635929431; x=1667465431;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8Mc4AIkZM5qONANXtlgw3gl/ONIHDQMV9uB5c0K6dZk=;
  b=JduV/YKR0PidVoGrnscz9U+N3++CmxjTy+Yo7d+rKQLHHxxYPf8wKg6O
   0F/pOd/gOig2mqaVT4ea4xfWT1C0G67mqwFJ15zb+/2SZXfkrRragW0p5
   K/d8+Yx/qEXRT9gSjQCw7qD7vnsWYYHqIwqmZs4M3HAB66CdLLVaJVAR3
   pUO2ID0S7YsjSAIpAxqWMU+pGSrXrzr7CkitV00YABoFM8y3l58oYi87d
   qVVSENrk2fqMp4OyirLrwSg1yn26+E7RSFed5VPUmcDPZe8+dcryqDcCf
   1kq/RJrZDAG6UqeSrcM7woVUQ/Z2cMcXLsvWG1MpN4JpetNm3CB3vsI++
   w==;
IronPort-SDR: BhUdyzZdBdAPmHeGf4T30/V8cNu1/uusgQF76QfKkD1ElI+qGJhXM/TYr8OIf5wlT7FuI8VvTh
 QCA5Bx2UbnZ1BY2xrjLeR7oravDto41zVcNGW6dg8fJzKqcBzNSD4jiBFN0uoQ04+vblcDHWXI
 vONUHxLNBBabfWuU0y0nAHFAM4qyqmB6wHt9Vic/sEMyWSLvKl2PkLVUbQLkH3B+G1RRsi+R3l
 oETIjRcG+md20X0aryR6pKGvyxJpKTyizKAyWmbcWdxOVpWyA2N1DiAXjdksWW1Ti/bJbcg3pO
 vZ+dnjAD/1nSd03k/Cya4NgM
X-IronPort-AV: E=Sophos;i="5.87,205,1631602800"; 
   d="scan'208";a="150539856"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 Nov 2021 01:50:30 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 3 Nov 2021 01:50:30 -0700
Received: from soft-dev3-1.microsemi.net (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Wed, 3 Nov 2021 01:50:28 -0700
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh+dt@kernel.org>, <kavyasree.kotagiri@microchip.com>,
        <nicolas.ferre@microchip.com>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: [RFC PATCH v4 2/4] dt-bindings: clock: lan966x: Extend for clock gate support
Date:   Wed, 3 Nov 2021 09:51:00 +0100
Message-ID: <20211103085102.1656081-3-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211103085102.1656081-1-horatiu.vultur@microchip.com>
References: <20211103085102.1656081-1-horatiu.vultur@microchip.com>
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
 .../devicetree/bindings/clock/microchip,lan966x-gck.yaml     | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/clock/microchip,lan966x-gck.yaml b/Documentation/devicetree/bindings/clock/microchip,lan966x-gck.yaml
index fca83bd68e26..df2bec188706 100644
--- a/Documentation/devicetree/bindings/clock/microchip,lan966x-gck.yaml
+++ b/Documentation/devicetree/bindings/clock/microchip,lan966x-gck.yaml
@@ -19,7 +19,10 @@ properties:
     const: microchip,lan966x-gck
 
   reg:
-    maxItems: 1
+    minItems: 1
+    items:
+      - description: Generic clock registers
+      - description: Optional gate clock registers
 
   clocks:
     items:
-- 
2.33.0

