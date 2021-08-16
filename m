Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22AF13ECEBC
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 08:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233617AbhHPGrO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 02:47:14 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:34335 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233558AbhHPGrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 02:47:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1629096395; x=1660632395;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yFsxGY63YCvB8utk9S62cEz1WklCguNPzTa34XrLuwU=;
  b=JJNQmcQr6U21FXIdxpbmU8RctCQn2TRGos0NnaYKL91EvgzFKzzPfuPZ
   UbyaJz1S8NQy9TTbAoGb8ArErPR8pMVCPmv1TbxZbUQa7HNiQKlH97HUF
   oLZBn2lUSrxtG/ZokGOwWfLTXir0xrq1x/AHVE8vpQjczUbpPd2IbHQsD
   cP9w4gF2UHWWSCL3bikJfvYrkc7xu3U+AQsbAkUG4FoMxucX39ZEYhp0h
   fRPGqgwYz1xCCZxTzZews/cAkrwQxYoNtnZa2ou3/H0BijjTSoKMSs2qx
   OAHcSHuVFLcggcGfIBc60yibf+t78QFDK6jmuxKNCm0zwpRwLA68BmsCb
   g==;
IronPort-SDR: JtoqbsWL+cJ7sK1DWD+NVxqcGWDmvX5HBgdasW+7e7hbO3dnZF322w4dR8FBXvTi57TRTskreg
 NhTXd4Ab/hOqfsMSLDPHuLAA8z+7XBZ88xC37R5u07+lr8rt+rpDwMIq75dvcCdKCH+pjpxKFp
 O/eE820EhP6d8SAzOydSc+8evPO6uy+HH/9CjgK5YDo/Wg4Zz7Q9ZvkjSHrHE5ZxVQNFhsjrFr
 TPCaODGrzWavm1gsCNis0xlJvOn4QN693fdZVAYTNfDUCyol4dZWXRdQaje2415qLaXXm5zm+f
 4deng9hlAArZExfPtKmewfOW
X-IronPort-AV: E=Sophos;i="5.84,324,1620716400"; 
   d="scan'208";a="140220940"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Aug 2021 23:46:34 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Sun, 15 Aug 2021 23:46:34 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Sun, 15 Aug 2021 23:46:31 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>,
        <arnd@arndb.de>, <olof@lixom.net>, <soc@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v2 3/7] dt-bindings: ARM: at91: document CalAmp LMU5000 board
Date:   Mon, 16 Aug 2021 09:44:12 +0300
Message-ID: <20210816064416.1630674-4-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210816064416.1630674-1-claudiu.beznea@microchip.com>
References: <20210816064416.1630674-1-claudiu.beznea@microchip.com>
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

