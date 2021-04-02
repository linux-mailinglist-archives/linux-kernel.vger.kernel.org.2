Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46FB2352DF9
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 19:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235667AbhDBRBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 13:01:52 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:12403 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbhDBRBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 13:01:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1617382910; x=1648918910;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wnn/4GDKS6xCaUhSPQqycRexKj5vTxduSlVAt/wTHXQ=;
  b=q9/0JAWe3nafhJgdEkdKXdGroWqyv9nt4dLerjO19gPPvne1KCmiA/ZP
   zCdMoaZqA6OuTD5ilcU4Ypce5fwsmlNl1dYf+2BGxBJdFxLrFZ+oLlntd
   v7aPyILZ553Em9Qc33cL2pB2o6ejj5gOUB8LtDj3//gKcLkaHUY/fUP1e
   QdqQ3iOChPLAUXuid5MMQQd1MG8MbO4xl6w0z4QJUSW5lkHNVggCg2hbS
   l0pcQSJpKcZQHm+7SK+xkRGILPapRYrpW1mfnYiYX2AOOm/YMlEmuc1t1
   GvjwAF9u56ZkZIvO4Ckh7Rhma1KzfXRzcQZ9ApAzJJQt9YO6x8FYrcN05
   Q==;
IronPort-SDR: sIcJ3pWnvRD/sHOnKlsT4EuBfPA7ourfNGpo/bfvmskJ8ixA3obcrAkIJsemgYUmzcMpCZO8PG
 rUSpG3FWAe+3eiVzVrwZ1R9LrXzC+CL1C4zM8Dcja4Jy2Kg95YPoPga9+SIAii39isB/MWflsB
 lcCY1lHz/I9QhDU9ws0Ih1ROrJUkcXBCO8M+OGmwTJTQEWbO66Q76XFTCatguE2hU1dahSgHHD
 UuySDnMrhNO+EyB8bWd/c2ahM85csgkJ/37l1AixdRXoYLOucazfbdn1PmftnkiGs6eUwQsFDs
 PD4=
X-IronPort-AV: E=Sophos;i="5.81,300,1610434800"; 
   d="scan'208";a="112277841"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Apr 2021 10:01:49 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 2 Apr 2021 10:01:48 -0700
Received: from ness.microchip.com (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2176.2 via Frontend
 Transport; Fri, 2 Apr 2021 10:01:47 -0700
From:   <nicolas.ferre@microchip.com>
To:     Ludovic Desroches <ludovic.desroches@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: [PATCH] ARM: dts: at91: sama5d2: add ETB and ETM unit name
Date:   Fri, 2 Apr 2021 19:01:39 +0200
Message-ID: <20210402170139.140595-1-nicolas.ferre@microchip.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicolas Ferre <nicolas.ferre@microchip.com>

Add unit address to the ETB and ETM nodes.

It also allow us to get rid of the warnings:
../arch/arm/boot/dts/sama5d2.dtsi:43.6-57.4: Warning
(unit_address_vs_reg): /etb: node has a reg or ranges property, but no
unit name
../arch/arm/boot/dts/sama5d2.dtsi:59.6-73.4: Warning
(unit_address_vs_reg): /etm: node has a reg or ranges property, but no
unit name
when we compile with W=1.

Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
---
 arch/arm/boot/dts/sama5d2.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dtsi
index 2c4952427296..a27294394508 100644
--- a/arch/arm/boot/dts/sama5d2.dtsi
+++ b/arch/arm/boot/dts/sama5d2.dtsi
@@ -40,7 +40,7 @@ pmu {
 		interrupts = <2 IRQ_TYPE_LEVEL_HIGH 0>;
 	};
 
-	etb {
+	etb@740000 {
 		compatible = "arm,coresight-etb10", "arm,primecell";
 		reg = <0x740000 0x1000>;
 
@@ -56,7 +56,7 @@ etb_in: endpoint {
 		};
 	};
 
-	etm {
+	etm@73C000 {
 		compatible = "arm,coresight-etm3x", "arm,primecell";
 		reg = <0x73C000 0x1000>;
 
-- 
2.31.1

