Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78B523D7080
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 09:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235819AbhG0HmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 03:42:17 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:25364 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235518AbhG0HmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 03:42:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1627371737; x=1658907737;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=om6xD5XEV4jFOd062wyEoEGfNZyedN6bua4XylEu0Pc=;
  b=G4Koh3WAyJuuvV3/+KrHlqfMdrp1nn4jXGl/uZffwQWf8DkXc4Ol+nFX
   a/stAo7FUR8TvgoU0Vp0wuNDRnC/YPsuzGkLp4HWh3pZ6Cr3RAT1q9Wcq
   WdVBskd1cdQ4T5bOaE+4A0TE7PZrEmG04NgIw72bh/3HNUnPCD/c31Gej
   PRpwxzNuZrfSOQN3F8iwUe9kfwybatSh9ews8miwlaHv/XqGhxU3izUYl
   dD0naTxa+Dhy/DJ4O+c0lmb04H1mrSbdFRQPG8m/LfuRVXsQS7Pspzc5g
   9Nfrn3/Uv4/nGVzo2AH0GXiefBPrbmk2lQg5r8t2ZMG7aRpd37T04j5R2
   A==;
IronPort-SDR: s2Hzefbpqir5S+HrIqqnJmX/5Ud8zqMR+emeH/Y5ShObedjKxWXFp78A+SlVfllsOq2W+qYlcl
 EB5WUnaPzizpZ2QwQJwhWE/JpCTjF+jobr3vmVWXUKmDLsHH1tmmLTyIqShzmHdFNuh50LYhgZ
 zjOUhUKfuwLNiCUj+/kUUXWfWlPeuaeyXgJvWAX4wvda43JcI+dFL6mh++m1cwQVccaaD0S3xR
 DEA0mi0CJNUSGoyemk95nXLjUi+yt2dHAqGNkTqEnPetg1ogDXtXH6y6ZqUOHFxq/z/3gJS65y
 ufnWRrbpwHD7dyEpYucyzEmA
X-IronPort-AV: E=Sophos;i="5.84,272,1620716400"; 
   d="scan'208";a="129958793"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 27 Jul 2021 00:42:16 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 27 Jul 2021 00:42:16 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Tue, 27 Jul 2021 00:42:13 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 2/2] ARM: dts: at91: add conflict note for d3
Date:   Tue, 27 Jul 2021 10:40:06 +0300
Message-ID: <20210727074006.1609989-2-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210727074006.1609989-1-claudiu.beznea@microchip.com>
References: <20210727074006.1609989-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pin feeding d3 led may be in conflict with EBI CS0, USART2 CTS.
Add a note for this.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 arch/arm/boot/dts/at91-sama5d3_xplained.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/at91-sama5d3_xplained.dts b/arch/arm/boot/dts/at91-sama5d3_xplained.dts
index cc55d1684322..d72c042f2850 100644
--- a/arch/arm/boot/dts/at91-sama5d3_xplained.dts
+++ b/arch/arm/boot/dts/at91-sama5d3_xplained.dts
@@ -399,7 +399,7 @@ d2 {
 		};
 
 		d3 {
-			label = "d3";
+			label = "d3"; /* Conflict with EBI CS0, USART2 CTS. */
 			gpios = <&pioE 24 GPIO_ACTIVE_HIGH>;
 		};
 	};
-- 
2.25.1

