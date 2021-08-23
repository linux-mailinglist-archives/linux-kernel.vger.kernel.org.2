Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 606333F482A
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 12:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236094AbhHWKEv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 06:04:51 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:30109 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236064AbhHWKEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 06:04:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1629713046; x=1661249046;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=px1vevLryi7Cd6OhTXHpe7HUqqTHehG8sW5dVfE4Qxo=;
  b=IwNySF4Jr7iSgGfIhcPQP+J+N8T2o0ZBWsHxvtQ4HpU3bUNjxGCgb68q
   o0U1IxB80PNgRF420hu8dzQlPV7G6Ggh0/yU8VBdQRH/A4/uTJc05kfDi
   g43Sp4iGjW1hL9wufqu/4WuvSG3Fm+h/cPK3FuQlNcFBw9IbldEfNU/3r
   gYi9sQVoU5YbkCU9Kua7xNJexGlCNWu1N2Ruoz200ZkQJt2zZLEEg7pnk
   HOd5IOddCN4ynHXUFWw/9eRhFDLEofZy+zaGbc3bNzwNYOWU7NdBwthqX
   w4J2KqAJLWXKiWsPcXwoj9mXzptkpTpMjVVl7u+LUm6/JT12pDzIFDaa0
   w==;
IronPort-SDR: mQ/LvNEh74tJsHzLd+LBnXvoxkxugfA9sufIERaJ/xZMG6OkKdjnCuE5L7yNRaz1+C5Cy5o5Cw
 TdEJBohmWkeNqsjBTnbAQNZkJP0CF1qOyH63mu8mn6KhHHu6GMFo1xlMPwxGQxgqHIrhBIoEXI
 kE9jgii0diJym8I4GWwUQ+Okc98daBZzYGJxI6lyfLWJ/f3Kpd+S2xfF++34OcWrPa1GVIlinl
 LpJo2vrkiEO8PZH08md5ADGuA8mk8q7owNiyt21vWYOPQDCjjRmqrS5+bMVTJx79AfEvPZxKSD
 86jWpyDqhlO1fTmcoidyF+AR
X-IronPort-AV: E=Sophos;i="5.84,344,1620716400"; 
   d="scan'208";a="141175764"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Aug 2021 03:04:06 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 23 Aug 2021 03:04:06 -0700
Received: from rob-dk-mpu01.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Mon, 23 Aug 2021 03:04:04 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 2/3] ARM: dts: at91: add bindins for securam
Date:   Mon, 23 Aug 2021 13:03:55 +0300
Message-ID: <20210823100356.22206-3-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210823100356.22206-1-claudiu.beznea@microchip.com>
References: <20210823100356.22206-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings for securam.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 arch/arm/boot/dts/sama7g5.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/sama7g5.dtsi b/arch/arm/boot/dts/sama7g5.dtsi
index ecabab4343b6..3a4315ac0eb0 100644
--- a/arch/arm/boot/dts/sama7g5.dtsi
+++ b/arch/arm/boot/dts/sama7g5.dtsi
@@ -75,6 +75,17 @@ soc {
 		#size-cells = <1>;
 		ranges;
 
+		securam: securam@e0000000 {
+			compatible = "microchip,sama7g5-securam", "atmel,sama5d2-securam", "mmio-sram";
+			reg = <0xe0000000 0x4000>;
+			clocks = <&pmc PMC_TYPE_PERIPHERAL 18>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0xe0000000 0x4000>;
+			no-memory-wc;
+			status = "okay";
+		};
+
 		secumod: secumod@e0004000 {
 			compatible = "microchip,sama7g5-secumod", "atmel,sama5d2-secumod", "syscon";
 			reg = <0xe0004000 0x4000>;
-- 
2.25.1

