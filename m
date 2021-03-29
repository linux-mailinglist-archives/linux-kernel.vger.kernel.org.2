Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F36534CD8B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 12:02:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232623AbhC2KBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 06:01:45 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:53767 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232647AbhC2KBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 06:01:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1617012070; x=1648548070;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=t9kuj2ot3UYem3vQ75ytO7Nb/vjYnZU5nbr9/C46sb0=;
  b=ZpsLxsmX2PfHophNzOe9xaJN/b0LhhNifSboc4n7d6q7FWTJDnqlOS1e
   gB8TSB1vH8FxNmSzuAj2ci/jDE6wtOuP7Xt7M39QMO7IoN3fe+kfefXfG
   ctNgk+ONZMLFYIF5VoWe+NrGIiVp3NJNcAuKwYO5A/MLp/OnbXRfup3BU
   2QkJCh7LnUdx2Pm/hthtes/IrZj+jO/yrM7pQ7e7SULVc85HLmrcO7smh
   rIpT1+GEZmBMOMJGXtBJQq7KMyPJMSCiWyKMT6zMtRn6KhJRPlcq8C4+g
   KHTK1iacWXhyqPqm6/+JnJTRR+10+mG+tGUSPFkNG9cDdZy8b8gFY/pQm
   A==;
IronPort-SDR: cqNvNgPhXvxOqOGtqMGMGpDL6RXDJOMKQC2hTvvNO8G4ovU4OxXLUiuDCXmgMk+Slmwcv2xCYA
 PIR6LmSPlwDtfLns76veWT+n3Zw+5z+DzAFY9egbh3T6nACUwbG6s2tdZgCYwSwUpKnYbh65wI
 icrGySJEncM9b3zdNvtmH7gVD+9y6hT5dSn0K1dGTh6vFF9T0CsbTd/G4a3BlQ1KVTUS3nM9M3
 NyOGCuDhXh4f5S77a07i4I/rTFs/+vKMFAYKCnGo0v0BWfnUuamGlEyr7EyQ489R+9HabYD+oZ
 HvU=
X-IronPort-AV: E=Sophos;i="5.81,287,1610434800"; 
   d="scan'208";a="111696135"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Mar 2021 03:01:09 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 29 Mar 2021 03:01:08 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Mon, 29 Mar 2021 03:01:06 -0700
From:   <nicolas.ferre@microchip.com>
To:     <linux-arm-kernel@lists.infradead.org>
CC:     <linux-kernel@vger.kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Cristian Birsan <cristian.birsan@microchip.com>,
        <emil.velikov@collabora.com>, <ezequiel@collabora.com>
Subject: [PATCH 3/7] ARM: configs: at91: sama5: Enable LAN78XX as module
Date:   Mon, 29 Mar 2021 11:56:41 +0200
Message-ID: <c016d98eb43bb90e0ef59e1b5a273794277a1a98.1617010856.git.nicolas.ferre@microchip.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1617010856.git.nicolas.ferre@microchip.com>
References: <cover.1617010856.git.nicolas.ferre@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Razvan Stefanescu <razvan.stefanescu@microchip.com>

Include this driver as the USB-Ethernet chip is present on SAMA5D2-ICP
board.

Signed-off-by: Razvan Stefanescu <razvan.stefanescu@microchip.com>
[nicolas.ferre@microchip.com: update commit subject and message]
Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
---
 arch/arm/configs/sama5_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/sama5_defconfig b/arch/arm/configs/sama5_defconfig
index 26222046a9cb..a528438ed678 100644
--- a/arch/arm/configs/sama5_defconfig
+++ b/arch/arm/configs/sama5_defconfig
@@ -89,6 +89,7 @@ CONFIG_MACB=y
 # CONFIG_NET_VENDOR_STMICRO is not set
 # CONFIG_NET_VENDOR_WIZNET is not set
 CONFIG_MICREL_PHY=y
+CONFIG_USB_LAN78XX=m
 CONFIG_LIBERTAS_THINFIRM=m
 CONFIG_LIBERTAS_THINFIRM_USB=m
 CONFIG_MWIFIEX=m
-- 
2.31.1

