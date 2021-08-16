Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A02DA3ECEC4
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 08:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233954AbhHPGr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 02:47:27 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:35787 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233715AbhHPGrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 02:47:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1629096409; x=1660632409;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+TD5GOQnMaG8+zRlR+FFVFgYC3jWTUSdaYfkn7DGXIY=;
  b=KoFdO+3I4eIUcHQ4Y5SAk9v6W5I77BPtTJZ7CK0eQJ4m3nEmoZpbmyO9
   FfiaqB43xFLwxlXX9Mh2FcgNtxbedGXe2A7LuwatARrDnFV2g6w5bNyNr
   hh3pSH2dz7RnFSxvOqgw2IPhddXC9eMC3sEDxMbv+CQNv/xjV46pELtsL
   speEd7Eiy2OzjFQDvbjBFQyv03Jm1aL/ULKBpxDZ8a4jcziAndcHtEErr
   vfuirWPTfQ+D/r53F8bTj3AX6IcpolUpHdQVt7VG4NNJoum1cQHsTpsJS
   lHyzMHAEpmbRrpejXWD7GInw6GGlXL+IMzgpGpetYrGn/L5QoTYWdn7kX
   A==;
IronPort-SDR: 5f6qOo1GKNYNXOi1pEE4Slc6alSK18UNI+2BgdfvSSzbFgqt0sQfeMSOtqabHQyjT+ixUeKWA1
 D/TMYAVZwc0YTxNuVOUs9E54sB09sh0XOMx28GJHmoEikP2/RY8FYKU8yeh+oC/UGKLtVAXUWU
 4AZLJbCu5E1AFEBv8Ru713SwKBWe0z4agRDHBk5t6xVZ6g0j+r+QK7pHCIAmHdWERdAtDpsBqV
 cUV5YXXGpBSHe7tA8C82HWmmC2OgG/VkvKOZQFmjYhU5WdBzzvL8ojn+qKLhTEGAz5juTQakhG
 MO/xoWnTDoMhP5JKtBLbbtA6
X-IronPort-AV: E=Sophos;i="5.84,324,1620716400"; 
   d="scan'208";a="125900554"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Aug 2021 23:46:48 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Sun, 15 Aug 2021 23:46:47 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Sun, 15 Aug 2021 23:46:43 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>,
        <arnd@arndb.de>, <olof@lixom.net>, <soc@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v2 6/7] dt-bindings: ARM: at91: document exegin q5xr5 board
Date:   Mon, 16 Aug 2021 09:44:15 +0300
Message-ID: <20210816064416.1630674-7-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210816064416.1630674-1-claudiu.beznea@microchip.com>
References: <20210816064416.1630674-1-claudiu.beznea@microchip.com>
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
index a9ab18510fef..08efb259a947 100644
--- a/Documentation/devicetree/bindings/arm/atmel-at91.yaml
+++ b/Documentation/devicetree/bindings/arm/atmel-at91.yaml
@@ -132,6 +132,12 @@ properties:
           - const: atmel,at91sam9g20
           - const: atmel,at91sam9
 
+      - description: Exegin Q5xR5 board
+        items:
+          - const: exegin,q5xr5
+          - const: atmel,at91sam9g20
+          - const: atmel,at91sam9
+
       - items:
           - enum:
               - atmel,sama5d31
-- 
2.25.1

