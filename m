Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DDA6358A21
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 18:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232489AbhDHQtN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 12:49:13 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:34495 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232465AbhDHQtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 12:49:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1617900538; x=1649436538;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8Mgp4Sxrh9WlS2gWb08UvgbjF5Ynw4XaA5muZVG9lpk=;
  b=HkCIHBgGF26KsVKYkzrld6YpNjcHPuDEobcjzmFu6lZpLqSnkOTDG9+T
   zD8A17v5UxKgyx1UQrmdPVm3TekZsBEB2G/tmvSi6xai8mKyFQvN7tKLX
   1B6ZBd9bs78V/M7sK50+1QaoLWJFWmuglV652EdRqJCoiXqdItdBqEUkC
   dqw0KlVkYmNyHZYsE2JxJzClItHqdQJvuW7GNjPL23yKuwK17E8fUDLAT
   jzNnOKjFkU7nfCMTbDnS2llJCHSeR8iEUuuhOdW4FquVwElDCcRACeuGn
   qRRPYVcY8YHAct8Anjw/qVFoqzmgDlTzs6OtLewpmLRI1++Ma91/4ts0/
   g==;
IronPort-SDR: +DUssVX0w37QvxfQd6vKSG2I6ogiR3Vaws0xkWKfE4EbhAidDjiFLzboF7mUmneYk8do5aAaKv
 vjMBqzN+7lPvRGtNGjlyDRABJEaYK7APvg3CQjdNRtFD3pV6x+NO/mQiP6NERGbv1dbye1kcvV
 EJFDSDNGJrEGn7qyHF81X28fxqDutfM4q2yDOV2SR4VkNZ2x6TlMqbZqUJ307OuaHWuXJsqfGR
 1aMRgb3QXZEiGDl4QRPeZLgX8BdiCzkI0vkHKNtUHXGOESq0WlegOW38AjSCdU298kMc2HHR4K
 Lx4=
X-IronPort-AV: E=Sophos;i="5.82,206,1613458800"; 
   d="scan'208";a="112925000"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Apr 2021 09:48:58 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 8 Apr 2021 09:48:57 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Thu, 8 Apr 2021 09:48:55 -0700
From:   <nicolas.ferre@microchip.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
CC:     Ludovic Desroches <ludovic.desroches@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Arnd Bergmann <arnd@kernel.org>
Subject: [PATCH] ARM: dts: at91: sama5d2/trivial: fix letter case for etm hex address
Date:   Thu, 8 Apr 2021 18:44:43 +0200
Message-ID: <20210408164443.38941-1-nicolas.ferre@microchip.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <161789493817.1630479.5024717274217057698.b4-ty@arndb.de>
References: <161789493817.1630479.5024717274217057698.b4-ty@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicolas Ferre <nicolas.ferre@microchip.com>

Fix the etm node hex address to lower case for matching regexp
specification and removing the additional warning that looks like:

arch/arm/boot/dts/at91-sama5d2_ptc_ek.dt.yaml: /: 'etm@73C000' does not
match any of the regexes: '@(0|[1-9a-f][0-9a-f]*)$', '^[^@]+$',
'pinctrl-[0-9]+'

Reported-by: Arnd Bergmann <arnd@kernel.org>
Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
---
 arch/arm/boot/dts/sama5d2.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dtsi
index a27294394508..801969c113d6 100644
--- a/arch/arm/boot/dts/sama5d2.dtsi
+++ b/arch/arm/boot/dts/sama5d2.dtsi
@@ -56,9 +56,9 @@ etb_in: endpoint {
 		};
 	};
 
-	etm@73C000 {
+	etm@73c000 {
 		compatible = "arm,coresight-etm3x", "arm,primecell";
-		reg = <0x73C000 0x1000>;
+		reg = <0x73c000 0x1000>;
 
 		clocks = <&pmc PMC_TYPE_CORE PMC_MCK>;
 		clock-names = "apb_pclk";
-- 
2.31.1

