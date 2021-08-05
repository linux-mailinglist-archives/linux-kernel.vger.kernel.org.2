Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64A103E18F2
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 17:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242862AbhHEP5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 11:57:51 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:35531 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242843AbhHEP5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 11:57:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1628179052; x=1659715052;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=u/FP3J42Jj1CUvIWoJWdIAW76KXzDQA0eBIvNVlOqIE=;
  b=XKkrp5ypFIR33gweECBG0OVs/xDwV5i9D2mBTZCcAvNaryG7175fpDk4
   r3NN/luYr5loixwTEJdFYg/NVvzMX+GyXT0ouz6g6+q1NF9aQPD+/gQsV
   p5FmyLtE2CXX/nZtDXbElP11m2Ihjik6umRHDJzjW0CS41FNwfU1ybCow
   fWzQPhV96ZOmqac4C24mMqg2tLxoXPW5WjSnBa1Za8Drv7uMCtR+knw8n
   7SZzOmrh/x8D58Dnepb9bLqP1tFoW0vLFQTmEv2qC1P1KRWWsI+qwzps3
   IsRp3VC/xMypD1ZDyHJ6yZJVv9goVftiUU29LO0kfizNrkoRHpIRHb8oJ
   Q==;
IronPort-SDR: GFZkV5EpqrR5KXm+N4PxVSN3Hm3IcViz9wPbaaqGcP86AuZzQ4IgoW/4ONmO2UDDTx9pg50uGe
 9IIyV3Q46POSvliV4f8TBnlQny0CRw0Mw2SLbHYG3TSUbq1wjLvWu9BTJBFDgkXhPYhA9n9MgI
 uShU7AZOkGz70phMI3hnSf2d42oP/O32wmgNHp+v10m1EpqHm6k+vTobAQdvaOtDpS4HCGkxuw
 sAW62dqK2GBxzmrmadn72nm1lShNs6dHTiarfmJjN3zJ5adNPaynDZHNfCScmkdiqP0Spz2vl4
 31p2FcS7LSRrM0xdIkfA8yWf
X-IronPort-AV: E=Sophos;i="5.84,296,1620716400"; 
   d="scan'208";a="131188594"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 Aug 2021 08:57:31 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 5 Aug 2021 08:57:30 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Thu, 5 Aug 2021 08:57:27 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>,
        <arnd@arndb.de>, <olof@lixom.net>, <soc@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 6/7] dt-bindings: ARM: at91: document CalAmp LMU5000 board
Date:   Thu, 5 Aug 2021 18:53:56 +0300
Message-ID: <20210805155357.594414-7-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210805155357.594414-1-claudiu.beznea@microchip.com>
References: <20210805155357.594414-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document CalAmp LMU5000.

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

